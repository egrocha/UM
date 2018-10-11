#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

void main(int argc, char** argv){

	execlp("ls","ls","-l",NULL);
	printf("erro\n");

}