#!/bin/sh

echo "--- Configurando seats..."

loginctl attach seat0 /sys/devices/pci0000:00/0000:00:1a.0/usb1
loginctl attach seat1 /sys/devices/pci0000:00/0000:00:1d.0/usb2

echo "--- Reinicie."
