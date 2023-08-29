#! /bin/bash
#source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo "                                  getBMCVersion";
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
bmc="192.168.2.11"
curl -u root:0penBmc -k -s  http://${bmc}/redfish/v1/Managers/bmc | grep FirmwareVer;
#echo "curl -s --insecure "https://169.254.95.118:443/redfish/v1/UpdateService/FirmwareInventory/47ce0879" --header "Authorization: Basic cm9vdDowcGVuQm1j" | grep Version";
#  "Version": "v0.10-00-kudo"
echo;
echo;
echo;