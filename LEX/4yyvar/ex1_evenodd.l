%option noyywrap
%{
	#include <stdlib.h>
	#include <stdio.h>
%}
	
number [0-9]+
 
%%
 
{number} {if((atoi(yytext))%2 == 0)
printf("Even");
else 
printf("Odd");
return 1;}
 
%%
 
int main()
{
	yylex();
	return 1;
}
