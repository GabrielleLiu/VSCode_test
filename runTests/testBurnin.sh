#! /bin/bash
source ../lib/clearLog.sh
source ../lib/createConfigLog.sh
source ../lib/collectLog.sh
#source ../lib/compareTwoFile.sh

# reset log
clearLogs

# define category name
fileName=Burnin
mkdir ../log/$fileName

# system log before test
createConfigLog

# start test
# !!! cssd_simple_io 會讓SSD消除資料, 請使用NetBoot測試 !!!
# 所有 /export/hda3/meltan 底下的測試跑一遍(排除cssd_simple_io), 儲存結果到測試名稱.log
# cat /BurnIn_meltan/bus_check_log.txt|grep "testRunEnd"|grep "status"|grep "result" >> /BurnIn_meltan/summary_log.txt
# ls -l /export/hda3/meltan/ | awk '/^d/ {print $NF}'
# every single test time??

# system log
collectLog $fileName
# HW log
createConfigLog 0 $fileName
# compare
compareTwoFile $fileName