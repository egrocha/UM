#!/usr/bin/python3
#Imprime os pares de um array

lista = [1,2,3,4,5,6,7,8,9,10]

def pares(l):
    for e in l:
        if not e % 2:
            print(e)

pares(lista)