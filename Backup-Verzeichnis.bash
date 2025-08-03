#!/bin/bash

# Definiere den Quellpfad (den Ordner, den du kopieren möchtest)
QUELLE="/pfad/zu/deinem/datenordner"

# Definiere den Zielpfad (wo die Daten kopiert werden sollen)
ZIEL="/pfad/zum/zielordner"

# Überprüfe, ob der Quellordner existiert
if [ ! -d "$QUELLE" ]; then
  echo "Der Quellordner existiert nicht: $QUELLE"
  exit 1
fi

# Überprüfe, ob der Zielordner existiert; falls nicht, erstelle ihn
if [ ! -d "$ZIEL" ]; then
  echo "Der Zielordner existiert nicht. Er wird jetzt erstellt: $ZIEL"
  mkdir -p "$ZIEL"
fi

# Kopiere die Daten rekursiv
rsync -av --progress "$QUELLE/" "$ZIEL/"

if [ $? -eq 0 ]; then
  echo "Daten wurden erfolgreich kopiert."
else
  echo "Beim Kopieren ist ein Fehler aufgetreten."
fi