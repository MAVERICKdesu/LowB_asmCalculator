assume cs:code,ds:data

data segment
	string dw 0
	number dw 0
	realnumber dw 0
	string1 db 'please input the first number','$'
	string2 db 'please input the second number','$'
	string3 db '+,-,*,/ which one?$'
	string4 db 'because ','$'
	number1 db 34 dup('$')
	number2 db 34 dup('$')
	i db 0
	j db 0
	realnumber1 db 33 dup(0)
	realnumber2 db 33 dup(0)
	answer db 34 dup(0)
data ends

code segment

start:mov ax,data
	mov ds,ax

	mov string,offset string1
	mov number,offset number1
	mov realnumber,offset realnumber1
	call gets
	mov string,offset string2
	mov number,offset number2
	mov realnumber,offset realnumber2
	call gets
	call panduan
	call puts
	call cls

	jmp start

over:	mov ax,4C00h
    	int 21h ;	end

jiafa:	mov cx,33
	mov ah,0
	lea si,realnumber1
	lea di,realnumber2
	lea bx,answer
xx:	mov al,ds:[si]
	add al,ds:[di]
	mov ds:[bx],al
	inc bx
	inc si
	inc di
	loop xx
	call jinwei
	ret


jianfa:	mov cx,33
	lea bx,realnumber2
jian99:	mov al,ds:[bx]
	mov ah,9
	sub ah,al
	mov ds:[bx],ah
	inc bx
	loop jian99
	call jiafa
	lea bx,answer
	cmp byte ptr ds:[bx+32],9
	je fu
zheng:	inc byte ptr ds:[bx]
	call jinwei
	jmp o
fu:	mov ah,2
	mov dl,45
	int 21h
	mov cx,33
jian9:	mov al,ds:[bx]
	mov ah,9
	sub ah,al
	mov ds:[bx],ah
	inc bx
	loop jian9
o:
	ret
	
mull:lea bx,answer
	lea si,realnumber1
	mov byte ptr i,0
x1:push bx
	lea di,realnumber2
	mov byte ptr j,0
x2:mov ah,ds:[si]
	mov al,ds:[di]
	mul ah
	mov dl,10
	div dl
	add ds:[bx],ah
	add ds:[bx+1],al
	inc bx
	inc byte ptr j
	inc di
	cmp byte ptr j,32
	jne x2
	pop bx
	inc bx
	inc byte ptr i
	inc si
	cmp byte ptr i,32
	jne x1
	call jinwei
	ret

chufa:
	lea bx,realnumber1
	mov cx,16
	mov ax,10
	mov dx,0
d16:
	
	ret

puts:mov cx,32
	lea bx,answer
	mov si,31
zero:	cmp byte ptr ds:[bx+si],0
	jne a
	cmp cx,1
	je a
	dec si
	loop zero
a:	mov ah,2
out1:	mov dl,ds:[bx+si]
	add dl,48
	int 21h
	dec si
	loop out1
 	mov dl,0ah
	int 21h
	ret

cls:	mov cx,34
	lea si,number1
	lea di,number2
	lea bx,answer
c1:	mov byte ptr ds:[si],'$'
	mov byte ptr ds:[di],'$'
	mov byte ptr ds:[bx],0
	inc si
	inc di
	inc bx
	loop c1
	mov cx,33
	lea si,realnumber1
	lea di,realnumber2
c2:	mov byte ptr ds:[si],0
	mov byte ptr ds:[di],0
	inc si
	inc di
	loop c2
	ret

jinwei:	mov cx,33
	lea bx,answer
nn:	mov al,ds:[bx]
	mov ah,0
	mov dl,10
	div dl
	add ds:[bx+1],al
	mov ds:[bx],ah
	inc bx
	loop nn
	ret


gets:mov dx,string
	call zfc;       输出字符串
	mov dx,number
	mov ah, 10
	int 21h;	输入数字
 	mov ah,02h
 	mov dl,0ah
	int 21h

	mov bx,number
	add bx,2
	mov cx,0
xh:	mov al,ds:[bx];
	cmp al,48
	jb next
	cmp al,57
	ja next
	inc cx;	记录位数
	inc bx
	jmp xh
next:	
	mov si,number
	add si,cx
	inc si
	mov di,realnumber
fz:	mov al,ds:[si];   数字的位数为cx,偏移量为第一个数字最高位,1+cx为第cx个数字最低位 要将其所有数字复制到realnumber，从低位到高位赋值      offset number+(1+cx) 赋给offser realnumber+ax
	sub al,48
	mov ds:[di],al
	dec si
	inc di
	loop fz
	ret
	
zfc:mov ah,09h
	int 21h
	ret

panduan:mov dx,offset string3
	call zfc ; 输出字符串3
	mov ah,0    ;进行输入
   	int 16h
   	mov bl,al
   	mov ah,02h
 	mov dl,0ah
	int 21h
   	cmp bl,49
	jne pl
	call jiafa
	jmp o1
pl:	cmp bl,50
	jne jf
	call jianfa
	jmp o1
jf:	cmp bl,51
	jne cf
	call mull
	jmp o1
cf:	cmp bl,52
	jne qt
	call chufa
	jmp o1
qt:
o1:
	ret
code ends
end start
