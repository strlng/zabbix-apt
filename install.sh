#!/bin/bash

command_exists() {
  command -v "$@" > /dev/null 2>&1
}

sh_c='sh -c'
if [ "$user" != 'root' ]; then
  if command_exists sudo; then
    sh_c='sudo -E sh -c'
  else
    if command_exists su; then
      sh_c='su -c'
    else
      echo "Error: this installer needs the ability to run commands as root."
      echo "We are unable to find either 'sudo' or 'su' available to make this happen."
      exit 1
    fi
  fi
fi

$sh_c "curl -fsSL https://github.com/strlng/zabbix-apt/archive/master.zip -o zabbix-apt.zip"

$sh_c "unzip zabbix-apt.zip"
$sh_c "cp -r zabbix-apt-master/apt.conf.d/02periodic /etc/apt/apt.conf.d/"
$sh_c "cp zabbix-apt-master/zabbix_agentd.d/apt.conf /etc/zabbix/zabbix_agentd.d/"
$sh_c "systemctl restart zabbix-agent.service"

$sh_c "rm zabbix-apt.zip"
$sh_c "rm -r zabbix-apt-master"
