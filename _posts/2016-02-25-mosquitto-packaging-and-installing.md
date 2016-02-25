---
layout: post
title: "Mosquitto packaging and installing"
description: ""
category: 
tags: []
---
{% include JB/setup %}

### Making Mosquitto packages for Debian

#### Download and unpack the mosquitto source tarball:

>    wget http://mosquitto.org/files/source/mosquitto-1.1.2.tar.gz
>
>    tar -zxf mosquitto-1.1.2.tar.gz

#### Rename the tarball to match Debian requirements:

>    mv mosquitto-1.1.2.tar.gz mosquitto_1.1.2.orig.tar.gz

The current mosquitto packaging files are available at http://mentors.debian.net/debian/pool/main/m/mosquitto/ – you want the .debian.tar.gz:

>    wget http://mentors.debian.net/debian/pool/main/m/mosquitto/mosquitto_1.1.2-1.debian.tar.gz
>
>    tar -zxf mosquitto_1.1.2-1.debian.tar.gz -C mosquitto-1.1/

### Build the packag

you may find that you need to install some packages first:

>    sudo apt-get install build-essential python quilt libwrap0-dev libssl-dev devscripts python-setuptools

build the packages

>   cd mosquitto-1.1.2/
>
>    debuild

### Install the .deb package

You should now have a list of .deb files in the parent directory which you can install with:

>    sudo dpkg -i *.deb


### Install Mosquitto from Debian repository

#### Import the repository package signing key:

>    wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key
>
>    sudo apt-key add mosquitto-repo.gpg.key

#### Make the repository available to apt:

>    cd /etc/apt/sources.list.d/
>    
>    sudo wget http://repo.mosquitto.org/debian/mosquitto-wheezy.list
>    
>    apt-get update
>
>    apt-cache search mosquitto

#### Install:

>    apt-get install mosquitto


### Testing

>	mosquitto_sub -h test.mosquitto.org -t "sensor" -v

	sensor {"sensor_id": "sensor_2","measure_time": "2015-06-30,10:39:40","category": "strage",	"temperature": 35.599054180303284,"humidity": 98.678980836857434,"power": 15989,"is_dynamic": false}