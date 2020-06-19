use16
org 7E00h   ;ядро загрузилось по адресу 7E00h поэтому и все метки должны 
 ;быть расчитаны относительно этого адреса, если хотим чтобы
 ;программа печатала не мусор, а нашу строку с поздравлениями
mov dx, 0200h         ;чуть чуть изменил позицию курсора, чтобы не затирать напечатанное
mov bx, 0000h
mov ah, 00h
jmp finish
again:
mov ah, 00h
int 16h
mov al, bl
cmp al, 0dh
jne skiplf
mov ah, 0eh
push bx
mov bx, 0008h
int 10h
pop bx
mov al, 0ah
skiplf:
mov ah, 0eh
push bx
mov bx, 0008h
int 10h
pop bx
inc bl
cmp bl, 083h
jle next
jmp again

next:
mov bx, 0000h
again2:
mov ah, 00h
int 16h
mov al, bl
add al, 7fh
mov ah, 0eh
push bx
mov bx, 0007h
int 10h
pop bx
inc bl
cmp bl, 0ffh
jle finish
jmp again2

finish:
mov bx, 0005h
mov ax, 1301h
mov dx, 0501h
mov cx, conend - con
mov bp, con
int 10h
mov dx, 0000h
call dremsc2
jmp $

dremsc:
inc dh
mov dl, 00h
dremsc2:
mov bx, 001Fh
mov ax, 1301h
mov cx, 1h
mov bp, cst
cmp dh, 00h
je toppanel
cmp dh, 01h
je borderh
cmp dh, 17h
je borderh
jmp draw
borderh:
cmp dl, 00h
je ugolleft
cmp dl, 4fh
je ugolright
mov bp, brdrh
jmp draw
ugolleft:
cmp dh, 01h
je ugollefttop
mov bp, brdrlb
jmp draw
ugollefttop:
mov bp, brdrlt
jmp draw
ugolright:
cmp dh, 01h
je ugolrighttop
mov bp, brdrrb
jmp draw
ugolrighttop:
mov bp, brdrrt
jmp draw
toppanel:
mov bx, 0030h
draw:
int 10h
inc dl
cmp dl, 50h
jne dremsc2
cmp dh, 17h
jne dremsc
ret

brdrlt db 0dah
brdrlb db 0c0h
brdrrt db 0bfh
brdrrb db 0d9h
brdrh db 0c4h
cst db 20h
cstend:
con db 'Kernel was loaded!'
conend:
times 512-($-$$) db 0    
