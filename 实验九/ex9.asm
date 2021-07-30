assume cs:codesg,ds:datasg,ss:stacksg

datasg segment
  db 'Welcome to Sinny World!'
  ;string resource
datasg ends

stacksg segment
  dd 0,0,0,0
stacksg ends

codesg segment
  start:mov ax,stacksg
	mov ss,ax 
	mov sp,16	;stacksg init

	mov ax,datasg
	mov ds,ax
	mov bx,0	
	mov di,0	;datasg init

	mov ax,113*256
	push ax
	mov ax,36*256
	push ax
	mov ax,3*256
	push ax		;attr

	mov ax,0B800H
	mov es,ax
	mov ax,160*12
	mov bp,ax
	mov si,0	;dest init

	mov cx,3	;line init
	
  s0:	pop ax
	push cx
	mov cx,23	;rol init

  s1:	mov al,[bx+di]	
	inc di
	mov es:[bp+28*2+si],ax
	add si,2
	loop s1

	mov si,0
	mov di,0
	add bp,80*2

	pop cx
	loop s0
	
	mov ax,4200H
	int 21H
	
codesg ends

end start
