; FUNCIONES de C
  extern malloc
  extern free
  extern fprintf
  extern printf
   
; FUNCIONES
  global ct_new
  global ct_delete
  global ct_print
  global ctIter_new
  global ctIter_delete
  global ctIter_first
  global ctIter_next
  global ctIter_get
  global ctIter_valid

	; define sobre ct
  %define ctSize 12
  %define offset_size 8
  %define offset_root 0 
  
  %define Size_P 8

	; define sobre nodos

  %define offset_father 0 
  %define offset_value 8
  %define offset_child 21
  %define offset_len 20
  %define Size_Value 4
 
	; define sobre iterCt
  %define Size_It 21
  %define offset_tree 0
  %define offset_nodo 8
  %define offset_current 16
  %define offset_count 17

  %define jneg jb
section .data
printNum: DB "%d", 10

section .text

; =====================================
; void ct_new(ctTree** pct);
ct_new:
;rdi = puntero a puntero a ct
	  push rbx                          ; salvo rbx y alineo pila
    mov rbx, rdi                      ;rbx ahora tiene el puntero al puntero al ct
    mov rdi, ctSize                   ; rdi tiene el tamaño para llamar a malloc d un ctree
    call malloc
                                      ;rax tiene la direccion de este ctree;
    mov [rbx], rax                    ; ahora efectivamente rbx apunta a un puntero que si apunta a una direccion valida d memoria
   
    mov rdi, [rbx]                    ; rdi ahora es un puntero directo al ctree
    mov qword [rdi+offset_root], 0 		;pongo como nullo el puntero a la raiz del ctree
    mov word [rdi+offset_size], 0     ; pongo que el tamaño del ctTree sea 0
    
    
    pop rbx                           ; restablesco rbx    
    ret
    
    ; LINEAS (10)

; =====================================
; void ct_delete(ctTree** pct);
ct_delete:
    push rbx  ; pila alineada
    mov rbx, [rdi]   ; guardo el puntero al ctree para desp
    mov rsi, [rdi]                  ;rsi es el puntero a ctTree
    mov rdi, [rsi+offset_root]      ;rdi es el puntero a la raiz
    call destruir
    mov rdi, rbx ; rdi tiene el puntero al ctreee
    call free
    

	pop rbx 
    ret
    
    ;LINEAS (9)

; =====================================
; void destruir(ctNode_t* pct);
destruir:
                      ;rdi = pct que es el puntero al Nodo
    push rbp          ;
    mov rbp, rsp      ;
    push rbx          ;D
    push r12          ;A
    push r15          ;D
	sub rsp, 8          ;A


    .casoNULL:
        cmp rdi, 0    									; veo si es 0 el puntero
        je .fin       									; si lo es me salgo de la func

    .casoNoNull:
        mov r12, 0    									; r12 lo uso de contador que voy a recorrer los hijos, voy a llamar uan funcion y 
                      									; no quiero q se me cambie
        mov rbx, rdi  									; rbx ahora es el puntero al nodo que estoy destruyendo
        .ciclo:
            lea r15, [rbx + r12*Size_P + offset_child ] ; r15 ahora es la direccion del puntero puntero al nodo hijo correspondiente
            mov rdi, [r15]                                ; rdi ahora tamb lo es (=r15)
            call destruir
            inc r12
            ;sub r12, 1                                  ;decremento el contador
            cmp r12, 4                                  ; si no es 0 todavia salto a ciclo nuevamente
            jne .ciclo

														; SALI DEL CICLO EN ESTE PUNTO ASI Q LIMPIAMOS EL PUNTERO PCT que lo tenemos en rbx
        
        mov rdi, rbx                                    ; muevo a rdi el puntero pct y lo libero
        call free
       ; mov qword [rdi], 0                              ; pongo en cero dicho puntero

    .fin:
		add rsp, 8
        pop r15
        pop r12
        pop rbx

        pop rbp
        ret

		;LINEAS (24)
; ; =====================================
; ; void ct_aux_print(ctNode* node);
ct_aux_print:
        ret


