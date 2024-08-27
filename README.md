# Automated ArchLinux
This ansible playbook automates my personal Arch Linux installation.
The goal is a fully encrypted and secure desktop system.  All
dotfiles are kept in an independent repository. They are managed using
[chezmoi](https://www.chezmoi.io/) and
will only get installed if the `dotfiles` variable is defined.

## Main features of this installation
* Full disk encryption (optional)
* LVM on LUKS partitioning scheme (optional)
* KDE

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

## How to run the ansible playbook after the initial installtion
First install ansible

``` bash
$ sudo pacman -S ansible python-jmespath
```

Then install some pre-requisites from the AUR:
Either use your favorite aur helper, or install these by hand:
* ansible-gpg-key-git
* ansible-collection-kewlfft-aur
* ansible-collection-community-general

Then download the playbook and make sure you adjust the values of the global
config in `group_vars/all.yaml` to match your system stats. Then run it.

n.b., the -K flag in the ansible-playbook command line tells ansible to prompt
for the become (that is, sudo) password.

``` bash
$ git clone -j8 https://github.com/amatos/ansible-archlinux.git
$ cd ansible-archlinux/ansible
$ ansible-playbook -i inventory/localhost playbook.yaml [--tags $LIMIT_TO_TAG] -K
```

Lean back and watch the installation.
