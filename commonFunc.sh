#! /bin/bash
#source globalVariable.sh

# clear os log, ipmitool sel, gsys log before test
function clearLogs() {
    # 1
    cat /dev/null > /var/log/messages
    # 2
    dmesg -C
    # 3 ,Redfish
    ipmitool sel clear
    # 4
    gsys eventlog clear 2>/dev/null >/dev/null
    
    sync # force data write into disk when it is modified
}

# use for CPU load test
# $1: assign file category, default is CPU_Load
function monitorSensors() {
    
    fileName=CPU_Load;
    if [ -n $1 ]; then
        fileName=$1
    fi
    # log data every 10 seconds
    while true
	do
	  date "+%Y-%m-%d %H:%M:%S" >> $fileName/ipmitool_SensorList.txt
	  ipmitool sensor list >> $fileName/ipmitool_SensorList.txt
	  echo ----------------mptat---------------- >> $fileName/ipmitool_SensorList.txt
	  timeout 2 mpstat 1 >> $fileName/ipmitool_SensorList.txt
	  echo ----------------free---------------- >> $fileName/ipmitool_SensorList.txt
	  free >> $fileName/ipmitool_SensorList.txt

	  date "+%Y-%m-%d %H:%M:%S" >> $fileName/cpupower_frequency.txt
	  cpupower frequency-info >> $fileName/cpupower_frequency.txt
	  sleep 10
	  echo "" >> $fileName/ipmitool_SensorList.txt
	  echo ------------------------------------------- >> $fileName/ipmitool_SensorList.txt
	  echo "" >> $fileName/cpupower_frequency.txt
	done
}

# $1, $2
# echo "main.sh" | cut -d"." -f 1
function compareAandBdiff() {

    if diff "$1" "$2" -b -B >> config_verify.log; then
		echo "Configcheck files is match" > config_match.txt						
		echo  Compare Pass >> config_verify.log				
		printf "\033[1;32m Conan Configcheck files is match !!! \033[0m\n"
		printf "\n"															
	else
		echo "Configcheck files are different!!" > config_diff.txt
		echo Compare Fail >> config_verify.log			
		printf "\033[1;31m Configcheck Failed !!! \033[0m\n"
		printf "\n"		
	fi
}

function dumpLogs() {
    cat /var/log/messages > var_log_messages.txt
    dmesg > dmesg_log.txt
    cat dmesg_log.txt | egrep 'error|ERROR|aer|AER|ras|RAS|fail|FAIL|Critical|critical|errortype|severity' >> dmesg_summary_logs.txt
    ipmitool sel list > ipmitool_sel_log.txt
    SEL_awk=`cat ipmitool_sel_log.txt | grep "OEM record" | awk '{print$13}'`
    for SEL_awk_loop in $SEL_awk; do
        perl ampereone_bmc_sel.plx raw_pldm $SEL_awk_loop >> SEL_OEM.log
    done
    gsys event records list > gsys_event_log.txt
    free > free.txt
    echo
}






#config_build