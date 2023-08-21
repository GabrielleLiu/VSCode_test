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
    
    cd /
    if [ -n "$2" ]; then
        file=/VSCode_test/log/$2/configurationCheck.log;
    else
        file=/VSCode_test/log/configuration.log;
    fi

    newLogTitle > $file
    if [ -n "$1" ] && [ $1 -eq 1 ]; then
        #echo no BIOS log;
        #./VSCode_test/getConfigurations/getBIOSVersion.sh >> $file
        ./VSCode_test/getConfigurations/getBMCVersion.sh >> $file
        ./VSCode_test/getConfigurations/getBootDevice.sh >> $file
        ./VSCode_test/getConfigurations/getCPUInfo.sh >> $file
        ./VSCode_test/getConfigurations/getgsysVersion.sh >> $file
        ./VSCode_test/getConfigurations/getKernelVersion.sh >> $file
        ./VSCode_test/getConfigurations/getMemoryInfo.sh >> $file
        ./VSCode_test/getConfigurations/getMotherBoardInfo.sh >> $file
        ./VSCode_test/getConfigurations/getNICInfo.sh >> $file
        ./VSCode_test/getConfigurations/getSensorInfo.sh >> $file  

    elif [ -n "$1" ] && [ $1 -eq 2 ]; then
        #echo no BMC log;
        ./VSCode_test/getConfigurations/getBIOSVersion.sh >> $file
        #./VSCode_test/getConfigurations/getBMCVersion.sh >> $file
        ./VSCode_test/getConfigurations/getBootDevice.sh >> $file
        ./VSCode_test/getConfigurations/getCPUInfo.sh >> $file
        ./VSCode_test/getConfigurations/getgsysVersion.sh >> $file
        ./VSCode_test/getConfigurations/getKernelVersion.sh >> $file
        ./VSCode_test/getConfigurations/getMemoryInfo.sh >> $file
        ./VSCode_test/getConfigurations/getMotherBoardInfo.sh >> $file
        ./VSCode_test/getConfigurations/getNICInfo.sh >> $file
        ./VSCode_test/getConfigurations/getSensorInfo.sh >> $file  

    else
        #echo get all log
        ./VSCode_test/getConfigurations/getBIOSVersion.sh >> $file
        ./VSCode_test/getConfigurations/getBMCVersion.sh >> $file
        ./VSCode_test/getConfigurations/getBootDevice.sh >> $file
        ./VSCode_test/getConfigurations/getCPUInfo.sh >> $file
        ./VSCode_test/getConfigurations/getgsysVersion.sh >> $file
        ./VSCode_test/getConfigurations/getKernelVersion.sh >> $file
        ./VSCode_test/getConfigurations/getMemoryInfo.sh >> $file
        ./VSCode_test/getConfigurations/getMotherBoardInfo.sh >> $file
        ./VSCode_test/getConfigurations/getNICInfo.sh >> $file
        ./VSCode_test/getConfigurations/getSensorInfo.sh >> $file  
    fi
}

#createConfigLog