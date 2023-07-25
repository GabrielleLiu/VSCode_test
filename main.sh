#! /bin/bash
source globalVariable.sh

# create a new log file
createNewLog > $Log_PATH/configuration_check.log;

# input all cofig into log
DIR='/lib'
for FILE in "$DIR"/*.sh
do
    ./lib/$FILE >> $Log_PATH/configuration_check.log;
done