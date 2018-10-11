#include <stdio.h>
#include <stdlib.h>

typedef struct lligada {
  int valor;
  struct lligada *prox;
} *LInt;


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
}*ABin;



ABin newABin(int n, ABin e, ABin d){
  ABin new; 
  new = (ABin) malloc(sizeof(ABin));
  new->valor = n;
  new->esq = e;
  new->dir = d;
}

/*
LInt newLInt(int n, LInt l){
  LInt new;
  LInt aux=l;
  new=(LInt) malloc(sizeof(LInt));
  new->valor=n;
  new->prox=NULL;
  if(l==NULL){
      return NULL;
  }
  for(aux=l; aux->prox!= NULL ; aux = aux->prox);
  aux->prox=new;
  return aux;
}
*/


//////////////////////////////////////////////////////////////
int length (LInt l) {
  int a=0;
  LInt* aux = &l;

 while(*aux != NULL ){
   a++;
   aux = &(*aux)-> prox;
 }
  return a;
}

/////////////////////////////////////////////////////
//temos de libertar apontador a apontador
void freeL (LInt l){
  LInt aux = l;
  while(l!=NULL){
    l=l->prox;
    free(aux);
    aux=l;
  }
}

///////////////////////////////////////////////////////
void imprimeL (LInt l){
  while(l != NULL){
    printf("%d\n",l->valor);
    l=l->prox;
  }
}

////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////

void insertOrd (LInt *l, int x){

while(*l != NULL && (*l)->valor < x){
    l = &(*l)->prox;
}

*l=newLInt(x,*l);
}

////////////////////////////////////////////////////////
int removeOneOrd (LInt *l, int x){
LInt* aux = l;

while(*aux != NULL && (*aux)->valor < x)
	aux = &(*aux)->prox;

if (*aux == NULL) return 1;

LInt remove = *aux;
*aux = remove->prox;

return 0;
}
////////////////////////////////////////////////////////

void merge(LInt *r, LInt a, LInt b){

LInt *aux = &(*r);

while(a != NULL && b != NULL){
        if(a->valor < b->valor){
           *r = newLInt(a->valor,NULL) ;
           a=a->prox;
           r = &(*r)->prox;
        }
        else{
         *r = newLInt(b->valor,NULL) ;
           b=b->prox;
           r = &(*r)->prox;
        }
    }
if (a !=NULL){
*r = a;

}

else{
*r = b;
}
}
/*
LInt merge(LInt *r, LInt a, LInt b){
LInt *aux = &(*r);
while(a != NULL || b != NULL){
        if(b == NULL || (a->valor < b->valor)){
           *r = newLInt(a->valor,NULL) ;
           a=a->prox;
           r = &(*r)->prox;
        }
        if(a == NULL || (a->valor > b->valor)){
         *r = newLInt(b->valor,NULL);
           b=b->prox;
           r = &(*r)->prox;
        }
    }
return *aux;
}
*/
//////////////////////////////////////////////////////
void splitMS (LInt l, int x, LInt *mx, LInt *Mx){
  while(l !=NULL) {
    if (l->valor < x) {
      *mx =newLInt(l->valor,NULL); // insere nó na lista dos menores
      mx = &((*mx)->prox); // endereço onde continua lista dos menores
    } else {
      *Mx = newLInt(l->valor,NULL); // insere nó na lista dos maiores
      Mx = &((*Mx)->prox); // endereço onde continua lista dos maiores
    }
    l = l->prox;
  }
}
///////////////////////////////////////////////////////
LInt parteAmeio (LInt *l){
LInt aux = *l;
LInt* head = l;
LInt* res = l;

if( (*l)->prox == NULL) return NULL;

while(*l != NULL ){
  l = &(*l)->prox;

  if(*l != NULL){
    l = &(*l)->prox;
    res = &(*res)->prox;
  } 
}
 
*head = (*res);
*res = NULL;
 
return aux;
}


