#! /bin/bash
#source globalVariable.sh

#echo System IP is $SUP_IP;
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";
echo "                                  getSensorInfo";
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<";
echo;
bmc="192.168.2.11"
echo "Redfish Sensor Inventory"
RFRESP=`curl -s --insecure "http://${bmc}/redfish/v1/Chassis" --header "Authorization: Basic cm9vdDowcGVuQm1j"` declare -a arr_chassis=(`echo $RFRESP | jq '.Members[]."@odata.id"'`)
for chassis_id in "${arr_chassis[@]}"
do
    COL_ITEM_URL=`sed -e 's/^"//' -e 's/"$//' <<<"$chassis_id"`
    RFRESP=`curl -s --insecure "http://${bmc}${COL_ITEM_URL}/Sensors" --header "Authorization: Basic cm9vdDowcGVuQm1j"` declare -a arr_sensors=(`echo $RFRESP | jq '.Members[]."@odata.id"'`)
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
echo;
echo;
echo;
