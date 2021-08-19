filename="predictionsBCG.csv"
threshold = 500.0

f = open(filename,"r")
f.readline() # Skip header
alleles = {}

# Reads the file and filters the content
for line in f:
	cols = line.split(",") # columns
	if cols[0] not in alleles.keys():
		alleles[cols[0]] = []
	if float(cols[2]) <= threshold:
		alleles[cols[0]].append(cols[1])
f.close()
#print(alleles)
#{'HLA-A0101': ['TSDYYQLYS', 'STDTGVEHV'], 'HLA-A0201': ['WLIVGVALL', 'ALLAVFQSA'], 'HLA-A0202': ['FVTVYSHLL', 'TVYSHLLLV'], 'HLA-A1101': ['VTHSKGLYR', 'ASKIITLKK', 'IMRLWLCWK'], 'HLA-A2402': ['DFVRATATI', 'ASLPFGWLI'], 'HLA-B0702': ['IPIQASLPF', 'APFLYLYAL'], 'HLA-B1503': ['IPIQASLPF', 'VGVALLAVF'], 'HLA-B3501': ['IPIQASLPF', 'LPFGWLIVG'], 'HLA-B4001': ['EEEQEEDWL', 'SEDNQTTTI'], 'HLA-B5101': ['MPLSAPTLV', 'LPIDKCSRI']}


# Writes the filtered content in separate allele files.
for allele in alleles.keys():
	f = open(allele+"_BCGpeps","w")
	for entry in alleles[allele]:
		f.write(entry + '\n')
f.close()

