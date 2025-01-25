%{
	#include <stdio.h>
%}

single "//"(.)*
multi "/*"[^"*/"]*"*/"

%option noyywrap

%%
{single} 	{printf("%s\n",yytext);}
{multi}		{printf("%s\n",yytext);}
(.)		{printf("");}
"\n"		{printf("");}

%%

int main(){
	FILE * fp = fopen("inp4.txt","r");
	if(fp){
		yyin = fp;
	}
	yylex();
	return 1;
}

