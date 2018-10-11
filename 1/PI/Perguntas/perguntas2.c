#include <stdio.h>

typedef struct lligada{
	int valor;
	struct lligada *prox;
}*LInt;

LInt newLInt(int n, LInt l){
  LInt new;
  new=(LInt) malloc(sizeof(LInt));
  new->valor = n;
  new->prox = l;
  return new;
}

typedef struct nodo{
	int valor;
	struct nodo *esq, *dir;
} *ABin;

ABin newABin(int n, ABin e, ABin d){
	ABin new;
	new = (ABin) malloc(sizeof(ABin));
	new -> valor = n;
	new -> esq = e;
	new -> dir = d;
}

//1
	int length(LInt l){
		int i;
		LInt* aux = &l;
		for(i=0; *aux != NULL; i++){
			aux = &(*aux)->prox;
		}
		return i;
	}

int length(LInt l){
	int i;
	for(i = 0; l; i++){
		l = l -> prox;
	} 
	return 1;
}

//2
void freeL(LInt l){
	LInt aux = l;
	while(l != NULL){
		l->prox;
		free(aux);
		aux = l;
	}
}

//3
void imprimeL(LInt l){
	while(l != NULL){
		printf("%d\n",l->valor);
		l = l->prox;
	}
}

//4 
LInt reverseL(LInt l){
LInt atual, anterior, proxima;
atual = l;
anterior = NULL;
while(atual != NULL){
	proxima = atual->prox;
	atual->prox = anterior;
	anterior = atual;
	atual = proxima;
}
l = anterior;
return l;
}

//5 
void insertOrd(LInt *l, int x){
	while(*l != NULL && x > (*l)->valor){
		l = &(*l)->prox;
	}
	*l = newLInt(x,*l);
}

//6
int removeOneOrd(LInt *l, int x){
	LInt* aux = l;
	while(*aux != NULL && (*aux) -> valor < x){
		aux = &(*aux) -> prox;
	}
	if(*aux == NULL) return 1;
	LInt remove = *aux;
	*aux = remove -> prox;
	return 0;
}

//7
void merge(LInt *r, LInt a, LInt b){
	LInt *aux = &(*r);
	while(a != NULL && b != NULL){
		if(a -> valor < b -> valor){
			*r = newLInt(a -> valor, NULL)
			a = a -> prox;
			r = &(*r) -> prox;
		}
		else{
			*r = newLInt(b -> valor, NULL);
			b = b -> prox;
			r = &(*r) -> prox;
		}
	}
	if(a != NULL){
		*r = a;
	}
	else{
		*r = b;
	}
}

//8
void splitMS(LInt l, int x, LInt *mx, LInt *Mx){
	while(l != NULL){
		if(l -> valor < x){
			*mx = newLInt(l -> valor, NULL);
			mx = &((*mx) -> prox);
		}
		else{
			*Mx = newLInt(l -> valor, NULL);
			Mx = &((*Mx) -> prox);
		}
		l = l -> prox;
	}
}


//9
LInt parteAmeio(LInt *l){
	LInt aux = *l;
	LInt* head = l;
	LInt* res = l;
	if((*l) -> prox == NULL) return NULL;
	while(*l != NULL){
		l = &(*l) -> prox;
		if(*l != NULL){
			l = &(*l) -> prox;
			res = &(*res) -> prox;
		}
	}
	*head = *res;
	*res = NULL;
	return aux;
}

//10
int removeAll(Lint *l, int x){
	int a = 0;
	LInt* aux = l;
	LInt remov; 
	while(*aux != NULL){
		if((*aux) -> valor == x){
			remov = *aux;
			*aux = remov -> prox;
			a++;
		}
		else{
			aux = &(*aux) -> prox;
		}
	}
	return a;
}

//11
int removeDups(LInt *l){
	int a = 0;
	int b = 0;
	while((*l) != NULL){
		b = (*l) -> valor;
		aux = &(*l) -> prox;
		while(*aux != NULL){
			if((*aux) -> valor == b){
				remov = *aux;
				*aux = remov -> prox;
				a++;
			}
			else aux = &(*aux) -> prox;
		}
		l = &(*l) -> prox;
	}
	return a;
}

