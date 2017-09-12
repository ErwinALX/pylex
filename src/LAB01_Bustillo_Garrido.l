%{
/* need this for the call to atof() below */
#include <stdlib.h>
%}

DIGIT    [0-9]
ID       [a-zA-z][a-zA-z0-9]*
INT      {DIGIT}+
REAL     {DIGIT}*"."{DIGIT}+
ASSIGN   =

%%

{INT}       {
            printf( "An integer: %s (%d)", yytext,
                    atoi( yytext ) );
            }

{REAL}      {
            printf( "A float: %s (%g)", yytext,
                    atof( yytext ) );
            }

if          printf( "The keyword: %s", yytext );

{ID}        printf( "Id=%s", yytext );

[ \t]+      printf( "\t" );

[ \n]+      printf( "\n" );

{ASSIGN}    printf( "assign=%s", yytext );

.           printf( "Unrecognized character: %s", yytext );
