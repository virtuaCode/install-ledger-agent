#!/bin/bash

echo 'Installing Dependencies'

sudo apt install python3-pip python3-dev python3-tk libusb-1.0-0-dev libudev-dev

echo 'Installing ledger-agent'

pip3 install --user ledger_agent

if [ ! -d $HOME/.config/systemd/user ]; then
    echo "Creating ${HOME}/.config/systemd/user directory"
    mkdir -p $HOME/.config/systemd/user
fi

echo "Initialize services"

cat ledger-gpg-agent.service | envsubst > $HOME/.config/systemd/user/ledger-gpg-agent.service \
&& cat ledger-gpg-agent.socket | envsubst > $HOME/.config/systemd/user/ledger-gpg-agent.socket \
&& cat ledger-ssh-agent.service | envsubst > $HOME/.config/systemd/user/ledger-ssh-agent.service \
&& cat ledger-ssh-agent.socket | envsubst > $HOME/.config/systemd/user/ledger-ssh-agent.socket

echo "Enable linger for user $USER"

loginctl enable-linger $USER

echo "Add 'key' function to .bashrc"

echo -e "\n" >> $HOME/.bashrc
echo 'key () { SSH_AUTH_SOCK=$(systemctl show --user --property=Listen ledger-ssh-agent.socket | grep -o "/run.*" | cut -d " " -f 1) GNUPGHOME=~/.gnupg/ledger/ $@ ; }' >> $HOME/.bashrc

echo "Linking executable ledger-add.sh"
ln -s "$(pwd)/ledger-add.sh" "$HOME/.local/bin/ledger-add"