; ; =====================================
; ; void ct_print(ctTree* ct, pfile);
ct_print:
	push rbx
	push r12
	push r13
			; en rdi tengo el puntero a mi ct
			; en rsi  mi pfile 
		mov r12, rdi			; en r12 tengo el puntero al ct tree
		mov rbx, rsi			; en rbx tengo el  pfile
		call ctIter_new 		; en rax tengo un puntero al iterador
		mov rdi, rax   			; lo pongo en rdi
		mov r13, rdi  			; r13 ahora es el puntero al iterador
		call ctIter_first 		; lo seteo para que empiece desde el primer nodo
		.ciclo:
			mov rdi, r13
			call ctIter_valid 	; veo si es valido, la respuesta esta en rax
			cmp rax, 0
			je .fin  			; si no es valido me salgo ya
			mov rdi, r13		; muevo el puntero al iterador a rdi
			call ctIter_get		; obtengo su valor, que lo tengo en eax
			mov rdi, rbx		; pongo en rdi el pfile
			mov rsi, printNum 	; pongo en rsi el formato de que voy a imprimir
			mov edx, eax		; pongo en edx el valor a imprimi
			call fprintf		; finalmente imprimo
			
			mov rdi, r13		; pongo el putnero al iterador en rdi, para moverlo
			call ctIter_next	; me muevo al siguient elemento
			jmp .ciclo
			
			


	.fin:
		mov rdi, r13
		call free
		pop r13
		pop r12
		pop rbx
	

		ret
		
		
		;LINEAS (26)

; =====================================
; ctIter* ctIter_new(ctTree* ct);
ctIter_new:
				; rdi = ct que es el puntero al arbol que tengo
	push rbx
	
	mov rbx, rdi 							         ; salvo el puntero a ct
	mov rdi, Size_It						       ; muevo a rdi el tamaño del it
	call malloc								          ; rax ahora tiene un puntero a un pedazo d memoria para un it
	mov [rax+offset_tree], rbx  			  ; pongo que el arbol del it sea el ct pasado por parametro
	mov qword [rax + offset_nodo], 0 		; pongo null el puntero al nodo del iterador
	mov byte [rax + offset_current], 0 		; pongo valor por defecto para current
	mov word [rax + offset_count], 0		; pongo valor por defecto para count
		pop rbx
        ret

; =====================================
; void ctIter_delete(ctIter* ctIt);
ctIter_delete:
						; en rdi ya tengo el punteor a lo que voy a liberar simplemente me qda saltar a free y que retorne con lo que le parezca a free
	jmp free
        

; =====================================
; void ctIter_first(ctIter* ctIt);
ctIter_first:
						                         ; en rdi tengo el punteor al it
  mov dword [rdi+offset_count], 1           ; le ponemos el l primer elemento
	mov rsi, [rdi + offset_tree]  			 ; en rsi tengo el puntero a arbol
	mov rsi, [rsi + offset_root]   			 ; en rsi tengo el punteor al primer nodo
	
	cmp rsi, 0								         ; me fijo si es nulla la raiz, y si lo es ya me vuelvo, nothing to do here
	je .fin
	
	mov rcx, rsi 						           ; tengo en rcx el nodo actual
	.ciclo:
		mov rax, rcx 						         ; pongo guardo el nodo actual en rax
		mov rcx, [rax+offset_child] 		 ; pongo en rcx el primer hijo
		
		cmp rcx, 0 						           ; si es null el primer hijo me salgo del ciclo y queda el ultimo nodo valido en rax
		jne .ciclo
	mov [rdi + offset_nodo], rax			 ; pongo en el it el valor del nodo con el valor mas chico
	
	.fin:
        ret

; =====================================
; void ctIter_next(ctIter* ctIt);
ctIter_next:
	push rbp
	mov rbp, rsp
	push rbx
	push r12
	push r13
	push r14
	push r15
	sub rsp, 8
