#!/usr/bin/python3
#Implementar função que recebe um nome de ficheiro, imprime as
#10 palavras mais frequentes e o número de ocorrências.

words = open('sda_irmandade.txt').read().split()

#Cria array com todas as palavras distintas
uniques = []
for word in words:
	if word not in uniques:
		uniques.append(word)

#Conta quantas vezes acontecem no ficheiro
counts = []
for unique in uniques:
	count = 0
	for word in words:
		if word == unique:
			count += 1
	counts.append((count, unique))

#Ordena array de contagem de palavras por ordem decrescente
counts.sort()
counts.reverse()

#Imprime 10 primeiros
for i in range(min(10, len(counts))):
	count, word = counts[i]
	print('%d: %s - %d' % (i+1, word, count))