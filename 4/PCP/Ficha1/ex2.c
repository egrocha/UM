#include <omp.h>
#include <stdio.h>

int main(){
	#pragma omp parallel num_threads(2)
	//#pragma omp for //um thread vai de 0 a 49, o outro de 50 a 100
	//#pragma omp master //apenas o thread 0 corre
	//#pragma omp single //parece igual ao master, apenas o master corre
	#pragma omp critical //thread 0 faz tudo antes de o thread 1 começar
	for(int i=0; i<100; i++){
		int id = omp_get_thread_num();
		printf("T%d:i%d\n", id, i);
	}
}