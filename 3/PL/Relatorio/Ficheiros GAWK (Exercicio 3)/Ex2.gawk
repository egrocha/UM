BEGIN	{ if(ARGC==7){ ARGC=8; ARGV[7]=ARGV[6]}

if(ARGV[1] == ARGV[2] && ARGV[3] == ARGV[4]){

	alteraTimestamp(ARGV[5], ARGV[6])

}

else{

	if(ARGV[3] == ARGV[4]) {

		alteraTimestamp(ARGV[1], ARGV[2], ARGV[3], ARGV[4], ARGV[5], ARGV[6]).
	}

	else{

		ficheiro(ARGV[1], ARGV[2], ARGV[3], ARGV[4],)
	}
}

function ficheiro(i1, i2, f1, f2){

	dur1=f1-i1
	dur2=f2-i2
	scale=dur1/dur2
	shift=i2*scale -i1
	f(t)=t*scale-shift

}

function alteraTimestamp(i1, i2, f1, f2, original, alterado){

	## Percorrendo todas as legendas de cada ficheiro

		## Retira-se o identificador da legenda, de cada ficheiro

		## Se o identificador da legenda for igual em ambos os ficheiros
		## e estiverem dentro dos limites impostos pelos 4 primeiros argumentos da função

			## Copia o timestamp do ficheiro original
	
			## E substitui o timestamp da legenda no ficheiro alterado
}