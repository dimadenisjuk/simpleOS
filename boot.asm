jmp start
nop
include 'bpb.asm'
start:
mov ax, 07C0h
mov ds, ax
mov ax, 9000h
mov ss, ax
mov sp, 0FFFFh
cld
mov si, kernel_filename
call load_file
jmp 2000h:0000h
kernel_filename db "MYKERNELBIN"
include 'disk.asm'
times 510-($-$$) db 0
dw 0AA55h
buffer:
