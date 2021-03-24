#!/bin/bash

red='\033[0;31m'
grn='\033[0;32m'
url=$1

if [ "$1" == "" ];then
	printf "${red} Usage: ./r3con.sh target.url\n"
	printf "${red} Example: ./r3con.sh tesla.com\n"

else

if [ ! -d "$url" ];then
	mkdir $url
fi

if [ ! -d "$url/r3con" ];then
	mkdir $url/r3con
fi

if [ ! -d "$url/r3con/subdomains" ];then
	mkdir $url/r3con/subdomains
fi

if [ ! -d "$url/r3con/gobuster" ];then
	mkdir $url/r3con/gobuster
fi

if [ ! -d "$url/r3con/nmap" ];then
	mkdir $url/r3con/nmap
fi

if [ ! -d "$url/r3con/screenshots" ];then
	mkdir $url/r3con/screenshots
fi

printf "${grn} [*] Collecting subdomains with Assefinder...\n"
assetfinder $url >> $url/r3con/subdomains/assets.txt
cat $url/r3con/subdomains/assets.txt | grep $1 >> $url/r3con/subdomains/subs_final.txt
rm $url/r3con/subdomains/assets.txt
printf "${grn} [+]Finished!\n"

#printf "${grn} [*] Collecting subdomains with Amass...\n"
#amass enum -d $url >> $url/r3con/subdomains/a.txt
#sort -u $url/r3con/subdomains/a.txt >> $url/r3con/subdomains/subs_final.txt
#rm $url/r3con/subdomains/a.txt
#printf "${grn} [+]Finished!\n"

printf "${grn} [*] Gathering alive subdomains with httprobe...\n"
cat $url/r3con/subdomains/subs_final.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/r3con/subdomains/alive.txt
printf "${grn} [+]Finished!\n"

#printf "${grn} [*] Checking for open directories with Gobuster...\n"
	#for sub in $(cat $url/r3con/subdomains/alive.txt);do
		#gobuster dir -u $sub -k -w /usr/share/seclists/Discovery/Web-Content/raft-small-words.txt -o $url/r3con/gobuster/$sub.out
	#done
#printf "${grn} [+]Finished!\n"

#printf "${grn} [*] Checking for open ports with Nmap...\n"
#nmap -iL $url/r3con/subdomains/alive.txt -T4 -oN $url/r3con/nmap/port_scan.nmap
#printf "${grn} [+]Finished!\n"

#printf "${grn} [*] Collecting screenshots with Eyewitness...\n"
#eyewitness --web -f $url/r3con/subdomains/alive.txt -d $url/r3con/screenshots --resolve
#printf "${grn} [+]Finished!\n"
#printf "${grn} [*] Happy hunting @rootshooter!\n"
fi
