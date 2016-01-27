---
layout: post
title: "Auto xterm ping test"
description: ""
category: 
tags: []
---
{% include JB/setup %}

###Open multiple xterm windows automaticly

> vi xtping.sh 


	#!/bin/sh
	while read LINE
	do
		echo $LINE
		xterm -geometry 100x10 -e /sysdisk/testping/PING.sh $LINE &
		sleep 1
	done < /sysdisk/testping/ip_list.txt

###Get ping result with color

> vi PING.sh

	#!/bin/sh
	
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
	
	IPADDR=$1
	ECHO "Camera IP $IPADDR"
	
	NG_NO=${IPADDR##*.}
	
	while [ 1 ]
	do
		#echo $1
		CONNECT_NUM=`ping $1 -c 2 | grep "ttl=64" | wc -l`
		#ECHO "${CONNECT_NUM}" COLOR_RED
		if [ "${CONNECT_NUM}" == "2" ];
		then
			ECHONRT "*OK " COLOR_BLUE
		else
			ECHONRT "#${NG_NO} " COLOR_RED
		fi
	done

###