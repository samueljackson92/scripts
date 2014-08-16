#!/bin/bash -e
#file to run the makefile in one command
green='\e[1;32m'
endColour='\e[0m'

clear
echo

make
make install
make clean

echo
echo -e "${green}Build Successful!${endColour}"
