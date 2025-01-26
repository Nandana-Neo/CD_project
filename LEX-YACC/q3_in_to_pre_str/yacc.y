%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
%}

%union{
    char *s;
    char c;
};

%token VAR
%token END
%left '+'
%left '*'

//Input will print Complete only if \n is given in the input.txt
%%

start   : expr END   {printf("%s\nComplete\n",$<s>1); exit(0);}
        ;


expr    : expr '+' expr     { 
    int len = strlen($<s>1) + strlen($<s>3) + 5;
    char* word = (char*) malloc(len*sizeof(char));
    sprintf(word, "+ %s %s ", $<s>1, $<s>3);
    $<s>$ = strdup(word);
    free(word);
 }

        | expr '*' expr     {
    int len = strlen($<s>1) + strlen($<s>3) + 5;
    char* word = (char*) malloc(len*sizeof(char));
    sprintf(word, "* %s %s ", $<s>1, $<s>3);
    $<s>$ = strdup(word);
    free(word);
}
        | '(' expr ')'      {$<s>$ = $<s>2;}
        | VAR               {$<s>$=$<s>1;}
        ;



%%

int yyerror() {
    printf("\nError\n");
}

int main(){
    yyparse();
    return 1; //Will reach here only if there is an error
}