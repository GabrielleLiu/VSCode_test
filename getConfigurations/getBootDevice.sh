#! /bin/bash
#source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo "                                  getBootDevice";
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
echo -n "Pysical disk total count: ";
Drivesss=`lsblk -l | grep disk | awk '{print$1}'`;
echo "${#Drivesss[*]}"; # count the number of harddrive
for Dth in ${Drivesss}; do
    echo ${Dth};
	smartctl -i /dev/${Dth} | grep current;
    smartctl --all /dev/${Dth} | grep Size;
    smartctl --all /dev/${Dth} | grep Serial;
    smartctl --all /dev/${Dth} | grep "Firmware Version";
    smartctl -x /dev/${Dth} | egrep "(Raw_Read_Error)|(UDMA_CRC_Error_Count)|(ATTRIBUTE_NAME)";
    echo;
done
echo;
echo;
echo;
