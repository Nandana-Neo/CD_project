%{
    #include <stdio.h>
    #include <stdlib.h>
    int yyerror();
    int yylex();
%}

%union{
    char c;
};

%token VAR
%token END
%left '+'
%left '*'

%%
start : expr END   {printf("\nComplete\n"); exit(0);}   //Exit here itself if no errors found
      /* | expr {printf("\nComplete\n"); exit(0) ;} */
      ;

expr : expr '+' expr    {printf("+");}
     | expr '*' expr    {printf("*");}
     | VAR              {printf("%c",$<c>1);}
     | '(' expr ')'     {/*No action req*/}
     ;
%%

int yyerror() {
    printf("\nError\n");
}

int main(){
    yyparse();
    return 1; //Will reach here only if there is an error
}