/*
 1.Do Infix to postfix conversion where lexemes are either operators or single characters instead of numbers.

Sample input: a+b*c

Sample output: abc*+

*/

/**********DECLARATIONS*************/
%{
    #include <stdio.h>
    #include "./y.tab.h"
%}
/**********RULES*******************/
%%

[a-zA-Z]    { yylval.c = yytext[0]; return VAR; }
[+*()]      { return *yytext; }
\n          { return END; }
.           { printf("Unexpected character: %c\n", *yytext); exit(1); }

%%
/***********AUX FNS***************/
int yywrap() {
    return 1;
}