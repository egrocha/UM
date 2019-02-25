#!/usr/bin/python3

from collections import Counter
import re


def ocorrencia(file):
    text = open(file).read()
    text = clean_text(text)
    words = text.split()
    counter = Counter(words).most_common(10)
    return counter

def ocorrencia2(file):
    ocor = {}
    for line in open(file).readlines():
        for word in re.findall(r"\w+(?:-\w+)*", line.lower()):
            ocor[word] = ocor.get(word, 0) + 1
    return list(reversed(sorted(ocor.items(), key = lambda e : e[1])))[0:10]

def clean_text(text):
    text = text.lower()
    text = re.sub(r"[ãàá]", r"a", text)
    text = re.sub(r"é", r"e", text)
    text = re.sub(r"õ", r"o", text)
    text = re.sub(r"í", r"i", text)
    text = re.sub(r"[,.!\?-]", r"", text)
    text = re.sub(r"(\w+)([,.!?])", r"\1", text)
    return text

counter = ocorrencia2("sda_irmandade.txt")
i = 0
for ele in counter:
    print("%d: %s" % (i+1, ele[0]))
    i = i + 1