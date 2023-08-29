#! /bin/bash
source ../lib/clearLog.sh
source ../lib/createConfigLog.sh
source ../lib/collectLog.sh
source ../lib/compareTwoFile.sh

# define category name
fileName=ConfigurationCheck
clearLog $fileName

#createConfigLog
createConfigLog 0 $fileName
collectLog $fileName

#compareTwoFile $fileName