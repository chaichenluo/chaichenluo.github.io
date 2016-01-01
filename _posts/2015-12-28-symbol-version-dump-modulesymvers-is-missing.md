---
layout: post
title: "Symbol version dump Module.symvers is missing"
description: ""
category: 
tags: []
---
{% include JB/setup %}

#####Symbol version dump Module.symvers is missing
I am trying to compile a driver that we have from source and I am working through the issues with a new target environment. One of the slightly disturbing things I see is the following warning:

>WARNING: Symbol version dump /usr/src/linux-2.6.38/Module.symvers is missing; modules will have no dependencies and modversions.

In Ubuntu the missing Module.symvers (symbol version dump) file is in the package named linux-headers-x.y.z; for example linux-headers-3.13.0-24-generic as can be found on packages.ubuntu.com 

#####File "wifiphisher.py", line 20, in <module> from scapy.all import *
sudo apt-get install python-scapy

