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
source ../lib/clearLog.sh
source ../lib/createConfigLog.sh
source ../lib/collectLog.sh
source ../lib/compareTwoFile.sh

cd /
StartLogo

fileName=BIOSUpandDown
COUNTER=0
if [ ! -f /media/BIOS_UP_DOWN_count.txt ]; then
	echo 0 > /media/BIOS_UP_DOWN_count.txt
	clearLog $COUNTER
	createConfigLog
else
	COUNTER=`cat /media/BIOS_UP_DOWN_count.txt`
	mkdir VSCode_test/log/$COUNTER
fi

# Please modify cycles in next line =====================================================
if [ $COUNTER -lt 50 ]; then

	COUNTER=$(($COUNTER+1))
	echo $COUNTER > /media/BIOS_UP_DOWN_count.txt

	createConfigLog 0 $COUNTER
	collectLog $COUNTER
	compareTwoFile $COUNTER
else
	echo ------------------------------------------
	echo "BIOS Upgrade and Downgrade Test Complete.. !!!"
	FinishLogo
	exit 0
fi

exit 0

