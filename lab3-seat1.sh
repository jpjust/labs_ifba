#!/bin/sh -e

echo "--- Instalando o LightDM..."
apt update
apt install -y lightdm
apt remove -y gdm3

sed -i 's/^#*background=.*/background=\/usr\/share\/wallpapers\/ifba_feira.jpg/' /etc/lightdm/lightdm-gtk-greeter.conf

echo "--- Configurando o monitor do seat1..."
loginctl flush-devices
#loginctl attach seat1 /sys/devices/pci0000\:00/0000\:00\:01.0/0000\:01\:00.0/drm/card0

echo "--- Reinicie."
