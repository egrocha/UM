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

int time = 0;
int ctrlC = 0;
int flagPrint = 0;

void handlerAlarm(){
	time++;
}

void handlerCtrlC(){
	printf("%d\n",time);
	ctrlC++;
}

void handlerCtrlS(){
	printf("%d\n",ctrlC);
	exit(0);
}

int main(int argc, char** argv){
	int x;
	signal(SIGALRM, handlerAlarm);
	signal(SIGINT, handlerCtrlC);
	signal(SIGQUIT, handlerCtrlS);
	while(1){
		alarm(1);
		sleep(1);
	}
	return 0;
}