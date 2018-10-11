#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>

//int open(const char *path, int oflag[, mode]);
ssize_t read(int fildes, void *buf, size_t nbyte);
ssize_t write(int fildes, const void *buf, size_t nbyte);
int close(int fildes);

int main(){
	char buf[100];
	int n;

	while(1){
		n = read(0,buf,1);
		if(n <= 0){
			exit(0);
		}
		write(1,buf,n);
	}
	exit(0);
}