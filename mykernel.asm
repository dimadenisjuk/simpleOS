mov ax, 2000h
mov ds, ax
mov es, ax

mainLoop:
cmp byte [superUser], 1
je promptSUdraw
mov si, prompt
jmp drawPrompt
promptSUdraw:
mov si, promptSU
drawPrompt:
call lib_print_string
mov si, userInput
call lib_input_string

cmp byte [si], 0
je mainLoop

cmp word [si], "ls"
je list_files

cmp word [si], "su"
je upPrivelegies

;findNameOfFile:
;mov cx, [fileNameToLoad]
;mov bx, si
;cmp bx, 32
;je foundNameOfFile
;mov al, [bx]
;mov [cx], al
;inc cx
;inc bx
;jmp findNameOfFile


foundNameOfFile:
mov ax, si
mov cx, 32768
call lib_load_file
jc load_fail

mov si, userInput
findArgument:
cmp byte [si], 32
je callProgram
cmp byte [si], 0
je callProgram
inc si
jmp findArgument
callProgram:
mov ax, si 
call 32768
jmp mainLoop


load_fail:
mov si, loadFailMsgStart
call lib_print_string
mov si, userInput
call lib_print_string
mov si, loadFailMsgEnd
call lib_print_string
jmp mainLoop

upPrivelegies:
mov byte [superUser], 1
jmp mainLoop

list_files:
mov si, file_list
call lib_get_file_list
call lib_print_string
jmp mainLoop

prompt db 13, 10, "dmitryOS $ ", 0
promptSU db 13, 10, "dmitryOS # ", 0
superUser db 0
loadFailMsgStart db 13, 10, "Command not found (", 34, 0
loadFailMsgEnd db 34, ")!", 0
userInput:
times 256 db 0
fileNameToLoad:
times 32 db 0
file_list:
times 2048 db 0
include 'lib.asm'
