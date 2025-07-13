#!/bin/bash

# Liste der Benutzer mit Passwörtern (plain Text, anpassen!)
benutzerListe=(
  "Benutzer1:Passwort1"
  "Benutzer2:Passwort2"
  "Benutzer3:Passwort3"
  "Benutzer4:Passwort4"
  "Benutzer5:Passwort5"
)

# Funktion zum Hinzufügen eines Benutzers
add_user() {
  local name=$1
  local pass=$2

  # Prüfen, ob der Benutzer bereits existiert
  if id "$name" &>/dev/null; then
    echo "Benutzer '$name' existiert bereits."
  else
    # Benutzer erstellen ohne Home-Verzeichnis (optional: -m für homedir erstellen)
    sudo useradd -m "$name"
    if [ $? -eq 0 ]; then
      echo "Benutzer '$name' wurde erstellt."
      # Passwort setzen
      echo "$name:$pass" | sudo chpasswd
      echo "Passwort für '$name' gesetzt."
    else
      echo "Fehler beim Erstellen von '$name'."
    fi
  fi
}

# Loop durch die Benutzerliste
for benutzer in "${benutzerListe[@]}"; do
  IFS=":" read -r name pass <<< "$benutzer"
  add_user "$name" "$pass"
done