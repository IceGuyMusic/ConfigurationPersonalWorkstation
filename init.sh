#!/bin/bash

# Funktion, um Fehler zu melden
report_error() {
  curl -H "ta:skull" -d "Job is stopped. Maybe an error" http://172-104-242-141.ip.linodeusercontent.com/computer_logs
  exit 1
}

# Trap, um Fehler während der Ausführung des Skripts zu fangen
trap 'report_error' ERR

# 1. Update und Upgrade
sudo apt-get update && sudo apt-get upgrade -y

# 2. Alias in .bashrc einfügen
echo "alias home='cd ~'" >> ~/.bashrc
echo "alias remember_me='curl -H \"ta:tada\" -d \"Job is finished\" http://172-104-242-141.ip.linodeusercontent.com/computer_logs'" >> ~/.bashrc
echo "alias remember_me_fail='curl -H \"ta:skull\" -d \"Job is stopped. Maybe an error\" http://172-104-242-141.ip.linodeusercontent.com/computer_logs'" >> ~/.bashrc

# Neu laden von .bashrc, damit Alias sofort verfügbar ist
source ~/.bashrc

# 3. nvim (neovim) installieren
sudo apt-get install neovim -y

mv generate.vim $XDG_CONFIG_HOME/nvim/init.vim

# 4. docker.io installieren
sudo apt-get install docker.io -y

# 5. Wieder Update und Upgrade
sudo apt-get update && sudo apt-get upgrade -y

# 6. K3s installieren
curl -sfL https://get.k3s.io | sh -

# 7. Reboot
sudo reboot

# Wenn das Skript bis hierhin keine Fehler hatte, wird Erfolg gemeldet
curl -H "ta:tada" -d "Job is finished" http://172-104-242-141.ip.linodeusercontent.com/computer_logs"
