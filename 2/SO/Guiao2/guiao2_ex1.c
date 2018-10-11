#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

void main(){
	printf("process id: %d\n", getpid());
	printf("parent process id: %d\n", getppid());
}