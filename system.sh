#!/bin/sh -e

echo "--- Instalando arquivos de sistema..."
tar -zxf files/system.tar.gz --no-same-owner -C /

if [ ! -d "/root/files" ]; then
  mkdir /root/files
fi

cp files/usuarios.tar.gz /root/files/
chown -R root: /root
chmod 0700 /root
