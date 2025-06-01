#!/bin/sh -e

if [ $# -eq 0 ]; then
  for pacote in "."/*; do
    if [ -d $pacote ]; then
      echo "--- Empacotando $pacote..."
      cd $pacote
      rm -rf ../../files/$pacote.tar.gz
      tar -zcf ../../files/$pacote.tar.gz *
      cd ..
    fi
  done  
else
  echo "--- Empacotando $1..."
  cd $1
  rm -rf ../../files/$1.tar.gz
  tar -zcf ../../files/$1.tar.gz *
  cd ..
fi