//12
int removeMaiorL(LInt *l){
	LInt* head = l;
	LInt rem;
	LInt* aux = l;
	int a = 0;
	int flag = 0;
	while(*l){
		if((*l) -> valor > a) 
			a = (*l) -> valor;
		l = &(*l) -> prox;
	}
	l = head;
	while(*aux && !flag){
		if((*aux) -> valor == a){
			rem = *aux;
			*aux = rem -> prox;
			flag = 1;
		}
		else 
			aux = &(*aux) -> prox;
	}
	return a;
}

//13
void init(LInt *l){
	while(*l){
		if(*l -> prox == NULL){
			free(*l);
			*l = NULL;
		}
		else{
			l = &(*l) -> prox;
		}	
	}
}

//14
void appendL(LInt *l, int x){
	while(*l){
		l = &(*l) -> prox;
	}
	*l = newLInt(x, NULL);
}

//15
void concatL(LInt *a, LInt b){
	while(*a){
		a = &(*a) -> prox;
	}
	*a = b;
}

//16
LInt cloneL(LInt l){
	LInt res = NULL;
	LInt *aux = &res;
	while(l){
		*aux = newLInt(l -> valor, NULL);
		l = l -> prox;
		aux = &((*aux) -> prox);
	}	
	return res;
}

//17
LInt cloneRev(LInt l){
	LInt a = NULL;
	while(l){
		a = newLInt(l -> valor, a);
		l = l -> prox;
	}
	return a;
}

//18
int maximo(LInt l){
	int a = 0;
	while(l){
		if(l -> valor > a) 
			a = l -> valor;
		l = l -> prox;
	}
	return a;
}

//19
int take(int n, LInt *l){
	int a = 0;
	while(*l){
		if(a < n){
			l = &(*l) -> prox;
			a++;
		}
		else{
			LInt aux = (*l) -> prox;
			(*l) = NULL;
			free(aux);
		}
	}
	return a;
}

//20
int drop(int n, LInt *l){
	int a = 0;
	LInt* head = l;
	LInt* aux = l;
	while(a < n && *l){
		aux = &(*l);
		l = &(*l) -> prox;
		free(*aux);
		a++;
	}
	*head = *l;
	return a;
}

//21
LInt NForward(LInt l, int N){
	LInt* aux = &l;
	while(*aux && N > 0){
		aux = &(*aux) -> prox;
		N--;
	}
	return *aux;
}

//22
int listToArray(LInt l, int v[], int N){
	int a = 0;
	LInt* aux = &l;
	while(*aux && a < N){
		v[a] = (*aux) -> valor;
		aux = &(*aux) -> prox;
		a++;
	}
	return a;
}

//23
LInt arrayToList(int v[], int N){
	LInt res = NULL;
	N--;
	while(N >= 0){
		res = newLInt(v[N], res);
		N--;
	}
	return res;
}

//24
LInt somasAcL(LInt l){
	int a = 0;
	LInt res = NULL;
	LInt *aux = &res;
	while(l){
		a += l -> valor;
		l = l -> prox;
		*aux = newLInt(a, NULL);
		aux = &(*aux) -> prox;
	}
	return res;
}

//25
void remreps(LInt l){
	int a = 0;
	LInt remov;
	LInt* res = &l;
	LInt* aux;
	while(*res){
		a = (*res) -> valor;
		aux = &(*res) -> prox;
		while(*aux){
			if((*aux) -> valor == a){
				remov = *aux;
				*aux = remov -> prox;
				free(remov);
			}
			else aux = &(*aux) -> prox;
		}
	res = &(*res) -> prox;
	}
}

//26
LInt rotateL(LInt l){
	LInt* aux = &l;
	LInt primeiro = NULL;
	if(*aux){
		primeiro = l;
		l = l -> prox;
		primeiro -> prox = NULL;
	}
	while(*aux){
		aux = &(*aux) -> prox;
	}
	*aux = primeiro;
	return l;
}

LInt rotateL(LInt l){
	//LInt* aux = &l;
	LInt primeiro = NULL;
	if(l){
		primeiro = l;
		l = l -> prox;
		primeiro -> prox = NULL;
	}
	while(l){
		l = l -> prox;
	}
	l = primeiro;
	return l;
}


//27
LInt parte(LInt l){
	LInt *n, *e, r;
	n = &r;
	e = &l;
	int i = 0;
	while(*e){
		if(i % 2 != 0){
			*n = *e;
			n = &(*n) -> prox;
			*e = (*e) -> prox;
		}
		else{
			e = &(*e) -> prox;
		}
		i++;
	}
	*n = NULL;
	return r;
}

