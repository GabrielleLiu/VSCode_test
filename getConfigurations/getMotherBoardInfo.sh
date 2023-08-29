#! /bin/bash
#source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo "                                  getMotherBoardInfo";
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
dmidecode -t 3 | grep "Manufacturer:";
echo "---All EEPROMS---";

bmc="192.168.2.11"
FRUSP=`curl -s --insecure "http://${bmc}/redfish/v1/Chassis" --header "Authorization: Basic cm9vdDowcGVuQm1j"` declare -a fru_chassis=(`echo $FRUSP | jq '.Members[]."@odata.id"'`)
for fru_id in "${fru_chassis[@]}"
do
    COL_ITEM_URL=`sed -e 's/^"//' -e 's/"$//' <<<"$fru_id"`
	curl -s --insecure "http://${bmc}${COL_ITEM_URL}" --header "Authorization: Basic cm9vdDowcGVuQm1j"| grep -A 4 'SerialNumber\|Manufacturer'
	echo
	echo "---"
done
#ipmitool fru;
echo;
echo "---Any USB conections---";
lsusb -t;
echo "(Empty is as expect. No USB IP support in Athena)";
echo;
echo;
