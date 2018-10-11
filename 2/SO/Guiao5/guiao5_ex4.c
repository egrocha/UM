#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>

int pipe(int pd[2]);

int main(int argc, char** argv){
	char* buffer = (char*) malloc (sizeof(char*));
	int fd[2];
	int n = pipe(fd);
	if(n < 0) return 0;
	int x = fork();
	if(x == 0){
		close(fd[0]);
		dup2(fd[1], 1);
		execlp("ls","ls","/etc",NULL);
		exit(-1);
	}
	else{
		close(fd[1]);
		dup2(fd[0], 0);
		execlp("wc","wc","-l",NULL);
		exit(-1);
	}
	wait(&x);
}