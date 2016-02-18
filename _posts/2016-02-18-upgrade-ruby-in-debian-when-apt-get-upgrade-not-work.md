---
layout: post
title: "Upgrade ruby in debian when apt get upgrade not work"
description: ""
category: 
tags: []
---
{% include JB/setup %}


### 1. Install RVM

>$ curl -L get.rvm.io | bash -s stable

>$ source ~/.rvm/scripts/rvm


### 2. Query and install dependant packages

>$ rvm requirements

	Checking requirements for debian.
	Installing requirements for debian.
	Updating system..
	password required for 'apt-get --quiet --yes update': 
	..
	Installing required packages: libreadline6-dev, libssl-dev, libyaml-dev, libsqlite3-dev, sqlite3, libgdbm-dev, libffi-dev........
	Requirements installation successful.

### 3. Install specified Ruby version

> $ rvm install 1.9.3

	Searching for binary rubies, this might take some time.
	No binary rubies available for: debian/6/i386/ruby-2.2.1.
	Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
	Checking requirements for debian.
	Requirements installation successful.
	Installing Ruby from source to: /home/jason/.rvm/rubies/ruby-2.2.1, this may take a while depending on your cpu(s)...
	ruby-2.2.1 - #downloading ruby-2.2.1, this may take a while depending on your connection...
	  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
	                                 Dload  Upload   Total   Spent    Left  Speed
	100 12.7M  100 12.7M    0     0   967k      0  0:00:13  0:00:13 --:--:-- 1191k
	ruby-2.2.1 - #extracting ruby-2.2.1 to /home/jason/.rvm/src/ruby-2.2.1....
	ruby-2.2.1 - #applying patch /home/jason/.rvm/patches/ruby/2.2.1/fix_installing_bundled_gems.patch.
	ruby-2.2.1 - #configuring.........................................................
	ruby-2.2.1 - #post-configuration..
	ruby-2.2.1 - #compiling....................................................................................
	ruby-2.2.1 - #installing............................
	ruby-2.2.1 - #making binaries executable..
	ruby-2.2.1 - #downloading rubygems-2.4.8
	ruby-2.2.1 - #extracting rubygems-2.4.8.....
	ruby-2.2.1 - #removing old rubygems.........
	ruby-2.2.1 - #installing rubygems-2.4.8......................
	ruby-2.2.1 - #gemset created /home/jason/.rvm/gems/ruby-2.2.1@global
	ruby-2.2.1 - #importing gemset /home/jason/.rvm/gemsets/global.gems................................................
	ruby-2.2.1 - #generating global wrappers........
	ruby-2.2.1 - #gemset created /home/jason/.rvm/gems/ruby-2.2.1
	ruby-2.2.1 - #importing gemsetfile /home/jason/.rvm/gemsets/default.gems evaluated to empty gem list
	ruby-2.2.1 - #generating default wrappers........
	ruby-2.2.1 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
	Install of ruby-2.2.1 - #complete 
	Ruby was built without documentation, to build it run: rvm docs generate-ri

### 4. Testing

> ruby -v

	ruby 1.9.3p551 (2014-11-13 revision 48407) [i686-linux]


### 5. Appendix

***Notice:***

* Change a new source 

> gem source -r http://rubygems.org/;gem source -a http://ruby.aliyun.com

* Install Bundle and Rails

> $ gem install bundler rails

* Some IDE could not find ruby, the resolution is

> sudo cp -rf ~/.rvm/bin/ruby /usr/bin