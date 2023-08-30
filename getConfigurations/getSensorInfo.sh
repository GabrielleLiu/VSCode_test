#! /bin/bash
#source globalVariable.sh

bmc=ifconfig | grep bmc -A 1 | grep inet | awk -F ' ' '{print $2}' | awk -F ':' '{print $2}'
function Get_sensor () {
    #echo ====================================================================================================
    echo "Redfish Sensor Inventory"
    RFRESP=`curl -s --insecure "http://${bmc}/redfish/v1/Chassis" --header "Authorization: Basic cm9vdDowcGVuQm1j"`
    declare -a arr_chassis=(`echo $RFRESP | jq '.Members[]."@odata.id"'`)
    for chassis_id in "${arr_chassis[@]}"
    do
        COL_ITEM_URL=`sed -e 's/^"//' -e 's/"$//' <<<"$chassis_id"`
        RFRESP=`curl -s --insecure "http://${bmc}${COL_ITEM_URL}/Sensors" --header "Authorization: Basic cm9vdDowcGVuQm1j"`
        declare -a arr_sensors=(`echo $RFRESP | jq '.Members[]."@odata.id"'`)
        for sensor_id in "${arr_sensors[@]}"
        do
            COL_ITEM_URL=`sed -e 's/^"//' -e 's/"$//' <<<"$sensor_id"`
            RFRESP=`curl -s --insecure "http://${bmc}${COL_ITEM_URL}" --header "Authorization: Basic cm9vdDowcGVuQm1j"`			
            chassis_id2=`echo ${chassis_id} | tr -d '"'`
            sensorId=`echo $RFRESP | jq '.Id' | tr -d '"'`
            sensorReading=`echo $RFRESP | jq '.Reading' | tr -d '"'`
            sensorReadingType=`echo $RFRESP | jq '.ReadingType' | tr -d '"'`
						
            echo ${chassis_id2}:  ${sensorId}:   ${sensorReading}:   ${sensorReadingType}
        done        
    done 
}

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo "                                  getSensorInfo";
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
if [ -n $bmc ];then
    Get_sensor > /SDR_List.txt
    echo "Number of sensors";
    cat /SDR_List.txt | awk -F ':' '{print $1,$2}'| wc -l
    echo;

    echo;
    echo "Number of normal state";
    cat /SDR_List.txt | awk -F ':' '{print $3}'| grep -v 'null' | wc -l
    echo;

    echo;
    echo "SDR List";
    cat /SDR_List.txt | awk -F ':' '{print $1,$2}'
    echo;
else
    echo Please check bmc inet IP setting on your host!!!
fi
echo;
echo;
echo;