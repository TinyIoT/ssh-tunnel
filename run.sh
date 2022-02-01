#!/bin/bash -e

# Load public keys from environment variables
for key in "${!PUBLIC_KEY_@}"; do
    echo "Writing value of $key to $AUTHORIZED_KEYS"
    echo ${!key} >> $AUTHORIZED_KEYS
done

# Run sshd
# -d run in attached mode
# -e log everything to stderr
exec /usr/sbin/sshd -D -e