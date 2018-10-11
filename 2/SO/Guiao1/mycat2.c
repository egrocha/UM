#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

//int open(const char *path, int oflag[, mode]);
ssize_t read(int fildes, void *buf, size_t nbyte);
ssize_t write(int fildes, const void *buf, size_t nbyte);
int close(int fildes);

int main(int argc, char* argv[]){
	char* buf = NULL;
	int nbytes = atoi(argv[1]);
	int n;

	buf = malloc(nbytes);

	while(1){
		n = read(0,buf,nbytes);
		if(n <= 0){
			free(buf);
			exit(0);
		}
		write(1,buf,n);
	}
	return 0;
}
