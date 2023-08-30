#!/bin/sh

# Setup rc-local.service
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


echo "#!/bin/bash" > /etc/rc.local
echo "echo test is starting ..." >> /etc/rc.local
echo "cd /" >> /etc/rc.local
echo "./VSCode_test/runTest/testBIOSUpgradeDowngrade.sh" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local


systemctl daemon-reload
#cp rc.local /etc/
sudo chmod +x /etc/rc.local
sudo systemctl stop rc-local.service
systemctl daemon-reload
sudo systemctl enable rc-local
timeout 10 systemctl start rc-local.service
