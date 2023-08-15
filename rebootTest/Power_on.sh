#!/bin/bash
#notes:
#    DC_cycle_clean_power_on_verification_for_reboot 
#
#Include Charles Debug Message Patch(issue199924390)

cd /
sleep 70;

ipmitool chassis power status | awk '{print $4}' >  current_power.txt
base=`cat off.txt`
current=`cat current_power.txt`

if [ ! -f /count.txt ]; then
	echo 0 > /count.txt
fi

COUNTER=`cat /count.txt`

	if [ $base  = $current ] ; then
		COUNTER=$(($COUNTER+1))
    	echo "$COUNTER" > count.txt
		echo ------------------------------------------ >> /tmp/power_cycle_log.txt
		echo "Reboot Combination (DC Clean) : $COUNTER" >> /tmp/power_cycle_log.txt
		echo " " >> /tmp/power_cycle_log.txt
		date >> /tmp/power_cycle_log.txt
		echo `ipmitool power status` >> /tmp/power_cycle_log.txt
        ipmitool chassis power on
		echo "Executed Ipmitool chassis power on Command !!!" > /tmp/Executed_Poweron.log
		date >> /tmp/power_cycle_log.txt
		sleep 10
		echo `ipmitool power status` >> /tmp/power_cycle_log.txt
		rm current_power.txt
	else			
		echo "Chassis power is already on.. !!!"        > /already_on.log
        fi

exit 0

