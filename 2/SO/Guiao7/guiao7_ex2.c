#include <signal.h>
#include <stdio.h>
#include <stdlib.h>	
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

unsigned int sleep(unsigned int seconds);
typedef void (*sighandler_t)(int);
sighandler_t signal(int signum, sighandler_t handler);
int kill(pid_t pid, int sig);
unsigned int alarm(unsigned int seconds);
int pause(void);

void handlerCont(){

}

void handlerStop(){

}

void handlerChild(){
	
}

int main(int argc, char** argv){
	signal(SIGCONT, handlerCont);
	signal(SIGSTOP, handlerStop);
	signal(SIGCHLD, handlerChild);
	int i = 1, x;
	while(1){
		x = fork();
		if(x == 0){
			execlp(argv[i], argv[i], NULL);
			exit(-1);
		}
		sleep(1);
		i++;
	}
}