////////////////////////////////////////////////////////
int removeAll (LInt *l, int x){
int a =0;
LInt* aux = l;
LInt remov;

while(*aux != NULL ){
    if ((*aux)->valor == x){
    remov = *aux;
    *aux = remov->prox;
    a++;
    }

    else{
     aux = &(*aux)->prox;
    }
}

return a;
}


////////////////////////////////////////////////////////
int removeDups (LInt *l){
int a = 0;
int b = 0;
LInt remov;
LInt *aux;

  while((*l) != NULL){
    b  = (*l)->valor;
    aux = &(*l)->prox;

       while(*aux != NULL ){

          if ((*aux)->valor == b){
          remov = *aux;
          *aux = remov->prox;
          a++;
          }

          else aux = &(*aux)->prox;
       }

    l = &(*l)->prox;
 }

return a;
}
////////////////////////////////////////////////////////
int removeMaiorL (LInt *l){
LInt* head = l; // tem de ser assim ou vai dar merda , believe me.... ( ou poem    LInt *head = l; head =l; e a mesma coisa)
int a = 0;
int flag = 0;
LInt rem;
LInt* aux = l;


while( *l != NULL){ // calcula o maior
if ((*l)->valor > a) a = (*l)->valor ;
l = &(*l)->prox;
}

l = head; // poem o l a apontar para a cabeça outra vez

while(*aux != NULL && flag != 1){
    if((*aux)->valor == a ){
      rem = *aux;
      *aux = rem->prox;
      flag = 1;
    }
    else aux = &(*aux)->prox;  // tem de ter o else se nao no caso de ser NULL NULL da porcaria
}

return a;

}

/////////////////////////////////////////////////////////

void init (LInt *l){
  while((*l) != NULL){
    if((*l)->prox == NULL) {
      free(*l);
      *l= NULL;
    }
    else l = &(*l)->prox;
  }
}


/*void init (LInt *l){
if(*l == NULL) return;
  while((*l)->prox != NULL)
    l = &(*l)->prox;
  free(*l);
  *l = NULL;
}
*/


/*
void init (LInt *l){
  LInt ll = *l;
  LInt ante = ll;
  LInt head = ll;
  ll = ll->prox;
  while (ll->prox){
    ante = ll;
    ll = ll->prox;
  }
  ante->prox = NULL;
  free(ll);
  *l = head;
}
*/
/////////////////////////////////////////////////////////
void appendL (LInt *l, int x){
  while((*l) != NULL)
    l = &(*l)->prox;

  *l = newLInt(x,NULL);
}

////////////////////////////////////////////////////////
void concatL (LInt *l, LInt b){
  while(*l != NULL)
    l = &(*l)->prox;

*l = b;
}

////////////////////////////////////////////////////////
LInt cloneL(LInt l) {
  LInt res = NULL;
  LInt *aux = &res;


  while (l != NULL) {
    *aux = newLInt(l->valor, NULL);
    l = l->prox;
    aux = &((*aux)->prox);
  }

  return res;

}

/*LInt clone(LInt l){
   if(l == NULL ) return NULL;
    LInt aux = newLInt(l->valor,NULL);
   LInt a =&(aux);
   l = l->prox;
   while(l != NULL){
    aux->prox = newLInt(aux->valor,NULL);
    l = l->prox;
   }
return a;
}
*/
////////////////////////////////////////////////////////
LInt cloneRev (LInt l){
LInt a = NULL;

while(l != NULL){
  a = newLInt(l->valor,a);
 l = l->prox;
}

return a;
}

////////////////////////////////////////////////////////
int maximo (LInt l){
  int a=0;
  LInt *aux;
  aux = &l;

  while(*aux != NULL){
    if((*aux)->valor > a) a = (*aux)->valor;
    aux = &(*aux)->prox;
  }

  return a;
}

