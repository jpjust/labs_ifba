#!/usr/bin/bash

if [ $# -lt 3 ]; then
  echo "Uso: $0 num_lab arquivo caminho_destino"
  echo ""
  echo "Exemplo: $0 4 aula.txt /home/aluno1/Documentos/"
  echo " - Copia o arquivo aula.txt para a pasta de documentos do aluno1 no laboratório 4."
  exit 1
fi

for i in $(seq 1 20); do
  printf -v num "%02d" $i
  echo "--- Copiando para root@lab$1-pc$num.local:$3"
  scp $2 root@lab$1-pc$num.local:$3
done
