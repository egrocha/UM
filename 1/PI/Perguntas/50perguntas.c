#include <stdio.h>
//1
void main () {
    int x=1,y=0;
    while (x!=0) {scanf ("%d",&x);y+=x;}
    printf("%d\n", y);
}


//2
void main () {
    int x=1,y=0;
    while (x!=0) {scanf ("%d",&x);if (x>y) y=x;}
    printf("%d\n", y);
}

//3
void main () {
    int x=1,y=0,w=-1;
    while (x) {scanf ("%d",&x);y+=x;++w;}
    printf("%d\n", (y/w));
}
//4
void main () {
    int x=1,segundo=0,maior=-1;
    while (x) {
      scanf ("%d",&x);
      if (x>maior) {segundo=maior; maior=x;}
      if (x<maior && x>segundo) segundo=x;}
    printf("%d\n", segundo);
}

//5

int bitsUm (int x){
    int r=0;
    while (x>0) {
		if (x%2) r++;
		(x/=2);
	}
    return r;
}

//6
int trailingZ (unsigned int n) {
    int r=0;
    while (n%2==0) {++r; n/=2;}
    return r;
}

//7
int qDig (int n) {
    int r = 0;
    while (n/=10>1) {++r; n/=10;}
    return r;
}

//8
int mystrlen(char str[]) {
	int i=0;
	while (str[i]!='\0') i++;
	return i;
}

//9
char *mystrcat(char s1[], char s2[]) {
    int i=0, j=0,x;
    while (s1[i]!='\0') ++i; // ou     i= strlen (s1);
    while (s2[j]!='\0') {s1[i]=s2[j]; ++j;++i;}
    s1[i]='\0';
    return (s1);
}

//10
char *mystrcpy(char s1[], const char s2[]) {
    int i=0;
    while (s2[i]!='\0') {
        s1[i]=s2[i];
        ++i;
    }
    s1[i]='\0';
    return s1;
}

//11
int mystrcmp(char s1[], char s2[]) {
    int i;
    for(i=0;s1[i] && s2[i] && s1[i]==s2[i];++i);
    return (s1[i]-s2[i]);
}

//12
char *mystrstr (char s1[], char s2[]) {
    int i=0,j=0,w=0;
    for (i=0; s1[i]&& s2[j];++i){
        w=i; 
        j=0;
        while (s2[j] && s1[i]==s2[j]) {++i; ++j;}
        i=w;
    }
    if (s2[j]=='\0') return s1+w;
    else return NULL;
}

//13
void strrev (char s[]) {
    int i=0,j;
    j=(strlen (s))-1;
    char t [j+1];
    strcpy (t,s);
    while (t[i]!='\0') {
        s[j]=t[i];
        --j;++i;
    }
}
// ou
void strrev (char s[]) {
   int i=0,j;
   char t;
   j=(strlen (s))-1;
   while (i<j) {
    t=s[i];
    s[i]=s[j];
    s[j]=t;
    --j;
    ++i;
   }
}
// ou neste apenas encurta
void strrev (char s[]) {
   int i=0,j;
   char t;
   j=(strlen (s))-1;
   while (i<j) {
    t=s[i];
    s[i++]=s[j];
    s[j--]=t;
   }
}

//14
void strnoV (char t[]){
    int i=0,j=0;
    while (t[i]!='\0') { 
        if ((t[i]!='a') && (t[i]!='e') && (t[i]!='i') && (t[i]!='o') && (t[i]!='u') && (t[i]!='A') && (t[i]!='E') && (t[i]!='I') && (t[i]!='O') && (t[i]!='U'))
         {t[j]=t[i]; ++j;}
        ++i;     
    }
    t[j]='\0';
}
// ou
void strnoV (char t[]){
    int i=0,j=0;
    while (t[i]!='\0') { 
        if ((t[i]=='a') || (t[i]=='e') || (t[i]=='i') || (t[i]=='o') || (t[i]=='u') || (t[i]=='A') || (t[i]=='E') || (t[i]=='I') || (t[i]=='O') || (t[i]=='U')) ;
        else {t[j]=t[i]; ++j;} // ou t[j++]=t[i];
        ++i;  
    }
    t[j]='\0';
}

//15
void truncW (char t[], int n){
    int i=0,j=0, w;
    w=n;
    while (t[i]) {
        if (t[i]==' ') {n=w,t[j]=t[i];++j;} // ou {n=w,t[j++]=t[i];}
        else if (n!=0) {t[j]=t[i];--n;++j;} // ou {t[j++]=t[i];--n;}
        ++i;
    }
    t[j]='\0';
}

