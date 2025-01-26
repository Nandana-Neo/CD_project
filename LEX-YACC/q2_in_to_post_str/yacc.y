%{
    #include <stdio.h>
    #include <stdlib.h>
    
%}

%union{
    char *s;
    char c;
};

%token VAR
%token END
%token SPACE
%left '+'
%left '*'

//Input will print Complete only if \n is given in the input.txt
%%

start   : expr END   {printf("\nComplete\n"); exit(0);}
        ;


expr    : expr '+' expr     {printf("+ ");}
        | expr '*' expr     {printf("* ");}
        | '(' expr ')'      {/*Ignore*/}
        | VAR               {printf("%s ",$<s>1);}
        ;



%%

int yyerror() {
    printf("\nError\n");
}

int main(){
    yyparse();
    return 1; //Will reach here only if there is an error
}