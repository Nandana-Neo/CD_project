%{
	#include <stdio.h>
	int integers = 0;
	int fl = 0;
%}

int_num [0-9]+
int_fl 	[0-9]+"."[0-9]+
%option noyywrap

%%
{int_num} 	{
			printf("%s",yytext);
			integers++;
		}	
{int_fl}	{
			printf("%s",yytext);
			fl++;
		}

%%

int main(){
	yyin = fopen("inp2.txt","r");
	yylex();
	printf("\nOUTPUT\nIntegers:%d\nFloating:%d\n",integers,fl);
	return 1;
}
