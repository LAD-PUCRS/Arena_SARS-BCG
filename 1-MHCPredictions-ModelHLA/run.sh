#!/bin/bash

# data
#-rw-r--r-- 1 root root 13671854 Jul 14 12:19 bcg_peptides.txt
#-rw-r--r-- 1 root root   107954 Jul 14 12:19 sars_peptides.txt
#-rw-r--r-- 1 root root     5333 Jul 14 12:32 hlas.fasta

# script
#-rw-r--r-- 1 root root     1031 Jul 14 13:19 mhcflurrySARS.py
#-rw-r--r-- 1 root root     1029 Jul 14 12:44 mhcflurryBCG.py
#-rw-r--r-- 1 root root     1554 Jul 14 12:43 model_hla.py
#-rw-r--r-- 1 root root      970 Jul 14 13:19 filter500_SARS.py
#-rw-r--r-- 1 root root      968 Jul 14 13:19 filter500_BCG.py



echo
echo
echo python mhcflurrySARS.py
time python mhcflurrySARS.py
echo
echo
echo python mhcflurryBCG.py
time python mhcflurryBCG.py
echo
echo
echo python model_hla.py
time python model_hla.py
echo
echo
echo python filter500_SARS.py
time python filter500_SARS.py
echo
echo
echo python filter500_BCG.py
time python filter500_BCG.py
echo
echo
echo "Genetarating ../in_data for next steps"
mv *peps *pdb /in_data
