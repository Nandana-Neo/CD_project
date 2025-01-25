%{
	#include <stdio.h>
	#include <stdlib.h>
	char c;
%}

%token VAR

%%
start : VAR '\n'  {printf("Complete"); exit(1);}
      ;
%%

yyerror() {
	printf("Error");
}

yylex() {
	
	if((c>='a' && c<='z') || (c>='A' && c<= 'Z')){
		while((c>='a' && c<='z') || (c>='A' && c<= 'Z') || (c>='0' && c<='9')){
		c=getchar();
		}
		return VAR;
	}
	else if(c=='\n')
		return c;
}

main() {
	c = getchar();
	yyparse();
	return 1;
}
