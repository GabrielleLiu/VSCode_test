#!/bin/bash
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

function StartLogo () {
printf "\033[1;34m  ______ ______   _______ ____  _   _ _   _         _____  _____ _____\033[0m\n" 
printf "\033[1;34m |  ____/ __ \ \ / / ____/ __ \| \ | | \ | |       / ____|/ ____|_   _|\033[0m\n"
printf "\033[1;34m | |__ | |  | \ V / |   | |  | |  \| |  \| |______| |    | (___   | |\033[0m\n"  
printf "\033[1;34m |  __|| |  | |> <| |   | |  | | | | | | | |______| |     \___ \  | |\033[0m\n"  
printf "\033[1;34m | |   | |__| / . \ |___| |__| | |\  | |\  |      | |____ ____) |_| |_\033[0m\n" 
printf "\033[1;34m |_|    \____/_/ \_\_____\____/|_| \_|_| \_|       \_____|_____/|_____|\033[0m\n"
printf "\n"  
}

function PwrcycleLogo () {
printf "\033[1;34m _______          _______         _____           _ \033[0m\n"     
printf "\033[1;34m|  __ \ \        / /  __ \       / ____|         | | \033[0m\n"    
printf "\033[1;34m| |__) \ \  /\  / /| |__) |_____| |    _   _  ___| | ___ \033[0m\n"
printf "\033[1;34m|  ___/ \ \/  \/ / |  _  /______| |   | | | |/ __| |/ _ \\033[0m\n"
printf "\033[1;34m| |      \  /\  /  | | \ \      | |___| |_| | (__| |  __/\033[0m\n"
printf "\033[1;34m|_|       \/  \/   |_|  \_\      \_____\__, |\___|_|\___|\033[0m\n"
printf "\033[1;34m                                        __/ |\033[0m\n"            
printf "\033[1;34m                                       |___/\033[0m\n"
}

function ExitLogo () {
printf "\033[5;35m  ______     ________ _ \033[0m\n"
printf "\033[5;35m |  _ \ \   / /  ____| |\033[0m\n"
printf "\033[5;35m | |_) \ \_/ /| |__  | |\033[0m\n"
printf "\033[5;35m |  _ < \   / |  __| | |\033[0m\n"
printf "\033[5;35m | |_) | | |  | |____|_|\033[0m\n"
printf "\033[5;35m |____/  |_|  |______(_)\033[0m\n"
printf "\n"
}

function FinishLogo () {
printf "\033[1;34m _______        _     ______ _       _     _       _ _ _ \033[0m\n"
printf "\033[1;34m|__   __|      | |   |  ____(_)     (_)   | |     | | | |\033[0m\n"
printf "\033[1;34m   | | ___  ___| |_  | |__   _ _ __  _ ___| |__   | | | |\033[0m\n"
printf "\033[1;34m   | |/ _ \/ __| __| |  __| | | '_ \| / __| '_ \  | | | |\033[0m\n"
printf "\033[1;34m   | |  __/\__ \ |_  | |    | | | | | \__ \ | | | |_|_|_|\033[0m\n"
printf "\033[1;34m   |_|\___||___/\__| |_|    |_|_| |_|_|___/_| |_| (_|_|_)\033[0m\n"
}

function FailedLogo () {
printf "\033[1;31m ______      _____ _   \033[0m\n"   
printf "\033[1;31m|  ____/\   |_   _| |   \033[0m\n"  
printf "\033[1;31m| |__ /  \    | | | |   \033[0m\n"  
printf "\033[1;31m|  __/ /\ \   | | | |   \033[0m\n"  
printf "\033[1;31m| | / ____ \ _| |_| |____ \033[0m\n"
printf "\033[1;31m|_|/_/    \_\_____|______|\033[0m\n"
}


#########################################(MAIN)############################################

cd /
StartLogo

COUNTER=0
if [ ! -f /media/BIOS_UP_DOWN_count.txt ]; then
	echo 0 > /media/BIOS_UP_DOWN_count.txt
else
	COUNTER=`cat /media/BIOS_UP_DOWN_count.txt`
fi

