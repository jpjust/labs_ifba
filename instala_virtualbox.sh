#!/bin/sh -e

# Chaves do VirtualBox
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor

# Configuração do APT e pacotes
echo "--- Configurando o apt-get..."
apt update

echo "--- Atualizando o sistema..."
apt upgrade -y

echo "--- Instalando pacotes do VirtualBox..."
apt install -y --allow-downgrades virtualbox-7.1

# Grupos para VirtualBox
for grupo in "kvm" "libvirt" "libvirt-qemu" "vboxusers" "video" "wireshark"
do
  if getent group $grupo > /dev/null; then
    usermod -aG $grupo aluno
    if getent passwd "aluno2" > /dev/null; then
      usermod -aG $grupo aluno2
    fi
  else
    echo "--- Grupo $grupo não existe."
  fi
done

echo "--- Pronto!"
