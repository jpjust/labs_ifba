#!/bin/sh

echo "--- Configurando seats..."

loginctl attach seat0 /sys/devices/pci0000\:00/0000\:00\:14.0/usb1/1-2/
loginctl attach seat0 /sys/devices/pci0000\:00/0000\:00\:14.0/usb1/1-8/
loginctl attach seat0 /sys/devices/pci0000\:00/0000\:00\:14.0/usb1/1-9/
loginctl attach seat0 /sys/devices/pci0000\:00/0000\:00\:14.0/usb1/1-12/

loginctl attach seat1 /sys/devices/pci0000\:00/0000\:00\:14.0/usb1/1-1/
loginctl attach seat1 /sys/devices/pci0000\:00/0000\:00\:14.0/usb1/1-4/
loginctl attach seat1 /sys/devices/pci0000\:00/0000\:00\:14.0/usb1/1-10/
loginctl attach seat1 /sys/devices/pci0000\:00/0000\:00\:14.0/usb1/1-13/

echo "--- Feito!"
