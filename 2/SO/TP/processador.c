#include "processador.h"

/*
handlerChild - função handler usada quando o processo pai recebe um sinal
SIGINT, que trata de chamar a função remFiles para remover os ficheiros 
temporários criados pelo programa.
*/
void handlerChild(){
	remFiles();
	exit(0);
}

/*
main - função responsável por iniciar o processamento de ficheiros.
Abre o ficheiro de input e cria o ficheiro de output para onde vamos
temporariamente colocar o texto criado pelo programa. No final
chamamos a função terminar para copiar o texto criado para o ficheiro 
de input.
*/
int main(int argc, char** argv){
	int input = open(argv[1], O_CREAT | O_RDWR, 0600);
	int output = open("temp.txt", O_CREAT | O_TRUNC | O_RDWR, 0600);
	signal(SIGINT, handlerChild);
	reader(input, output);
	terminar(argv[1]);	
	return 0;
}

/*
reader - função que lê o texto que está no ficheiro de input e cria vectores
com argumentos caso os encontre dentro do ficheiro.
*/
int reader(int input, int output){
	int n, flag = 0, flagPipe = 0, i = 0, j = 0, k = 0, l = 0, prev = 1;
	char* aux = (char*) malloc (10*MAXSIZE*sizeof(char*));
	char* buffer = (char*) malloc (10*MAXSIZE*sizeof(char*));
	char** args = (char**) malloc (MAXSIZE*sizeof(char*));
	char current;
	while(1){
		if(flag == 1){
			memset(buffer,0,strlen(buffer));
			i = 0;
			j = 0;
			l = 0;
			prev = 0;
			while(current != '\n' && current != '\0'){
				n = read(input, buffer + i, 1);
				current = buffer[i];
				if((current == ' ' || current == '\n' || current == '\0') && 
					strlen(buffer) > 1){
					memset(aux,0,strlen(aux));
					for(j = 0; prev < i; j++, prev++){
						aux[j] = buffer[prev];
					}
					args[l] = (char*) malloc (10*MAXSIZE*sizeof(char*));
					strcpy(args[l], aux);
					l++;
					prev++;
				}
				i++;
			}
			j = 0;
			while(j < i-1){
				write(output, buffer+j, 1);
				j++;
			}
			write(output, "\n", 1);
			if(flagPipe == 1){
				pipeAux(output, args);
				flagPipe = 0;
			}
			else execAux(output, args);
			for(k = 0; k < l; k++){
				free(args[k]);
				args[k] = NULL;
			}
			flag = 2;
		}
		else{
			n = read(input,buffer,1);
			if(n <= 0){
				free(aux);
				free(buffer);
				free(args);
				return 0;
			}
		}
		current = buffer[0];
		if(current == '$'){
			flag = 1;
			write(output, buffer, 1);
			read(input, buffer, 1);
			current = buffer[0];
			if(current == '|'){
				write(output, buffer, 1);
				read(input, buffer, 1);
				flagPipe = 1;
			}
		}
		if(flag == 2) flag = 0;
		else write(output,buffer,1);
	}
	return 0;
}

/*
execAux - função que executa execs caso não seja necessário usar a 
função de pipe.
*/
void execAux(int output, char** argv){
	int input = open("pipe.txt", O_CREAT | O_TRUNC | O_RDWR, 0600);
	int x = fork();
	if(x == 0){
		dup2(input, 1);
		execvp(argv[0], argv);
		kill(getppid(), SIGINT);
		exit(-1);
	}
	wait(&x);
	close(input);
	rewrite(output);
}

