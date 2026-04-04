#!/bin/sh
sudo nmcli con mod "Home" ipv4.dns "94.140.14.14 94.140.15.15" ipv4.ignore-auto-dns yes
sudo nmcli con up "Home"
