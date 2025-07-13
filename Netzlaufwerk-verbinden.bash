#!/bin/bash

# Platzhalter für den Mount-Punkt (lokales Verzeichnis)
MOUNT_POINT="/mnt/netzlaufwerk" # Ersetze durch dein gewünschtes Verzeichnis

# Platzhalter für den Netzwerkpfad (z.B. //Server/Share)
NETWORK_PATH="//Server/Share" # Ersetze durch den tatsächlichen Netzwerkpfad

# Platzhalter für den Benutzernamen und das Passwort
USERNAME="BENUTZERNAME"  # z.B. "user"
PASSWORD="PASSWORT"      # z.B. "mypassword"

# Definitiv sicherstellen, dass das Mount-Verzeichnis existiert
if [ ! -d "$MOUNT_POINT" ]; then
    echo "Erstelle das Mount-Verzeichnis: $MOUNT_POINT"
    mkdir -p "$MOUNT_POINT"
fi

# Warnung und Bestätigung
echo "WARNUNG: Das Skript wird ein Netzlaufwerk mounten."
echo "Folgende Risiken bestehen:"
echo "- Unbefugter Zugriff: Passwörter könnten abgefangen werden."
echo "- Versehentliche Weitergabe: Das Skript könnte versehentlich an Dritte gelangen."
read -p "Möchten Sie fortfahren? (J/N): " CONFIRMATION

if [[ "$CONFIRMATION" != [Jj] ]]; then
    echo "Skriptabbruch durch Benutzer."
    exit 1
fi

# Optional: Vorherige Mounts entfernen
if mountpoint -q "$MOUNT_POINT"; then
    echo "Entferne vorherigen Mountpoint..."
    umount "$MOUNT_POINT"
fi

# Mounten mit credentials
# Für Samba/CIFS benötigst du das cifs-utils-Paket
# Stelle sicher, dass es installiert ist:
# sudo apt-get install cifs-utils

# Mount-Optionen mit Anmeldedaten
CIFS_OPTIONS="rw,username=$USERNAME,password=$PASSWORD"

# Mounten
echo "Versuche, das Netzlaufwerk zu mounten..."
sudo mount -t cifs "$NETWORK_PATH" "$MOUNT_POINT" -o "$CIFS_OPTIONS"

if [ $? -eq 0 ]; then
    echo "Netzlaufwerk erfolgreich gemountet unter $MOUNT_POINT"
else
    echo "Fehler beim Mounten des Netzlaufwerks."
fi