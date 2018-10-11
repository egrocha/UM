grammar ficha2ex12;

lista returns[int comp, int contaN, float media]
@after{println("Comprimento da lista: "+$lista.comp);
       println("Quantidade dos números: "+$lista.contaN);
       println("Média dos números lidos: "+$lista.media);
}
    : 'LISTA' elems '.'
      {$lista.comp=$elems.comp; $lista.contaN=$elems.contaN; $lista.media=$elems.total/$elems.contaN;}
    ;

elems returns[int comp, int contaN, int total]
    : elem {$elems.comp=1; $elems.contaN=$elem.num; $elems.total=$elem.valor;}
      (',' elems {$elems.comp++; $elems.contaN=$elems.contaN + $elem.num;
                  $elems.total=$elems.total+$elem.valor;})*
    ;

elem returns[int num, int valor]
    : NUMERO {$elem.num=1; $elem.valor=$NUMERO.int;}
    | PAL    {$elem.num=0; $elem.valor=0;}
    ;