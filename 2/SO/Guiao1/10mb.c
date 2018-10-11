#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]){
	char* buf = NULL;
	char a = 'a';
	int i = 0, max = 10*1024*1024, f;

	f = open(argv[1],O_CREAT | O_TRUNC | O_WRONLY,0640);

	while(i<max){
		write(f,&a,1);
		i++;
	}

	close(f);
	exit(0);
}