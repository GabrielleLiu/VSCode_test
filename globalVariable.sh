#! /bin/bash

# Please check below variable is correct

# getConfiguration/getBMCVersion.sh
BMC_FW_ADDR="https://169.254.95.118:443/redfish/v1/UpdateService/FirmwareInventory/47ce0879"

# lib/
# 0= AC cycle, 1=...
REBOOT_TYPE=0

REBOOT_COUNT=200

# ================================Automation part================================
SCRIPT_PATH=$(pwd)
#echo $SCRIPT_PATH