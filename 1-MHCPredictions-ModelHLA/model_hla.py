#!/usr/bin/env python
# coding: utf-8

# # HLA-Arena Workflow 3: Virtual Screening Example

# All data will be saved in a folder called "workflow3"

# In[1]:


import os
from subprocess import call
from Bio import SeqIO

import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import pandas as pd
import HLA_Arena as arena
import ipywidgets as widgets
import time
import subprocess
from ipywidgets import interact, FloatRangeSlider, IntSlider, IntProgress
import importlib

os.chdir("./")
call("pwd", shell=True)


hla_count = 0
hla_sequences = {}
for seq_obj in list(SeqIO.parse("hlas.fasta", "fasta")):
    hla_allele = seq_obj.description
    hla_allele = hla_allele.replace("*", "")
    hla_seq = seq_obj.seq
    hla_sequences[hla_allele] = seq_obj
    hla_count+=1
print("List of HLA alleles:", hla_sequences.keys())


print("Approximated time needed for modelling HLAs with MODELLER:")
print("2 minutes per HLA")
print("{:}".format(hla_count*2)+" min")
print("{:.2f}".format(hla_count/30)+" h")
print ('-'*80)


hla_alleles = hla_sequences.keys()
for hla_allele in hla_alleles:
    if os.path.exists(hla_allele + ".pdb"):
        print("Already found " + hla_allele + ".pdb")
        continue
    allele_name_reformatted = hla_allele[:5] + "*" + hla_allele[5:-2] + ":" + hla_allele[-2:]
    print(allele_name_reformatted)
    SeqIO.write(hla_sequences[hla_allele], "alpha_chain.fasta", "fasta")
    arena.model_hla(("alpha_chain.fasta", hla_allele), num_models=2)
    call(["cp best_model.pdb " + hla_allele + ".pdb"], shell=True)
