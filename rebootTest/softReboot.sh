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
StartLogo

cd /
source ./VSCode_test/lib/clearLog.sh
source ./VSCode_test/lib/createConfigLog.sh
source ./VSCode_test/lib/collectLog.sh
#source ./VSCode_test/lib/compareTwoFile.sh
cd /VSCode_test/log/SoftReboot/

COUNTER=0

if [ ! -f "PWR_cmd_count.txt" ]; then
	echo 0 > PWR_cmd_count.txt
else
	COUNTER=`cat PWR_cmd_count.txt`
fi

if [ $COUNTER -lt 3 ]; then
	echo ------------------------------------------ >> power_cycle_log.txt
	date >> power_cycle_log.txt
	COUNTER=$(($COUNTER+1))
	echo $COUNTER > PWR_cmd_count.txt

	# display on screen
	echo "Reboot count is $COUNTER" >> power_cycle_log.txt
	printf "\033[1;32m Now reboot count is $COUNTER \033[0m\n"

	# compare config
	createConfigLog 0 "SoftReboot"

	cd /
	fileA=/VSCode_test/log/SoftReboot/configuration.log
    fileB=/VSCode_test/log/configurationCheck.log
    if diff "$fileA" "$fileB" -b -B >> SoftReboot/configuration_diff.log; then
        echo "Configuration Check => Passed" >> SoftReboot/power_cycle_log.txt
    else
        echo "Configuration Check => Failed" >> SoftReboot/power_cycle_log.txt
    fi

	PwrcycleLogo
	sleep 1
	ExitLogo
	#fii.sh rst hotswap     ## Trigger power cycle
	shutdown -r

else
	printf "\033[1;32m Power Cycle Test Complete !!! \033[0m\n"
	echo "Power Cycle Test Complete !!!" >> power_cycle_log.txt
	FinishLogo

	# collect logs
	collectLog "SoftReboot"
fi