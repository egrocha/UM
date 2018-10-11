#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <string.h>

void aux(char* comando, char** args);


void main(int argc, char** argv){
	int f, flag1 = 0, flag2 = 0, i;
	char* comando;
	char** args;

	if(strcmp(argv[1], "-i") == 0){
		flag1 = 1;
		f = open(argv[2], O_RDONLY);
		dup2(f, 0);
	}
	if(strcmp(argv[3], "-i") == 0){
		flag1 = 1;
		f = open(argv[4], O_CREAT | O_TRUNC | O_RDWR, 0600);
		dup2(f,0);
	}
	if(strcmp(argv[1], "-o") == 0){
		flag2 = 1;
		f = open(argv[2], O_CREAT | O_TRUNC | O_RDWR, 0600);
		dup2(f,1);
	}
	if(strcmp(argv[3], "-o") == 0){
		flag2 = 1;
		f = open(argv[4], O_CREAT | O_TRUNC | O_RDWR, 0600);
		dup2(f,1);
	}

	//printf("%i %i\n",flag1,flag2);

	if(flag1 && flag2){
		args = (char**) malloc ((argc-6)*sizeof(char**));
		for(i = 5; i < argc; i++){
			args[i-5] = argv[i];
		}
		aux(argv[5], args);
	}
	else if(flag1 || flag2){
		args = (char**) malloc ((argc-3)*sizeof(char**));
		for(i = 3; i < argc; i++){
			args[i-3] = argv[i];
		}
		//args[i] = NULL;
		aux(argv[3], args);
	}
	if(!flag1 && !flag2){
		args = (char**) malloc ((argc-1)*sizeof(char**));
		for(i = 1; i < argc; i++){
			args[i-1] = argv[i];
		}
		//args[i] = NULL;
		aux(argv[1], args);
	}
}

void aux(char* comando, char** args){
	int x = fork();
	if(x == 0){
		//printf("%s\n",comando);
		//printf("%s\n",args[0]);
		execvp(comando,args);
	}
}