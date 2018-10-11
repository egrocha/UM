#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

void main(){
	int i, x;
	for(i = 0; i < 10; i++){
		x = fork();
		if(x != 0){
			break;
		}
		printf("process id: %d\n", getpid());
		printf("parent process id: %d\n", getppid());
	}
	wait(&x);
}