while true
do	
	if [ $COUNTER -lt 3 ]; then


		echo ------------------------------------------ >> /media/power_cycle_log.txt
		date >> /media/power_cycle_log.txt
		COUNTER=$(($COUNTER+1))
		echo $COUNTER > /media/PWR_cmd_count.txt
		echo "AC Reboot count= $COUNTER" >> /media/power_cycle_log.txt
		printf "\033[1;32m AC Reboot count= $COUNTER \033[0m\n"

		#echo "Executed fii.sh rst hotswap Command(AC Cycle) !!!" > /media/Executed_power.log
		printf "\033[1;32m Executed fii.sh rst hotswap Command(AC Cycle) !!! \033[0m\n"

		sleep 10 & PID=$!
		while kill -0 $PID 2> /dev/null; do 
			printf "\033[1;33m Please wait to boot to OVSS.. !!! \033[0m\n"
			sleep 10
		done
		cat /var/log/obmc-console-cpu0.log | grep "localhost login:" > /media/login1.log
		cat /var/log/obmc-console-cpu1.log | grep "localhost login:" > /media/login2.log

		if [ ! -d "/media/host1_log" ]; then
			mkdir /media/host1_log
		fi
		if [ ! -d "/media/host2_log" ]; then
			mkdir /media/host2_log
		fi

		sync
		sleep 2
		filename1="/media/login1.log"
		filename2="/media/login2.log"
		# Check Host1
		if [ -s "$filename1" ];
		then
			printf "\033[1;32m Host1 AC cycle boot into OVSS Successfully !!! \033[0m\n"
			echo "Host1 AC cycle boot into OVSS Successfully !!!" >> /media/power_cycle_log.txt
			count_temp=`cat /media/host1_count_PASS.txt`
			echo $(($count_temp+1)) > /media/host1_count_PASS.txt
		else
			printf "\033[1;32m Host1 AC cycle boot into OVSS Failed!!! \033[0m\n"
			echo "Host1 AC cycle boot into OVSS Failed!!!" >> /media/power_cycle_log.txt
			count_temp=`cat /media/host1_count_FAIL.txt`
			echo $(($count_temp+1)) > /media/host1_count_FAIL.txt
			if [ ! -d "/media/host1_log/$COUNTER" ]; then
				mkdir /media/host1_log/$COUNTER
			fi
			cp var/log/*.* media/host1_log/$COUNTER
		fi

		# Check Host2
		if [ -s "$filename2" ];
		then
			printf "\033[1;32m Host2 AC cycle boot into OVSS Successfully !!! \033[0m\n"
			echo "Host2 AC cycle boot into OVSS Successfully !!!" >> /media/power_cycle_log.txt
			count_temp=`cat /media/host2_count_PASS.txt`
			echo $(($count_temp+1)) > /media/host2_count_PASS.txt
		else
			printf "\033[1;32m Host2 AC cycle boot into OVSS Failed!!! \033[0m\n"
			echo "Host2 AC cycle boot into OVSS Failed!!!" >> /media/power_cycle_log.txt
			count_temp=`cat /media/host2_count_FAIL.txt`
			echo $(($count_temp+1)) > /media/host2_count_FAIL.txt
			if [ ! -d "/media/host2_log/$COUNTER" ]; then
				mkdir /media/host2_log/$COUNTER
			fi
			cp var/log/*.* media/host2_log/$COUNTER
		fi

		sleep 1
		
		##Clear obmc-console-cpu0.log>>
		printf "\033[1;33m Clear obmc-console-cpu0.log \033[0m\n"
		cat /dev/null > /var/log/obmc-console-cpu0.log
		printf "\033[1;33m Clear obmc-console-cpu1.log \033[0m\n"
		cat /dev/null > /var/log/obmc-console-cpu1.log
		sync
		sleep 5
		##Clear obmc-console-cpu0.log<<
		
		PwrcycleLogo
		sleep 1
		ExitLogo
		#fii.sh rst hotswap     ## Trigger power cycle
		#kudo.sh rst hotswap
	else
		printf "\033[1;32m AC Cycle Test Complete !!! \033[0m\n"
		echo ------------------------------------------ >> /media/power_cycle_log.txt
		echo "AC Cycle Test Complete.. !!!" >> /media/power_cycle_log.txt
		count_host1_pass=`cat /media/host1_count_PASS.txt`
		count_host1_fail=`cat /media/host1_count_FAIL.txt`
		count_host2_pass=`cat /media/host2_count_PASS.txt`
		count_host2_fail=`cat /media/host2_count_FAIL.txt`
		echo $count_host1_pass, $count_host1_fail, $count_host2_pass, $count_host2_fail >> /media/power_cycle_log.txt
		echo "Host1 fail rate is $count_host1_fail %" >> /media/power_cycle_log.txt
		echo "Host2 fail rate is $count_host2_fail %" >> /media/power_cycle_log.txt
		FinishLogo
		exit 0
	fi
	
done

exit 0

