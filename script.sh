#!/bin/sh -e

# Arquivos do sistema
echo "--- Instalando arquivos de sistema..."
tar -zxf files/system.tar.gz -C /

if [ ! -d "/root/files" ]; then
  mkdir /root/files
fi

cp files/usuarios.tar.gz /root/files/
chown -R root: /root
chmod 0700 /root

# Configuração do APT e pacotes
echo "--- Configurando o apt-get..."
apt update

echo "--- Removendo pacotes desnecessários..."
apt purge -y cups* thunderbird* rhythmbox brasero transmission* hexchat \
  parole simple-scan gnome-games gnome-sudoku gnome-mahjongg gnome-mines

echo "--- Atualizando o sistema..."
apt upgrade -y

echo "--- Instalando pacotes do laboratório..."
apt install -y build-essential btop chromium clang cmake flatpak g++ gcc git \
  libgtk-3-dev linux-headers-amd64 mc ncdu neovim net-tools ninja-build nmap \
  openjdk-17-jdk postgresql preload python3 r-base r-base-dev vim wireshark-qt

## Flutter (copiado da documentação)
apt install -y curl git unzip xz-utils zip libglu1-mesa mesa-utils
apt install -y libc6:amd64 libstdc++6:amd64 lib32z1 libbz2-1.0:amd64

## Pacotes não mais necessários
apt autoremove -y
apt autoclean

## Pacotes extras
for pacote in "deb"/*; do
  apt install -y ./$pacote
done
apt upgrade -y

# Arquivos
echo "--- Copiando arquivos..."
tar -zxf files/android-studio.tar.gz -C /
tar -zxf files/android-cmdtools.tar.gz -C /
tar -zxf files/flutter.tar.gz -C /
tar -zxf files/intellij.tar.gz -C /
tar -zxf files/nodejs.tar.gz -C /

# Configurações
## fsck automático
echo "--- Configurando..."
sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="fsck.mode=auto fsck.repair=yes"/' /etc/default/grub
update-grub

## Avahi
sed -i 's/publish-hinfo=.*/publish-hinfo=yes/' /etc/avahi/avahi-daemon.conf
sed -i 's/publish-workstation=.*/publish-workstation=yes/' /etc/avahi/avahi-daemon.conf
sed -i 's/^hosts:.*/hosts: files mdns mdns4_minimal [NOTFOUND=return] dns/' /etc/nsswitch.conf

## Desabilita suspensão automática
sed -i 's/^#*HandleSuspendKey=.*/HandleSuspendKey=ignore/' /etc/systemd/logind.conf
sed -i 's/^#*HandleLidSwitch=.*/HandleLidSwitch=ignore/' /etc/systemd/logind.conf
sed -i 's/^#*HandleLidSwitchDocked=.*/HandleLidSwitchDocked=ignore/' /etc/systemd/logind.conf
systemctl restart systemd-logind

# Swap
if [ ! -e "/swap.img" ]; then
  echo "--- Criando arquivo de swap..."
  dd if=/dev/zero of=/swap.img bs=4096 count=1048576 status=progress
  chmod 0600 /swap.img
  mkswap /swap.img
  echo "/swap.img swap swap 0 0" >> /etc/fstab
  swapon -a
fi

# Reseta os usuários
/root/reset-usuarios.sh

echo "--- Pronto!"
