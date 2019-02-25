#!/usr/bin/python3
#Implementar ex5 em python

import subprocess, sys

file = sys.argv[1]

output = subprocess.check_output(["head", "-n 50", file])

print("\n".join(output.decode("utf-8").split('\n')[-12:]))