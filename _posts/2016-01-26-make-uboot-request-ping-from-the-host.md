---
layout: post
title: "Make uboot request ping from the host"
description: ""
category: 
tags: []
---
{% include JB/setup %}


###Make uboot request ping from the host

####Add recvping command
./common/cmd_net.c

		#if defined(CONFIG_CMD_PING)
		static int do_ping(cmd_tbl_t *cmdtp, int flag, int argc, char * const argv[]) {
			if (argc < 2)
				return -1;
		
			NetPingIP = string_to_ip(argv[1]);
			if (NetPingIP == 0)
				return CMD_RET_USAGE;
		
			if (NetLoop(PING) < 0) {	printf("ping failed; host %s is not alive\n", argv[1]);
				return 1;
			}
		
			printf("host %s is alive\n", argv[1]);
		
			return 0;
		}
		
		U_BOOT_CMD(
			ping,	2,	1,	do_ping,
			"send ICMP ECHO_REQUEST to network host",
			"pingAddress"
		);

		static int recv_ping(cmd_tbl_t *cmdtp, int flag, int argc, char * const argv[]) {  			printf("recv ping command excute \n");	  
			if (NetLoop(RECVPING) < 0) {  				printf("ping failed; ");  
				return 1;  
			}  
		  
			printf("host  is alive\n");  
		  
			return 0;  
			  
		}  
		
		U_BOOT_CMD(  
			recvping,	2,	1,	recv_ping,	
			"recv ICMP ECHO_REQUEST from network host",  
			"wait the ping from other host"  
		);
		#endif

####Add RECVPING to the protocol list 
./include/net.h
		
		enum proto_t {
			BOOTP, RARP, ARP, TFTPGET, DHCP, PING, DNS, NFS, CDP, NETCONS, SNTP,
			TFTPSRV, TFTPPUT, LINKLOCAL, RECVPING	//ljz
		};


####Add RECVPING to main network processing loop
./net/ping.c

		void recvping_start(void) {  		    printf("Using %s device\n", eth_get_name());  
		    NetSetTimeout(100000UL, ping_timeout);  
		} 

./net/net.c

		case RECVPING:
			recvping_start();  
			break;

####Bingo!

* uboot

		# recvping 
		recv ping command excute 
		Using eth0 device

* host

		C:\Users>ping 192.168.1.83 -t
		正在 Ping 192.168.1.83 具有 32 字节的数据:
		请求超时。
		来自 192.168.1.83 的回复: 字节=32 时间=999ms TTL=128
		来自 192.168.1.83 的回复: 字节=32 时间<1ms TTL=128
		来自 192.168.1.83 的回复: 字节=32 时间<1ms TTL=128
		来自 192.168.1.83 的回复: 字节=32 时间<1ms TTL=128
		来自 192.168.1.83 的回复: 字节=32 时间<1ms TTL=128