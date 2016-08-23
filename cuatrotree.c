#include "cuatrotree.h"
extern void ct_new(ctTree** pct);

ctNode* nuevoNodo(ctNode* father){
    ctNode* res = malloc (sizeof(ctNode));
    res -> father = father;                                                //SETEO TODOS LOS ELEMENTOS
    for(int i = 0; i <3; i ++) res -> value [i] = 0;
    res -> len = 0;
    for(int i = 0 ; i < 4; i ++) res -> child [i]= NULL;
    return res;
}

void ct_add(ctTree* ct, uint32_t value) {
    if( ct->root == NULL) ct->root = nuevoNodo(NULL);
    ctNode * n= ct->root;
    ct->size +=1;
    
    while(n->len == 3){
          uint32_t a = n->value[0];
          uint32_t b = n->value[1];
          uint32_t c = n->value[2];
          if ( value < a ){
              if( n->child [0] == NULL) n->child [0] = nuevoNodo( n );        
              n = n -> child [0];
          }
          else if ( value < b ){
              if( n->child [1] == NULL) n->child [1] = nuevoNodo( n );      
              n = n -> child [1];
          }
          else if ( value < c ){
              if( n->child [2] == NULL) n->child [2] = nuevoNodo( n );       
              n = n -> child [2];
          }
          else{
              if( n->child [3] == NULL) n->child [3] = nuevoNodo( n );   
              n = n -> child [3];
          }

          // EN ESTE PUNTO N AHORA ES UN NUEVO NODO O UN NODO HIJO YA EXISTENTE Y ANTES DE ENETRAR AL WHILE VA A HABER SI
          // HAY LUGAR PARA MI VALOR QUE QUIERO METER
    }

    if(n->len == 0){
        n->value [0] = value;
        n-> len +=1;
    }
    else if( n -> len == 1){
        if(value > n->value[0]) n->value [1] = value;
        else {
            n->value [1] = n->value [0];
            n->value [0] = value;
        }
        n-> len +=1;
    }
    else {
        if(value < n->value [0]){
            n->value [2] = n->value [1];
            n->value [1] = n->value [0];
            n->value [0] = value;
        }
        else if(value < n->value [1]){
            n->value [2] = n->value [1];
            n->value [1] = value ;
        }
        else n->value [2]= value;
        n->len +=1;
    }

    //LESTO :D
}








/*
 * 		; rdi = ctIt que es el puntero a mi iterador pasado por parametro;
	add byte [rdi + offset_current], 1 				; sumo uno a current
	mov cl, [rdi+ offset_current]  					; rcx tien el current
	mov rsi, [rdi +offset_nodo] 					; rsi tiene el puntero al nodo actual
    cmp [rsi + cl*Size_p + offset_child], 0 
    jne .bajo
    .sinHijo:
			mov r8b, [rsi + offset_len] 			; r8b tiene ahora la longitud
			cmp [rdi+offset_current], r8b			
			jb .fin									; si me da que la long es mas grande que el current o igual ya ta termino el prog
			
			
			.subo:
				; rdi = ctIt puntero a mi iterador
				; rsi  = puntero al nodo actual ;
				; cl = current actual del it
				sub cl, 1
				mov edx, [rsi + cl*Size_Value + offset_value] 		; edx tien emi ultimo valor recorrido
				.ciclo:
					mov rsi, [rsi +offset_father]
					cmp  [rsi+16], edx  							;  el magico 16 es igual a offset_value + 2 * Value_size que es igual a n->value[2]
																	; y comparo con mi ultimo valor, a ver si es menor o igual
					jbe .ciclo
																	; cuando salgo del ciclo tnego el nodo actual en rsi
				
				 
    
    .bajo:
    
    
    .fin:
        ret
        * */
