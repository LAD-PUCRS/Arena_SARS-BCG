## 1-MHCPredictions-ModelHLA

This step should be executed in a single machine after completing the environment [setup](../Install/README.md).

**1. Container Image Build**

Build the container that will be used in this step.

```sh
docker build . -t step1
```
**2. Run Container Image**

Create a directory `in_data` on the repository root directory.

```sh
mkdir ../in_data
```

Create a container and start processing. When finished, the output will be stored on `../in_data`.

```sh
docker run --rm -v $(pwd)/../in_data:/in_data step1
```

The container execution will take some time. A description of the processing tasks of this container and their expected time is provided below.

2.1. Execute mhcflurrySARS.py
 - Input: sars_peptides.txt (9814 peptides) e hlas.fasta (14 alleles)
 - Output: predictionsSARS.csv
 - Time: 54.247s

2.2 Execute mhcflurryBCG.py
 - Input: bcg_peptides.txt (1242896 peptides) e hlas.fasta (14 alleles)
 - Output: predictionsBCG.csv
 - Time: 84m14.885s

2.3. Execute model_hla.py
 - Input: hlas.fasta (14 alleles)
 - Output: .pdb de cada allele
 - Time: 47m19.297s

2.4. Execute filter500_SARS.py
 - Input: predictionsSARS.csv
 - Output: "<allele>_SARSpeps" for each allele 
 - Time: 0.264s

2.5. Execute filter500_BCG.py
 - Input: predictionsBCG.csv
 - Output: "<allele>_BCGpeps" for each allele
 - Time: 29.097s