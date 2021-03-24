#!/bin/bash

RED='\033[0;31m'
GRN='\033[0;32m'

if [ "$1" == "" ]
then
printf "${RED} Usage: ./start.sh [dir_name]\n"
printf "${RED} Example: ./start.sh tryhackme"
else 
for d in $1; do
mkdir $1
mkdir $1/nmap
mkdir $1/gobuster
printf "${GRN} [+] Done!\n"
printf "${GRN} [+] Happy hacking!"
done
fi
