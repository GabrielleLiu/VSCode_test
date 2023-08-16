#! /bin/bash
source globalVariable.sh

#config_build
#echo helloworld

function menu {
    echo -e "\t\t\tSys Adamin Menu\n"
    echo -e "\t1. Configuration Check"
    echo -e "\t0. Exit\n\n"
    echo -en "\t\tEnter option:"
    read -n 1 option
}

function option1 {
    clear
    config_build
}

# start
while [ 1 ]
do
    menu
    case $option in
    0)
        break;;
    1)
        option1;;
    *)
        clear
        echo "sorry , wrong selection";;
esac
echo -en "\n\n\t\t\tHit any key to continue"
read -n 1 line
done
clear