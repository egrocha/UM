#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

void main(){
	int x;
	x = fork();
	if(x == 0){
		write(1,"filho\n",6);
	}
	else{
		write(1,"pai\n",4);
	}
}