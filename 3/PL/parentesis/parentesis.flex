%option yylineno
%option main
%{
	int cont = 0;	
	int erro = 0;
%}

%%

\(		{ 
			cont++; 
			printf("%s",yytext); 
			printf("%d",cont);
			if(cont < 1) erro++; 
		}

\)		{ 
			printf("%s",yytext); 
			printf("%d",cont); 
			cont--; 
		}

<<EOF>>	{ 
			printf("\n"); 
			if(cont>0){ 
				printf("%d erro(s)\n", cont); 
				printf("Falta fechar %d parêntesis\n", cont);
			}
			if(cont<0){ 
				printf("%d erro(s)\n", abs(cont));
				printf("Falta fechar %d parêntesis\n", abs(cont));
			}
			return 0;
		}

%%

