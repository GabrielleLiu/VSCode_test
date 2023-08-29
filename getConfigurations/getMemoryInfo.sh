#! /bin/bash
#source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo "                                  getMemoryInfo";
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
dmidecode -t memory
echo;
echo "---"
echo -n "DIMM total count: ";
dmidecode -t 17 | grep 'Logical Size' | grep 'GB' --count;
echo;
echo -n "DIMM total Size in /proc/meminfo(kb):";
cat /proc/meminfo | grep 'MemTotal:' | awk '{print $2}'
echo;
echo;
echo;
