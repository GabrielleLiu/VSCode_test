#! /bin/bash
source globalVariable.sh
source commonFunc.sh

# create a new log file
#createNewLog > $Log_PATH/configuration_check.log;
createNewLog()
echo line8;

# input all cofig into log
DIR='/getConfigurations/'
for FILE in ${DIR}; do
    #./lib/$FILE >> $Log_PATH/configuration_check.log;
    echo $FILE;
done
echo line16;

config_build();