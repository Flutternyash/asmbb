; _______________________________________________________________________________________
;|                                                                                       |
;| ..:: Fresh IDE ::..  template project.                                                |
;|_______________________________________________________________________________________|
;
;  Description: AsmBoard is assembly written message board engine working over FastCGI
;
;  Target OS: Any, supported by FreshLib
;
;  Dependencies: FreshLib
;
;  Notes:
;_________________________________________________________________________________________

include "%lib%/freshlib.inc"

LINUX_INTERPRETER equ './ld-musl-i386.so'   ;'./ld-linux.so.2'

@BinaryType console, compact

options.ShowSkipped = 0
options.ShowSizes = 1

options.DebugMode = 1
options.AlignCode = 0
options.ShowImported = 1

HeapManager  equ ASM
;LinuxThreads equ native


include "%lib%/freshlib.asm"

;uses sqlite3:"sqlite3.inc"

;include "sqlite3.asm"   ; sqlite utility functions.
include "get.asm"
include "commands.asm"
include "render.asm"
include "fcgi.asm"


iglobal
  sqlCreateDB file 'create.sql'
              dd   0

  cDatabaseFilename text "./board.sqlite"
endg

uglobal
  hMainDatabase dd ?

  StartTime     dd ?
endg


cmdListThreads = 0
cmdShowThread  = 1
cmdSavePost    = 2

cmdMax         = 2


rb 273

start:
        stdcall GetTimestamp
        mov     [StartTime], eax

        InitializeAll

;        stdcall OpenOrCreate, cDatabaseFilename, hMainDatabase, sqlCreateDB
;        jc      .finish

        stdcall Listen

; close the database

;        cinvoke sqliteClose, [hMainDatabase]

.finish:
        FinalizeAll
        stdcall TerminateAll, 0



