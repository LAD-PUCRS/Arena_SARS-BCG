1. Criação de imagem (em uma única máquina) pelo DockerFile
 - Execução: docker build . -t step1

2. Execução do run.sh. Dentro da instancia docker.
 - Primeiro crio a pasta in_data: mkdir ../in_data
 - Execução: docker run --rm -v $(pwd)/../in_data:/in_data step1  

2.1. Executa mhcflurrySARS.py
 - Entrada: sars_peptides.txt (9814 peptideos) e hlas.fasta (14 alelos)
 - Saida: predictionsSARS.csv
 - Tempo: 54.247s

2.2 Executa mhcflurryBCG.py
 - Entrada: bcg_peptides.txt (1242896 peptideos) e hlas.fasta (14 alelos)
 - Saida: predictionsBCG.csv
 - Tempo: 84m14.885s

2.3. Executa model_hla.py
 - Entrada: hlas.fasta (14 alelos)
 - Saida: .pdb de cada alelo
 - Tempo: 47m19.297s

2.4. Executa filter500_SARS.py
 - Entrada: predictionsSARS.csv
 - Saida: "<alelo>_SARSpeps" para cada alelo 
 - Tempo: 0.264s

2.5. Executa filter500_BCG.py
 - Entrada: predictionsBCG.csv
 - Saida: "<alelo>_BCGpeps" para cada alelo 
 - Tempo: 29.097s

2.6. Move os arquivos necessários para as proximas etapas em ../in_data 
