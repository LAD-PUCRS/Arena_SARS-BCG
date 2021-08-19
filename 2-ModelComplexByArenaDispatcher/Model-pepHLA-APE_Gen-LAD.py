#!/usr/bin/env python
# coding: utf-8

import os
import sys
from subprocess import call
from datetime import datetime
import HLA_Arena as arena
import pandas as pd

in_data="in_data/"
out_data="out_data/"
DEBUG=True
#energyThr = -8
#cutoff = 500

path = os.getcwd()+"/"
complex_list = {}

def debug(message="message"):
	if DEBUG:
		print ('-'*80)
		print (datetime.now().strftime("%Y-%m-%d_%H:%M:%S	") + message + " #DEBUGLAD(job "+path+")")
		print ('-'*80)

debug("Leitura dos arquivos")
count_complex = 0
for file in sorted(os.listdir(in_data)):
	temp = file.split(".")
	if len(temp) > 1:
		complex_list[temp[0]] = {}

		f = open(in_data+temp[0]+"_BCGpeps")
		complex_list[temp[0]]['BCG']=f.readlines()
		count_BCGpeps = len(complex_list[temp[0]]['BCG'])
		count_complex += count_BCGpeps
		print(str(count_BCGpeps)+" BCG peptides for allele "+temp[0]) 
		f.close()

		f = open(in_data+temp[0]+"_SARSpeps")
		complex_list[temp[0]]['SARS']=f.readlines()
		count_SARSpeps = len(complex_list[temp[0]]['SARS'])
		count_complex += count_SARSpeps
		print (str(count_SARSpeps)+" SARS peptides for allele "+temp[0]) 
		f.close()
print("Total: "+str(count_complex)+" complexes read")

# complex_list structure:
#{
#	hla-bc101{
#		bcg [
#			fdagadg, safagasf, safafasf
#		]
#		sars [
#			dfsdgsgs, sdgsdgsd, sdgsdg 
#		]
#	}
#	hla-bc102{
#		bcg {
#			fdagadg, safagasf, safafasf
#		}
#		sars {
#			dfsddgsgsgs, sdgsdgsd, sdgsdg 
#		}
#	}
#}

complex_start = 1
complex_stop = count_complex
argv_size = len(sys.argv)
if argv_size >= 2 :
	complex_start = int(sys.argv[1])
if argv_size >= 3 :
	complex_stop = int(sys.argv[2])
print("Process "+str(complex_stop - complex_start + 1)+" complexes ("+str(complex_start)+" to "+str(complex_stop)+")")


debug("Inicia precessamento completo dos complexos")
count_total_complex = 1
count_apegen = 1
for allele in complex_list:
	for tipo in complex_list[allele]:
		i=0
		error_count = 0
		while i < len(complex_list[allele][tipo]):
			if count_total_complex >= complex_start and count_total_complex <= complex_stop:
				peptide = complex_list[allele][tipo][i].strip()
				print ('-'*80)
				print("Running ("+str(count_apegen)+"/"+str(complex_stop - complex_start + 1)+") APE-Gen on HLA:" + allele +" peptide:"+ peptide)
				print ('-'*80)

				comp =  allele.replace("*", "")+"-"+tipo+"_"+peptide
				print(comp)
				call(["mkdir -p " + out_data+comp], shell=True)
				os.chdir(out_data+comp)
				try:
					call(["mkdir -p "+path+"selected_structures"], shell=True)

					print ("exec best_scoring_conf = arena.dock("+peptide+", "+path+in_data+allele+".pdb)")
					best_scoring_conf = arena.dock(peptide, path+in_data+allele+".pdb")
					print("best_scoring_conf = "+best_scoring_conf)
					
					print("Fast rescoring with Smina for complex "+comp)
					func = "vina"
					binding = "Binding affinity prediction (kcal/mol)"
					energy = arena.rescore_complex_simple_smina(best_scoring_conf, func)
					print(comp+": "+str(energy)+" kcal/mol")

					print("Gather selected structure for complex "+comp)
					print("No energy threshold chosen")
					print("Writing "+comp+" to "+path+"selected_structures/")
					call(["cp "+best_scoring_conf+" "+path+"selected_structures/"+comp+".pdb"], shell=True)
					selected_pdb = open(path+'selected_structures/'+comp+'.pdb', 'a')
					selected_pdb.write("REMARK   2 Energy Binding affinity prediction (kcal/mol): "+str(energy))
					selected_pdb.close()
					os.chdir("../")
					print ("Cleaning the temp data for "+comp)
					call(["rm -rf "+comp], shell=True)

					error_count = 0
					i+=1
					count_apegen += 1
					count_total_complex += 1
				except:
					error_count += 1
					os.chdir("../../")
					call(["rm -r "+comp], shell=True)
					print("ERROR "+str(error_count)+"/5 from APE-Gen generating structure "+comp)
					if error_count >= 5:
						print("Giving up from "+comp+" after 5 tries")
						selected_pdb = open(path+'selected_structures/'+comp+'.pdb', 'a')
						selected_pdb.write("REMARK   1 Giving up from "+comp+" ("+str(count_total_complex)+"/"+str(count_complex)+") after 5 tries")
						selected_pdb.close()
						error_count = 0
						i+=1
						count_apegen += 1
						count_total_complex += 1
					else:
						print("Repeating reconstruction of the structure "+comp)

				os.chdir(path)
			else: 
				#print ("Ignoring complex "+str(count_total_complex)+" because it doesn't belong to the running list")
				i += 1;
				count_total_complex += 1

debug("Encerrando execucao")
