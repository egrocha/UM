#!/usr/bin/python3
#Imprime as linhas de um ficheiro em ordem contraria

def reverseFile(filename):
    for line in reversed(open(filename).readlines()):
        print(line.rstrip())

reverseFile("ex2.py")