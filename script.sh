#!/bin/sh -e

# Arquivos do sistema
./system.sh

# Configuração do APT e pacotes
echo "--- Configurando o apt-get..."
apt update

echo "--- Removendo pacotes desnecessários..."
grep -vE '^\s*#|^\s*$' pacotes_purge.txt | xargs apt purge -y

echo "--- Atualizando o sistema..."
apt upgrade -y

echo "--- Instalando pacotes do laboratório..."
grep -vE '^\s*#|^\s*$' pacotes_apt.txt | xargs apt install -y

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
tar -zxf files/android-studio.tar.gz --no-same-owner -C /
tar -zxf files/android-sdk.tar.gz --no-same-owner -C /
tar -zxf files/flutter.tar.gz --no-same-owner -C /
tar -zxf files/intellij.tar.gz --no-same-owner -C /
tar -zxf files/nodejs.tar.gz --no-same-owner -C /

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

## systemd-timesyncd
sed -i 's/^#*NTP=.*/NTP=ntp.on.br/' /etc/systemd/timesyncd.conf

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

# Usuários do Postgre
sudo -u postgres createuser -d aluno1
sudo -u postgres createuser -d aluno2

echo "--- Pronto!"
