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
	dup2(fd[1],0);
	int n = pipe(fd);
	if(n < 0) return 0;
	int x = fork();
	if(x == 0){
		close(fd[1]);
		execlp("wc","wc",NULL);
	}
	else{
		close(fd[0]);
		while(read(0, buffer, 1) > 0){
			write(fd[1],buffer,1);
		}
		close(fd[1]);
	}
	wait(&x);
}