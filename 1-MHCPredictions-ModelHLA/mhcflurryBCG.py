#!/usr/bin/env python
# coding: utf-8

import os
from subprocess import call
from Bio import SeqIO

os.chdir("./")
call("pwd", shell=True)


peptides = []
f = open("bcg_peptides.txt")
for line in f:
    line_arr = line.split()
    if line_arr[0][0] == "#": continue
    peptides.append(line_arr[0])
f.close()
print("Num of peptides:", len(peptides))

hla_count = 0
hla_sequences = {}
for seq_obj in list(SeqIO.parse("hlas.fasta", "fasta")):
    hla_allele = seq_obj.description
    hla_allele = hla_allele.replace("*", "")
    hla_seq = seq_obj.seq
    hla_sequences[hla_allele] = seq_obj
    hla_count+=1
print("List of HLA alleles:", hla_sequences.keys())


f = open("mhcflurry_input.csv", 'w')
f.write("allele,peptide\n")

for allele in hla_sequences.keys():
    for peptide in peptides:
        f.write(allele + "," + peptide + "\n")

f.close()


from subprocess import PIPE
command = "mhcflurry-predict mhcflurry_input.csv --out predictionsBCG.csv"
call([command], shell=True)
call("rm -rf mhcflurry_input.csv", shell=True)