///////////////////////////////////////////////////////////////////////////////////
//** confirmar esta porque nao tenho a certeza quanto ao free se ta bem ou nao **//
///////////////////////////////////////////////////////////////////////////////////
  int take (int n, LInt *l){
 int a =0;

 while((*l) != NULL){
    if (a < n) {
        l = &(*l)->prox;
    a++;

    }
    else {
   LInt aux = (*l)->prox;
    (*l) = NULL;
    freeL(aux);
    }
 }
 return a;
 }

 ///////////////////////////////////////////////////////////////////////////////
int drop (int n, LInt *l){
 int a =0;
LInt* head = l;
LInt* aux ;


 while(a<n && *l != NULL){
   aux = &*l;
   l= &(*l)->prox;
   free(*aux);
  a++;
  }

*head = *l;

 return a;
}
///////////////////////////////////////////////////////////////////////////////
LInt NForward (LInt l, int N){
 int a =0;
 
LInt* aux = &l;
 
 
 while(*aux != NULL && a<N){
     aux = &(*aux)->prox;
     a++;
 }
 
  return *aux;
}
///////////////////////////////////////////////////////////////////////////////
int listToArray (LInt l, int v[], int N){
  int a=0;
 LInt* aux = &l;

  while(*aux != NULL && a<N){
    v[a] = (*aux)->valor;
    aux = &(*aux)->prox;
    a++;
  }


return a;
}
//////////////////////////////////////////////////////////////////////////////
LInt arrayToList (int v[], int N){
LInt res = NULL;
N--;
while (N >=0){
  res = newLInt(v[N],res);
  N--;
}
return res;
}
///////////////////////////////////////////////////////////////////////////////
LInt somasAcL (LInt l){
int a=0;
LInt res = NULL;
LInt *aux = &res;

while(l != NULL){
  a += l->valor;
  l = l->prox;
  *aux = newLInt(a,NULL);
  aux = &(*aux)->prox;
}

return res;
}

///////////////////////////////////////////////////////////////////////////////
void remreps (LInt l){
int b = 0;
LInt remov;
LInt* res = &l;
LInt *aux;

  while((*res) != NULL){
    b  = (*res)->valor;
    aux = &(*res)->prox;

       while(*aux != NULL ){

          if ((*aux)->valor == b){
            remov = *aux;
           *aux = remov->prox;
          free(remov);
          }

          else aux = &(*aux)->prox;
       }

    res = &(*res)->prox;
 }
}
//////////////////////////////////////////////////////////////////////////////
LInt rotateL (LInt l){
LInt* aux = &l;
LInt primeiro = NULL;

if(*aux != NULL ){
  primeiro = l ;
  l = l->prox;
  primeiro->prox = NULL;
}

while( *aux != NULL){
aux = &(*aux)->prox;
}

*aux = primeiro;
return l ;
}

/////////////////////////////////////////////////////////////////////////////7/

LInt parte (LInt l){

  LInt *n, *e, r;

  n = &r;
  e = &l;

  int i = 0;

  while (*e != NULL){
    if (i%2 != 0){
      *n = *e;
      n = &((*n)->prox);
      *e = (*e)->prox;
    }
    else{
      e = &((*e)->prox);
    }
          i++;
  }

  *n = NULL;

  return r;
}



///////////////////////////////////////////////////////////////////////////////
int altura(ABin l){
int a = 0;

if(l != NULL){
if ( altura((l)->esq) > altura((l)->dir))
a = 1 + altura((l)->esq);
else a = 1 + altura((l)->dir);
}

return a;
}

///////////////////////////////////////////////////////////////////////////////
ABin cloneAB (ABin a){
ABin new;

if(a == NULL) return NULL;

new = newABin(a->valor, cloneAB(a->esq), cloneAB(a->dir));

return new;

}

