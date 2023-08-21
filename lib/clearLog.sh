#! /bin/bash


# clear all logs
function clearLog() {
    # delete log file
    rm -r /VSCode_test/log
    mkdir /VSCode_test/log
    # create test log file
    mkdir /VSCode_test/log/$1

    # clear log
    cat /dev/null > /var/log/messages
    dmesg -C
    #ipmitool sel clear
    gsys eventlog clear 2>/dev/null >/dev/null
    sync
}

#clearLogs