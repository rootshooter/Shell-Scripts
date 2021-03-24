#!/bin/bash

HOST=$1
URL=$2
RED='\033[0;31m'
GRN='\033[0;32m'

if [ "$HOST" == "" ]
then 
printf "${RED} Usage: ./dns3num.sh [target] [domain]\n"
printf "${RED} Example: ./dns3num.sh 10.10.10.1 test.com\n"
printf "${RED} Domain specification is optional\n"
else
for ip in "$HOST"; do
if [ ! -d "$HOST" ]
then
mkdir "$HOST"
fi

if [ ! -d "$HOST/dns" ]
then
mkdir "$HOST/dns"
fi

printf "${GRN} [*] Running Nmap\n"
echo "[+] Nmap Scan Information" >> $HOST/dns/dns_info.txt
nmap -n -sS -sU -p53 $HOST >> $HOST/dns/dns_info.txt
printf "${GRN} [+] Nmap scan complete\n"

if [ "$URL" == "" ]
then
printf "${GRN} [*] Done!\n"
printf "${GRN} [*] Happy Hacking!"
else
printf "${GRN} [*] Running Server Enumeration\n"
echo "[+] Dig Name Server Information" >> $HOST/dns/dns_info.txt
timeout 5 dig +short +time=5 +tries=1 $URL NS @$HOST +nocookie >> $HOST/dns/dns_info.txt
echo "[+] Host Name Server Information" >> $HOST/dns/dns_info.txt
timeout 5 host -t ns $URL $HOST >> $HOST/dns/dns_info.txt
printf "${GRN} [+] Collecting Name Server\n"
echo "[+] Dig Mail Server Information" >> $HOST/dns/dns_info.txt
timeout 5 dig +short +time=5 +tries=1 $URL MX @$HOST +nocookie >> $HOST/dns/dns_info.txt
echo "[+] Host Mail Server Information" >> $HOST/dns/dns_info.txt
timeout 5 host -t mx $URL $HOST >> $HOST/dns/dns_info.txt
printf "${GRN} [+] Collecting Mail Server\n"
echo "[+] Dig Zone Transfer Information" >> $HOST/dns/dns_info.txt
timeout 5 dig +short +time=5 +tries=1 @$HOST $URL -t AXFR +nocookie >> $HOST/dns/dns_info.txt
echo "[+] Host Zone Transfer Information" >> $HOST/dns/dns_info.txt
timeout 5 host -t axfr $URL $HOST >> $HOST/dns/dns_info.txt
printf "${GRN} [+] Collecting Zone Transfer\n"
printf "${GRN} [+] Server Enumeration Complete\n"
fi

printf "${GRN} [*] Done!\n"
printf "${GRN} [*] Happy Hacking!"
done
fi
