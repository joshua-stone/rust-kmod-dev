#!/usr/bin/bash

set -oeux pipefail

readonly VM_NAME="fedora-kmod"
readonly PASSWORD="$(cat .vmpasswd)"

IP_ADDRESS="$(virsh domifaddr fedora-kmod | grep vnet | awk '{ print $4 }' | cut -d '/' -f1)"

sshpass -p "${PASSWORD}" ssh -o "StrictHostKeyChecking no" "root@${IP_ADDRESS}"
