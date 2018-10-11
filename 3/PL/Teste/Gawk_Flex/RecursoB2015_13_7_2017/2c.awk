#!/usr/bin/awk

BEGIN { FS = " "; }

      { x = int($1/1000); a[x][$2]++; }

END { 
    for ( item in a ) {
        b = 0;
        for ( item2 in a[item] ) {
            b += a[item][item2];
            print( item " -> " item2 " -> " a[item][item2])
        }
        print(item " -> " b)
    }
}