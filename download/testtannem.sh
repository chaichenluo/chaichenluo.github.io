#!/bin/bash

# ANSI COLORS
COLOR_CRE="[K"
COLOR_NORMAL="[0;39m"
COLOR_RED="[1;31m"
COLOR_GREEN="[1;32m"
COLOR_YELLOW="[1;33m"
COLOR_BLUE="[1;34m"
COLOR_MAGENTA="[1;35m"
COLOR_CYAN="[1;36m"
COLOR_WHITE="[1;37m"

#$1: string
#$2: color
ECHO()
{
	[ -n "$2" ] && eval echo -n \"\${${2}}\";
	echo "${1}${COLOR_NORMAL}"
}

ECHONRT()
{
	[ -n "$2" ] && eval echo -n \"\${${2}}\";
	echo -e "${1}${COLOR_NORMAL}\c"
}

PRINTDATE()
{
	ECHO  `date "+%Y-%m-%d_%H:%M:%S"` COLOR_RED
}


i=0
while [ 1 ]
do
	a=1
	i=`expr $i + $a`
	ECHO ""
	ECHO "*****************************************"
	ECHONRT "TESTNO:$i#####" COLOR_RED
	PRINTDATE

	ECHO "Step 1:" COLOR_BLUE
	ECHO "host vive.me" COLOR_BLUE
	host vive.me
	
	ECHO "Step 2:" COLOR_BLUE
	ECHO "ping -c 3 vive.me" COLOR_BLUE
	ping -c 3 vive.me
	ECHO "ping -c 3 www.vive.me" COLOR_BLUE
	ping -c 3 www.vive.me

	ECHO "Step 3:" COLOR_BLUE
	ECHO "traceroute vive.me" COLOR_BLUE
	traceroute vive.me

	ECHO "Step 4:" COLOR_BLUE
	ECHO "curl -v --trace-ascii --connect-timeout 10 -m 10 -s -w '%{time_connect}:%{time_starttransfer}:%{time_total}:%{time_namelookup}:%{speed_download}\n' 'http://vive.me'" COLOR_BLUE
	curl -v --trace-ascii --connect-timeout 10 -m 10 -s -w '\n%{time_connect}:%{time_starttransfer}:%{time_total}:%{time_namelookup}:%{speed_download}\n' 'http://vive.me'	

	ECHO "curl -o /dev/null --connect-timeout 10 -m 10 -s -w '%{time_connect}:%{time_starttransfer}:%{time_total}:%{time_namelookup}:%{speed_download}\n' 'https://vive.me'" COLOR_BLUE
	curl -o /dev/null --connect-timeout 10 -m 10 -s -w '\n%{time_connect}:%{time_starttransfer}:%{time_total}:%{time_namelookup}:%{speed_download}\n' 'https://vive.me'	

	ECHO "Step 5:" COLOR_BLUE
	ECHO "curl -d \"\" --connect-timeout 10 -m 10 -w '%{time_connect}:%{time_starttransfer}:%{time_total}:%{time_namelookup}:%{speed_download}\n' -v https://ios-api.vive.me/rawrpc.php" COLOR_BLUE
	curl -d "" --connect-timeout 10 -m 10 -w '\n%{time_connect}:%{time_starttransfer}:%{time_total}:%{time_namelookup}:%{speed_download}\n' -v https://ios-api.vive.me/rawrpc.php

	ECHO "Step 6:" COLOR_BLUE
	ECHO "curl -d \"\" --connect-timeout 10 -m 10 -w '%{time_connect}:%{time_starttransfer}:%{time_total}:%{time_namelookup}:%{speed_download}\n' -v https://0urppydow3.execute-api.us-east-1.amazonaws.com/production" COLOR_BLUE
	curl -d "" --connect-timeout 10 -m 10 -w '\n%{time_connect}:%{time_starttransfer}:%{time_total}:%{time_namelookup}:%{speed_download}\n' -v https://0urppydow3.execute-api.us-east-1.amazonaws.com/production

		
done
