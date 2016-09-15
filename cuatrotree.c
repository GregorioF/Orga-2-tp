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


int yaAgregue( ctTree* ct, uint32_t value){                              ///FUNCION Q ME DICE SI UN VALOR YA ESTA, LA VERDAD ES MALISIMA LO SE,PERO NO VALUAMOS COMPLEGIDAD
																		 /// MUAJAJAJAJAJ, NV EN ALGORITMOS 				
	ctNode* n = ct->root;
	while(n != NULL){
		for(int i = 0; i < n->len; i ++){
			if( n ->value [i] == value) return 1;
		}
		
		if ( value < n->value[0] ) {
			  n = n -> child [0];
		  }
		else if ( value < n->value [1] ){
			  n = n -> child [1];
		  }
		else if ( value < n->value [2] ){
			  n = n -> child [2];
		  }
		else{
			  n = n -> child [3];
		}
		
	}
	return 0;

}

int pertenece(ctNode* n, uint32_t value){
	int len = n-> len;
	for(int i =0; i < len ; i++) if(n->value [i] == value) return 1;
	return 0;
}

void ct_add(ctTree* ct, uint32_t value) {
    if( ct->root == NULL) ct->root = nuevoNodo(NULL);
    ctNode * n= ct->root;
    int yaLoAgregue = 0;
    
       
	while(n->len == 3 ){
		  uint32_t a = n->value[0];
		  uint32_t b = n->value[1];
		  uint32_t c = n->value[2];
		 	yaLoAgregue = pertenece(n, value)+yaLoAgregue;

		 if(yaLoAgregue == 0){
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
		}
		else break;
		

		  // EN ESTE PUNTO N AHORA ES UN NUEVO NODO O UN NODO HIJO YA EXISTENTE Y ANTES DE ENETRAR AL WHILE VA A HABER SI
		  // HAY LUGAR PARA MI VALOR QUE QUIERO METER
	}

		yaLoAgregue = yaLoAgregue + pertenece(n,value);

		if(yaLoAgregue == 0){

			ct->size +=1;
		

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

		}			//LESTO :D
	
}




