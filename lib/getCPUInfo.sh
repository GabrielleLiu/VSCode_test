#! /bin/bash
source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>CPUs>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo;
dmidecode -t processor;
echo;
echo;
echo -n "Socket enabled under /proc/cpuinfo: ";
cat /proc/cpuinfo| grep processor | wc -l;
echo;
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<CPUs<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
