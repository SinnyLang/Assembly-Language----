assume cs:codesg,ss:stack,ds:table

data segment
  db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
  db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
  db '1993','1994','1995'
  ;the above are the 21 strings that define those 21 years

  dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
  dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
  ;the above is 21 dword data representing the company's total revenue in the past 21 years

  dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
  dw 11542,14430,15257,17800
  ;the above is 21 word data representing the number of employees in the company in the past 21 years
data ends

table segment
  db 21 dup ('year summ ne ?? ')
table ends

stack segment
  dw 16 dup (0)
stack ends

codesg segment
  start:mov ax,stack
	mov ss,ax
	mov sp,16	;stack init

	mov ax,table
	mov ds,ax
	mov bx,0	;table init

	mov ax,data
	mov es,ax	
	mov bp,0	;data init

	mov cx,21	;count init
	mov di,0
	mov si,0

  s0:	push cx
	mov cx,2
  cyear:mov ax,word ptr es:[di]
	mov word ptr ds:[bx+si],ax
	add si,2
	add di,2
	loop cyear	;copy strings of year
	pop cx
	
	mov ax,word ptr es:[168+bp]
	mov word ptr ds:[bx+10],ax
	add bp,2	;copy num of ne
	
	sub di,4	;reback the cursor si to copy summ
	mov si,0
	mov ax,word ptr es:[84+di]
	mov word ptr ds:[bx+5+si],ax
	add di,2
	add si,2
	mov dx,word ptr es:[84+di]
	mov word ptr ds:[bx+5+si],dx
	add di,2	
	mov si,0	;copy the num of summ
	
	div word ptr ds:[bx+10]
	mov word ptr ds:[bx+13],ax
			;calculate per capita income
	
	add bx,10H
	loop s0
	
	mov ax,4200H
	int 21H
codesg ends

end start