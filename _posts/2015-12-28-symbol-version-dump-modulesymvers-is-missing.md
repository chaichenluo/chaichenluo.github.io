---
layout: post
title: "Symbol version dump Module.symvers is missing"
description: ""
category: 
tags: []
---
{% include JB/setup %}

#####I am trying to compile a driver that we have from source and I am working through the issues with a new target environment. One of the slightly disturbing things I see is the following warning:

>WARNING: Symbol version dump /usr/src/linux-2.6.38/Module.symvers is missing; modules will have no dependencies and modversions.

In Ubuntu the missing Module.symvers (symbol version dump) file is in the package named linux-headers-x.y.z; for example linux-headers-3.13.0-24-generic as can be found on packages.ubuntu.com 
