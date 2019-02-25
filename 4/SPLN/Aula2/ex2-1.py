#!/usr/bin/python3
#Retorna um array os pares de uma lista

lista = [1,2,3,4,5,6,7,8,9,10]

def pares(l):
    return [e for e in l if not e % 2]

print(pares(lista))