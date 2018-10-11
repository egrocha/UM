
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> /* chamadas ao sistema: defs e decls essenciais */
#include <sys/wait.h> /* chamadas wait*() e macros relacionadas */

#define MAX_LINES 20
#define MAX_COL 100000

unsigned int sleep(unsigned int seconds);
typedef void (*sighandler_t)(int);
sighandler_t signal(int signum, sighandler_t handler);
int kill(pid_t pid, int sig);
unsigned int alarm(unsigned int seconds);
int pause(void);

int numProc = 0;

void handlerChild(){
	numProc++;
	//printf("Processo %d terminado\n", numProc);
}


void genMatrix(int m[MAX_LINES][MAX_COL])
{
    for (int i = 0; i < MAX_LINES; i++) {
        for (int j = 0; j < MAX_COL; j++) {
            m[i][j] = 1;
        }
    }

    m[MAX_LINES - 1][MAX_COL - 1] = 27; // Valor a encontrar.
}

int main()
{
	signal(SIGCHLD, handlerChild);
    int pid;
    int i = 0, j = 0;
    int ret, flag = 0;
    int m[MAX_LINES][MAX_COL];

    genMatrix(m);
	
    for (i = 0; i < MAX_LINES; i++) {
        if ((pid = fork()) == 0) {
            for (j = 0; j < MAX_COL; j++) {
                if (m[i][j] == 27) {
                	printf("found %d\n",m[i][j]);
                    _exit(1);
                    //_exit(1); // Valor encontrado, retornar 1 para o pai.
                }
            }
            _exit(0);
        }
    }

    for (i = 0; i < MAX_LINES && flag != 1; i++) { // Pai vai esperar pelo valor de saida de todos os filhos.
        wait(&ret);
      	if (WEXITSTATUS(ret) == 1) {
			flag = 1;
		}
    }

    if (flag == 1) printf("<pai> Foi encontrado o elemento!\n");
    else printf("<pai> O elemento %d não existe na matriz.\n", 27);
    printf("%d processos terminados\n", numProc);
	
	/*
	// Versão sequencial
	for (i = 0; i < MAX_LINES; i++) {
		for (j = 0; j < MAX_COL; j++) {
			if (m[i][j] == 27) {
				printf("Foi encontrado o elemento!\n");
				return 1;
			}
		}
	} */
    return 0;
}