//ou
void truncW (char t[], int n){
    int i,j=0, w=n;
    for (i=0; t[i];++i){
        if (t[i]==' ') {n=w,t[j]=t[i];++j;} // ou {n=w,t[j++]=t[i];}
        else if (n!=0) {t[j]=t[i];--n;++j;} // ou {t[j++]=t[i];--n;}
    }
    t[j]='\0';
}

//16

char charMaisFreq (char t[]){
    int i=0,j=0,x;
    char f='0',g;
    while (t[0]!='\0'){
        g=t[0];
        for (x=0,i=0;t[i]!='\0';++i) {if (t[i]==g) ++x;} // conta
        if (x>j) {f=g;j=x;}
        for (i=0,x=0; t[i]!='\0';++i) {if (t[i]!=g) t[x++]=t[i];} // delete
        t[x]='\0';      
    }
    return f;
}

char charMaisfreq(char t[]){
  int i, j, max = 0, cont = 1;
  char f;
  if(t[0] == '\0') return 0;
  else f = t[0];
  for(i = 0; t[i]; i++){
    cont = 1;
    for(j = i; t[j]; j++){
      if(t[i] == t[j]) cont++;
      if(cont > max){
        max = cont;
        f = t[j];
      }
    }
  }
  return f;
}


//ou
char charMaisFreq (char t[]){
    int i=0,j=0,x,l;
    char f='0',g;
    while (t[0]!='\0'){
        g=t[0];
        for (x=0,i=0,l=0;t[i]!='\0';++i) {
            if (t[i]==g) ++l;
            else {t[x]=t[i];++x;}}
        t[x]='\0';
        if (l>j) {f=g;j=l;}
    }
    return f;
}
//ou
char charMaisFreq (char t[]){
    int i=0,m=0,x,g;
    char f='0';
    for (i=0;t[i];++i){
        g=i;
        for (x=0;t[g]!='\0';++g) {if (t[g]==t[i]) ++x;} 
        if (x>m) {m=x;f=t[i];}
    }
    return f;
}

//17
int iguaisConsecutivos (char s[]) {
    int i = 0, g=1,m=0;
    while (s[i]){
        if (s[i]==s[i+1]) ++g;
        else {if (g>m) m=g;
             g=1;
        }
        ++i;
    }
    return m;
}

//ou
int iguaisConsecutivos (char s[]) {
    int i = 0, g=1,m=0;
    while (s[i]){
        while (s[i]==s[i+1]) {++g;++i;}
        if (g>m) m=g;
             g=1;
        ++i;
    }
    return m;
}

//18 
int difConsecutivos (char s[]) {
    int i=0,m=0,j=0,w=0,g=0;
    for (i=0; s[i];++i) {
        for (j=i-1,w=1;j>g && s[j]!=s[i] ;--j,++w);
        if (w>m) m=w;
        g=j;
    }
    return m;
}

//19
int maiorPrefixo (char s1 [], char s2 []) {
    int i;
    for (i=0; s1[i]==s2[i] && s1[i]!='\0';++i);
    return i;
}

//20 
int maiorSufixo (char s1 [], char s2 []) {
    int i,j,w;
    i = (strlen (s1))-1;
    j= (strlen (s2))-1;
    for (w=0; i>=0 && j>=0 &&s1[i]==s2[j];++w,--i,--j); 
    return w;
}

//21
int sufPref (char s1[], char s2[]) {
    int w=0,i=0,j=0,s;
    while (s1[i]&& w==0) {
        s=i;
        if (s1[i]==s2[0]) {while (s1[i]==s2[j]&&s1[i]) {++i;++j;++w;}}
        if (s1[i]) {i=s;j=0;w=0;}
        ++i;
          }
    return w;
}
//ou
int sufPref (char s1[], char s2[]) {
    int i=0,j=0,w;
    for (i=0;s1[i] && s1[w];++i) {
        w=i;
        j=0;
        if (s1[i]==s2[j]) {while (s1[w]==s2[j]&&s1[w] && s2[j]) {++w;++j;}}
    }
    return j;
}

//22 simplificar depois
int contaPal (char s[]) {
    int i=0, j=0;
    while (s[i]!='\0') {
        if (s[i]==' ' && s[i+1]!=' ' && s[i+1]!='\0') ++j;
        ++i;
    }
    if (s[0]=='\0'|| s[0]==' ') return j;
    else return (j+1);
}

//ou
int contaPal (char s[]) {
    int i=0,w=0;
    for (i=0;s[i];++i) {
        if (s[i]!=' ' && (s[i+1]==' ' || s[i+1]=='\0')) ++w;
    }
    return w;
}

