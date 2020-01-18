#!/bin/bash
LEDGER_BIN=$(which ledger-agent)
LEDGER_HOST="${1}"
LEDGER_PORT="${2:-22}"
LEDGER_CONF="${HOME}/.ssh/ledger.conf"

if [ -z "${LEDGER_HOST}" ]; then
  echo "Usage: ${0} user@host [port]"
  echo exiting
  exit 1
fi

echo "Generating the public key, please confirm on the Nano S..."
key=$(ledger-agent ${LEDGER_HOST})
echo "${key}" | cut -f 3 -d ' ' >> ${LEDGER_CONF}
echo "Adding ${LEDGER_HOST} to your ssh config"
ssh_host=$(echo ${LEDGER_HOST} | cut -f 2 -d '@')
ssh_user=$(echo ${LEDGER_HOST} | cut -f 1 -d '@')

echo "
    Host ${ssh_host}
    HostName ${ssh_host}
    Port ${LEDGER_PORT}
    User ${ssh_user}
    PreferredAuthentications publickey" >> ${HOME}/.ssh/config
echo ""
echo "Public Key for ${LEDGER_HOST}"
echo "${key}"
echo ""
${LEDGER_BIN} ${LEDGER_CONF} -v -s
exit 0