/*
pipeAux - função que executa execs caso seja necessário usar pipes.
Cria um pipe anónimo para onde envia os conteúdos do ficheiro que 
contém o output do último comando executado.
*/
void pipeAux(int output, char** argv){
	flagFile = 1;
	char* buffer = (char*) malloc (MAXSIZE*sizeof(char*));
	int n;
	int x = fork();
	if(x == 0){
		int fd[2];
		pipe(fd);
		int y = fork();
		if(y == 0){
			close(fd[0]);
			dup2(fd[1], 1);
			execlp("cat","cat","pipe.txt",NULL);
			kill(getppid(), SIGINT);
			exit(-1);
		}
		else{
			close(fd[1]);
			dup2(fd[0], 0);
			int input = open("pipeAux.txt", O_CREAT | O_TRUNC | O_RDWR, 0600);
			dup2(input, 1);
			execvp(argv[0], argv);
			close(input);
			kill(getppid(), SIGINT);
			exit(-1);
		}
	}
	wait(&x);
	int input = open("pipe.txt", O_CREAT | O_TRUNC | O_RDWR, 0600);
	int aux = open("pipeAux.txt", O_CREAT | O_RDONLY, 0600);
	while((n = read(aux, buffer, 1)) > 0){
		write(input, buffer, 1);
	}
	free(buffer);
	rewrite(output);
}

/*
rewrite - função que envia os conteúdos do ficheiro pipe.txt para o ficheiro
temp.txt
*/
void rewrite(int output){
	int n;
	int pipe = open("pipe.txt", O_RDONLY, 0600);
	char* buffer = (char*) malloc (MAXSIZE*sizeof(char*));
	write(output, ">>>\n", 4);
	while((n = read(pipe, buffer, 1)) > 0){
		write(output, buffer, 1);
	}
	write(output, "<<<\n", 4);
	close(pipe);
	free(buffer);
}

/*
terminar - função que que envia os conteúdos do ficheiro temp.txt de volta 
para o ficheiro input, tendo atenção para substitiuir outputs já criados 
previamente pelo programa.
*/
void terminar(char* filename){
	char* buffer = (char*) malloc (10*MAXSIZE*sizeof(char*));
	memset(&buffer[0], 0, sizeof(buffer));
	char current;
	int n, flag = 0, flagPrim = 0, flagEnd = 0;
	int input = open("temp.txt", O_CREAT | O_RDONLY, 0600);
	int output = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
	while((n = read(input, buffer, 1)) > 0){
		current = buffer[0];
		if(flagEnd && current != '>') flagPrim = 0;
		flagEnd = 0;
		if(buffer[0] == '>'){
			read(input, buffer+1, 3);
			if(buffer[0] == '>' && buffer[1] == '>' && 
			   buffer[2] == '>' && buffer[3] == '\n'){
				if(flagPrim == 0){
					write(output, buffer, 4);
					read(input, buffer, 1);
					flagPrim = 1;
				}
				else flagPrim = 0;
				flag = 1;
			}
			else{
				write(output, buffer, 4);
				read(input, buffer, 1);
			}
		}
		if(buffer[0] == '<'){
			read(input,buffer+1,3);
			if(buffer[0] == '<' && buffer[1] == '<' &&
			   buffer[2] == '<' && (buffer[3] == '\n' || buffer[3] == '\0')){
				if(flagPrim == 1){
					write(output, buffer, 4);		
					flagEnd = 1;	
				}
				else{
					if((n = read(input, buffer, 1)) <= 0) flagEnd = 1;
				}
				flag = 0;
			}
		}
		if((flag == 0 || (flag == 1 && flagPrim == 1)) && flagEnd == 0){
			write(output, buffer, 1);

	memset(&buffer[0], 0, sizeof(buffer));
		}
	}
	remFiles();
	close(input);
	close(output);
	free(buffer);
}

/*
remFiles - função que remove os ficheiros temp.txt e pipe.txt, e também
pipeAux.txt caso a função pipeAux tenha sido executada.
*/
void remFiles(){
	int x = fork();
	if(x == 0){
		execlp("rm","rm","temp.txt",NULL);
		kill(getppid(), SIGINT);
		exit(-1);
	}
	x = fork();
	if(x == 0){
		execlp("rm","rm","pipe.txt",NULL);
		kill(getppid(), SIGINT);
		exit(-1);
	}
	if(flagFile){
		x = fork();
		if(x == 0){
			execlp("rm","rm","pipeAux.txt",NULL);
			kill(getppid(), SIGINT);
			exit(-1);
		}
	}
}