/****************DECLARATIONS*****************/

%{

    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    #include "./y.tab.h"

%}

/********************REG DEF******************/

letter [a-zA-Z]
digit [0-9]
id {letter}({letter}|{digit})*
num {digit}+

/*********************RULES*******************/

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
                                yylval.s.code = strdup("");
                                yylval.s.val = strdup(yytext);
                                return ID;
                            }
{num}                       {
                                yylval.s.code = strdup("");
                                yylval.s.val = strdup(yytext);
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
[^ \n\t]                    {
                                printf("Syntax Error\n"); exit(1); 
                            }      
                                              
%%

/*************AUXILLARY FUNCTIONS*************/

int yywrap() {
    return 1;
}