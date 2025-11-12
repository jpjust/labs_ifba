#!/bin/sh

echo "--- Configurando os usuários..."

if getent passwd "aluno1" > /dev/null; then
  echo "aluno1:aluno" | chpasswd
fi
if getent passwd "aluno2" > /dev/null; then
  echo "aluno2:aluno" | chpasswd
fi

rm -rf /home/aluno*
tar -zxf /root/files/usuarios.tar.gz --no-same-owner -C /
cp -r /etc/skel/. /home/aluno1/
if getent passwd "aluno2" > /dev/null; then
  cp -r /etc/skel/. /home/aluno2/
fi

chown -R aluno1: /home/aluno1
if getent passwd "aluno2" > /dev/null; then
  chown -R aluno2: /home/aluno2
fi

groupadd -f autologin
for grupo in "audio" "autologin" "bluetooth" "cdrom" "dialout" "dip" "disk" "floppy" "kvm" "libvirt" "libvirt-qemu" "lpadmin" "netdev" "plugdev" "scanner" "tcpdump" "vboxusers" "video" "wireshark"
do
  if getent group $grupo > /dev/null; then
    usermod -aG $grupo aluno1
    if getent passwd "aluno2" > /dev/null; then
      usermod -aG $grupo aluno2
    fi
  else
    echo "--- Grupo $grupo não existe."
  fi
done
