#include <omp.h>
#include <stdio.h>

int main(){
	#pragma omp parallel num_threads(2)
	#pragma omp for ordered //divide a carga do ciclo entre as threads,
	                        //de forma ordenada
	for(int i=0; i<100; i++){
		int id = omp_get_thread_num();
		#pragma omp ordered //com isto faz uma thread tudo primeiro, depois
		                    //a outra
		printf("T%d:i%d\n", id, i);
		//#pragma omp barrier //as threads fazem as suas iterações 
						      //alternadamente
	}
}