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

function config_build() {
    # $1=0 or other, get all log(default)
    # $1=1 no BIOS log
    # $1=2, no BMC log
    newLogTitle > originalConfig.log
    if [ $1 -eq 1 ]; then
        #echo no BIOS log;
        #./getConfigurations/getBIOSVersion.sh >> originalConfig.log
        ./getConfigurations/getBMCVersion.sh >> originalConfig.log
        ./getConfigurations/getBootDevice.sh >> originalConfig.log
        ./getConfigurations/getCPUInfo.sh >> originalConfig.log
        ./getConfigurations/getgsysVersion.sh >> originalConfig.log
        ./getConfigurations/getKernelVersion.sh >> originalConfig.log
        ./getConfigurations/getMemoryInfo.sh >> originalConfig.log
        ./getConfigurations/getMotherBoardInfo.sh >> originalConfig.log
        ./getConfigurations/getNICInfo.sh >> originalConfig.log
        ./getConfigurations/getSensorInfo.sh >> originalConfig.log    

    elif [ $1 -eq 2 ]; then
        #echo no BMC log;
        ./getConfigurations/getBIOSVersion.sh >> originalConfig.log
        #./getConfigurations/getBMCVersion.sh >> originalConfig.log
        ./getConfigurations/getBootDevice.sh >> originalConfig.log
        ./getConfigurations/getCPUInfo.sh >> originalConfig.log
        ./getConfigurations/getgsysVersion.sh >> originalConfig.log
        ./getConfigurations/getKernelVersion.sh >> originalConfig.log
        ./getConfigurations/getMemoryInfo.sh >> originalConfig.log
        ./getConfigurations/getMotherBoardInfo.sh >> originalConfig.log
        ./getConfigurations/getNICInfo.sh >> originalConfig.log
        ./getConfigurations/getSensorInfo.sh >> originalConfig.log    

    else
        #echo get all log
        ./getConfigurations/getBIOSVersion.sh >> originalConfig.log
        ./getConfigurations/getBMCVersion.sh >> originalConfig.log
        ./getConfigurations/getBootDevice.sh >> originalConfig.log
        ./getConfigurations/getCPUInfo.sh >> originalConfig.log
        ./getConfigurations/getgsysVersion.sh >> originalConfig.log
        ./getConfigurations/getKernelVersion.sh >> originalConfig.log
        ./getConfigurations/getMemoryInfo.sh >> originalConfig.log
        ./getConfigurations/getMotherBoardInfo.sh >> originalConfig.log
        ./getConfigurations/getNICInfo.sh >> originalConfig.log
        ./getConfigurations/getSensorInfo.sh >> originalConfig.log        
    fi
}
