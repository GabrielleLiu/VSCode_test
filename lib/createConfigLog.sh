#! /bin/bash


# print title of log
function newLogTitle() {
    echo "------------------------------------------------------------------------------";
    echo "------------------------------------------------------------------------------";
    echo "Copyright (c) 2023 Foxconn. All Rights Reserved.";
    echo "For Athena Project System Test";
    echo "------------------------------------------------------------------------------";
    echo "------------------------------------------------------------------------------";
}

# config_build $1 $2
# $1 : 1=no BIOS log, 2=no BMC log
# $2 : assign log file name
function createConfigLog() {
    
    if [ -n "$2" ]; then
        file=../log/$2/configurationCheck.log;
    else
        file="../log/configuration.log";
    fi

    newLogTitle > $file
    if [ -n "$1" ] && [ $1 -eq 1 ]; then
        #echo no BIOS log;
        #./getConfigurations/getBIOSVersion.sh >> $file
        ../getConfigurations/getBMCVersion.sh >> $file
        ../getConfigurations/getBootDevice.sh >> $file
        ../getConfigurations/getCPUInfo.sh >> $file
        ../getConfigurations/getgsysVersion.sh >> $file
        ../getConfigurations/getKernelVersion.sh >> $file
        ../getConfigurations/getMemoryInfo.sh >> $file
        ../getConfigurations/getMotherBoardInfo.sh >> $file
        ../getConfigurations/getNICInfo.sh >> $file
        ../getConfigurations/getSensorInfo.sh >> $file  

    elif [ -n "$1" ] && [ $1 -eq 2 ]; then
        #echo no BMC log;
        ../getConfigurations/getBIOSVersion.sh >> $file
        #./getConfigurations/getBMCVersion.sh >> $file
        ../getConfigurations/getBootDevice.sh >> $file
        ../getConfigurations/getCPUInfo.sh >> $file
        ../getConfigurations/getgsysVersion.sh >> $file
        ../getConfigurations/getKernelVersion.sh >> $file
        ../getConfigurations/getMemoryInfo.sh >> $file
        ../getConfigurations/getMotherBoardInfo.sh >> $file
        ../getConfigurations/getNICInfo.sh >> $file
        ../getConfigurations/getSensorInfo.sh >> $file   

    else
        #echo get all log
        ../getConfigurations/getBIOSVersion.sh >> $file
        ../getConfigurations/getBMCVersion.sh >> $file
        ../getConfigurations/getBootDevice.sh >> $file
        ../getConfigurations/getCPUInfo.sh >> $file
        ../getConfigurations/getgsysVersion.sh >> $file
        ../getConfigurations/getKernelVersion.sh >> $file
        ../getConfigurations/getMemoryInfo.sh >> $file
        ../getConfigurations/getMotherBoardInfo.sh >> $file
        ../getConfigurations/getNICInfo.sh >> $file
        ../getConfigurations/getSensorInfo.sh >> $file  
    fi
}

#createConfigLog