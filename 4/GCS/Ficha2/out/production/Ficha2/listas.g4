grammar listas;

@members{int tam=0; int soma=0;}

listas : lista+;

lista : 'LISTA' elems '.' {System.out.println("Tamanho: "+tamanho);}
      ;

elems : elem /*{tam=1;}*/ (',' elem /*{tam++;}*/)*
      ;

elem : NUMERO {tam++;soma+=$NUMERO.int;}
     | PAL {tam++;}
     ;

PAL : [a-zA-Z]+;

NUMERO :  ('0'..'9')+;

Separador: ('\r'?'\n'|' '|'\t')+ -> skip;