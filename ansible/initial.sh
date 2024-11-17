#!/bin/env bash

echo "Ansible pre-flight"

echo "\n\n-------------------\n\n"
echo "Setting chrooted to true (just in case)"
sed -i 's/chrooted: false/chrooted: true/g' group_vars/all.yaml

echo "Setting install type to empty (again, just in case)"
sed -i 's/  type: "desktop"/  type: ""/g' group_vars/all.yaml

echo "Edit group_vars/all.yaml to update your preferences, then run:"
echo "ansible-playbook -i inventory/localhost -K playbook.yaml"
