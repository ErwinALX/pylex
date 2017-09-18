%{
#include <stdio.h>
#include <string.h>
 void almacenarNombre(char *c);
 int obtenerIndice(char *c);
 void stringUpr(char *s);
%}
 char nombres[1000][1000];
 int cantidad_identificadores = 0;
ENTERO        [+-]?[0-9]+
LONG    [+-]?[0-9]+(L|l)
DECIMAL   [-+]?[0-9]*.?[0-9]+([e][-+]?[0-9]+)?
ID       (_|[a-zA-Z])([a-zA-Z0-9]|_)*
PALABRA  and|break|continue|def|elif|else|for|if|import|in|is|not|or|pass|print|return|while
OPERADORES +|<<|<|-|>>|>|*|&|<=|**|||>=|/|^|==|//|~|!=|%|<>
CADENA ('|")^('|"|\n)*('|")
DELIMITADORES (|,|+=|&=|)|:|-=||=|[|.|*=|^=|]|>>=|/=|**=|=|<<=|//=|%=|;
%%
{PALABRA} stringUpr(yytext); printf( "%s", yytext );
{ENTERO} printf("ENTERO=%s", yytext);
{LONG} printf("LONG=%s", yytext);
{DECIMAL} printf("DECIMAL=%s", yytext);
({ENTERO}|{DECIMAL})(j|J) printf("IMAGINARIO=%s", yytext);
{ID}    almacenarNombre(yytext);printf("id%i=%s",obtenerIndice(yytext), yytext);
"+"	printf("suma");
"<<"	printf("a");
"<"	printf("b");
"-"	printf("Menos");
">>"	printf("c");
">"	printf("d");
"*"	printf("mult");
"&"	printf("e");
"<="	printf("menor_ig");
"**"	printf("f");
"|"	printf("g");
">="	printf("mayor_ig");
"/"	printf("div");
"^"	printf("h");
"=="	printf("i");
"//"	printf("j");
"~"	printf("k");
"!="	printf("l");
"%"	printf("n");
"<>"	printf("o");
   

#*\n 	printf("\n");

%%

int main(int argc[], char **argv[]){
   yyin = fopen("entrada.txt", "r");
   yyout = fopen("salida.txt", "wb");
   yylex();
   int i=0;
   printf("%i identificadores\n", cantidad_identificadores);
   for (i=0;i<cantidad_identificadores;++i){
      printf("id%i=%s\n", i + 1, nombres[i]);
   }

   
   return 0;
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

int obtenerIndice(char *c){
   int i=0;
   for (i=0;i<cantidad_identificadores;++i){
	int resultado=strcmp(c,nombres[i]);
	if (resultado==0){
	   return i + 1;
	}
   }
   return -1;
}

void stringUpr(char *s)
{
    int i=0;
    while(s[i]!='\0')
    {
        if(s[i]>='a' && s[i]<='z'){
            s[i]=s[i]-32;
        }
        ++i;
    }
}
