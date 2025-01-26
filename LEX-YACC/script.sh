#!/usr/bin/bash

# FOLDER="q1_in_to_post"
# Run ./script.sh <folder_name> in shell
cd "$1"

yacc yacc.y -d
lex lex.l
gcc y.tab.c lex.yy.c -o a.out
./a.out < input.txt
