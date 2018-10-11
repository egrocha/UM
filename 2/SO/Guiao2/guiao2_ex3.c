#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

void main(){
	for(int i = 0; i < 10; i++){
		int x = fork();
		if(x == 0){
			printf("process id: %d\n", getpid());
			printf("parent process id: %d\n", getppid());
			_exit(i+1);
		}
		else{
			wait(&x);
			printf("exit code: %d\n", WEXITSTATUS(x));
		}
	}
}