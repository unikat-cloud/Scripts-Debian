#!/bin/bash

# DNS-Cache bei systemd-resolved neu starten
sudo systemctl restart systemd-resolved

echo "DNS-Cache wurde bei systemd-resolved neu gestartet."
