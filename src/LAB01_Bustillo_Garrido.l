%{
/* need this for the call to atof() below */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void almacenar_nombre(char *c);
int obtener_indice(char *c);
void string_upr(char *s);

char nombres[1000][1000];
int cantidad_identificadores = 0;
int num_errores = 0;
%}

DIGIT       [0-9]
ID          (_|[a-zA-Z])([a-zA-Z0-9]|_)*
SIGN        [+-]?
INT         {SIGN}{DIGIT}+
LONG        {INT}+(L|l)
EXPART      e{SIGN}{DIGIT}+
DECIMAL     {SIGN}({DIGIT}*)\.{DIGIT}+{EXPART}?
NUMERIC     {INT}|{DECIMAL}
IMAGINARY   {NUMERIC}(j|J)
BOOL        False|True
FUNCTIONS   range
KEYWORD     and|break|continue|def|elif|else|for|if|import|in|is|not|or|pass|print|return|while
OPERATORS   +|<<|<|-|>>|>|*|&|<=|**|||>=|/|^|==|//|~|!=|%|<>
DQSTR       \"(\\.|[^"])*\"
SQSTR       '(\\.|[^'])*'
STRING      {DQSTR}|{SQSTR}
DELIM       (|,|+=|&=|)|:|-=||=|[|.|*=|^=|]|>>=|/=|**=|=|<<=|//=|%=|;
COMMENT     #.*\n

%%

{KEYWORD}               {
                            string_upr(yytext);
                            printf("%s ", yytext);
                        }

{INT}                   printf("entero= %s ", yytext);

{LONG}                  printf("long= %s ", yytext);

{DECIMAL}               printf("real= %s ", yytext);

{IMAGINARY}             printf("imaginario= %s ", yytext);

{BOOL}                  {
                            string_upr(yytext);
                            printf("%s ", yytext);
                        }

{FUNCTIONS}             {
                            string_upr(yytext);
                            printf("%s ", yytext);
                        }

{STRING}                printf("cadena= %s ", yytext);

{ID}                    {
                            almacenar_nombre(yytext);
                            printf("id%i= %s ", obtener_indice(yytext), yytext);
                        }

"("                     printf("parabre= ( ");

")"                     printf("parcierr= ) ");

"["                     printf("corabre= [ ");

"]"                     printf("corcierr= ] ");

"="                     printf("assign= = ");

","                     printf("coma= , ");

":"                     printf("dospunt= : ");

"+"	                printf("suma= + ");

"<<"	                printf("left_shift= << ");

"<"	                printf("menor= < ");

"-"	                printf("resta= - ");

">>"	                printf("right_shift= >> ");

">"	                printf("mayor= > ");

"*"	                printf("mult= * ");

"&"	                printf("log_and= & ");

"<="	                printf("menor_ig= <= ");

"**"	                printf("exp_op= ** ");

"|"	                printf("log_or= | ");

">="	                printf("mayor_ig= >= ");

"/"	                printf("div= / ");

"^"	                printf("log_xor= ^ ");

"=="	                printf("comp= == ");

"//"	                printf("dob_div= // ");

"~"	                printf("tilde= ~ ");

"!="	                printf("dif= != ");

"%"	                printf("perc= %% ");

"<>"	                printf("sig_dif= <> ");

"+="			printf("mas_i= += ");

"-="			printf("menos_i= -= ");

"*="			printf("mult_i= *= ");

"/="			printf("div_i= /= ");

"&="			printf("log_and_i= &= ");

"|="			printf("log_or_i= |= ");

"^="			printf("log_xor_i= ^= ");

"**="			printf("exp_op_i= **= ");

"<<="			printf("left_shift_i= <<= ");

">>="			printf("right_shift_i= >>= ");

"//="			printf("dob_div_i= //= ");

"%="			printf("perc_i= %%= ");

";"			printf("punt_coma= ; ");

[\n]+                   printf("\n");

[ ]                     printf(" ");

{COMMENT}               printf("\n");

.                       {
                            ++num_errores;
                            printf("ERROR= %s", yytext);
                        }

%%

int main(int argc[], char **argv[]){
   yyin = fopen("entrada.txt", "r");
   yyout = fopen("salida.txt", "wb");
   yylex();

   printf("\n%i identificadores\n\n", cantidad_identificadores);

   for (int i = 0; i < cantidad_identificadores; ++i) {
      printf("id%i=%s\n", i + 1, nombres[i]);
   }

   printf("\n");

   if (num_errores == 1) {
       printf("%d Error", num_errores);
   } else {
       printf("%d Errores", num_errores);
   }

   printf("\n");
   printf("\n");

   return 0;
}

void almacenar_nombre(char *c) {
   for (int i = 0; i < cantidad_identificadores; ++i) {
	int resultado = strcmp(c, nombres[i]);
	if (resultado == 0) {
	   return;
	}
   }

   strcpy(nombres[cantidad_identificadores], c);
   ++cantidad_identificadores;
}

int obtener_indice(char *c) {
   for (int i = 0; i < cantidad_identificadores; ++i) {
	int resultado = strcmp(c, nombres[i]);
	if (resultado == 0) {
	   return i + 1;
	}
   }
   return -1;
}

void string_upr(char *s) {
    int i = 0;
    while (s[i] != '\0') {
        if (s[i] >= 'a' && s[i] <= 'z') {
            s[i] = s[i] - 32;
        }
        ++i;
    }
}
