#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "cuatrotree.h"

void mostrar(ctNode* n){
	printf("%s : ", "Los valores son: " );
	for(int i = 0; i < 3; i ++) printf(" %d, ", n->value[i] );
}

int main (void){
    char* name = "cambiameporotronombre.txt";
    FILE *pFile = fopen( name, "a" );
    
    fprintf(pFile,"-\n");
        
    fclose( pFile );

    ctTree* ct;
    ct_new(&ct);

    ct_add(ct, 10);
    ct_add(ct, 50);
    ct_add(ct, 30);
    ct_add(ct, 5);
    ct_add(ct, 20);
    ct_add(ct, 40);
    ct_add(ct, 60);
    ct_add(ct, 19);
    ct_add(ct, 39);
    ct_add(ct, 4);
    
    
    ctIter* it;
    it=ctIter_new(ct);
    ctIter_first(it);
    int i = 0;
    while(ctIter_valid(it)){
         printf("%d\n", ctIter_get(it) );
        ctIter_next(it);
        
    }
    ct_delete(&ct); 
    ctIter_delete(it);
    



    return 0;    
}
