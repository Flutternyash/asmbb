



;                               |       0      |      1    |        2          |      3        |     4    |                                      5                                       |    6

sqlDelConfirmInfo  text  "select P.id as PostID, P.threadID, U.nick as UserName, U.id as UserID, P.Content, (select count(1) from Posts P2 where P2.threadID = P.threadID ) as cnt_thread, T.Slug ",    \
                         "from Posts P left join Users U on U.id = P.userID left join Threads T on T.id = P.threadID where P.id = ?"


proc DeleteConfirmation, .postID, .pSpecial
.stmt dd ?
begin
        pushad

        xor     ebx, ebx
        mov     esi, [.pSpecial]

        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlDelConfirmInfo, sqlDelConfirmInfo.length, eax, 0

        cinvoke sqliteBindInt, [.stmt], 1, [.postID]

        cinvoke sqliteStep, [.stmt]
        cmp     eax, SQLITE_ROW
        jne     .finish_ok

        stdcall StrNew
        mov     ebx, eax

        test    [esi+TSpecialParams.userStatus], permDelAll
        jnz     .perm_ok

        test    [esi+TSpecialParams.userStatus], permDelOwn
        jz      .perm_not_ok

        cinvoke sqliteColumnInt, [.stmt], 3             ; UserID
        cmp     eax, [esi+TSpecialParams.userID]
        jne     .perm_not_ok


.perm_ok:
        stdcall StrCat, [esi+TSpecialParams.page_title], "Delete confirmation"

        stdcall StrCatTemplate, ebx, "del_confirm", [.stmt], [.pSpecial]

.finish_ok:

        cinvoke sqliteFinalize, [.stmt]

        clc

.finish:
        mov     [esp+4*regEAX], ebx
        popad
        return


.perm_not_ok:
        cinvoke sqliteFinalize, [.stmt]

        stdcall StrMakeRedirect, ebx, "/message/error_cant_delete"
        stc
        jmp     .finish

endp




sqlDelPost text "delete from Posts where id = ?"
sqlDelThread text "delete from Threads where id = ?"

proc DeletePost, .postID, .pSpecial
.stmt dd ?

.threadID dd ?
.post_cnt dd ?
.slug     dd ?

begin
        pushad

        xor     ebx, ebx
        mov     [.threadID], ebx
        mov     [.post_cnt], ebx
        mov     [.slug], ebx

        mov     esi, [.pSpecial]


        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlBegin, sqlBegin.length, eax, 0
        cinvoke sqliteStep, [.stmt]
        mov     edi, eax
        cinvoke sqliteFinalize, [.stmt]
        cmp     edi, SQLITE_DONE
        jne     .finish


        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlDelConfirmInfo, sqlDelConfirmInfo.length, eax, 0
        cinvoke sqliteBindInt, [.stmt], 1, [.postID]
        cinvoke sqliteStep, [.stmt]
        cmp     eax, SQLITE_ROW
        jne     .write_failure


        stdcall StrNew
        mov     ebx, eax

        test    [esi+TSpecialParams.userStatus], permDelAll
        jnz     .perm_ok

        test    [esi+TSpecialParams.userStatus], permDelOwn
        jz      .perm_not_ok

        cinvoke sqliteColumnInt, [.stmt], 3             ; UserID
        cmp     eax, [esi+TSpecialParams.userID]
        jne     .perm_not_ok


.perm_ok:

        cinvoke sqliteColumnInt, [.stmt], 1
        mov     [.threadID], eax                                ; threadID

        cinvoke sqliteColumnInt, [.stmt], 5
        mov     [.post_cnt], eax                                ; post_cnt

        cinvoke sqliteColumnText, [.stmt], 6
        stdcall StrDupMem, eax
        mov     [.slug], eax                                    ; thread slug

        cinvoke sqliteFinalize, [.stmt]

        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlDelPost, sqlDelPost.length, eax, 0
        cinvoke sqliteBindInt, [.stmt], 1, [.postID]
        cinvoke sqliteStep, [.stmt]
        cmp     eax, SQLITE_DONE
        jne     .write_failure

        cmp     [.post_cnt], 1
        ja      .commit

        cinvoke sqliteFinalize, [.stmt]

        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlDelThread, sqlDelThread.length, eax, 0
        cinvoke sqliteBindInt, [.stmt], 1, [.threadID]
        cinvoke sqliteStep, [.stmt]
        cmp     eax, SQLITE_DONE
        jne     .write_failure

.commit:

        cinvoke sqliteFinalize, [.stmt]

        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlCommit, sqlCommit.length, eax, 0
        cinvoke sqliteStep, [.stmt]
        cmp     eax, SQLITE_DONE
        jne     .write_failure

        cinvoke sqliteFinalize, [.stmt]

        cmp     [.post_cnt], 1
        ja      .finish_redirect_thread


.finish_redirect_list:

        stdcall StrMakeRedirect, ebx, "/list"
        jmp     .finish


.finish_redirect_thread:

        stdcall StrDupMem, "/threads/"
        stdcall StrCat, eax, [.slug]
        stdcall StrMakeRedirect, ebx, eax
        stdcall StrDel, eax
        jmp     .finish


.perm_not_ok:
        stdcall StrMakeRedirect, ebx, "/message/error_cant_delete"
        jmp     .do_rollback


.write_failure:
        stdcall StrMakeRedirect, ebx, "/message/error_cant_write"


.do_rollback:
        cinvoke sqliteFinalize, [.stmt]
        cinvoke sqliteExec, [hMainDatabase], sqlRollback, 0, 0, 0

.finish:
        stdcall StrDel, [.slug]
        mov     [esp+4*regEAX], ebx
        popad
        return


endp