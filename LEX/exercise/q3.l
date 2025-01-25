%{
	#include <stdio.h>
%}

req A[A-Z][A-Z]
%option noyywrap

%%
{req} 		{
			printf("%s\n",yytext);
		}	
.		{	printf("");
		}

%%

int main(){
	yyin = fopen("inp3.txt","r");
	yylex();
	return 1;
}
