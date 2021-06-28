assume cs:codesg,ss:stacksg,ds:datasg

stacksg segment
  dw 0,0,0,0,0,0,0,0
stacksg ends

datasg segment
  db '1. display      '
  db '1. brows        '
  db '1. replace      '
  db '1. modify       '
datasg ends

codesg segment
  start:mov ax,stacksg
	mov ss,ax
	mov sp,16	;stack init

	mov ax,datasg
	mov ds,ax
	mov bx,0	;data init

	mov cx,4	;count init
	
  s0:	push cx
	mov si,0	;set the cursor si to 0
	mov cx,4	;inner count init

  s:	mov al,[bx+si+3]
	and al,11011111b
	mov [bx+si+3],al	;convert character to their uppercase
	
	inc si		;the cursor is incremented by one
	loop s		

	add bx,16	;let bx point to the next string
	pop cx
	loop s0

	mov ax,4200H
	int 21H

codesg ends

end start