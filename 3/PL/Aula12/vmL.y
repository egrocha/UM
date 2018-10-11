%{
#define _GNU_SOURCE
#include <stdio.h>
#include <string.h>


void alocarVar(char* nomeVar);
int enderecoVar(char* nomeVar);
int asprintf(char **strp, const char *fmt, ...);
int yylex();
void yyerror(char* c);

int tamanhoTotal = 0;
struct {
    int tam;
    int tipo;
    int pos;
} tabelaSimbolos[256];

%}


%union {int i; char* s;}
%token INT VAR ESCREVER IF THEN ELSE WHILE
%type <i> INT
%type <s> VAR f p exp inst prog
%%

z : prog { printf("start \npushn %d \n%s \n stop \n", tamanhoTotal, $1);}
;

prog :                  { $$ = ""; }
     | inst '\n' prog   { asprintf(&$$, "%s \n%s \n",$1,$3); }
;

cond : exp NE exp       { asprintf(&$$, "%s \n %s \n EQUAL\n NOT\n", $1, $3); }
     | exp 

exp : exp '+' p { asprintf(&$$, "%s \n%s \nadd \n", $1, $3);}
    | exp '-' p { asprintf(&$$, "%s \n%s \nsub \n", $1, $3);}
    | p         { $$ = $1; }
;

p   : p '*' f { asprintf(&$$, "%s \n%s \nmul \n", $1, $3);}
    | p '/' f { asprintf(&$$, "%s \n%s \ndiv \n", $1, $3);}
    | f       { $$ = $1; }
;

inst : VAR '=' exp  { asprintf(&$$, "%s \nstoreg %d \n", $3, enderecoVar($1)); }
     | ESCREVER exp { asprintf(&$$, "%s writei \n", $2); }
     | IF exp THEN inst ELSE inst {
         asprintf(&$$, "%s \n JZ ELSE \n %s \nJUMP ENDIF \n ELSE: %s\n ENDIF: ", $2, $4, $6);
     }
     | WHILE exp inst {
          asprintf(&$$, "INICIOW: %s \n JZ FIMW \n %s \nJUMP INICIOW \n FIMW: ", $2, $3);
     }
;


f : INT         { asprintf(&$$, "pushi %d\n", $1);       }
  | VAR         { asprintf(&$$, "pushg %d \n", enderecoVar($1)); }
  | '(' exp ')' { $$ = $2;                               }
  | '?'         { asprintf(&$$, "read \natoi \n");       }
;

%%

#include "lex.yy.c"

int main(){
    yyparse();
    return 0;
}

void yyerror(char* s){
    fprintf(stderr, "%s, '%s', line %d \n", s, yytext, yylineno);
}

void alocarVar(char* nomeVar){ //vars so podem ter comprimento 1!
    if( tabelaSimbolos[nomeVar[0]].tam != 1 ){
        tabelaSimbolos[nomeVar[0]].tam = 1;
        tabelaSimbolos[nomeVar[0]].pos = tamanhoTotal;
        tamanhoTotal++;
    }
}

int enderecoVar(char* nomeVar){
    alocarVar(nomeVar);
    return tabelaSimbolos[nomeVar[0]].pos;
}