O objetivo dessa etapa é gerar uma imagem da superficie da molecula do complexo modelado.

o speedup.sh pode ser ignorado momentaneamente.
Ele executa um mesmo teste repetidas vezes sobre um conjunto determinado de dados para verificar tempos de execução com diferentes numeros de processadores

os scripts importantes mesmo são os run_parallel.sh e run.sh.
O run.sh dispara um processo do pymol que roda o run.pml e a partir disso que vai chamando os demais arquivos.
O run_parallel.sh dispara N vezes o run.sh
As diferentes execuções do run.sh não interferem umas as outras, pois cada processo cria uma lista total de arquivos pdb que precisam ser processados para geração da respectiva imagem e não processa arquivos em que o arquivo da respectiva imagem já existe.
Ambos scripts contém variáveis que devem ser revisadas para execução, como numero de processos e diretórios de input (arquivos pdb) e output (arquivos png) e diretório de instalação do pymol

Há uma questão importante com relação aos arquivos mol-fit.pdb e run.pml:
O run.pml nada mais é do que uma sequencia de comandos do pymol e um destes comandos é o set_view, que posiciona a molecula (3D) de forma que a a imagem (2D) exiba o que é importante.
Cada molécula (arquivo PDB) é carregada pelo pymol em uma posicão diferente, ou seja, cada arquivo utilizaria valores de set_view diferentes.
A solução foi criar um set_view baseado em um único PDB (mol-fit.pdb) e sempre carregá-lo juntamente com o PDB desejado, executar o comando extra_fit baseado nele e depois removê-lo da execução. Ou seja, o extra_fit posiciona a molecula processada igualmente à utilizada como fit, para que os parametros de set_view possam ser os mesmos.
Estes comandos já estão inclusos no run.pml, porém pode ser necessário trocar arquivo mol-fit.pdb e os parametros do set_view.

### Importante: Este repositório não inclui a instalação do Pymol. A seguir temos o passo a passo de instalação do mesmo:

```
apt-get install libgl1-mesa-glx
wget https://pymol.org/installers/PyMOL-2.4.1_198-Linux-x86_64-py37.tar.bz2
tar -xjf PyMOL-2.4.1_198-Linux-x86_64-py37.tar.bz2
rm -rf  PyMOL-2.4.1_198-Linux-x86_64-py37.tar.bz2
```

Pode ser útil mapear a pasta bin no PATH:
`export PATH=$PWD/pymol/bin:$PATH`