//28
int altura (ABin a){
	int x = 0;
	if(a){
		if(altura(a -> esq) >= altura(a -> dir)){
			x = 1 + altura(a -> esq);
		}
		else{
			x = 1 + altura(a -> dir);
		}
	}
	return x;
}

//29
ABin cloneAB(ABin a){
	ABin new;
	if(a == NULL) return NULL;
	new = newABin(a -> valor, cloneAB(a -> esq), cloneAB(a -> dir));
	return new;
}

//30
void mirror(ABin *a){
	if(*a){
		mirror(&(*a) -> esq);
		mirror(&(*a) -> dir);
		ABin temp = ((*a) -> dir);
		(*a) -> dir = (*a) -> esq; 
		(*a) -> esq = temp;
	}
}

//31
void inorderAux(ABin a, LInt *l){
	LInt r;
	if(a == NULL) r = l;
	else{
		r = (LInt) malloc(sizeof(struct lligada));
		r -> valor = a -> valor;
		r -> prox = inorderAux(a -> dir, l);
		r = inorderAux(a -> esq, r);
	}
	return r;
}

void inorder(ABin a, LInt *l){
	return (inorderAux(a, NULL));
}

//32
void preorder(ABin a, LInt *l){
	LInt r;
	if(a == NULL) r = l;
	else{
		r = (LInt) malloc(sizeof(struct lligada));
		r -> valor = a -> valor;
		r -> prox = inorderAux(a -> dir, l);
		r = inorderAux(a -> esq, r);
	}
	return r;
}

void preorder(ABin a, LInt *l){
	return (preorderAux(a, NULL));
}

//33
void posorderAux(ABin a, LInt *l){
	if(a){
		*l = newLInt(a -> valor, *l);
		posorderAux(a -> dir, l);
		posorderAux(a -> esq, l);
	}
}

void posorder(ABin a, LInt *l){
	*l = NULL;
	posorderAux(a, l);
}

//34
int depth(ABin a, int x){
	int r = 1;
	if(a == NULL) r = -1;
	else if(a -> valor != x){
		if(depth(a -> dir, x) != -1 && depth(a -> esq, x) != -1){
			if(depth(a -> dir, x) > depth(a -> esq, x)) 
				r += depth(a -> esq, x);
			else r += depth(a ->dir, x);
		}
		else{
			if(depth(a -> esq, x) != -1)
				r += depth(a -> esq, x);
			else if(depth(a -> dir, x) != -1)
				r += depth(a -> dir, x);
			else r = -1;
		}
	}
}

//35
int freeAB(ABin a){
	int x = 0;
	if(a == NULL) return x;
	x = 1 + freeAB(a -> dir) + freeAB(a -> esq);
	free(a);
	return x;
}

//36
int pruneAB(ABin *a, int l){
	int counter;
	ABin *tmp;
	if(*a == NULL) counter = 0;
	else{
		if(l == 0){
			tmp = a;
			counter = 1 + pruneAB((&(*a) -> dir), 0);
			counter += pruneAB((&(*a) -> esq), 0);
			free(*tmp);
			*tmp = NULL;
		}
		else{
			counter = pruneAB((&(*a) -> dir), l - 1);
			counter += pruneAB((&(*a) -> esq), l - 1),
		}
	}
	return counter;
}

//37
int iguaisAB(ABin a, ABin b){
	if(!a && !b) return 1;
	else if(a&&b&&a->valor == b->valor&&iguaisAB(a->dir,b->dir) && iguaisAB(a->esq,b->esq)) return 1;
	return 0;
}

//38
LInt nivelL(ABin a, int n){
	LInt l = NULL;
	LInt p = NULL;
	if(a){
		if(n == 1)
			l = newLInt(a -> valor, NULL);
		else{
			p = nivelL(a -> dir, n-1);
			l = nivelL(a -> esq, n-1);
		}
	}
	LInt* e = &l;
	while(*e){
		e = &(*e) -> prox;
	}
	*e = p;
	return l;
}

//39
int nivelV(ABin a, int n, int v[]){
	int i = 0;
	if(a){
		if(n == 1){
			v[i] = a -> valor;
			i++;
		}
		else{
			i += nivelV(a -> esq, n-1, v);
			i += nivelV(a -> dir, n-1, v+i);
		}
	}
	return i;
}

