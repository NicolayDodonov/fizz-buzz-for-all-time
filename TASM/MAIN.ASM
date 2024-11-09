.Model Small
.Stack 100h
.Data
	fizz db 'Fizz$'
	buzz db 'Buzz$'
	space db ', $'
	number	dw 0h
.Code
	fb proc near		; функция FizzBuzz
		xor dx, dx		; очищаем регистры dx
		xor bx, bx		; очищаем регистры bx
		
		mov bl, 3
		call divproc	; делим число в cx на 3
		
		jnz j1			; если ZF != 0, прыжок на j1
						; иначе:
		lea dx, fizz	; положить в dx начало строки Fizz
		call printproc	; вызвать печать
		inc bh			; увеличить bh - счётчик вызова печати
	j1:
		mov bl, 5
		call divproc	; делим число в cx на 3

		jnz j2			; если ZF != 0, прыжок на j1
						; иначе:
		lea dx, buzz	; положить в dx начало строки Buzz
		call printproc	; вызвать печать
		inc bh			; увеличить bh - счётчик вызова печати
	j2:
		cmp bh, 0
		jnz j3			; если ZF != 0, прыжок на j1
						; иначе:
		mov number, cx
		call ShowUInt16
	j3:	
		ret
	fb endp
	
	divproc proc near	; функция деления и проверки остатка
						; использует bl в качестве делителя
		mov ax, cx
		div bl
		
		cmp ah, 0		; проверям, равен ли остаток 0 и 
						; и устанавливает флаг ZF
		ret
	divproc endp
	
	printproc proc near	; функция вывода строки на экран
						; используется регистр dx для хранения
						; адреса начала строки
		mov ah, 09h
		int 21h			; вызываем 21 прерывание для вывода
		ret				
	printproc endp
	
	ShowUInt16 proc		; функция вывода n-ричного числа на экран
						; взято с сайта https://www.cyberforum.ru/
		push ax
		push bx
		push cx
		push dx
		
		mov ax, number	; берём число из переменной number
        mov bx, 10		; делитель (основание системы счисления)
        mov cx, 0		; количество выводимых цифр
		@@div:
			xor dx, dx	; делим (dx:ax) на bx
			div  bx
			add  dl, '0'; преобразуем остаток деления в символ цифры
			push dx 	; и сохраняем его в стеке
			inc  cx		; увеличиваем счётчик цифр
			test ax, ax	; в числе ещё есть цифры?
		jnz @@div 		; да - повторить цикл выделения цифры
        @@show:
			mov ah, 02h	; функция ah=02h int 21h - вывести символ из dl на экран
			pop dx 		; извлекаем из стека очередную цифру
			int 21h 	; и выводим её на экран
		loop @@show		; и так поступаем столько раз, сколько нашли цифр в числе (cx) pop bx
        
		pop dx
		pop cx
		pop bx
		pop ax
		
		ret
	ShowUInt16 endp
	
start:
	mov ax, @DATA		; инициализируем сегмент данных
	mov ds, ax
	xor ax, ax
	
	;===================  Цикл  ===================
	mov cx, 1			; создаём счётчик цикла в cx
loopSt:	
	call fb				; вызываем FizzBuzz
	
	lea dx, space
	call printproc		; отрисовываем пробел
	
	inc cx				; увеличиваем счётчик
	
	cmp cx, 100			; проверяем условие цикла
	jnz loopSt			; если ложь - переход loopSt
	;===================  Цикл  ===================
	
	
	mov AX, 4c00h		; 4c конец программы, 00 код выполнения
	int 21h				; 21 прерывание
end start	