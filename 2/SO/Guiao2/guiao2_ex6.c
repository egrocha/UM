#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>

void main(int argc, char** argv){
	int num = atoi(argv[1]);
	int i, j, x;
	int matriz[5][20000];
	int cont = 1;

	for(i = 0; i < 5; i++){
		cont = 1;
		for(j = 0; j < 20000; j++){
			matriz[i][j] = cont++;
		}
	}
	matriz[0][0] = 0;
	matriz[3][0] = 0;

	for(i = 0; i < 5; i++){
		x = fork();
		if(x == 0){
			for(j = 0; j < 20000; j++){
				if(matriz[i][j] == num){
					printf("found by %d, num = %d\n", i+1, num);
					_exit(i+1);
				}
			}
			_exit(0);
		}
	}

	for(i = 0; i < 5; i++){
		wait(&x);
		int aux = WEXITSTATUS(x);
		if(aux){
			printf("%d\n", aux);
		}
	}	
}