////////////////////////////////////////////////////////////////////////////////
void mirror(ABin *a){
 if(*a != NULL){ 
   mirror(&(*a)->esq);
   mirror(&(*a)->dir);
   ABin temp = ((*a)->dir);
   (*a)->dir = (*a)->esq;
   (*a)->esq = temp;
  }
}
///////////////////////////////////////////////////////////////////////////////
void inorderAux (ABin a, LInt *l){
  if(a != NULL) {

    inorderAux(a->dir,l);

    *l= newLInt(a->valor,*l);

    inorderAux(a->esq,l);
  }
  /*tem de estar ao contrario porque tem de inserir a cabeça pelo newLInt !!*/
}

void inorder (ABin a, LInt *l){
  *l = NULL;
  inorderAux(a,l);
}

///////////////////////////////////////////////////////////////////////////// 
void preorderAux (ABin a, LInt *l){
if(a != NULL){
preorderAux(a->dir,l);
preorderAux(a->esq,l);
*l= newLInt(a->valor,*l);
}
}

void preorder(ABin a, LInt *l){
  *l = NULL;
  preorderAux(a,l);
}
//////////////////////////////////////////////////////////////////////////////
void posorderAux (ABin a, LInt *l){
  if(a != NULL) {
    *l= newLInt(a->valor,*l);
    posorderAux(a->dir,l);
    posorderAux(a->esq,l);
  }
  /*tem de estar ao contrario porque tem de inserir a cabeça !!*/
}

void posorder(ABin a, LInt *l){
  *l = NULL;
  posorderAux(a,l);
}
///////////////////////////////////////////////////////////////////////////////
int depth (ABin a, int x){
  int r = 1;
  if (a == NULL) r = -1;
  else if (a->valor != x){
          if(depth(a->dir, x) != -1 && depth(a->esq, x) != -1){
               if  (depth(a->dir, x) > depth(a->esq, x))  r += depth(a->esq, x);
               else r +=  depth(a->dir, x);
          }
          else if (depth(a->esq, x) != -1) r +=  depth(a->esq, x);
               else if (depth(a->dir, x) != -1) r += depth(a->dir, x);
                    else r = -1;
        }
  return r;
}
///////////////////////////////////////////////////////////////////////////////
int freeAB (ABin a){
int x = 0;

if(a == NULL) return x;


x = 1+ freeAB(a->dir) + freeAB(a->esq);
free(a);
return x;
}
///////////////////////////////////////////////////////////////////////////////
int pruneAB (ABin *a, int l){

  int counter;
  ABin *tmp;

  if (*a == NULL) counter = 0;

  else{

    if (l == 0){
      tmp = a;
      counter = 1 + pruneAB((&(*a)->dir), 0);
      counter += pruneAB((&(*a)->esq), 0);

      free(*tmp);
      *tmp = NULL;    
    }

    else{
      counter = pruneAB((&(*a)->dir), l - 1);
      counter += pruneAB(&((*a)->esq), l - 1);
    }
  }
  return counter;
}

//////////////////////////////////////////////////////////////////////////////
int iguaisAB (ABin a, ABin b){
 if (a ==NULL && b== NULL) return 1;
else if (a != NULL && b != NULL && a->valor == b->valor && iguaisAB(a->dir, b->dir) && iguaisAB(a->esq, b->esq)) return 1; 
  
return 0;
}
//////////////////////////////////////////////////////////////////////////////
LInt nivelL (ABin a, int n){
    LInt l = NULL;
    LInt p= NULL;
  if (a == NULL) l = NULL;
  else{
    if (n == 1)
       l = newLInt(a->valor,NULL);
    
    else{
      p = nivelL(a->dir, n - 1);
      l = nivelL(a->esq, n - 1);
    }
  }
  //concatL(&l,p); // usar a concatL das LInt 
  LInt* e = &l;
  while(*e != NULL)
      e = &(*e)->prox;
  *e = p;
 
  return l;
}
/////////////////////////////////VER ESTA 39//////////////////////////////////////////////
int nivelV (ABin a, int n, int v[]){
int i =0;
    if(a!=NULL ) {
        if(n==1){
            v[i] = a->valor;
            i++;
        }
        else{
        i = nivelV(a->esq,n-1,v);
        i += nivelV(a->dir,n-1,v+i);
        }
    
    }
    
return i;
}
/////////////////////////////////////////////////////////////////////////////

