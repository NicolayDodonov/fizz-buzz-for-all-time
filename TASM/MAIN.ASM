.Model Small
.Stack 100h
.Data
	fizz db 'Fizz$'
	buzz db 'Buzz$'
.Code
	;FizzBuss procedure
	fb proc near
		;clear REG
		xor dx, dx
		xor bx, bx
		
		;cx % 3 == 0 ?
		mov dl, 3
		call divproc
		
		;No, jmp j1
		jnz j1
		;print fizz
		lea dx, fizz
		call printproc
		inc bh
	j1:
		;cx % 5 == 0 ?
		mov dl, 5
		call divproc
		;No, jmp j2
		jnz j2
		;Yes, dl++
		;print buzz
		lea dx, buzz
		call printproc
		inc bh
	j2:
		;bz == 0?
		cmp bh, 0
		;No, jmp j3
		jnz j3
		;yes
		mov dx, cx
		;сдвигаем число до символа числа
		add dx, 30h
		mov ah, 02h
		int 21h
	j3:	
		ret
	fb endp
	
	divproc proc near
		;cx % dl == 0?
		mov ax, cx
		mov bl, dl
		div bl
		;set ZF
		cmp ah, 0
		ret
	divproc endp
	
	printproc proc near
		;get text from dx
		mov ah, 09h
		int 21h
		ret
	printproc endp
	
start:
	;load Data segment in ds
	;for use string
	mov ax, @DATA
	mov ds, ax
	xor ax, ax
	
	;create counter for loop
	mov cx, 100
	;loop_Start
loopSt:	
	call fb
	loop loopSt
	
	mov AX, 4c00h
	int 21h
end start	