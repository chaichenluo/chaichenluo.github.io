---
layout: post
title: "DS HCHO Sensor"
description: ""
category: 
tags: []
---
{% include JB/setup %}


### Physical Pin Description

DS-HCHO pin 

	Pin    <==> Description
	1      <==> VCC (3.3V)
	2      <==> GND
	3      <==> RESET (Low is valid)
	4      <==> NULL
	5      <==> NULL
	6      <==> TX
	7      <==> RX

Connect DS-HCHO to USB2RS232+MA3321C

	DS-HCHO  <==> USB2RS232
	6(TX)    <==>  3 (RX)
	7(RX)    <==>  4 (TX)


### Protocol

#### Command format

	| BIT1  | BIT2   | BIT3    | BIT4 | BIT5  | BIT6   | BIT7   |
	|Start1 | Start2 | Command |DataH | DataL | CheckH | CheckL |
	| 0x42  | 0x4d   | CMD     | DHH  | DLL   | LRCH   | LRCL   | 

#### Command content

Host command:

	NO CMD     Identification
	1  Query   0x01
	2  clear   --
	3  SPAN    --
	4  Reset   --

Module response

	| BIT1  | BIT2   | BIT3    | BIT4 | BIT5  | |BIT6      | BIT7  | BIT8  | BIT9   | BIT10  |
	|Start1 | Start2 | Length  | Type | Unit  | Equivalent |DataH  | DataL | CheckH | CheckL |
	| 0x42  | 0x4d   | 0x08    | ID   | UNIT  | VH         |DHH    | DLL   | LRCH   |  LRCL  |

Unit definition

	data unit
	0x01 ppm
	0x02 VOL
	0x03 LEL
	0x04 Ppb
	0x05 Mg/m3

Equivalent definition

	data equivalent
	0x01 1
	0x02 10
	0x03 100
	0x04 1000