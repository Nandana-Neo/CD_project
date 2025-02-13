%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    int yylex();
    int yyerror();
    extern FILE* yyin;
%}

%token BCSMAIN IF ELSE WHILE INT BOOL ID RELOP NUM
%nonassoc BCSMAIN IF ELSE WHILE INT BOOL RELOP

%%

program :   BCSMAIN '{' declist stmtlist '}'  {
    printf("Parsing Successful\n");
    exit(0);
}
        ;

declist :   declist decl    {}
        |   decl            {}
        ;

decl    :   type ID ';'
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
    printf("\nSyntax Error\n");
}

int main(int argc, char ** argv){
    char input_file[100];
    if(argc > 1) {
        strcpy(input_file,argv[1]);
        
        FILE * fp = fopen(input_file,"r");
        if(fp){
                yyin=fp;
        }
        yyparse();
    }
    return 1; //Will reach here only if there is an error
}