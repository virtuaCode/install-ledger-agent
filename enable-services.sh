#!/bin/bash

echo "Activating ledger agent services"

systemctl --user start ledger-gpg-agent.service ledger-gpg-agent.socket && \
systemctl --user enable ledger-gpg-agent.socket

systemctl --user start ledger-ssh-agent.service ledger-ssh-agent.socket && \
systemctl --user enable ledger-gpg-agent.socket
