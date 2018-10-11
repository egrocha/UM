#!/usr/bin/awk

BEGIN { FS = " " }

$6 ~ /,/        { a = split($6, b, ","); 
                  for (i = 1; i <= a; i++) {
                      cc[$2][$4][b[i]];
                      }
                }
$6 !~ /,/       { cc[$2][$4][$6]; }

END {
    for (item in cc) {
        for (item2 in cc[item]) {
            for (item3 in cc[item][item2]) {
                print("<triple>" item "; " item2 "; " item3 "</triple>");
            }
        }
    }
}