#!/usr/bin/awk -f

BEGIN { FS = "[-]" }

$1 !~ /:/      { a[$1]++; b[$2]++; }

END   {
    c = 0;
    r = 0;
    for (item in a){
        c ++;
    }
    for (item in b){
        r ++;
    }
    print(c " Conceitos Diferentes, " r " Relacões Distintas");
}