Execução manual de diversos passos

1. É necessário que todas as máquinas tenham o diretório ../in_data
 - Essa pasta é gerada em uma execução unica de instancia docker da etapa "1-MHCPredictions-ModelHLA"

2. Criação de imagem (em todas as máquinas) pelo DockerFile
 - Execução: docker build . -t step2

3. Configuração do arquivo dispatcher/hosts.cfg
 - O proprio arquivo apresenta descrição da configuração, porém deve exeirtir 1 linha para cada máquina do conjunto, onde a primeira informação de cada linha é o IP da máquina

4. Configuração do arquivo dispatcher/start.py
 - Para execução básica o script já está pronto (não necessária alteração), mas o proprio script documenta algumas configurações que  podem ser modificadas de acordo com a expertise do usuário.

5. Acessar pasta do dispatcher e execução do mesmo
 - acesso a pasta: cd dispatcher
 - O dispatcher roda em apenas uma máquina, ele que inicia instancias docker de processamento nas demais máquinas do conjunto
 - Indica-se utilização de nohup: nohup python3 -u start.py &

Pós execução:
 - O HLA, por conter calculos estocasticos, algumas modelagens podem não convergir. Por padrão o hla reinicia o calculo, porém nosso script Model-pepHLA-APE_Gen-LAD.py limita cada complexo a, no máximo, 5 erros. Aí pula para o proximo.
 - Desta forma, é possivel/provavel que nem todos complexos tenham um respectivo arquivo modelado (PDB).
 - Dependendo do conhecimento do usuário é possivel trabalhar os dados na pasta ../in_data para ter uma nova versão sómente com os complexos que  apresentaram falha, deste modo é possivel fazer um backup da  pasta output e reiniciar o processo do dispatcher (desta vez, apenas com os complexos que falharam na prieira execução)
 - Outra alternativa é remover a limitação do script Model-pepHLA-APE_Gen-LAD.py, porém é possivel que a execução do dispatcher tenha algumas instancias docker rodando infinitamnte o calculo de modelagem do mesmo complexo (sempre falhando).
