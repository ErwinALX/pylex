#include <stdio.h>
#include <string.h>

void sumar();
void almacenarNombre(char *c);
int cantidad_identificadores = 0;
char nombres[1000][1000];

int main(){
   almacenarNombre("prueba");
   almacenarNombre("prueba2");
   almacenarNombre("prueba3");
   int i=0;
   for (i=0;i<cantidad_identificadores;++i){
	printf("esto es:%s\n",nombres[i]);
   }
}

void almacenarNombre(char *c){
   int i=0;
   for (i=0;i<cantidad_identificadores;++i){
	int resultado=strcmp(c,nombres[i]);
	if (resultado==0){
	   return;
	}
   }
   strcpy(nombres[cantidad_identificadores], c);
   ++cantidad_identificadores;
}
