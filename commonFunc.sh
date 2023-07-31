#! /bin/bash
#source globalVariable.sh

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