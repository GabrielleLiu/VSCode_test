#! /bin/bash


function collectLog() {
    
    cd /
    if [ -n "$1" ]; then
        cat /var/log/messages > VSCode_test/log/$1/var_log_messages.txt
        dmesg > VSCode_test/log/$1/dmesg_log.txt
        #ipmitool sel list > /BurnIn_meltan/ipmitool_sel_log.txt
        gsys event records list > VSCode_test/log/$1/gsys_sel_log.txt

    else
        cat /var/log/messages > VSCode_test/log/var_log_messages.txt
        dmesg > VSCode_test/log/dmesg_log.txt
        #ipmitool sel list > /BurnIn_meltan/ipmitool_sel_log.txt
        gsys event records list > VSCode_test/log/gsys_sel_log.txt
    fi
    sync
}

#collectLogs