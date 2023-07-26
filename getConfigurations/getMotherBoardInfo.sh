#! /bin/bash
#source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> getMotherBoardInfo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo;
dmidecode -t 3 | grep "Manufacturer:";
echo "All EEPROMS";
echo "null"; #TBD
#ipmitool fru;
echo;
echo "Any USB conections: "; 
lsusb -t;
echo;
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< getMotherBoardInfo <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
echo;
echo;
