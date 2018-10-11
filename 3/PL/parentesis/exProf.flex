
%{
	int c = 0;
	int col = 0;
	int lin = 0;
%}

%%

\(		{ printf("(%d",++c); col++; }
\)		{ printf(")%d",c--); col++; }
.		{ ECHO; col++; }
\n		{ ECHO; lin++; }
%%
