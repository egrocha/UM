#!/usr/bin/python3

#1 - fazer print do texto com 3 '###' no 
#    inicio de cada frase
def clean(file):
    text = open(file).read()
    text = re.sub(r'\nO SENHOR DOS ANÉIS\n\d+', "", text)
    text = re.sub(r'\n\d+\nJ. R. R. TOLKIEN', "", text)
    return text

def paragrafos(text):
    re.sub(r'([.!?]\s*\n\s*)', r'\1#p# ', text)

def frases(text):
    paragrafos

#2 - encontrar e imprimir nomes proprios