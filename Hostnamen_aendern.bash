#!/bin/bash

# Überprüfen, ob das Skript mit root-Rechten ausgeführt wird
if [ "$EUID" -ne 0 ]; then
  echo "Dieses Skript muss als root ausgeführt werden. Bitte mit sudo starten."
  exit 1
fi

# Aktuellen Hostname ermitteln
current_name=$(hostname)
echo "Der aktuelle Hostname ist: $current_name"

# Frage, ob der Name geändert werden soll
read -p "Möchtest du den Hostname ändern? (y/n): " change_decision

if [[ "$change_decision" =~ ^[Yy]$ ]]; then
  # Neue Namen abfragen
  read -p "Bitte gib den gewünschten neuen Hostname ein: " new_name

  if [ -z "$new_name" ]; then
    echo "Kein Hostname eingegeben. Abbruch."
    exit 1
  fi

  # Hostname dauerhaft ändern
  hostnamectl set-hostname "$new_name"

  # /etc/hostname aktualisieren
  echo "$new_name" > /etc/hostname

  # /etc/hosts anpassen
  sed -i "/127.0.0.1/ s/$/ $new_name/" /etc/hosts

  echo "Der Hostname wurde erfolgreich geändert in: $new_name"
else
  echo "Der Hostname bleibt unverändert."
fi