//23
int contaVogais (char t[]) {
    int i=0,j=0;
    while (t[i]!='\0') { 
        if ((t[i]=='a') || (t[i]=='e') || (t[i]=='i') || (t[i]=='o') || (t[i]=='u') || 
            (t[i]=='A') || (t[i]=='E') || (t[i]=='I') || (t[i]=='O') || (t[i]=='U')) 
            ++j;
        ++i;  
    }
    return j;
}

//24
int contida (char a[], char b[]) {
    int i=0,j,w=1;
    while (a[i]!='\0'&& w==1){
        w=0;
        for (j=0; b[j]!='\0'&& w!=1;++j) {if (b[j]==a[i]) w=1;}
        ++i;
    }
    return w;
}

//ou
int contida (char a[], char b[]) {
    int i=0,j;
    for (i=0;a[i];++i){
        for (j=0; b[j] &&b[j]!=a[i] ;++j);
        if (b[j]=='\0') return 0;
    }
    return 1;
}
//25
int palindroma(char s[]){
    int i, j, w = 1;
    j = strlen(s) - 1;
    for(i =0 ; i < j && w != 0 ; ++i, --j)
        if(s[i] != s[j]) 
            w=0;
    return w;
}

//ou
int palindroma (char s[]) {
    int i=0,j;
    j = (strlen (s))-1;
    while (s[i]==s[j]) {++i;--j;}
    if (j<i) return 1;
    else return 0;
}

// 26

int remRep (char x []) {
  int i,e=0;
  for (i=0;x[i];++i)
    if (x[i]!=x[i+1]) {
      x[e]=x[i];
      e++;
    }
  x[e]='\0';
  return e;
}


//27

int limpaEspacos (char s []) {
    int i=0, j=0;
    while (s[i]!='\0') {
        if (s[i]!=' ' || s[i+1]!=' ') s[j++]=s[i];
        ++i;
    }    
    s[j]='\0';
    return j;
}

//28 
void insere (int v[], int N, int x){
       --N;
       while (N>=0){
         if(x>v[N]) {v[N+1]=x;N=-1;}
         else {v[N+1]=v[N];--N;}
       }
       if (x<v[0]) v[0]=x;
   }

//
 void insere (int v[], int N, int x){
int i;

for (i=N; (i>0) && (v[i-1] > x); i--)
v[i] = v[i-1];

v[i] = x;
}
//
   void insere (int v[], int N, int x){
    for (; (N>0) && (v[N-1] > x); N--)
    v[N] = v[N-1];

    v[N] = x;
}

//29 
   void merge (int r [], int a[], int b[], int na, int nb){
       int i=0, j=0,w=0;
       while (j<na && w<nb) {
           if (a[j]<b[w]) {r[i]=a[j];++i;++j;}
           else {r[i]=b[w];++i;++w;}
       }
       if (j==na) {while (w<nb) {r[i]=b[w];++i;++w;}}
       if (w==nb) {while (j<na) {r[i]=a[j];++i;++j;}}

   }
   

//30
      int crescente (int a[], int i, int j){
       int r=1;
       while (i<j && r==1){
           if (a[i]>a[i+1]) r=0;
           ++i;
       }
       return r;
   }


//31 como se elimina o resto
   int retiraNeg (int v[], int N){
   int i,j=0;
   for (i=0;i<N;++i) {
       if (v[i]>=0) {v[j]=v[i];++j;}
   }
   return j;
   }


//32 tentar outra maneira, esta é um bocado estupida
      int menosFreq (int v[], int N){

       int i=0,j=1,t=N,c;
       while (i<N-1) {
          j=1;
          while (v[i]==v[i+1]) {++j;++i;}
          if (j<t) {c=v[i];t=j;}
          ++i;
       }
       if (v[N-1]!=v[N-2] && t!=1) return v[N-1];
       else return c;
       
   }  



//33
   int maisFreq (int v[], int N){
       int i=0,j=1,t=0,c;
       while (i<N-1) {
          while (v[i]==v[i+1]) {++j;++i;}
          if (j>t) {c=v[i];t=j;}
          j=1;
          ++i;
       }
       return c;
   }

// tentaar perceber why it doesn't work, wokrjjnvebwbgnb+nvepofnveqnvqejrnpenrvprjbipesrnf
   int maisFreq (int v[], int N){
       int j=1,t=0,c;--N;
       while (N>=0) {
          while (v[N]==v[N-1]) {++j;--N;}
          if (j>=t) {c=v[N];t=j;}
          j=1;
          --N;
       }
       return c;
   }


