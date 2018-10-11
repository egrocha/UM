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
	int n, fifo = open("fifo", O_RDONLY, 0666);
	while((n = read(fifo, buffer, 1)) > 0){
		write(1, buffer, 1);
	}
}