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
  %define offSet_size 8
  %define offSet_root 0 
  
  %define Size_P 8

	; define sobre nodos
  %define offSet_value 8
  %define offSet_child 21

	; define sobre iterCt
  %define Size_It 21
  %define offset_tree 0
  %define offset_nodo 8
  %define offset_current 16
  %define offset_count 17
 
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
    mov [rbx], rax                 ; ahora efectivamente rbx apunta a un puntero que si apunta a una direccion valida d memoria
   
    mov rdi, [rbx]                    ; rdi ahora es un puntero directo al ctree
    mov qword [rdi+offSet_root], 0 		;pongo como nullo el puntero a la raiz del ctree
    mov word [rdi+offSet_size], 0     ; pongo que el tamaño del ctTree sea 0
    
    
    pop rbx                           ; restablesco rbx    
    ret

; =====================================
; void ct_delete(ctTree** pct);
ct_delete:
                                    ;rdi = oct que es el puntero a puntero a  ctTree
    mov rsi, [rdi]                  ;rsi es el puntero a ctTree
    mov rdi, [rsi+offSet_root]      ;rdi es el puntero a la raiz
    call destruir

    ret

; =====================================
; void destruir(ctNode_t* pct);
destruir:
                      ;rdi = pct que es el puntero al Nodo
    push rbp          ;
    mov rbp, rsp      ;
    push rbx          ;A
    push r12          ;D
    push r15          ;A   SEG FAULT AL HACER ESTE PUSH!!! PORQUE????????????????
  


    .casoNULL:
        cmp rdi, 0    									; veo si es 0 el puntero
        je .fin       									; si lo es me salgo de la func

    .casoNoNull:
        mov r12, 4    									; r12 lo uso de contador que voy a recorrer los hijos, voy a llamar uan funcion y 
                      									; no quiero q se me cambie
        mov rbx, rdi  									; rbx ahora es el puntero al nodo que estoy destruyendo
        .ciclo:
            lea r15, [rbx + r12*Size_P + offSet_child ] ; r15 ahora es el puntero al nodo hijo correspondiente
            mov rdi, r15                                ; rdi ahora tamb lo es (=r15)
            call destruir
            sub r12, 1                                  ;decremento el contador
            cmp r12, 0                                  ; si no es 0 todavia salto a ciclo nuevamente
            jne .ciclo

														; SALI DEL CICLO EN ESTE PUNTO ASI Q LIMPIAMOS EL PUNTERO PCT que lo tenemos en rbx
        
        mov rdi, rbx                                    ; muevo a rdi el puntero pct y lo libero
        call free
        mov qword [rdi], 0                              ; pongo en cero dicho puntero


    .fin:
        pop r15
        pop r12
        pop rbx

        pop rbp
        ret


; ; =====================================
; ; void ct_aux_print(ctNode* node);
ct_aux_print:
        ret

; ; =====================================
; ; void ct_print(ctTree* ct);
ct_print:
        ret

; =====================================
; ctIter* ctIter_new(ctTree* ct);
ctIter_new:
				; rdi = ct que es el puntero al arbol que tengo
	push rbx
	mov rbx, rdi 							; salvo el puntero a ct
	mov rdi, Size_It						; muevo a rdi el tamaño del it
	call malloc								; rax ahora tiene un puntero a un pedazo d memoria para un it
	mov [rax+offset_tree], rbx  			; pongo que el arbol del it sea el ct pasado por parametro
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
        ret

; =====================================
; void ctIter_first(ctIter* ctIt);
ctIter_first:
						; en rdi tengo el punteor al it
	mov rsi, [rdi+offset_tree]  			; en rsi tengo el puntero a arbol
	mov rsi, [rsi+offset_root]				; en rsi tengo el punteor al primer nodo
	
	cmp rsi, 0								; me fijo si es nulla la raiz, y si lo es ya me vuelvo, nothing to do here
	je .fin
	
	mov rcx, rsi 							; tengo en rcx el nodo actual
	.ciclo:
		mov rax, rcx 						; pongo guardo el nodo actual en rax
		mov rcx, [rax+offset_child] 		; pongo en rcx el primer hijo
		
		cmp rcx, 0 							; si es null el primer hijo me salgo del ciclo y queda el ultimo nodo valido en rax
		jne .ciclo
	mov [rdi + offset_nodo], rax			; pongo en el it el valor del nodo con el valor mas chico
	
	.fin:
        ret

; =====================================
; void ctIter_next(ctIter* ctIt);
ctIter_next:
        ret

; =====================================
; uint32_t ctIter_get(ctIter* ctIt);
ctIter_get:
        ret

; =====================================
; uint32_t ctIter_valid(ctIter* ctIt);
ctIter_valid:
        ret



