#! /bin/bash
#source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo "                                  getBMCVersion";
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
bmc=ifconfig | grep bmc -A 1 | grep inet | awk -F ' ' '{print $2}' | awk -F ':' '{print $2}'
if [ -n $bmc ];then
    curl -u root:0penBmc -k -s  http://${bmc}/redfish/v1/Managers/bmc | grep FirmwareVer;
else
    echo Please check bmc inet IP setting on your host!!!
fi
#echo "curl -s --insecure "https://169.254.95.118:443/redfish/v1/UpdateService/FirmwareInventory/47ce0879" --header "Authorization: Basic cm9vdDowcGVuQm1j" | grep Version";
#  "Version": "v0.10-00-kudo"
echo;
echo;
echo;