//34 
   int maxCresc (int v[], int N) {
        int i, w=1, t=0;
        for (i=1;(i<N);++i) {
            for (w=1;v[i]>=v[i-1]; ++i,++w);
            if (w>t) t=w;
        }
       return t;
   }

//35
   int elimRep (int v[], int N) {
       int i,j=0,w=0;
       for (i=1,w=1; i<N;++i){
           for (j=i-1;j>=0&&v[j]!=v[i];--j) ;
           if (j<0) {v[w]=v[i];++w;}
       }
       return w;}

//36
   int elimRepOrd (int v[], int N) {
       int i,j=1;
       for (i=1;i<N;++i) {
           if (v[i]!=v[i-1]) {v[j]=v[i];++j;}
       }
       return j;
   }

//37 
   int comunsOrd (int a[], int na, int b[], int nb){
       int i=0,j=0,w=0;
       while (i<na && j<nb){
           if (a[i]==b[j]) {++w;++j;++i;}
           else if (a[i]>b[j]) ++j;
           else ++i;
           } 
       return w;
   }

//38
   int comuns (int a[], int na, int b[], int nb){
    int w=0,j;
    for (--na;na>=0;--na) {
        for (j=0;j<nb && b[j]!=a[na];++j);
        if (j<nb) ++w;
        }
    return w;  
   }

//mais elaborada que faz outras coisas
int comuns (int a[], int na, int b[], int nb){
int i=0,w=0,j;
int c [nb];
for (i=0;i<nb;++i) c[i]=b[i];
for (i=0;i<na&&nb>0;++i) {
        for (j=0;j<nb && c[j]!=a[i];++j);
        if (j<nb) {
            --nb;
            ++w;
            while (j<nb) {c[j]=c[j+1];++j;}
            
        }
        }
    return w;  
   }


//39
int minInd (int v[], int n) {
int l=0;
for (--n;n>=0;--n) 
if (v[n]<=v[l]) l=n;
return l;
}

//40
void somasAc (int v[], int Ac [], int N){
   int i;
   Ac[0] = v [0];
   for (i=1;i<N;++i) {
        Ac [i] = Ac [i-1] + v [i];
   }
}


// 41
int triSup (int N, float m [N][N]) {
    int j;
    for (--N; N>=0; --N) {
        for (j=0; j<N; ++j) 
        if ((m [N] [j])!=0) return 0;
    }
    return 1;  
}


//42
void transposta (int N, float m [N][N]) {
    float x;
    int j;
    for (--N;N>=0;--N) {
        for (j=0; j<N; ++j) {
            x = m [N] [j];
            m [N] [j] = m [j] [N];
            m [j] [N] = x;
        }
    }
}


//43
void addTo(int N, int M, int a [N][M], int b[N][M]) {
    int j;
    for (--N;N>=0;--N) {
        for (j=0; j<M; ++j) (a [N] [j]) += (b [N] [j]); 
    }
}


//44 
void sumDiag(int N, int m [N][N]){
    int i, j=0, w=0;
    for (i=0; i<N;++i) {
        w=0;
        for (j=0;j<N;++j) if (i!=j) w += m [i] [j];
        m[i] [i] = w;
    }
}

//45
void main () {
    int x=65;
    while (x<=90) {
    printf("%c\t%d\n", x,x);
  ++x;}
  x=97;
    while (x<=122) {
    printf("%c\t%d\n", x,x);
  ++x;}
}

//46
      int unionSet (int N, int v1[N], int v2[N], int r[N]){
        int i=0;
        for (i=0;i<N;++i) {
        if (v1[i]==1 || v2[i]==1) r[i]=1;
        else  r[i]=0;}
        return 0;
   }


//47
   int  intersectSet (int N, int v1[N], int v2[N], int r[N]){
        for (--N;N>=0;--N) {
        if (v1[N]==1 && v2[N]==1) r[N]=1;
        else r[N]=0;}
        return 1;
   }


//48
   int intersectMSet (int N, int v1[N], int v2[N], int r[N]){
       for (--N;N>=0;--N) {if (v1[N]>v2[N]) r[N]=v2[N];
       else r[N]=v1[N];}
       return 1;
   }

//49
      int unionMSet (int N, int v1[N], int v2[N], int r[N]){
       for (--N;N>=0;--N) {if (v1[N]>v2[N]) r[N]=v1[N];
       else r[N]=v2[N];}
       return 1;
   }

//50 
   int cardinalMSet (int N, int v[N]){
      int i=0;
      for (--N; N>=0; --N) i+=v[N];
      return i; 
   }
