BEGIN {i = 0; d = "00:00:00,000"}

/^[0]/ {timeSilence(d,$1); d = $3;}
/^[0]/ {c = $0; i = 0;} 
/[a-zA-Z]/ && i == 0 {c = c " " $0; i = 1; next;}
/[a-zA-Z]/ && i >= 1 {c = c " | " $0; i++;}
/^[1-9]+/ {print c;}

END {print c;}

function timeSilence (fimAnt, iniDep){
		
	split(fimAnt, a, /:/);
	split(iniDep, b, /:/);
	if(b[2] > a[2]) printf("%s --> %s =================\n", fimAnt, iniDep);
	if((b[2] == a[2]) && (b[3] - a[3]) >= 2) printf("%s --> %s =================\n", fimAnt, iniDep);

}




