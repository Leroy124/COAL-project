.model small
.stack 4096

.data 
; for creating the face of marioa


 x1 db 4
 x2 db 6
 y1 db 25
 y2 db 25

; for creating the body of the mario
bx1 db 3
bx2 db 7
by1 db 26
by2 db 27

; for creating the legs of the mario (left)
lx1 db 4
lx2 db 4
ly1 db 28
ly2 db 29

; for creating the legs of the mario (right)
rx1 db 6
rx2 db 6
ry1 db 28
ry2 db 29
count1 db 0
.code
clear proc uses ax
    mov ah,0
    mov al,12h
    int 10h
    ret
clear endp
; macro for building the shape
mario1 macro xx1,xx2,yy1,yy2,bbx1,bbx2,bby1,bby2
mov ah,06h
mov al,00
mov cl,xx1
mov dl,xx2
mov ch,yy1
mov dh,yy2
mov bh,12
int 10h; code for making the face of the character ends here

; code for making the body of the shape
mov ah,06h
mov al,00
mov cl,bbx1
mov dl,bbx2
mov ch,bby1
mov dh,bby2
mov bh,13
int 10h
endm

mario2 macro llx1,llx2,lly1,lly2,rrx1,rrx2,rry1,rry2
; code for making the body of the shape
mov ah,06h
mov al,00
mov cl,llx1
mov dl,llx2
mov ch,lly1
mov dh,lly2
mov bh,13
int 10h
; code for making the body of the shape
mov ah,06h
mov al,00
mov cl,rrx1
mov dl,rrx2
mov ch,rry1
mov dh,rry2
mov bh,13
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
mario1 x1,x2,y1,y2,bx1,bx2,by1,by2
mario2 lx1,lx2,ly1,ly2,rx1,rx2,ry1,ry2

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
mario1 x1,x2,y1,y2,bx1,bx2,by1,by2
mario2 lx1,lx2,ly1,ly2,rx1,rx2,ry1,ry2
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
inc bx1
inc bx2
inc lx1
inc lx2
inc rx1
inc rx2
call clear
jmp l1
; checking for lef key
n2:
cmp ah,4Bh
jne n3
dec x1
dec x2

cmp x1,1
jb reset
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
mario1 x1,x2,y1,y2,bx1,bx2,by1,by2
mario2 lx1,lx2,ly1,ly2,rx1,rx2,ry1,ry2
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