#! /bin/bash

# $1: file1
# $2: file2
# $3: test Name
fileA=../log/configuration.log
fileB=../log/$fileName/$fileName.log
if diff "$fileA" "$fileB" -b -B >> ../log/$fileName/configuration_diff.log; then
    echo "Configuration Check => Passed" >> ../log/$fileName/summary.log
else
    echo "Configuration Check => Failed" >> ../log/$fileName/summary.log
fi