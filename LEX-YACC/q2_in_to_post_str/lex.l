/*
 2.Do symbolic infix to postfix conversion:

Sample input: hello+my*world

Sample output: hello my world * +
*/

/**********DECLARATIONS*************/
%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include "./y.tab.h"
%}
/**********RULES*******************/

id [a-zA-Z]+
%%

{id}        {
    yylval.s = strdup(yytext);
    return VAR; 
}



[*+()]      {
    return *yytext; 
}



\n          { return END; }


%%
/***********AUX FNS***************/
int yywrap() {
    return 1;
}