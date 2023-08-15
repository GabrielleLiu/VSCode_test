#!/bin/sh
# Setup_OVSS_rc.local
# Edit Date=20230815

cat /dev/null > /var/log/messages
dmesg -C
#ipmitool sel clear
gsys eventlog clear

ifconfig usb0 10.0.1.70 netmask 255.255.255.0

dos2unix reboot_configcheck.sh
dos2unix Total_TestCountProgressBar.sh
dos2unix Check_dmesg.sh
dos2unix rc.local

chmod 777 *

sshpass -p 0penBmc scp Power_on.sh off.txt root@10.0.1.69:/

cp reboot_configcheck.sh /
cp Total_TestCountProgressBar.sh /
cp ampereone_bmc_sel.plx /
cp Check_dmesg.sh /

cd /

./reboot_configcheck.sh > Configcheck_Baseline.txt

cd DC_Clean/

echo [Unit] > /etc/systemd/system/rc-local.service
echo Description=/etc/rc.local Compatibility  >> /etc/systemd/system/rc-local.service
echo ConditionPathExists=/etc/rc.local >> /etc/systemd/system/rc-local.service

echo  >> /etc/systemd/system/rc-local.service

echo [Service] >> /etc/systemd/system/rc-local.service
echo Type=forking >> /etc/systemd/system/rc-local.service
echo ExecStart=/etc/rc.local start >> /etc/systemd/system/rc-local.service
echo TimeoutSec=0 >> /etc/systemd/system/rc-local.service
echo StandardOutput=tty >> /etc/systemd/system/rc-local.service
echo RemainAfterExit=yes >> /etc/systemd/system/rc-local.service
echo SysVStartPriority=99 >> /etc/systemd/system/rc-local.service

echo  >> /etc/systemd/system/rc-local.service
echo [Install] >> /etc/systemd/system/rc-local.service
echo WantedBy=multi-user.target >> /etc/systemd/system/rc-local.service

systemctl daemon-reload

cp rc.local /etc/
sudo chmod +x /etc/rc.local
sudo systemctl stop rc-local.service
systemctl daemon-reload
sudo systemctl enable rc-local
timeout 10 systemctl start rc-local.service

