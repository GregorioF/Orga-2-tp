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

  %define ctSize, 12
  %EQU offSet_size, 8
  %EQU offset_root, 0 
 
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
    mov word [rdi+offset_size], 0     ; pongo que el tamaño del ctTree sea 0
    
    pop rbx                           ; restablesco rbx    
    ret

; =====================================
; void ct_delete(ctTree** pct);
ct_delete:
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



