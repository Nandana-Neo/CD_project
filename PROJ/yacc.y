%{
        #include <stdio.h>
        #include <string.h>
        #include <stdlib.h>
        int yylex();
        int yyerror();
        extern FILE* yyin;

        int tempCount = 0;

        char *newTemp() {
                char *temp = (char *)malloc(10);        //change?
                sprintf(temp, "t%d", tempCount++);
                return temp;
        }

        char *gen(char *arg1, char *arg2, char *arg3) {
                char * parent = (char *)malloc(10000);
                sprintf(parent,"%s%s%s",  arg1, arg2, arg3);
                return parent;
        }
%}

%union {
        struct {
                char* code;
                char* val;
        } s;
}
%token BCSMAIN IF ELSE WHILE INT BOOL ID RELOP NUM
%nonassoc BCSMAIN IF ELSE WHILE INT BOOL RELOP

%%

program :   BCSMAIN '{' declist stmtlist '}'    {
                                                        // printf("%s\n",$<s>4.code);
                                                        FILE* codeFile = fopen("3addr_code.txt", "w");
                                                        if (!codeFile) {
                                                                perror("fopen");
                                                                return 1;
                                                        }
                                                        fprintf(codeFile, "%s", $<s>4.code);
                                                        fclose(codeFile);
                                                        printf("Parsing Successful\n");
                                                        exit(0);
                                                }
        ;

declist :   declist decl
        |   decl            
        ;

decl    :   type ID ';'
        ;

type    :   INT
        |   BOOL
        ;

stmtlist:   stmtlist ';' stmt   {
        char * temp=(char*)malloc(10);
        sprintf(temp,"\0");
        $<s>$.code=gen($<s>1.code,temp,$<s>3.code);
        }

        |   stmt                {$<s>$=$<s>1;}
        ;

stmt    :   ID '=' aexpr        {
                char* left_code = $<s>1.code;
                char* right_code=$<s>3.code;
                char* left_val=$<s>1.val;
                char* right_val=$<s>3.val; 

                char* temp=(char*)malloc(10);
                sprintf(temp," = ");
                char* curr=gen(left_val,temp,right_val);
                sprintf(curr,"%s%s\n",curr,";");
                $<s>$.code=gen(left_code,right_code,curr);

                free($<s>1.val);
                free($<s>3.val);
                free($<s>1.code);
                free($<s>3.code);
                free(temp);
                free(curr);

        }

        |   IF '(' expr ')' '{' stmtlist '}' ELSE '{' stmtlist '}'
        |   WHILE '(' expr ')' '{' stmtlist '}'
        ;

expr    :   aexpr RELOP aexpr   
        |   aexpr               {
                $<s>$.code=$<s>1.code;
                $<s>$.val=$<s>1.val;
        }   
        ;

aexpr   :   aexpr '+' aexpr     {
                char* temp1=newTemp();
                $<s>$.val=temp1;


                char* left_code=$<s>1.code;
                char* right_code=$<s>3.code;
                char* temp=(char*)malloc(10);
                sprintf(temp," + ");
                char* lhs = gen($<s>1.val,temp,$<s>3.val);

                char* equal=(char*)malloc(10);
                sprintf(equal," = ");
                char* curr_code = gen(temp1,equal,lhs);
                sprintf(curr_code,"%s%s\n",curr_code,";");
                $<s>$.code = gen(left_code,right_code,curr_code);
                free($<s>1.val);
                free($<s>3.val);
                free($<s>1.code);
                free($<s>3.code);
                free(temp);
                free(equal);
                free(curr_code);
        }

        |   term                {
                $<s>$.code=$<s>1.code;
                $<s>$.val=$<s>1.val;
        }
        ;

term    :   term '*' factor     {
                char* temp1=newTemp();
                $<s>$.val=temp1;


                char* left_code=$<s>1.code;
                char* right_code=$<s>3.code;
                char* temp=(char*)malloc(10);
                sprintf(temp," * ");
                char* rhs = gen($<s>1.val,temp,$<s>3.val);

                char* equal=(char*)malloc(10);
                sprintf(equal," = ");
                char* curr_code = gen(temp1,equal,rhs);
                sprintf(curr_code,"%s%s\n",curr_code,";");
                $<s>$.code = gen(left_code,right_code,curr_code);
                free($<s>1.val);
                free($<s>3.val);
                free($<s>1.code);
                free($<s>3.code);
                free(temp);
                free(equal);
                free(curr_code);
                
        }

        |   factor              {
                $<s>$.val=$<s>1.val;
                $<s>$.code=$<s>1.code;
        }
        ;

factor  :   ID          {
                $<s>$.val=$<s>1.val;
                $<s>$.code=$<s>1.code;
        }

        |   NUM         {
                $<s>$.val=$<s>1.val;
                $<s>$.code=$<s>1.code;
        }
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