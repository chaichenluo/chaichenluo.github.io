---
layout: post
title: "Cross compile ethtool"
description: ""
category: 
tags: []
---
{% include JB/setup %}

###Cross compile ethtool 
./configure --host=arm-linux CC=/PATH/arm-xx-linux-gnueabi-gcc CPP=/PATH/arm-xxx-linux-gnueabi-cpp CXX=/PATH/arm-cortex-linux-gnueabi-g++ STRIP=/PATH/arm-xxx-linux-gnueabi-strip --prefix=/PATH/ethtool-6/distethtool

###Man page
man ./distethtool/ethtool.8

		ETHTOOL(8)

		NAME
		       ethtool - Display or change ethernet card settings
		
		SYNOPSIS
		       ethtool ethX
		
		       ethtool -h|--help
		
		       ethtool -a|--show-pause ethX
		
		       ethtool -A|--pause ethX [autoneg on|off] [rx on|off] [tx on|off]
		
		       ethtool -c|--show-coalesce ethX
		
		       ethtool -C|--coalesce ethX [adaptive-rx on|off] [adaptive-tx on|off] [rx-usecs N] [rx-frames N] [rx-usecs-irq N] [rx-frames-irq N] [tx-usecs N] [tx-frames N] [tx-usecs-irq N] [tx-
		       frames-irq N] [stats-block-usecs N] [pkt-rate-low N] [rx-usecs-low N] [rx-frames-low N] [tx-usecs-low N] [tx-frames-low N] [pkt-rate-high N] [rx-usecs-high N]  [rx-frames-high  N]
		       [tx-usecs-high N] [tx-frames-high N] [sample-interval N]
		
		       ethtool -g|--show-ring ethX
		
		       ethtool -G|--set-ring ethX [rx N] [rx-mini N] [rx-jumbo N] [tx N]
		
		       ethtool -i|--driver ethX
		
		       ethtool -d|--register-dump ethX [raw on|off] [hex on|off] [file name]
		
		       ethtool -e|--eeprom-dump ethX [raw on|off] [offset N] [length N]
		
		       ethtool -E|--change-eeprom ethX [magic N] [offset N] [value N]
		
		       ethtool -k|--show-offload ethX
		
		       ethtool -K--offload ethX [rx on|off] [tx on|off] [sg on|off] [tso on|off] [ufo on|off] [gso on|off]
		
		       ethtool -p|--blink ethX [N]
		
		       ethtool -r|--negotiate ethX
		
		       ethtool -S|--statistics ethX
		
		       ethtool -t|--test ethX [offline|online]
		
		       ethtool  -s  ethX  [speed 10|100|1000|2500]  [duplex half|full]  [port tp|aui|bnc|mii]  [autoneg on|off]  [advertise N] [phyad N] [xcvr internal|external] [wol p|u|m|b|a|g|s|d...]
		       [sopass xx:yy:zz:aa:bb:cc] [msglvl N]
		
		DESCRIPTION
		       ethtool is used for querying settings of an ethernet device and changing them.
		
		       ethX is the name of the ethernet device on which ethtool should operate.
		
		OPTIONS
		       ethtool with a single argument specifying the device name prints current settings of the specified device.
		
		       -h --help
		              Shows a short help message.
		
		       -a --show-pause
		              Queries the specified ethernet device for pause parameter information.
		
		       -A --pause
		              Changes the pause parameters of the specified ethernet device.
		
		       autoneg on|off
		              Specifies whether pause autonegotiation should be enabled.
		
		       rx on|off
		              Specifies whether RX pause should be enabled.
		
		       tx on|off
		              Specifies whether TX pause should be enabled.
		
		       -c --show-coalesce
		              Queries the specified ethernet device for coalescing information.
		
		       -C --coalesce
		              Changes the coalescing settings of the specified ethernet device.
		
		       -g --show-ring
		              Queries the specified ethernet device for rx/tx ring parameter information.
		
		       -G --set-ring
		              Changes the rx/tx ring parameters of the specified ethernet device.
		
		       rx N   Changes the number of ring entries for the Rx ring.
		
		       rx-mini N
		              Changes the number of ring entries for the Rx Mini ring.
		
		       rx-jumbo N
		              Changes the number of ring entries for the Rx Jumbo ring.
		
		       tx N   Changes the number of ring entries for the Tx ring.
		
		       -i --driver
		              Queries the specified ethernet device for associated driver information.
		
		       -d --register-dump
		              Retrieves and prints a register dump for the specified ethernet device.  The register format for some devices is known and decoded others are printed in hex.  When  raw  is
		              enabled, then ethtool dumps the raw register data to stdout.  If file is specified, then use contents of previous raw register dump, rather than reading from the device.
		
		       -e --eeprom-dump
		              Retrieves  and  prints an EEPROM dump for the specified ethernet device.  When raw is enabled, then it dumps the raw EEPROM data to stdout. The length and offset parameters
		              allow dumping certain portions of the EEPROM.  Default is to dump the entire EEPROM.
		
		       -E --change-eeprom
		              Changes EEPROM byte for the specified ethernet device.  offset and value specify which byte and it's new value.  Because of the persistent nature of writing to the  EEPROM,
		              a device-specific magic key must be specified to prevent the accidental writing to the EEPROM.
		
		       -k --show-offload
		              Queries the specified ethernet device for offload information.
		
		       -K --offload
		              Changes the offload parameters of the specified ethernet device.
		
		       rx on|off
		              Specifies whether RX checksumming should be enabled.
		
		       tx on|off
		              Specifies whether TX checksumming should be enabled.
		
		       sg on|off
		              Specifies whether scatter-gather should be enabled.
		
		       tso on|off
		              Specifies whether TCP segmentation offload should be enabled.
		
		       ufo on|off
		              Specifies whether UDP fragmentation offload should be enabled
		
		       gso on|off
		              Specifies whether generic segmentation offload should be enabled
		
		       -p --identify
		              Initiates adapter-specific action intended to enable an operator to easily identify the adapter by sight.  Typically this involves blinking one or more LEDs on the specific
		              ethernet port.
		
		       N      Length of time to perform phys-id, in seconds.
		
		       -r --negotiate
		              Restarts auto-negotiation on the specified ethernet device, if auto-negotiation is enabled.
		
		       -S --statistics
		              Queries the specified ethernet device for NIC- and driver-specific statistics.
		
		       -t --test
		              Executes adapter selftest on the specified ethernet device. Possible test modes are:
		
		       offline|online
		              defines test type: offline (default) means to perform full set of tests possibly causing normal operation interruption during the tests, online means to perform limited set
		              of tests do not interrupting normal adapter operation.
		
		       -s --change
		              Allows changing some or all settings of the specified ethernet device.  All following options only apply if -s was specified.
		
		       speed 10|100|1000|2500
		              Set speed in Mb/s.  ethtool with just the device name as an argument will show you the supported device speeds.
		
		       duplex half|full
		              Sets full or half duplex mode.
		
		       port tp|aui|bnc|mii
		              Selects device port.
		
		       autoneg on|off
		              Specifies  whether  autonegotiation should be enabled. Autonegotiation is enabled by deafult, but in some network devices may have trouble with it, so you can disable it if
		              really necessary.
		
		       advertise N
		              Sets the speed and duplex advertised by autonegotiation.  The argument is a hexidecimal value using one or a combination of the following values:
		              0x001    10 Half
		              0x002    10 Full
		              0x004    100 Half
		              0x008    100 Full
		              0x010    1000 Half(not supported by IEEE standards)
		              0x020    1000 Full
		              0x8000   2500 Full(not supported by IEEE standards)
		              0x800    10000 Full
		              0x03F    Auto
		
		       phyad N
		              PHY address.
		
		       xcvr internal|external
		              Selects transceiver type. Currently only internal and external can be specified, in the future further types might be added.
		
		       wol p|u|m|b|a|g|s|d...
		              Sets Wake-on-LAN options.  Not all devices support this.  The argument to this option is a string of characters specifying which options to enable.
		              p  Wake on phy activity
		              u  Wake on unicast messages
		              m  Wake on multicast messages
		              b  Wake on broadcast messages
		              a  Wake on ARP
		              g  Wake on MagicPacket(tm)
		              s  Enable SecureOn(tm) password for MagicPacket(tm)
		              d  Disable (wake on nothing).  This option clears all previous options.
		
		       sopass xx:yy:zz:aa:bb:cc
		              Sets the SecureOn(tm) password.  The argument to this option must be 6 bytes in ethernet MAC hex format (xx:yy:zz:aa:bb:cc).
		
		       msglvl N
		              Sets the driver message level. Meanings differ per driver.
		
		BUGS
		       Not supported (in part or whole) on all ethernet drivers.
		
		AUTHOR
		       ethtool was written by David Miller.
		
		       Modifications by Jeff Garzik, Tim Hockin, Jakub Jelinek, Andre Majorel, Eli Kupermann, Scott Feldman, Andi Kleen.
		
		AVAILABILITY
		       ethtool is available over the Web on the SourceForge site at http://sourceforge.net/projects/gkernel/
