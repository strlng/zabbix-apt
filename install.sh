#!/bin/bash

sh -c "curl -fsSL https://github.com/strlng/zabbix-apt/archive/master.zip -o zabbix-apt.zip"

sh -c "cp -r zabbix-apt/apt.conf.d/02periodic /etc/apt/apt.conf.d/"

sh -c "cp zabbix-apt/zabbix_agentd.d/apt.conf /etc/zabbix/zabbix_agentd.d/"

sh -c "systemctl restart zabbix-agent.service"

sh -c "rm -r zabbix-apt"
