/***********DECLARATIONS*****************/

%{

    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include "./y.tab.h"

%}
/*********REG DEF***********/
letter [a-zA-Z]
digit [0-9]
id {letter}({letter}|{digit})*
num {digit}+

/***********RULES************/
%%
"BcsMain"                   {
                                return BCSMAIN;
                            }
"if"                        {
                                return IF;
                            }
"else"                      {
                                return ELSE;
                            }
"while"                     {
                                return WHILE;
                            }
"int"                       {
                                return INT;
                            }
"bool"                      {
                                return BOOL;
                            }
{id}                        {
                                return ID;
                            }
{num}                       {
                                return NUM;
                            }
"<="                        {
                                return RELOP;
                            }
">="                        {
                                return RELOP;
                            }
"=="                        {
                                return RELOP;
                            }
"!="                        {
                                return RELOP;
                            }

[<>]                        {
                                return RELOP;
                            }

[{}()=;+*]                  {
                                return *yytext;
                            }
[^ \n]                      {
                                printf("Syntax Error\n"); exit(1); 
                            }      
                                              
%%
/************AUX FNS*************/
int yywrap() {
    return 1;
}