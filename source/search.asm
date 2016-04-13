



sqlSearchCnt    StripText "search_cnt.sql", SQL
sqlSearch       StripText "search.sql", SQL

proc ShowSearchResults2, .hStart, .pSpecial
.pages      dd ?
.stmt       dd ?
.query      dd ?
.start      dd ?
begin
        pushad

        mov     [.query], 0
        mov     esi, [.pSpecial]

        mov     eax, [.hStart]
        test    eax, eax
        jz      .start_ok

        stdcall StrToNumEx, eax

.start_ok:
        mov     [.start],eax


        stdcall ValueByName, [esi+TSpecialParams.params], "QUERY_STRING"
        jc      .missing_query

        stdcall GetQueryItem, eax, txt "s=", 0
        test    eax, eax
        jz      .missing_query

        mov     [.query], eax

        stdcall StrCat, [esi+TSpecialParams.page_title], "Search results for: "
        stdcall StrCat, [esi+TSpecialParams.page_title], [.query]

        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlSearchCnt, sqlSearchCnt.length, eax, 0

        stdcall StrPtr, [.query]
        cinvoke sqliteBindText, [.stmt], 1, eax, [eax+string.len], SQLITE_STATIC

        call    .bind_limits

        cinvoke sqliteStep, [.stmt]
        cinvoke sqliteColumnInt, [.stmt], 0
        mov     edi, eax
        cinvoke sqliteFinalize, [.stmt]

        OutputValue "Results count:", edi, 10, -1

        mov     [.pages], edi
        test    edi, edi
        jz      .pages_ok

        stdcall StrDupMem, txt "?s="
        stdcall StrCat, eax, [.query]
        push    eax

        stdcall CreatePagesLinks, [.start], edi, eax
        stdcall StrDel ; from the stack
        mov     [.pages], eax

.pages_ok:
        stdcall StrNew
        mov     edi, eax

        stdcall StrCat, edi, '<div class="thread">'

        stdcall StrCatTemplate, edi, "nav_search", 0, esi

        cmp     [.pages], 0
        je      .search_ok

        stdcall StrCat, edi, [.pages]

        lea     eax, [.stmt]
        cinvoke sqlitePrepare_v2, [hMainDatabase], sqlSearch, sqlSearch.length, eax, 0

        stdcall StrPtr, [.query]
        cinvoke sqliteBindText, [.stmt], 1, eax, [eax+string.len], SQLITE_STATIC

        cinvoke sqliteBindInt, [.stmt], 2, PAGE_LENGTH

        mov     eax, [.start]
        imul    eax, PAGE_LENGTH
        cinvoke sqliteBindInt, [.stmt], 3, eax

        call    .bind_limits

.search_loop:
        cinvoke sqliteStep, [.stmt]
        cmp     eax, SQLITE_ROW
        jne     .finalize

        stdcall StrCatTemplate, edi, "search_result", [.stmt], esi

        jmp     .search_loop

.finalize:

        cinvoke sqliteFinalize, [.stmt]

        stdcall StrCat, edi, [.pages]
        stdcall StrDel, [.pages]

        stdcall StrCatTemplate, edi, "nav_search", 0, esi

.search_ok:
        stdcall StrCat, edi, '</div>'

        clc

.finish:
        mov     [esp+4*regEAX], edi
        popad
        return


.missing_query:

        stdcall StrMakeRedirect, 0, "/!message/missing_query/"
        mov     edi, eax
        stc
        jmp     .finish



.bind_limits:

        cmp     [esi+TSpecialParams.thread], 0
        je      .thread_ok

        stdcall StrPtr, [esi+TSpecialParams.thread]
        cinvoke sqliteBindText, [.stmt], 4, eax, [eax+string.len], SQLITE_STATIC

.thread_ok:

        cmp     [esi+TSpecialParams.dir], 0
        je      .dir_ok

        stdcall StrPtr, [esi+TSpecialParams.dir]
        cinvoke sqliteBindText, [.stmt], 5, eax, [eax+string.len], SQLITE_STATIC

.dir_ok:
        retn


endp