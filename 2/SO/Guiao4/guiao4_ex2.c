#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>

void main(int argc, char** argv){
	char* buf = (char*) malloc (sizeof(char*));
	int n;
	int passwd, saida, erros;

	passwd = open("/etc/passwd", O_RDONLY);
	saida = open("saida.txt", O_CREAT | O_TRUNC | O_RDWR, 0600);
	erros = open("erros.txt", O_CREAT | O_TRUNC | O_RDWR, 0600);

	if(passwd < 0) exit(-1);
	if(saida < 0) exit(-1);
	if(erros < 0) exit(-1);

	dup2(passwd,0);
	dup2(saida,1);
	dup2(erros,2);

	int x = fork();
	if(x == 0){
		while(1){
			n = read(0,buf,1);
			if(n <= 0) exit(0);
			write(1,buf,n);
		}
	}

	wait(&x);
	exit(0);
}