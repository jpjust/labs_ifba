#!/bin/sh -e

apt update
apt install -y lightdm
apt remove -y gdm3

sed -i 's/^#*background=.*/background=/usr/share/wallpapers/ifba_feira.jpg/' /etc/lightdm/lightdm-gtk-greeter.conf
