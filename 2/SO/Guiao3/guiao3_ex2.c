#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

void main(int argc, char** argv){
	
	int x;
	x = fork();

	if(x == 0){
		execlp("ls","ls","-l",NULL);
		exit(-1);  
	}
	
	wait(&x);
	printf("OK\n");

}