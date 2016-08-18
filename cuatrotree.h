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
{
  *pct = malloc(sizeof(ctTree));
  ctTree* ct = *pct;
  ct->root = NULL;
  ct->size = 0;
}*/
/*
void destruir(ctNode_t* n){
	int i=0;
	if(n!=NULL){
		while(i<4){
			destruir(child[i]);
			i++;
		}
		free(n);
	}
	n = NULL;
}*/

void ct_delete(ctTree** pct);
/*{
  ctTree* ct = *pct;	
  destruir(ct->root);
  free(ct);
  ct = NULL;
}*/
void ct_add(ctTree* ct, uint32_t value);

void ct_print(ctTree* ct, FILE *pFile);


/** Funciones de Iterador de CuatroTree **/

ctIter* ctIter_new(ctTree* ct);

void ctIter_delete(ctIter* ctIt);

void ctIter_first(ctIter* ctIt);

void ctIter_next(ctIter* ctIt);

uint32_t ctIter_get(ctIter* ctIt);

uint32_t ctIter_valid(ctIter* ctIt);

