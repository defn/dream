#!/usr/bin/env bash -eux

set -eux

echo "==> Installing VMware Tools"

aptitude install -y linux-headers-$(uname -r) build-essential perl
aptitude install -y dkms

pth_vmware_iso="$(ls -d /home/*/linux.iso 2>/dev/null || true)"
if [[ -f "$pth_vmware_iso" ]]; then
  cd "$(dirname "$pth_vmware_iso")"

  if [[ -f "linux.iso" ]]; then
    mount -o loop "$(pwd)/linux.iso" /mnt

    # install
    VMWARE_TOOLS_PATH=$(ls /mnt/VMwareTools-*.tar.gz)
    VMWARE_TOOLS_VERSION=$(echo "${VMWARE_TOOLS_PATH}" | cut -f2 -d'-')
    VMWARE_TOOLS_BUILD=$(echo "${VMWARE_TOOLS_PATH}" | cut -f3 -d'-')
    VMWARE_TOOLS_BUILD=$(basename ${VMWARE_TOOLS_BUILD} .tar.gz)
    echo "==> VMware Tools Path: ${VMWARE_TOOLS_PATH}"
    echo "==> VMWare Tools Version: ${VMWARE_TOOLS_VERSION}"
    echo "==> VMware Tools Build: ${VMWARE_TOOLS_BUILD}" 

    tar zxf "$VMWARE_TOOLS_PATH" -C /tmp/
    VMWARE_TOOLS_MAJOR_VERSION=$(echo ${VMWARE_TOOLS_VERSION} | cut -d '.' -f 1)
    if [ "${VMWARE_TOOLS_MAJOR_VERSION}" -lt "10" ]; then
        /tmp/vmware-tools-distrib/vmware-install.pl -d
    else
        /tmp/vmware-tools-distrib/vmware-install.pl -f
    fi

    VMWARE_TOOLBOX_CMD_VERSION=$(vmware-toolbox-cmd -v)
    echo "==> Installed VMware Tools ${VMWARE_TOOLBOX_CMD_VERSION}" 

    umount /mnt
  fi

  rm -f linux.iso
fi
