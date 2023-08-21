#! /bin/bash

# $1: test Name
function compareTwoFile() {
    
    if [ -n "$1" ]; then
    
        cd /
        fileA=/VSCode_test/log/configuration.log
        fileB=/VSCode_test/log/$1/configurationCheck.log
        if diff "$fileA" "$fileB" -b -B >> /VSCode_test/log/$1/configuration_diff.log; then
            echo "Configuration Check => Passed" >> /VSCode_test/log/$1/summary.log
        else
            echo "Configuration Check => Failed" >> /VSCode_test/log/$1/summary.log
        fi
    fi
}

#compareTwoFile ConfigurationCheck