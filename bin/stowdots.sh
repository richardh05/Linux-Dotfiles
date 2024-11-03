#! usr/bin/bash
pacman -Qeq > ~/dots/home/packages.txt
stow -d ~/dots/home -t ~/ .
cd ~/dots/home
