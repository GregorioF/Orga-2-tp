; FUNCIONES de C
  extern malloc
  extern free
  extern fprintf
   
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

  %define ctSize 12
  %define offSet_size 8
  %define offSet_root 0 
  %define Size_P 8
  %define offSet_value 8
  %define offSet_child 21
 
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
    push r15          ;A


    .casoNULL:
        cmp rdi, 0    ; veo si es 0 el puntero
        je .fin       ; si lo es me salgo de la func

    .casoNoNull:
        mov r12, 4    ; r12 lo uso de contador que voy a recorrer los hijos, voy a llamar uan funcion y 
                      ; no quiero q se me cambie
        mov rbx, rdi  ; rbx ahora es el puntero al nodo que estoy destruyendo
        .ciclo:
            lea r15, [rbx + r12*Size_P + offSet_child ]  ; r15 ahora es el puntero al nodo hijo correspondiente
            mov rdi, r15                                 ; rdi ahora tamb lo es (=r15)
            call destruir
            sub r12, 1                                   ;decremento el contador
            cmp r12, 0                                   ; si no es 0 todavia salto a ciclo nuevamente
            jne .ciclo

                                     ; SALI DEL CICLO EN ESTE PUNTO ASI Q LIMPIAMOS EL PUNTERO PCT que lo tenemos en rbx
        
        mov rdi, rbx                                     ; muevo a rdi el puntero pct y lo libero
        call free
        mov qword [rdi], 0                                ; pongo en cero dicho puntero


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
        ret

; =====================================
; void ctIter_delete(ctIter* ctIt);
ctIter_delete:
        ret

; =====================================
; void ctIter_first(ctIter* ctIt);
ctIter_first:
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



