#!/bin/bash

host=$1
red='\033[0;31m'
green='\033[0;32m'

if [ "$host" == "" ]
then 
printf "${red} Usage: ./reverseFind3r.sh [DNS Server IP]\n"
printf "${red} Example: ./reverseFind3r.sh 172.16.5.10\n"
else
for ip in $(cat ips.txt)
do 
dig @$host -x $ip +nocookie

printf "${green} [+] Happy hacking!\n"
done
fi