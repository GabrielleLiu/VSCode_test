#! /bin/bash

固定IP
停止的機制?
/etc/systemd/system/rc-local.service

systemctl daemon-reload
cp rc.local /etc/ # AC
sudo chmod +x /etc/rc.local
sudo systemctl stop rc-local.service
systemctl daemon-reload
sudo systemctl enable rc-local
timeout 10 systemctl start rc-local.service

