# install-ledger-agent

Simple Bash script for installing the Hardware-based SSH/GPG agent [trezor-agent](https://github.com/romanz/trezor-agent) on my linux devices.

# Installation

Run `./install.sh` then reboot your system.

Next run `./enable-services.sh`.

# SSH Usage

Connect your Ledger Nano S / X and open the SSH/GPG Agent App

Now your can add new ssh identities with `ledger-add user@host [port]` e.g. `ledger-add git@github.com`

To connect to a remote server prefix your `ssh` command with the `key` command e.g. `key ssh git@github.com`

# GPG Usage

TODO
