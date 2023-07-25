#! /bin/bash
#source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> getCPUInfo >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo;
dmidecode -t processor;
echo;
echo "---";
echo -n "Socket enabled in /proc/cpuinfo: ";
cat /proc/cpuinfo| grep processor | wc -l;
echo;
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< getCPUInfo <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
echo;
echo;
