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
		close(fd[1]);
		while(read(fd[0],buffer,5) > 0){
			printf("%s",buffer);
		}
	}
	else{
		close(fd[0]);
		while(write(fd[1],"boas\n",5) > 0){
			sleep(1);
		}
	}
}