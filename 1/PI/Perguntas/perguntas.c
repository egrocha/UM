#include <stdio.h>
#include <string.h>

//1
int p1(){
	int x, y=0;
	while(x != 0){
		scanf("%d",&x);
		y += x; 
	}
	printf("%d\n",y);
}

//2
int p2(){
	int x, max=0;
	while(x != 0){
		scanf("%d",&x);
		if(x > max) max = x;
	}
	printf("%d\n",max);
}

//3
void p3(){
	int x=1, med=0, i=-1;
	while(x != 0){
		scanf("%d",&x);
		med += x;
		i++;
	}
	if(i>0){printf("%d\n",med/i);}
}

//4
void p4(){
	int x=1, fst=0, snd=0;
	while(x){
		scanf("%d",&x);
		if(x > fst) fst = x;
		if(x > snd && fst > x) snd = x;
	}
	printf("%d\n",snd);
}

//5
void p5(int n){
	int bits=0;
	while(n > 0){
		if(n % 2 == 1) bits++;
		n = n/2;
	}
	printf("%d\n",bits);
}

//6
void p6(unsigned int n){
	int bits=0;
	while(n > 0){
		if(n % 2 == 0) bits++;
		n = n/2;
	}
	printf("%d\n",bits);
}

//7
void p7(unsigned int n){
	int i = 0;
	while(n > 0){
		i++;
		n /= 10;
	}
	printf("%d\n",i);
}

//8
void p8(char str[]){
	int i = 0;
	while(str[i] != '\0'){
		i++;
	}
	printf("%d\n",i);
}

//9
void *p9(char s1[], char s2[]){
	int i = 0, j = 0;
	while(s1[i] != '\0'){
		i++;
	}
	while(s2[j] != '\0'){
		s1[i] = s2[j];
		j++;
		i++;
	}
	s1[i] = '\0';
	return s1;
}

//10
void *p10(char dest, char source[]){
	int i = 0;
	while(source[i] != '\0'){
		dest[i] = source[i];
		i++;
	}
	dest[i] = '\0';
	return dest;
}

//11
int p11(char s1[], char s2[]){
	int i, r;
	for(i = 0; s1[i] && s2[i] && s1[i] == s2[i]; i++);
	r = s1[i] - s2[i];
	return r;
}

//12
void p12(char s1[], char s2[]){
	int i = 0, j = 0, p = 0, w;
	while(s1[i] && s2[i]){
		w = i;
		j = 0;
		if(s1[i] == s2[j]){
			i++;
			j++;
		}
		i = w;
	}
	if(s2[i] == '\0'){
		return s1 + w;
	}
}

//13
void p13(char s[]){
    int i=0,j;
    j=(strlen (s))-1;
    char t [j+1];
    strcpy(t,s);
    while (t[i]!='\0') {
        s[j]=t[i];
        --j;++i;
    }
}

//14
void p14(char s[]){
   	int i, j=0;
	for(i = 0; s[i]!='\0'; i++){
		if(s[i] != 'a' && s[i] != 'e' && s[i] != 'i' && s[i] != 'o' && s[i] != 'u' && s[i] != 'A' && s[i] != 'E' && s[i] != 'I' && s[i] != 'O' && s[i] != 'U'){
			s[j] = s[i];
		    j++;
		}
	}
	s[j] = '\0';	
}

//15
void p15(char t[], int n){
	int i, j=0, e=1; 
	for(i = 0; t[i]; i++){
		if(t[i] != ' ' && e>n){
			s[j] = s[i];
			j++;
		}
		if(t[i] == ' ') e = 1;
		e++;
	}
	s[j] = '\0';
}

void main(){
	p13("asdf");
}