#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>

int pipe(int pd[2]);

int main(int argc, char** argv){
	int input = open("guiao5_ex1.c", O_RDONLY, 0600);
	char* buffer = (char*) malloc (sizeof(char*));
	int fd[2];
	dup2(fd[1],0);
	int n = pipe(fd);
	if(n < 0) return 0;
	int x = fork();
	if(x == 0){
		execlp("wc", "wc", NULL);
	}
	else{
		while(read(input,buffer,1) > 0){
			write(fd[1],buffer,1);
		}
	}
}