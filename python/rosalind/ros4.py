#!/usr/bin/python

def freq(x):
	x

#open our data file
f = open("data.txt", "r")
data = f.read()
f.close()

fastastrs = data.split('>')
for fasta in fastastrs:
	freq(fasta[14:])
