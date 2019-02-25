#!/usr/bin/python3

import re

#Fazer exp. regs. para apanhar strings
teste = "t a T 1234 420.69 M asd"

#1 - com um 't'
re.search(r"t", teste)

#2 - com um 't' ou 'T'
re.search(r"t|T", teste)
re.search(r"[tT]", teste)
re.search(r"t", teste, re.I) #case insensitive

#3 - tenha uma letra
re.search(r"[a-zA-Z]", teste)
re.search(r"(?!=[0-9])\w", teste)

#4 - tenha um digito
re.search(r"[0-9]", teste)
re.search(r"\d+(?:\.\d+)?", teste)

#5 - tenha um numero decimal
re.search(r"\.[0-9]+", teste)

#6 - tenha comprimento de mais de 3 caracteres
re.search(r".{4,}", teste)
re.search(r".{....+}", teste)

#7 - tenha um 'M' mas nao um 'm'
re.search(r"M" r"^[^m]+$", teste)
re.search(r"M", teste) and not r"m"

#8 - tenha um caracter repetido
re.search(r"(.).*\1", teste)

#9 . tenha apenas um caracter repetido varias vezes
re.search(r"^(.)\1*$", teste)

#10 - tenha todas as palavras entre {}
re.search(r"(\w)+", "{\1}", teste)