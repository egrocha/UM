#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

void main(){
	int x = fork();
	if(x == 0){
		printf("process id: %d\n", getpid());
	}
	else{
		printf("process id: %d\n", getpid());
		printf("child process id: %d\n", x);
	}
}