%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    int lex();
%}

%token BCSMAIN IF ELSE WHILE INT BOOL ID RELOP NUM
%nonassoc BCSMAIN IF ELSE WHILE INT BOOL

%%

program :   BCSMAIN '{' declist stmtlist '}'  {
    printf("Parsing Successful");
    exit(0);
}
        ;

declist :   declist decl    {}
        |   decl            {}
        ;

decl    :   type ID 
        ;

type    :   INT
        |   BOOL
        ;

stmtlist:   stmtlist ';' stmt
        |   stmt
        ;

stmt    :   ID '=' aexpr
        |   IF '(' expr ')' '{' stmtlist '}' ELSE '{' stmtlist '}'
        |   WHILE '(' expr ')' '{' stmtlist '}'
        ;

expr    :   aexpr RELOP aexpr
        |   aexpr
        ;

aexpr   :   aexpr '+' aexpr
        |   term
        ;

term    :   term '*' factor
        |   factor
        ;

factor  :   ID
        |   NUM
        ;
%%


int yyerror() {
    printf("Syntax Error");
}

int main(){
    char input_file[100];
    scanf("%s",input_file);
    FILE * fp = fopen(input_file,"r");
    if(fp)
        yyin=fp;
    yyparse();
    return 1; //Will reach here only if there is an error
}