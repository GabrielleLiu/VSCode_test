#! /bin/bash
#source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo "                                  getBMCVersion";
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
echo "curl -s --insecure "https://169.254.95.118:443/redfish/v1/UpdateService/FirmwareInventory/47ce0879" --header "Authorization: Basic cm9vdDowcGVuQm1j" | grep Version";
#  "Version": "v0.10-00-kudo"
echo;
echo;
echo;