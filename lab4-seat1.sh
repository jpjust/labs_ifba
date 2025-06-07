#!/bin/sh -e

echo "--- Configurando a partição extra..."

if [ ! -d "/home/aluno1/Arquivos" ]; then
  mkdir -p /home/aluno1/Arquivos
fi
if [ ! -d "/home/aluno2/Arquivos" ]; then
  mkdir -p /home/aluno2/Arquivos
fi

echo "/dev/sdb3 /home/aluno1/Arquivos ext4 user,noatime,nodiratime,errors=remount-ro 0 2" >> /etc/fstab
echo "/dev/sdb4 /home/aluno2/Arquivos ext4 user,noatime,nodiratime,errors=remount-ro 0 2" >> /etc/fstab
chown -R aluno1: /home/aluno1/Arquivos
chown -R aluno2: /home/aluno2/Arquivos

echo "--- Instalando o LightDM..."
apt update
apt install -y lightdm
apt remove -y gdm3

sed -i 's/^#*background=.*/background=\/usr\/share\/wallpapers\/ifba_feira.jpg/' /etc/lightdm/lightdm-gtk-greeter.conf

echo "--- Configurando o monitor do seat1..."
loginctl flush-devices
loginctl attach seat1 /sys/devices/pci0000\:00/0000\:00\:01.0/0000\:01\:00.0/drm/card0

echo "--- Reinicie."
