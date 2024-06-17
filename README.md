# Automated ArchLinux
This ansible playbook automates my personal Arch Linux installation.
The goal is a fully encrypted and secure desktop system.  All
dotfiles are kept in an independent repository. They are managed using
[rcm](https://robots.thoughtbot.com/rcm-for-rc-files-in-dotfiles-repos) and
will only get installed if the `dotfiles` variable is defined.

## Main features of this installation
* Full disk encryption
* LVM on LUKS partitioning scheme
* A desktop environment consisting of i3gaps, i3status-rust, rofi and picom

## Additional security features
* Restrictive and comprehensive iptables rules
* Use of linux-hardened
* Automatic mac address spoofer for wireless network devices
* No bullshit installed

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

then download the playbook and make sure you adjust the values of the global
config in `group_vars/all` to match your system stats. Then run it.

``` bash
$ git clone --recurse-submodules -j8 https://github.com/id101010/ansible-archlinux.git
$ cd ansible-archlinux/ansible
$ ansible-playbook -i inventory/localhost playbook.yml [--tags $LIMIT_TO_TAG]
```

Lean back and watch the installation.

## Testing and development (local vagrant machine)
Warning, this is kind of buggy. Vagrant looks quite abandoned. Hashicorp does not react to issues.
I might remove this section soon.

Assuming you've already installed vagrant you can set up a vritual machine with
just these steps

``` bash
$ git clone --recurse-submodules -j8 https://github.com/id101010/ansible-archlinux.git
$ cd ansible-archlinux/vagrant
$ vagrant up --provision
```

Now reboot the machine and start a graphical session using virtualbox. The
default credentials are `user:vagrant pw:vagrant`.  Alternativly you can log
into your machine using the command `vagrant ssh`.

Hint: To reload the configuration into the vagrant box you can eighter reload
(issues a graceful shutdown) the machine using `vagrant reload` or you can
update and apply the configuration changes using `vagrant rsync && vagrant
provision`.  This way you don't need to wait for the machine to boot when
testing changes.
