# Automated ArchLinux
This ansible playbook automates my personal Arch Linux installation.
The goal is a fully encrypted and secure desktop system.  All
dotfiles are kept in an independent repository. They are managed using
[chezmoi](https://www.chezmoi.io/) and
will only get installed if the `dotfiles` variable is defined.

## Main features of this installation
* Full disk encryption (optional)
* LVM on LUKS partitioning scheme (optional)

## Additional security features
* Restrictive and comprehensive firewalld rules
* Automatic mac address spoofer for wireless network devices (optional)
* Some bullshit installed, but only the bullshit I use.

## Install base system
You can either install your own minimal system or you follow the instructions
provided in the two installation guides below.

* [INSTALL\_EFI](/doc/INSTALL_EFI.md)
to setup a LVM on LUKS system using grub2 in GPT EFI boot mode.
* [INSTALL\_BIOS](/doc/INSTALL_BIOS.md)
to setup a LVM on LUKS system using syslinux in MBR BIOS boot mode.

The Ansible playbook does not depend on any specific installation method.
If you are unsure which BIOS mode to chose, go for UEFI as this is how it's
done on modern systems.

## Running from arch-chroot
The minimal installation is safe to run from arch-chroot as the root user, as it
doesn't do anything that is too unsafe for root, but, after rebooting, log in as
your normal user, and update the configuration file to include your preferred
DE and other bullshit.

## How to run the ansible playbook after the initial installtion
First install ansible

``` bash
$ sudo pacman -S ansible python-jmespath
```

Then download the playbook and make sure you adjust the values of the global
config in `group_vars/all.yaml` to match your system stats. Then run it.

n.b., the -K flag in the ansible-playbook command line tells ansible to prompt
for the become (that is, sudo) password.

``` bash
git clone -j8 https://github.com/amatos/ansible-archlinux.git
cd ansible-archlinux/ansible
ansible-playbook -i inventory/localhost playbook.yaml -K [--tags $LIMIT_TO_TAG] 
```

Lean back and watch the base installation.

Once you have rebooted the system and are logged in as your normal user, update the configuration
file to include more than the minimal installation.  You'll need to deploy yay and the ansible-galaxy aur helper

Deploy yay:
``` bash
git clone https://aur.archlinux.org/yay
cd yay.git
makepkg -sir
```

Deploy ansible collection:
``` bash
ansible-galaxy collection add kewlfft.aur
```

And re-run the playbook (AFTER changing the config file)
``` bash
cd ansible-archlinux/ansible
ansible-playbook -i inventory/localhost playbook.yaml -K [--tags $LIMIT_TO_TAG] 
```
