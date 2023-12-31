#!/bin/bash
#
# Execute directly under BMC side when host rc.local is ready

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
	# Please modify cycles in next line =====================================================
	if [ $COUNTER -lt 3 ]; then


		echo ------------------------------------------ >> /media/BIOS_UP_DOWN_summary.txt
		date >> /media/BIOS_UP_DOWN_summary.txt
		COUNTER=$(($COUNTER+1))
		echo $COUNTER > /media/BIOS_UP_DOWN_count.txt
		echo cycle No.$COUNTER >> /media/BIOS_UP_DOWN_summary.txt

		cd /run/initramfs/
		# Please modify the image file name here ============================================
		oldVersion="20230805_release"
		newVersion="20230822_release"
		
		if [ $(($COUNTER%2)) -eq 1 ]; then
			cp -f $oldVersion/athena-vanilla.bios .
			echo Host1 BIOS was Downgraded from $newVersion to $oldVersion !!! >> /media/BIOS_UP_DOWN_summary.txt
		else
			cp -f $newVersion/athena-vanilla.bios .
			echo Host1 BIOS was Upgraded from $oldVersion to $newVersion !!! >> /media/BIOS_UP_DOWN_summary.txt
		fi		
		fii-firmware-update.sh bios0 athena-vanilla.bios
		sleep 180
		fii.sh rst btn 1

		if [ $(($COUNTER%2)) -eq 1 ]; then
			cp -f $oldVersion/athena-vanilla.bios .
			echo Host2 BIOS was Downgraded from $newVersion to $oldVersion !!! >> /media/BIOS_UP_DOWN_summary.txt
		else
			cp -f $newVersion/athena-vanilla.bios .
			echo Host2 BIOS was Upgraded from $oldVersion to $newVersion !!! >> /media/BIOS_UP_DOWN_summary.txt
		fi
		fii-firmware-update.sh bios1 athena-vanilla.bios
		sleep 180
		fii.sh rst btn 2
		
		PwrcycleLogo
		# Please modify the cycle time here if needed ========================================
		sleep 420 & PID=$!
		while kill -0 $PID 2> /dev/null; do 
			printf "\033[1;33m Please wait to boot to OVSS.. !!! \033[0m\n"
			sleep 10
		done
		ExitLogo
		#fii.sh rst hotswap     ## Trigger power cycle
		#kudo.sh rst hotswap
	else
		echo ------------------------------------------ >> /media/BIOS_UP_DOWN_summary.txt
		echo "BIOS Upgrade and Downgrade Test Complete.. !!!" >> /media/BIOS_UP_DOWN_summary.txt
		FinishLogo
		exit 0
	fi
	
done

exit 0

