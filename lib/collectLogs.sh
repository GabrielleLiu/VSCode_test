#! /bin/bash


function collectLogs() {
    
    if [ -n "$1" ]; then
        cat /var/log/messages > ../log/$1/var_log_messages.txt
        dmesg > ../log/$1/dmesg_log.txt
        #ipmitool sel list > /BurnIn_meltan/ipmitool_sel_log.txt
        gsys event records list > ../log/$1/gsys_sel_log.txt

    else
        cat /var/log/messages > ../log/var_log_messages.txt
        dmesg > ../log/dmesg_log.txt
        #ipmitool sel list > /BurnIn_meltan/ipmitool_sel_log.txt
        gsys event records list > ../log/gsys_sel_log.txt
    fi
    sync
}

#collectLogs