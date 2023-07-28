#! /bin/bash

# $1: file1
# $2: file2
function compareTwoFile() {

    if diff "$1" "$2" -b -B >> config_llll.log; then
		echo "Configcheck files is match" > config_match.txt						
		echo  Compare Pass >> config_verify.log				
		printf "\033[1;32m Conan Configcheck files is match !!! \033[0m\n"
		printf "\n"															
	else
		echo "Configcheck files are different!!" > config_diff.txt
		echo Compare Fail >> config_verify.log
		printf "\033[1;31m Configcheck Failed !!! \033[0m\n"
		printf "\n"		
	fi
}

compareTwoFile ../log/configuration.log ../log/ConfigurationCheck/configurationCheck.log
#diff ../log/configuration.log ../log/ConfigurationCheck/configurationCheck.log