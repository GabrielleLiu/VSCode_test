#! /bin/bash
source globalVariable.sh

function createNewLog() {
    echo "------------------------------------------------------------------------------";
    echo "------------------------------------------------------------------------------";
    echo "Copyright (c) 2023 Foxconn. All Rights Reserved.";
    echo "For Athena Project System Test";
    echo "------------------------------------------------------------------------------";
    echo "------------------------------------------------------------------------------";
}

function config_build() {
    # $1=0, get all log(default)
    # $1="BIOS", no BIOS log
    # $1="BMC", no BMC log
    if ( $1=="0" ); then
        echo "$1=="0"";
    elif ( $1=="BIOS" ); then
        echo "$1==\"BIOS\"";
    elif ( $1=="BMC" ); then
        echo "$1==\"BMC\"";
    else
        echo "input error! Please input 0, BIOS, or BMC!";
        config_build()
    fi
}

function config_check() {

}