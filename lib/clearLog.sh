#! /bin/bash


# clear all logs
function clearLog() {
    # delete log file
    rm -r ../log
    mkdir ../log

    # clear log
    cat /dev/null > /var/log/messages
    dmesg -C
    #ipmitool sel clear
    gsys eventlog clear 2>/dev/null >/dev/null
    sync
}

#clearLogs