int dumpAbin (ABin a, int v[], int N){
    int i = 0;
  if (a != NULL){
    if (i < N) i =dumpAbin(a->esq, v, N);
    if (i < N){
        v[i] = a->valor; 
        i++;
    }
    if (i < N) i += dumpAbin(a->dir, v+i, N-i);
    }
   return i;
}

/////////////////////////////////////////////////////////////////////////
int valorABin (ABin a){

  int r;

  if (a == NULL) r = 0;

  else r = a->valor;

  return r;
}

ABin somasAcA (ABin a){

  ABin r;

  if (a == NULL) r = NULL;

  else{
    r = (ABin) malloc(sizeof(struct nodo));
    r->dir = somasAcA(a->dir);
    r->esq = somasAcA(a->esq);
    r->valor = a->valor + valorABin(r->dir) + valorABin(r->esq);
  }

  return r;
}
///////////////////////////////////////////////////////////////////////////////
int contaFolhas (ABin a){

	int r;

	if (a == NULL) r = 0;

	else{

		if (a->dir == NULL && a->esq == NULL) r = 1;

		else r = contaFolhas(a->dir) + contaFolhas(a->esq);

	}

	return r;
}
///////////////////////////////////////////////////////////////////////////////
ABin cloneMirror (ABin a){

	ABin r;

	if (a == NULL) r = NULL;

	else{
		r = (ABin) malloc(sizeof(struct nodo));
		r->valor = a->valor;
		r->esq = cloneMirror(a->dir);
		r->dir = cloneMirror(a->esq);
	}

	return r;
}
///////////////////////////////////////////////////////////////////////////////
/*int addOrd (ABin *a, int x){
	ABin n;
	int r = 0;
	if (*a == NULL){
		*a = (ABin) malloc(sizeof(struct nodo));
		(*a)->valor = x;
		(*a)->dir = NULL;
		(*a)->esq = NULL; 
	}
	else{
		if ((*a)->valor == x) r = 1;
		else{
			if (x > (*a)->valor){
				if (addOrd(&((*a)->dir), x)) r = 1;
			}
			else{
				if (addOrd(&((*a)->esq), x)) r = 1;
			}
		}
	}
	return r;
}*/
int addOrd (ABin *a, int x) {
  int r = 0;
  while( r != 1&& *a != NULL){
    if((*a)->valor == x) r= 1;
    else{
      if((*a)->valor > x) a = &(*a)->esq;
      else a = &(*a)->dir;
    }
  }
  if (*a == NULL){
		*a = (ABin) malloc(sizeof(struct nodo));
		(*a)->valor = x;
		(*a)->dir = NULL;
		(*a)->esq = NULL; 
	}
  return r;
}

