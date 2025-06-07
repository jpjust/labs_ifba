#!/usr/bin/bash

if [ $# -lt 2 ]; then
  echo "Uso: $0 num_lab \"comando\""
  echo ""
  echo "Exemplo: $0 4 \"shutdown -P now\""
  echo " - Desliga todos os computadores do laboratório 4."
  exit 1
fi

for i in $(seq 1 20); do
  printf -v num "%02d" $i
  echo "--- Executando em root@lab$1-pc$num.local"
  ssh root@lab$1-pc$num.local "$2"
done
