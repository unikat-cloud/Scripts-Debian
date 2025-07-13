#!/bin/bash

# Platzhalter für den Drucker-PCC
# Beispiel: smb://Benutzer:Passwort@Server/Share
drucker_url="<Drucker_URL>"  # z.B. smb://user:pass@server/share

# Optional: Name des Druckers im System
drucker_name="<Benutzerdefinierter_Druckername>"  # z.B. "BüroDrucker"

# Funktion zum Verbinden des Netzwerkdruckers
verbinde_drucker() {
    local url="$1"
    local name="$2"

    # Prüfen, ob der Drucker bereits installiert ist
    if lpstat -v | grep -q "$name"; then
        echo "Der Drucker '$name' ist bereits installiert."
    else
        # Drucker hinzufügen
        sudo lpadmin -p "$name" -E -v "$url" -m "everywhere"
        if [ $? -eq 0 ]; then
            echo "Drucker '$name' wurde erfolgreich hinzugefügt."
        else
            echo "Fehler beim Hinzufügen des Druckers."
        fi
    fi
}

# Beispiel: Platzhalter setzen
# drucker_url="smb://benutzer:passwort@server/share"
# drucker_name="MeinNetzDrucker"

# Funktion aufrufen
verbinde_drucker "$drucker_url" "$drucker_name"