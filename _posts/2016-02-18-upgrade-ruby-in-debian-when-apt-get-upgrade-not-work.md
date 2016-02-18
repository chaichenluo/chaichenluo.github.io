---
layout: post
title: "Upgrade ruby in debian when "apt get upgrade" not work"
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
	No binary rubies available for: debian/6/i386/ruby-1.9.3-p551.
	Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
	Checking requirements for debian.
	Requirements installation successful.
	Installing Ruby from source to: /home/jason/.rvm/rubies/ruby-1.9.3-p551, this may take a while depending on your cpu(s)...
	ruby-1.9.3-p551 - #downloading ruby-1.9.3-p551, this may take a while depending on your connection...
	  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
	                                 Dload  Upload   Total   Spent    Left  Speed
	100 9813k  100 9813k    0     0   915k      0  0:00:10  0:00:10 --:--:-- 1197k
	ruby-1.9.3-p551 - #extracting ruby-1.9.3-p551 to /home/jason/.rvm/src/ruby-1.9.3-p551....
	ruby-1.9.3-p551 - #applying patch /home/jason/.rvm/patches/ruby/GH-488.patch.
	ruby-1.9.3-p551 - #configuring..............................................
	ruby-1.9.3-p551 - #post-configuration..
	ruby-1.9.3-p551 - #compiling..
	..................................................................
	ruby-1.9.3-p551 - #installing........................
	ruby-1.9.3-p551 - #making binaries executable..
	ruby-1.9.3-p551 - #downloading rubygems-2.4.8
	  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
	                                 Dload  Upload   Total   Spent    Left  Speed
	100  437k  100  437k    0     0   199k      0  0:00:02  0:00:02 --:--:--  298k
	No checksum for downloaded archive, recording checksum in user configuration.
	ruby-1.9.3-p551 - #extracting rubygems-2.4.8....
	ruby-1.9.3-p551 - #removing old rubygems.........
	ruby-1.9.3-p551 - #installing rubygems-2.4.8......................
	ruby-1.9.3-p551 - #gemset created /home/jason/.rvm/gems/ruby-1.9.3-p551@global
	ruby-1.9.3-p551 - #importing gemset /home/jason/.rvm/gemsets/global.gems................................................
	ruby-1.9.3-p551 - #generating global wrappers........
	ruby-1.9.3-p551 - #gemset created /home/jason/.rvm/gems/ruby-1.9.3-p551
	ruby-1.9.3-p551 - #importing gemsetfile /home/jason/.rvm/gemsets/default.gems evaluated to empty gem list
	ruby-1.9.3-p551 - #generating default wrappers........
	ruby-1.9.3-p551 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
	Install of ruby-1.9.3-p551 - #complete 
	WARNING: Please be aware that you just installed a ruby that is no longer maintained (2014-02-23), for a list of maintained rubies visit:
	
	    http://bugs.ruby-lang.org/projects/ruby/wiki/ReleaseEngineering
	
	Please consider upgrading to ruby-2.2.1 which will have all of the latest security patches.
	Ruby was built without documentation, to build it run: rvm docs generate-ri

### 4. Testing

> ruby -v

	ruby 1.9.3p551 (2014-11-13 revision 48407) [i686-linux]


### 5. Appendix

*Notice:*

* Change a new source 

> gem source -r http://rubygems.org/;gem source -a http://ruby.aliyun.com

* Install Bundle and Rails

> $ gem install bundler rails

* Some IDE could not find ruby, the resolution is

> sudo cp -rf ~/.rvm/bin/ruby /usr/bin