///////////////////////////////////////////////////////////////////////////////
int lookupAB (ABin a, int x) {
  while( a != NULL){
    if(a->valor == x)return 1;
    if(a->valor < x) a = a->dir;
    else  a = a->esq;
  }
  return 0;
}
///////////////////////////////////////////////////////////////////////////////
int depthOrd (ABin a, int x){

  int r = 1;

  if (a == NULL) r = -1;

  else if (a->valor != x){
    if (depthOrd(a->esq, x) != -1) r +=  depthOrd(a->esq, x);
        
    else if (depthOrd(a->dir, x) != -1) r += depthOrd(a->dir, x);

    else r = -1;
  }
  
  return r;
}
///////////////////////////////////////////////////////////////////////////////
int maiorAB (ABin a) {
  int r = -1;
  while( a != NULL){
    if(a->valor > r)   r = a->valor; 
    a = a->dir;
  }
  return r;
}
///////////////////////////////////////////////////////////////////////////////
void removeMaiorA (ABin *a) {
  if(*a != NULL){ 
  while((*a)->dir!= NULL)
    a = &(*a)->dir;
    
  *a = (*a)->esq;
  }
}
///////////////////////////////////////////////////////////////////////////////
int quantosMaiores (ABin a, int x) {
  int r = 0;
  if(a == NULL) return 0;
  if(a->valor > x)   r++; 
  r += quantosMaiores(a->esq,x);
  r += quantosMaiores(a->dir,x);

  return r;

}
///////////////////////////////////////////////////////////////////////////////
/*void listToBTree (LInt l, ABin *a) {
  if(l->prox!= NULL)
    listToBTree(l,&(*a)->esq);
  (*a)= newABin(l->valor,NULL,NULL);
  
  listToBTree(l,&(*a)->dir);
}
}
*/
void arrayToBTree(ABin *a, int N, int v[]){

	int p;

	*a = (ABin) malloc(sizeof(struct nodo));

	if (N == 0 || *a == NULL) *a = NULL;

	else{
		p = N/2;
		(*a)->valor = v[p];
		arrayToBTree(&((*a)->esq), p, v);
		arrayToBTree(&((*a)->dir), N - p - 1, &v[p + 1]);
	} 

}

void listToBTree (LInt l, ABin *a){

	int i;

	LInt tmp = l;

	int v[100];

	for (i = 0 ; tmp != NULL ; i++){
		v[i] = tmp->valor;
		tmp = tmp->prox;
	}

	arrayToBTree(a, i, v);
}

///////////////////////////////////////////////////////////////////////////////
int maior(ABin a , int x){
  int r = 0;     
  if(a == NULL) r = 1;
  else if(a->valor > x && maior(a->dir,x) && maior(a->esq,x)) r = 1;
  return r;
}

int menor(ABin a , int x){
  int r = 0;
  if(a == NULL) r = 1;
  else if(a->valor < x && menor(a->dir,x) && menor(a->esq,x)) r = 1;
     
  return r;
}
 
 
int deProcura (ABin a){
	int r=0;
	if (a == NULL) r = 1;
  else if( menor(a->esq,a->valor) && maior(a->dir,a->valor) && deProcura(a->dir) && deProcura(a->esq)) r= 1;
	return r;
}


///////////////////////////////////////////////////////////////////////////////
void imprimeAB (ABin a){
  if (a==NULL)
    printf("NULL\n");
    //return;
  else{
   printf("%p %d head\n", a, a->valor);
  imprimeAB(a->esq);



  imprimeAB(a->dir);
}
}
///////////////////////////////////////////////////////////////////////////////
int main(){
/*
int x;
  LInt a = newLInt(7,NULL);
	LInt b = newLInt(6,a);
	LInt c = newLInt(5,b);
	LInt d = newLInt(4,c);
	LInt e = newLInt(3,d);
	LInt f = newLInt(2,e);
	LInt g = newLInt(1,f);
	LInt h = newLInt(8,g);
  LInt p;
int v[3];*/ 
//v[0] = 2;
//v[1] = 3;
//v[2] = 4;
//v[3] = 5;
LInt q;
q = NULL;

 
ABin i = newABin(10,NULL,NULL);
ABin j = newABin(30,NULL,NULL);
ABin k = newABin(20, i, j);
ABin l = newABin(5, NULL, k);
//)  mirror(&l);
 // z = somasAcA(l);

inorder(l,&q);
  //z = nivelL(l,2);
// imprimeAB(l);
//  p = parteAmeio(&a);
  //printf("%d\n", i );
  imprimeL(q);
  printf("||||||||||||||||||||||||||\n");
 // imprimeL(p);
  return 0;
}