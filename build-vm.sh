#!/usr/bin/bash

set -oeux pipefail

readonly MEMORY_SIZE="$((2 * 1024))"
readonly DISK_SIZE="8"
readonly FEDORA_RELEASE="37"
readonly CPU_CORE_COUNT="2"

readonly FEDORA_NAME="fedora${FEDORA_RELEASE}"
readonly VM_NAME="fedora-kmod"
readonly MIRROR="mirrors.mit.edu"
readonly URL="https://${MIRROR}/fedora/linux/development/rawhide/Everything/x86_64/os"

readonly VM_DISK="/var/lib/libvirt/images/${VM_NAME}.qcow2"
readonly KICKSTART_FILE="fedora.ks"
readonly LOADER="OVMF_VARS.secboot.fd"

readonly PASSWORD="$(cat .vmpasswd)"

readonly RUSTC_VERSION="$(./linux-rust/scripts/min-tool-version.sh rustc)"
readonly BINDGEN_VERSION="$(./linux-rust/scripts/min-tool-version.sh bindgen)"

sed "s@<PASSWORD>@${PASSWORD}@g; s@<RUSTC_VERSION>@${RUSTC_VERSION}@g; s@<BINDGEN_VERSION>@${BINDGEN_VERSION}@g" "${KICKSTART_FILE}" > "/tmp/${KICKSTART_FILE}"

virsh destroy --domain "${VM_NAME}" ||:
virsh undefine --domain "${VM_NAME}" --nvram ||:

rm -f "${VM_DISK}"
cp "/usr/share/edk2/ovmf/${LOADER}" "/var/lib/libvirt/qemu/nvram/${LOADER}"

virt-install --name "${VM_NAME}" \
             --memory "${MEMORY_SIZE}" \
	     --vcpus "${CPU_CORE_COUNT}" \
             --os-variant "${FEDORA_NAME}" \
             --boot hd,cdrom,loader=/usr/share/edk2/ovmf/OVMF_CODE.secboot.fd,loader_ro=yes,loader_type=pflash,nvram="/var/lib/libvirt/qemu/nvram/${LOADER}" \
	     --disk path="${VM_DISK}",size="${DISK_SIZE}",format=qcow2 \
	     --location "${URL}" \
             --initrd-inject="/tmp/${KICKSTART_FILE}" \
             --extra-args="inst.ks=file:/$KICKSTART_FILE"
