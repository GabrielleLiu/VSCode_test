#! /bin/bash
#source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> getNICInfo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo;
echo -n "NIC total count: ";
NIC=`ifconfig | grep Ethernet | awk '{print$1}' | egrep 'et|en|eth'`;
echo "${#NIC[*]}"; # count the number of ethernet
for Eth in ${NIC}; do
	NICBDF=`ethtool -i ${Eth} | grep bus-info | awk '{print$2}'`
	for DEVICE in ${NICBDF}; do
		echo `lspci -s $DEVICE` 
		echo `lspci -s $DEVICE -vvv | grep "LnkSta:"`
	done
done
echo;
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< getNICInfo <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
echo;
echo;
