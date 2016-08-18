#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

/** Estructuras **/

#define NODESIZE 3

typedef struct ctTree_t {
  struct ctNode_t* root;   	//8 bytes
  uint32_t size;			//4 bytes
} __attribute__((__packed__)) ctTree;  // total 12 bytes

typedef struct ctNode_t {
  struct ctNode_t* father;  	// 8 bytes
  uint32_t value[NODESIZE];		// 4*3 = 12 bytes
  uint8_t len;					// 1 byte
  struct ctNode_t* child[NODESIZE+1]; // 8*4 = 32 bytes
} __attribute__((__packed__)) ctNode; // total 53 bytes

typedef struct ctIter_t { 		
  ctTree* tree;					// 8 bytes
  struct ctNode_t* node;		// 8 bytes
  uint8_t current;				// 1 bytes
  uint32_t count;				// 4 bytes
} __attribute__((__packed__)) ctIter; //total 21 bytes


/** Funciones de CuatroTree **/

void ct_new(ctTree** pct);
/*
//CODIGO EN C DE LO QUE ESTA IMPLEMENTADO EN ASSMEBLER

{
  *pct = malloc(sizeof(ctTree));
  ctTree* ct = *pct;
  ct->root = NULL;
  ct->size = 0;
}


}*/

void ct_delete(ctTree** pct);
/*
//CODIGO EN C DE LO QUE ESTA IMPLEMENTADO EN ASSMEBLER
* 
* void destruir(ctNode_t* n){
	int i=0;
	if(n!=NULL){
		while(i<4){
			destruir(child[i]);
			i++;
		}
		free(n);
	}
	n = NULL;

  {
  ctTree* ct = *pct;	
  destruir(ct->root);
  free(ct);
  ct = NULL;
}*/



void ct_add(ctTree* ct, uint32_t value);

void ct_print(ctTree* ct, FILE *pFile);


/** Funciones de Iterador de CuatroTree **/



ctIter* ctIter_new(ctTree* ct);
/*
 CODIGO EN C D LO QUE ESTA  IMPLEMENTADO EN ASEMBLER
	ctIter* res ;
	res = malloc(sizeof(ctIter));
	res -> tree = ct;
	res-> node = NULL;
	res->current = 0;
	res->count = 0; 
	
 */

void ctIter_delete(ctIter* ctIt);
/*
 CODIGO EN C DE LO QUE ESTA IMPLEMENTADO EN ASEMBLER
 
	free (ctIt)
 */


void ctIter_first(ctIter* ctIt);
/*
 CODIGO EN C DE LO QUE ESTA IMPLMENTADO EN ASEMBLER
 
	ctTree * ct = ctIt -> tree;
	ctNode * n = ct -> root;
	if( n != NULL) while(n->child [0] != NULL) n = n->child [0];   // salgo de este while con el nodo que tiene el menor  dato
	ctIt->node =  n ;
 
 */

void ctIter_next(ctIter* ctIt);

/*
 * up(ctIter* ctIt){
	 * 	ctNode* n = ctIt->node;
	 *  uint32_t v = n->value[ctIt->current-1];
	 * 	while( n->value [2] < v) n = n->father; // salgo del while en el nodo donde se va a tener  qu eubicar el iterador
	 * 	int i =0;
	 * while( n->value[i] < v){
	 * 			 i ++;
	 * }
	 * ctIt->node = n ;
	 * ctIt ->current = i;  	 
	 *		 
 * }
 * 
 * next{
 *		ctIt -> current +=1;
 *		ctNode * n = ctIt->node;
 *		if( n->child[ctIt->current] == NULL ){
 *				if(n->len < ctIt->current) up(ctIt);
 *				
 *		 }
 *		 else{
 *			down(ctIt);
 *		}
 *		ctIt -> count +=1;
 *	}
 */


uint32_t ctIter_get(ctIter* ctIt);
/*
	ctIt->node->value[ctIt->current];
 */

uint32_t ctIter_valid(ctIter* ctIt);

