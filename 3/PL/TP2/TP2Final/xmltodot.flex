%option main
%{
	char* fst; int cont = 0;
%}

%%


\<.*\?\>		 	{printf("strict digraph{\n");}
\<!.*\> 			{;}

\<[a-z]*\>			{if(cont == 0) fst=yytext;}

\<\/.*\>			{;}
\<	 				{;}
\>.*\n 				{if(cont%2 == 0) printf("->"); else printf("\n"); cont++;}
.*\<				{;}
\>					{;}
\/					{;}

\"					{;}
\=					{;}
\-					{;}
\.					{;}
\[[:space::]]		{;}
\n					{;}


<<EOF>> {printf("\n}\n");return 0;}

%%