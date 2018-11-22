.model small
.stack 4096

.data 
x1 db 0 ;cl
x2 db 5 ; dl
y1 db 25 ; ch 
y2 db 29 ; dh
var dw 0
count1 db 0
.code
clear proc uses ax
    mov ah,0
    mov al,12h
    int 10h
    ret
clear endp
; macro for building the shape
shape macro p1,p2,q1,q2
    mov ah,06h
mov al,00
mov cl,p1                           ; cl and dl control the x-axis of the shape       ; to move a shape, make change in both of the regsiter (cl,dl)
mov ch,q1
mov dl,p2
mov dh,q2
mov bh,12
int 10h
endm
; macro ends
main proc
mov ax,@data
mov ds,ax
call clear
;mov ah,0ch
;mov al,12
;mov cx,100
mov cx,0
;int 21h
jmp l1
ground:
    add y1,5
    add y2,5
    inc x1
    inc x2
    call clear
l1:
mov ah,06h
mov al,00
mov cl,x1                           ; cl and dl control the x-axis of the shape       ; to move a shape, make change in both of the regsiter (cl,dl)
mov ch,y1
mov dl,x2
mov dh,y2
mov bh,12
int 10h
cmp y2,24
je ground

 mov ah,11h
   int 16h
   jnz checkey
   jmp l1

checkey:




mov ah,10h
 int 16h  ; cleaning the buffer

; checking for up key
cmp ah,48h

 jne n1
 jump1:
 dec y1
 dec y2
 inc x1
 inc x2
 call clear
 
INT 15H
shape x1,x2,y1,y2
MOV CX, 02h
MOV DX, 3000h   ; CX:DX Number of microseconds to elapse
MOV AH, 86H
INT 15H
 inc count1
 cmp count1,5
 jne jump1
 mov count1,0
 jmp l1
;checking for right key
n1:
cmp ah,4Dh
jne n2
inc x1
inc x2
call clear
jmp l1
; checking for lef key
n2:
cmp ah,4Bh
jne n3


cmp x1,0
je reset
dec x1
dec x2
call clear
jmp l1
reset: ; if the x-axis of the shape becomes lower than the initial point then reset it
  mov x1,0
  mov x2,5
  call clear
  jmp l1
n3: ; for pausing the game
cmp ah,19h
jne n4
call clear
resume:
shape x1,x2,y1,y2
mov ah,11h
int 16h  ; checking whether a key was pressed

mov ah,10h   ; clearing the buffer
int 16h
    cmp ah,19h   ; game won't resume until  pause key is 
    je l1
    
    
    jmp resume

    n4:
mov ah,4ch
int 21h
main endp
end main
