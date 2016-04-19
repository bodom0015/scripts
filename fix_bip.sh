#!/bin/sh

# Override default docker bridge IP
if [[ "$1" == "" ]]; then
	echo "Resetting .service override"
	sudo rm -f /etc/systemd/system/docker.service
else
	echo "Setting BIP to $1"
	echo "[Service]
	ExecStart=
	ExecStart=/usr/lib/coreos/dockerd daemon --host=fd:// --bip=$1" > /etc/systemd/system/docker.service
fi

# Reload Docker Daemon
sudo systemctl stop docker
sudo systemctl daemon-reload

# Remove stale bridge IP
sudo ip link set docker0 down
sudo brctl delbr docker0

# Restart Docker
sudo systemctl start docker
