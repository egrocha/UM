%{
	#include <stdio.h>
	int yylex();
	void yyerror(char* c);	
%}

%union {int i; char* s;}
%token INT VAR 
%type <i> INT
%type <s> VAR

%%

z	: prog '\n'			{printf("%d\n",$1);}