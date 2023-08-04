#! /bin/bash

# $1: test Name
function compareTwoFile() {
    
    if [ -n "$1" ]; then
    
        fileA=../log/configuration.log
        fileB=../log/$1/configurationCheck.log
        if diff "$fileA" "$fileB" -b -B >> ../log/$1/configuration_diff.log; then
            echo "Configuration Check => Passed" >> ../log/$1/summary.log
        else
            echo "Configuration Check => Failed" >> ../log/$1/summary.log
        fi
    fi
}

#compareTwoFile ConfigurationCheck