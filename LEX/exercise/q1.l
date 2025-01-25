%{
	#include <stdio.h>
	int lines=0;
	int words=0;
	int chars=0;

%}

word [a-zA-Z]+
line "\n"
%option noyywrap

%%
{word}		{
			words+=1;
			chars+=yyleng;
			printf("%s",yytext);
		}
{line}		{
			lines+=1;
			printf("%s",yytext);
		}
%%

int main(){
	yyin = fopen("inp1.txt","r");
	yylex();
	printf("OUTPUT\nLines:%d\nWords:%d\nCharacters:%d\n",lines,words,chars);
	return 1;
	
}

