#!/bin/bash

# generate xrdp key
if [ ! -f "/etc/xrdp/rsakeys.ini" ];
	then
		xrdp-keygen xrdp auto
fi

# generate machine-id
uuidgen > /etc/machine-id

exec "$@"