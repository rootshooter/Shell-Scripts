#!/bin/bash

host=$1
domain=$2
red='\033[0;31m'

if [ "$host" == "" ]
then 
printf "${red} Usage: ./hostFind3r.sh [target] [domain]\n"
printf "${red} Example: ./hostFind3r.sh 172.16.5.10 sportsfoo.com\n"
else
for name in $(cat /usr/share/wordlists/hosts.txt)
do
host $name.$domain $host -W 2; done | grep "has address"
fi