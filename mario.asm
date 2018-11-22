.model small
.stack 100h
.data
; for creating the face of mario
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

.code

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
clear proc uses ax
    mov ah,0
    mov al,12h
    int 10h
    ret
clear endp


main proc
mov ax, @data 
mov ds,ax
call clear

mario1 x1,x2,y1,y2,bx1,bx2,by1,by2

mario2 lx1,lx2,ly1,ly2,rx1,rx2,ry1,ry2

mov ah,4ch
int 21h
main endp
end main

