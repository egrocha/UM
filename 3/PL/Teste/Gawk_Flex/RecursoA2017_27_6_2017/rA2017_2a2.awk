#!/usr/bin/awk -f

BEGIN { FS = " "; }

$3 ~ /:/      { A[$2][$4]; }
# Se tiver junto ao conceito
$2 ~ /:/      { gsub(/:/,"",$2); A[$2][$3]; }

END {
    for (item in A){
        for (item2 in A[item]){
            print(item " -> " item2);
        }
    }
}