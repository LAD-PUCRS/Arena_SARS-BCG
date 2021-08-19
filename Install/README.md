Instalação do ambiente para execução dos diversos passos da metodologia

1. Executar ./gen_certs.sh (ou ./gen_installScripts.sh)
 old... - Ele cria uma pasta "certs" que conterá  certificados que o dispatcher utilizará para comunicar com demais hosts
 - Ele criará o arquivo install_docker.sh

2. Instalação do docker em todos os hosts.
 - Instalação manual, onde cada máquina do conjunto deve executar uma cópia do script install_docker.sh gerado na etapa anterior.
 - Script auto contido com os certificádos necessário para administração do docker remoto (pelo headnode do conjunto)
