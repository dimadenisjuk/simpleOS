org 32768

mov bx, @
call printString
ret

findCursor:
mov bh, 00h
mov al, 03h
int 10h
mov [cursorX], dl
mov [cursorY], dh
ret

printChar:
mov ah, 0eh
int 10h
ret

printString:
mov al, [bx]
cmp al, 00h
je exit
call printChar
inc bx
jmp printString
exit:
ret

@: db 'THANK YOU!', 0

cursorX rb 1
cursorY rb 1
