#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

void main(){
	int x;
	int i;
	for(i = 0; i < 10; i++){
		x = fork();
		if(x == 0){
			printf("process id: %d\n", getpid());
			printf("parent process id: %d\n", getppid());
			_exit(i+1);
		}
	}
	for(i = 0; i < 10; i++){
		wait(&x);
		printf("exit code: %d\n", WEXITSTATUS(x));
	}
}