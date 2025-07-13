#!/bin/bash

# Aktualisiere die Paketlisten
sudo apt update -qq

# Prüfe, ob Updates vorhanden sind
UPGRADES=$(apt list --upgradable 2>/dev/null | grep -v "Listing" | wc -l)

if [ "$UPGRADES" -gt 0 ]; then
    echo "Es sind $UPGRADES Updates verfügbar."
    # Optional: automatische Aktualisierung
    sudo apt upgrade -y
else
    echo "Keine Updates verfügbar."
fi