//40
int dumpAbin(ABin a, int v[], int N){
	int i = 0;
	if(a){
		if(i < N) i += dumpAbin(a -> esq, v, N);
		if(i < N){
			v[i] = a -> valor;
			i++;
		}
		if(i < N) i += dumpAbin(a -> dir, v+i, N-i);
	}
	return i;
}

//41
ABin somasAcA(ABin a){
	ABin r;
	if(!a) r = NULL;
	else{
		r = (ABin) malloc(sizeof(struct nodo));
		r -> dir = somasAcA(a -> dir);
		r -> esq = somasAcA(a -> esq);
		r -> valor = a -> valor + valorABin(r -> dir) + valorABin(r -> esq);
	}
	return r;
}

int valorABin(ABin a){
	int r;
	if(!a) r = 0;
	else r = a -> valor;
	return r;
}

//42
int contaFolhas(ABin a){
	int r;
	if(!a) r = 0;
	else{
		if(!(a -> dir) && !(a -> esq)) r = 1;
		else r = contaFolhas(a -> dir) + contaFolhas(a -> esq);
	}
	return r;
}

//43
ABin cloneMirror(ABin a){
	ABin r;
	if(!a) r = NULL;
	else{
		r = (ABin) malloc(sizeof(struct nodo));
		r -> valor = a -> valor;
		r -> esq = cloneMirror(a -> dir);
		r -> dir = cloneMirror(a -> esq);
	}
	return r;
}

//44
int addOrd(ABin *a, int x){
	int r = 0;
	while(r != 1 && !*a){
		if((*a) -> valor == x) r = 1;
		else{
			if((*a) -> valor > x) a = &(*a) -> esq;
			else = a = &(*a) -> dir;
		}
	}
	if(!*a){
		*a = (ABin) malloc(sizeof(struct nodo));
		(*a) -> valor = x;
		(*a) -> dir = NULL;
		(*a) -> esq = NULL;
	}
	return r;
}

//45
int lookupAB(ABin a, int x){
	while(a){
		if(a -> valor == x) return 1;
		if(a -> valor < x) a = a -> dir;
		else a = a -> esq;
	}
	return 0;
}

//46
int depthOrd(ABin a, int x){
	int r = 1;
	if(!a) r = -1;
	else if(a -> valor != x){
		if(depthOrd(a -> esq, x) != -1) r += depthOrd(a -> esq, x);
		else if(depthOrd(a -> dir, x) != -1) r += depthOrd(a -> dir, x);
		else r = -1;
	}
	return r;
}

//47
int maiorAB(ABin a){
	int r = -1;
	while(a){
		if(a -> valor > r) r = a -> valor;
		a = a -> dir;
	}
	return r;
}

//48
int removeMaiorA(ABin *a){
	if(*a){
		while((*a) -> dir){
			a = &(*a) -> dir;
			*a = *a -> esq;
		}
	}
}

//49
int quantosMaiores(ABin a, int x){
	int r = 0;
	if(!a) return 0;
	if(a -> valor > x) r++;
	r += quantosMaiores(a -> esq, x);
	r += quantosMaiores(a -> dir, x);
}

//50
void arrayToBTree(ABin *a, int N, int v[]){
	int p;
	*a = (ABin) malloc(sizeof(struct nodo));
	if(N == 0 || *a == NULL) *a = NULL;
	else{
		p = N/2;
		(*a) -> valor = v[p];
		arrayToBTree(&(*a) -> esq, p, v);
		arrayToBTree(&(*a) -> dir, N-p-1, &v[p+1]);
	}
}

void listToBTree(LInt l, ABin *a){
	int i;
	LInt tmp = l;
	int v[100];
	for(i = 0; tmp != NULL; i++){
		v[i] = tmp -> valor;
		tmp = tmp -> prox;
	}
	arrayToBTree(a, i, v);
}

//51
int maior(ABin a, int x){
	int r = 0;
	if(!a) r = 1;
	else if(a -> valor > x && maior(a -> dir, x) && maior(a -> esq, x)) r = 1;
	return r;
}

int menor(ABin a, int x){
	int r = 0;
	if(!a) r = 1;
	else if(a -> valor < x && menor(a -> dir, x) && menor (a -> esq, x)) r = 1;
	return r;
}

int deProcura(ABin a){
	int r = 0;
	if(!a) r = 1;
	else if(menor(a -> esq, a -> valor) && maior(a -> dir, a -> valor) && deProcura(a -> dir) && deProcura(a -> esq)) r = 1;
	return r;
}
