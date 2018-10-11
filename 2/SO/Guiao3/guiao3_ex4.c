#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

int main(int argc, char** argv){

	char** args = (char**) malloc(argc * sizeof(char*)); 
	int i;
	
	for(i = 0; i < argc-1; i++){
		args[i] = argv[i+1];
	}
	args[i] = NULL;

	int x = fork();
	if(x == 0){
		execvp(argv[1],args); 
		exit(-1);
	}

	wait(&x);
	return 0;

}