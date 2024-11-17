#!/bin/env bash

echo "Ansible pre-flight"

echo "\n\n-------------------\n\n"
echo "Installing yay and powerpill"
echo "Cloning yay"
git clone https://aur.archlinux.org/yay /tmp/yay.git
pushd /tmp/yay.git
echo "Making and installing package"
makepkg -sir
popd

echo "Installing powerpill"
yay -S powerpill

echo "\n\n-------------------\n\n"
echo "Installing SF nerd font mono"
yay -S nerd-fonts-sf-mono

echo "\n\n-------------------\n\n"
echo "Setting chrooted to false"
sed -i 's/chrooted: true/chrooted: false/g' group_vars/all.yaml

echo "Setting install type to desktop"
sed -i 's/  type: ""/  type: "desktop"/g' group_vars/all.yaml

echo "Edit group_vars/all.yaml to update your desktop preferences, then run:"
echo "ansible-playbook -i inventory/localhost -K playbook.yaml"
