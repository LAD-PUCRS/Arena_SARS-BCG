Para esta etapa é necessário ter o R instalado (em nosso ambiente foi utilizado o R versão 3.6.1, instalado pelo miniconda) e, dentro dele, deve estar instalado o pvclust.
O PVClust pode ser instalado com o seguinte comando (dentro do terminal R):
```
install.packages("pvclust")
```

O primeiro passo é rodar o transpose.sh, que gera um arquivo CSV único, com todas as informações necessárias para o Pvclust, a partir dos CSVs gerados na etapa anterior.
```sh
./transpose.sh <CVS_PATH>
```

Depois basta rodar o script R que executa o Pvclust para geração do dendrograma
```sh
nohup bash -c 'time Rscript dendrogram_PVCLUST.R' &> pvclust_R.log &
```

- Vale ressaltar que ambos scripts (transpose.sh e dendrogram_PVCLUST.R) contém informações baseadas nos dados gerados pela [etapa anterior](../4-GetHistograms_ImageJ/README.md) utilizando o RoiSet_46diag.zip. Caso haja alguma alteração no roiset, é necessário revisar ambos scripts.
