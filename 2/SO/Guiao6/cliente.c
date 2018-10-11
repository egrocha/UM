#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>

int mkfifo(const char *pathname, mode_t mode);

int main(int argc, char** argv){

	char* buffer = (char*) malloc (sizeof(char*));
	int n, fifo = open("pipe", O_WRONLY, 0666);

	while((n = read(0, buffer, 1)) > 0){
		write(fifo, buffer, 1);
	}

}