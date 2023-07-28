#! /bin/bash


# clear all logs
function clearLogs() {
    # delete log file
    rm -r ../logs
    mkdir ../logs

    # clear log
    cat /dev/null > /var/log/messages
    dmesg -C
    #ipmitool sel clear
    gsys eventlog clear 2>/dev/null >/dev/null
    sync
}

clearLogs