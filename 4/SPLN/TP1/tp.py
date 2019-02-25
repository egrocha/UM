#!/usr/bin/python3

import re

def clean(file):
    text = open(file).read()
    text = re.sub(r'<(\w+)>', r"\1", text)
    text = re.sub(r'<\/(\w+)>', "", text)
    text = re.sub(r'<(.+)\/>', r"\1", text)
    text = re.sub(r' {4}', ' - ', text)
    return text

res = clean("teste.xml")
print(res)