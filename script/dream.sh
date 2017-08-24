#!/usr/bin/env bash

function main {
  set -exfu

  if ! systemctl >/dev/null; then
    return 0
  fi

  if ! test -d /var/lib/cloud/instance/.; then
    return 0
  fi

  tail -f /var/log/cloud-init-output.log &

  set +x
	while true; do 
    case "$(systemctl is-active cloud-final.service)" in
      active|failed) 
          systemctl is-active cloud-final.service
          pkill tail
          wait
          reboot
          sleep 120
          exit 0
        ;;
    esac
    sleep 1
  done

  usermod -p '*' ubuntu
  usermod -p '*' root

  systemctl disable apt-daily.service
  systemctl disable apt-daily.timer

  # Make sure udev does not block our network - http://6.ptmc.org/?p=164
  echo "==> Cleaning up udev rules"
  rm -rf /dev/.udev/
  rm -f /lib/udev/rules.d/75-persistent-net-generator.rules

  echo "==> Cleaning up leftover dhcp leases"
  (set +f; rm -f /var/lib/dhcp/*)

  echo "==> Cleaning up tmp"
  (set +f; rm -rf /tmp/*)

  # Cleanup apt cache
  dpkg --configure -a
  apt-get -y autoremove --purge
  apt-get -y clean

  # Remove Bash history
  unset HISTFILE
  rm -f /root/.bash_history
  (set +f; rm -f /home/*/.bash_history)

  # Clean up log files
  set +x; find /var/log -type f | while read f; do echo -ne '' > $f; done; set -x

  echo "==> Clearing last login information"
  >/var/log/lastlog
  >/var/log/wtmp
  >/var/log/btmp

  # Make sure we wait until all the data is written to disk, otherwise
  # Packer might quite too early before the large files are deleted
  sync
}

main "$@"
