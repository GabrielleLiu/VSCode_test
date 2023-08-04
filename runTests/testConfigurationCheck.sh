#! /bin/bash
source ../lib/clearLog.sh
source ../lib/createConfigLog.sh
source ../lib/collectLog.sh
source ../lib/compareTwoFile.sh

clearLog

# define category name
fileName=ConfigurationCheck
mkdir ../log/$fileName

#createConfigLog
createConfigLog 0 $fileName
collectLog $fileName

#compareTwoFile $fileName