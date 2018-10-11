#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <signal.h>

#ifndef HEADER_FILE
#define HEADER_FILE

#define MAXSIZE 20

int flagFile = 0;

void handlerChild();
int start(char* filename);
int reader(int input, int output);
void execAux(int output, char** argv);
void pipeAux(int output, char** argv);
void rewrite(int output);
void terminar(char* output);
void remFiles();

#endif /* HEADER_FILE */