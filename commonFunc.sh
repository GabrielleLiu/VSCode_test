#! /bin/bash
source globalVariable.sh


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
function config_build() {

    fileName="originalConfig.log";
    if [ -n "$2" ]; then
        fileName="$2";
    fi

    newLogTitle > $fileName
    if [ -n "$1" ] && [ $1 -eq 1 ]; then
        #echo no BIOS log;
        #./getConfigurations/getBIOSVersion.sh >> $fileName
        ./getConfigurations/getBMCVersion.sh >> $fileName
        ./getConfigurations/getBootDevice.sh >> $fileName
        ./getConfigurations/getCPUInfo.sh >> $fileName
        ./getConfigurations/getgsysVersion.sh >> $fileName
        ./getConfigurations/getKernelVersion.sh >> $fileName
        ./getConfigurations/getMemoryInfo.sh >> $fileName
        ./getConfigurations/getMotherBoardInfo.sh >> $fileName
        ./getConfigurations/getNICInfo.sh >> $fileName
        ./getConfigurations/getSensorInfo.sh >> $fileName  

    elif [ -n "$1" ] && [ $1 -eq 2 ]; then
        #echo no BMC log;
        ./getConfigurations/getBIOSVersion.sh >> $fileName
        #./getConfigurations/getBMCVersion.sh >> $fileName
        ./getConfigurations/getBootDevice.sh >> $fileName
        ./getConfigurations/getCPUInfo.sh >> $fileName
        ./getConfigurations/getgsysVersion.sh >> $fileName
        ./getConfigurations/getKernelVersion.sh >> $fileName
        ./getConfigurations/getMemoryInfo.sh >> $fileName
        ./getConfigurations/getMotherBoardInfo.sh >> $fileName
        ./getConfigurations/getNICInfo.sh >> $fileName
        ./getConfigurations/getSensorInfo.sh >> $fileName   

    else
        #echo get all log
        ./getConfigurations/getBIOSVersion.sh >> $fileName
        ./getConfigurations/getBMCVersion.sh >> $fileName
        ./getConfigurations/getBootDevice.sh >> $fileName
        ./getConfigurations/getCPUInfo.sh >> $fileName
        ./getConfigurations/getgsysVersion.sh >> $fileName
        ./getConfigurations/getKernelVersion.sh >> $fileName
        ./getConfigurations/getMemoryInfo.sh >> $fileName
        ./getConfigurations/getMotherBoardInfo.sh >> $fileName
        ./getConfigurations/getNICInfo.sh >> $fileName
        ./getConfigurations/getSensorInfo.sh >> $fileName  
    fi
}