xor r13, r13
xor r12, r12

  mov rax, [rdi + offset_tree]
  mov r13d, [rax + offset_size]
  mov r12d, [rdi+offset_count]
  cmp r12, r13
  jne .continuo                                   ; ESTO DEL PRINCIPIO ES POR SI YA RECORRI TODO QUE NO ME TIRE SEG FAULT EN CASO DE HACER SIG
  mov qword [rdi+offset_nodo], 0
  jmp .fin
	

  .continuo:                             ; rdi = ctIt que es el puntero a mi iterador pasado por parametro;
  add byte [rdi + offset_current], 1        ; sumo uno a current
  add dword [rdi + offset_count], 1         ; le sumo ya el siguiente elemnto
  xor rcx, rcx
  mov cl, [rdi+ offset_current]             ; rcx tien el current
  mov rsi, [rdi +offset_nodo]               ; rsi tiene el puntero al nodo actual
  
  cmp qword [rsi + rcx*Size_P + offset_child], 0   ; me fijo si el proximo hijo es null o no
  jne .bajo                                        ; si no es null voy a  tener que "bajar"
    
    .sinHijo:									   ; si es null en cambio abarco el caso sin Hijo 
      xor r8, r8
      mov r8b, [rsi + offset_len]           ; r8b tiene ahora la longitud
      cmp cl, r8b                           ; si el current es igual al leen entonces...
      jl .fin                               ; si me da que la long es mas grande que el current no tengo porq moverme y termino
      jmp .subo								
      
 
      
      .subo:   ; rdi = ctIt puntero a mi iterador ; rsi  = puntero al nodo actual ; cl = current actual del it
        
        sub rcx, 1
        mov edx, [rsi + rcx*Size_Value + offset_value]     ; edx tien emi ultimo valor recorrido
          
          .ciclo:
				mov rsi, [rsi +offset_father]         ; ahora rsi es el puntero al padre d mi anterior nodo
				cmp  [rsi+16], edx                    ;  el magico 16 es igual a offset_value + 2 * Value_size que es igual a n->value[2]
                                                  ; y comparo con mi ultimo valor, a ver si es menor o igual
				jl .ciclo
                                                  ; cuando salgo del ciclo tnego el nodo con un valor mayor a mi ultimo valor en rsi.
          xor rcx, rcx                            ; reinicio el rcx porq tengo q buscar el nuevo current valido
          
          .get:
            cmp edx, [rsi+ rcx*Size_Value + offset_value]     ; comparo el valor con edx
            jl .sigo										; si edx es mas chico ya tengo a mi current
            add rcx, 1                                       ; sino incremento rxc para la prox iter
            jmp .get                                    

          .sigo:
			  mov [rdi + offset_nodo], rsi
			  mov [rdi + offset_current], cl                  ; actualizo el iterador con los datos correspondientes y me salgo de la func

			  jmp .fin
        
         
    
    .bajo:      ; rdi = ctIt puntero a mi iterador ;rsi = puntero al nodo actual ; cl = current actual del it
        
        mov  rsi, [rsi + rcx*Size_P +offset_child]   ;rsi ahora es el puntero al hijo mas proximo
        .ciclo2:
        	cmp qword [rsi+offset_child], 0  	; me fijo si rsi tiene hijos con valorse menores
        	je .actualizarIt            		; si no lo tiene ya actualizo el it y listo
        	mov rsi, [rsi + offset_child] 		; si lo tiene muevo a rsi a ese nodo y salto denuevo al ciclo2
        	jmp .ciclo2


        .actualizarIt:
        	mov [rdi + offset_nodo], rsi
        	mov byte [rdi + offset_current], 0
        jmp .fin
          

  
    .fin:
		add rsp, 8
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbx 
		pop rbp
        ret
	

; =====================================
; uint32_t ctIter_get(ctIter* ctIt);
ctIter_get:
				                                                    ;rdi = ctIt que es un puntero a mi iterador
        xor rcx, rcx                                        ; vacio rcx para desp
        mov cl, [rdi+offset_current] 						 ; en cl tengo mi current, lo guardo ahi para poder usar el direccionamiento q intel nos da 
        
        mov rsi, [rdi + offset_nodo]  						; rsi ahora es un puntero al nodo en el que estoy
        mov eax, [rsi + rcx * Size_Value + offset_value ] 	; en eax tengo el valor a devolver  
        ret

; =====================================
; uint32_t ctIter_valid(ctIter* ctIt);
ctIter_valid:
      cmp qword [rdi+offset_nodo], 0  ; veo si es valido el nodo al que apunta
      jne .true                        ; si lo es salto a true   
      .false:
        mov eax, 0
        jmp .fin
      .true:
        mov eax, 1
        jmp .fin
      .fin:
        ret



