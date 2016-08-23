ct_print:
	push rbx
	push r12
	push r13
			; en rdi tengo el puntero al pfile
			; en rsi  punteor a ct tree
		mov rbx, rdi			; en rbx tengo el puntero al pfile
		mov r12, rsi			; en r12 tengo el puntero al ct tree
		mov rdi, rsi 			; pong en rdi el puntero al ct
		call ctIter_new 		; en rax tengo un puntero al iterador
		mov rdi, rax   			; lo pongo en rdi
		mov r13, rdi  			; r13 ahora es el puntero al iterador
		call ctIter_first 		; lo seteo para que empiece desde el primer nodo
		.ciclo:
			mov rdi, r13
			call ctIter_valid ; veo si es valido, la respuesta esta en rax
			cmp rax, 0
			je .fin  			; si no es valido me salgo ya
			mov rdi, r13		; muevo el puntero al iterador a rdi
			call ctIter_get		; obtengo su valor, que lo tengo en eax
			mov rdi, rbx		; pongo en rdi el pfile
			mov rsi, printNum 	; pongo en rsi el formato de que voy a imprimir
			mov edx, eax		; pongo en edx el valor a imprimi
			call fprint			; finalmente imprimo
			
			mov rdi, r13		; pongo el putnero al iterador en rdi, para moverlo
			call ctIter_next	; me muevo al siguient elemento
			jmp .ciclo
			
			


	.fin:
		pop r13
		pop r12
		pop rbx
	
        ret
