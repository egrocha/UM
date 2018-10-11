#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

void main(int argc, char** argv){

	for(int i = 1; i < argc; i++){
		int x = fork();
		if(x == 0){
			execlp(argv[i], argv[i], NULL);
		}
	}

}