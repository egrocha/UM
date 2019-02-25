/*
 * Linguagem: Evento
 * Processador: Processamento de Eventos para Registo numa Base de Dados
 * PRI/GCS 18/19
 */

grammar eventos;

//@members{String titulo; String subtitulo; String data; String descricao;}

eventos : 'EVENTO:' 
	  'TITULO:' titulo  
	  ('SUBTITULO:' subtitulo)? 
	  'DATA:' data 
          'DESCRICAO:' descricao 
           EOF
        ;

titulo : TEXTO ;

subtitulo: TEXTO ;

data: DATA;

descricao: TEXTO ;

/* Definicao do Analisador LEXICO */

DATA: [0-9][0-9]?'-'[0-9][0-9]?'-'[0-9][0-9][0-9][0-9] ;
TEXTO: (LETRA)+(' '(LETRA)+)* ;

Separador: ('\r'? '\n' | ' ' | '\t')+  -> skip ;

// LETRA n�o � um terminal. Simplesmente foi definido para simplificar outras express�es regulares.
fragment LETRA : [a-zA-Z������������������������������������_] ;
