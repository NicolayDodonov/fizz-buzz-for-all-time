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
		call toString
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
	
	toString proc		; функция конвертации и вывода чисел
						; была написана для автомата по ASM
		push ax
		push bx
		push cx
		push dx
		
		mov ax, number  ; загружаем число в регистр ax
		mov bx, 10      ; основание системы счисления (десятичная)
		xor cx, cx      ; обнуляем счетчик цифр
		mov dx, 0       ; обнуляем результат
		
	convertLoop:
		div bx          ; делим число в ax на основание системы счисления
		push dx         ; сохраняем остаток от деления в стеке
		inc cx          ; увеличиваем счетчик цифр
		cmp cx, 3     ; проверяем, что число не равно 0
		jnz convertLoop ; если число не равно 0, продолжаем деление

	printLoop:
		pop dx          ; извлекаем цифры из стека в обратном порядке
		add dl, '0'     ; преобразуем цифру в символ
		mov ah, 02h     ; функция вывода символа
		int 21h         ; выводим символ
		
		loop printLoop  ; повторяем для всех цифр
		
		pop dx
		pop cx
		pop bx
		pop ax
		ret
	toString endp
	
start:
	mov ax, @DATA		; инициализируем сегмент данных
	mov ds, ax
	xor ax, ax
	
	mov cx, 100			; создаём счётчик цикла в cx
loopSt:	
	call fb				; вызываем FizzBuzz
	lea dx, space
	call printproc
	loop loopSt			; выполняем цикл
	
	mov AX, 4c00h		; 4c конец программы, 00 код выполнения
	int 21h				; 21 прерывание
end start	