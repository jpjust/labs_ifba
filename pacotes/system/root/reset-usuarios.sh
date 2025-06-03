#!/bin/sh

echo "--- Configurando os usuários..."

if ! getent passwd "aluno1" > /dev/null; then
  useradd -m -c "Aluno 1" -s /bin/bash aluno1
  echo "aluno1:aluno" | chpasswd
fi
if ! getent passwd "aluno2" > /dev/null; then
  useradd -m -c "Aluno 2" -s /bin/bash aluno2
  echo "aluno2:aluno" | chpasswd
fi

rm -rf /home/aluno*
tar -zxf /root/files/usuarios.tar.gz --no-same-owner -C /
cp -r /etc/skel/. /home/aluno1/
cp -r /etc/skel/. /home/aluno2/

# Android SDK
echo "export ANDROID_HOME=\"/home/aluno1/Android/Sdk\"" >> /home/aluno1/.profile
echo "export ANDROID_HOME=\"/home/aluno2/Android/Sdk\"" >> /home/aluno2/.profile
echo "export PATH=\"\$ANDROID_HOME/cmdline-tools/latest/bin:\$ANDROID_HOME/platform-tools:\$PATH\"" >> /home/aluno2/.profile
echo "export PATH=\"\$ANDROID_HOME/cmdline-tools/latest/bin:\$ANDROID_HOME/platform-tools:\$PATH\"" >> /home/aluno2/.profile

chown -R aluno1: /home/aluno1
chown -R aluno2: /home/aluno2

groupadd -f autologin
for grupo in "audio" "autologin" "bluetooth" "cdrom" "dialout" "dip" "disk" "floppy" "kvm" "libvirt" "libvirt-qemu" "lpadmin" "netdev" "plugdev" "scanner" "tcpdump" "vboxusers" "video" "wireshark"
do
  if getent group $grupo > /dev/null; then
    usermod -aG $grupo aluno1
    usermod -aG $grupo aluno2
  else
    echo "--- Grupo $grupo não existe."
  fi
done
