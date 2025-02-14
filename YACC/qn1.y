%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	char c;
	int depth = 1;
	char buffer[100];
	int pos = 0;
%}

%token IF
%token THEN 
%token ELSE
%token ID
%token NUM
%token RELOP

%nonassoc RELOP
%left '+'
%left '*'
%%
start : expr '\n'			{printf("Complete\n");exit(1);}
  	  ;


expr : IF cond THEN expr ELSE expr 	{printf("Level:%d\n",$1);}
     | IF cond THEN expr	 	{printf("Level:%d\n",$1);}
     | var '+' var			{}
     | var '*' var			{}
     | '(' expr ')'			{}
	;

var : ID				{}
    | NUM				{}
	;

cond : var RELOP var			{}
     	;

%%

yyerror() {
	printf("Error\n");
}

yylex() {
	if(c==' ') {	
		c=getchar();
		yylex();
	}
	else if(isdigit(c)){
		while(isdigit(c)){
			c=getchar();
		}
		return NUM;
	}
	else if(c=='+' || c=='*' || c=='(' ||c==')'){
		char l=c;
		c=getchar();
		return l;
	}
	else if(c=='\n'){
		return c;
	}
	else{
		buffer[0] =  c;
		pos = 0;
		pos++;
		c=getchar();
		while(c!='\n' && c!=' '){
			buffer[pos++] = c;
			c=getchar();
		}
		buffer[pos] = '\0';
		if(strcmp(buffer,"if") == 0){
			yylval = depth;
			depth++;
			return IF;
		}
		else if(strcmp(buffer,"then")==0){
			return THEN;
		}
		else if(strcmp(buffer,"else")==0){
			return ELSE;
		}
		else if(strcmp(buffer,"relop")==0){
			return RELOP;
		}
		else{
			return ID;
		}
	}
}
main() {
	c=getchar();
	yyparse();
	return 1;
}
