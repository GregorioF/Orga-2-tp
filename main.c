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

    ct_add(ct, 50);
    ct_add(ct, 1);
    ct_add(ct,100);
    ct_add(ct , 25);
    ct_add(ct, 10);
    // los esta agregando piola

    ct_delete(&ct);




    return 0;    
}
