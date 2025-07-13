#!/bin/bash

# Zielpfad für die exportierte Hardware-Inventarliste
EXPORT_FILE="$HOME/Hardware_Inventar.txt"

# Leere Datei erstellen / überschreiben
> "$EXPORT_FILE"

# Systeminformationen sammeln
echo "=== Systeminformationen ===" >> "$EXPORT_FILE"
echo "Hostname: $(hostname)" >> "$EXPORT_FILE"
echo "Betriebssystem: $(lsb_release -d | cut -f2-)" >> "$EXPORT_FILE"
echo "Kernel-Version: $(uname -r)" >> "$EXPORT_FILE"
echo "" >> "$EXPORT_FILE"

# CPU
echo "=== CPU Informationen ===" >> "$EXPORT_FILE"
echo "Kerne: $(nproc)" >> "$EXPORT_FILE"
echo "Architektur: $(uname -m)" >> "$EXPORT_FILE"
echo "CPU Modell: $(lscpu | grep 'Model name' | head -1 | cut -d':' -f2-)" >> "$EXPORT_FILE"
echo "" >> "$EXPORT_FILE"

# Arbeitsspeicher
echo "=== Arbeitsspeicher (RAM) ===" >> "$EXPORT_FILE"
MemTotal=$(grep MemTotal /proc/meminfo | awk '{print $2 / 1024 " MB"}')
echo "Gesamtspeicher: $MemTotal" >> "$EXPORT_FILE"
echo "" >> "$EXPORT_FILE"

# Festplatten
echo "=== Festplatten ===" >> "$EXPORT_FILE"
lsblk -d -o NAME,TYPE,SIZE,MODEL | grep 'disk' >> "$EXPORT_FILE"
echo "" >> "$EXPORT_FILE"

# Netzwerkschnittstellen
echo "=== Netzwerkschnittstellen ===" >> "$EXPORT_FILE"
ip link show | awk -F: '$0 !~ "lo|vir|docker|br-|veth|wl-" {print $2}' >> "$EXPORT_FILE"
echo "" >> "$EXPORT_FILE"

# Graphics Card
echo "=== Grafikkarte ===" >> "$EXPORT_FILE"
lspci | grep -i --color 'vga\|3d\|2d' >> "$EXPORT_FILE"
echo "" >> "$EXPORT_FILE"

# Motherboard (falls möglich)
echo "=== Mainboard ===" >> "$EXPORT_FILE"
dmidecode -t baseboard 2>/dev/null | grep -E 'Manufacturer|Product Name|Serial Number' >> "$EXPORT_FILE"
echo "" >> "$EXPORT_FILE"

echo "Hardware-Inventar wurde erstellt: $EXPORT_FILE"
