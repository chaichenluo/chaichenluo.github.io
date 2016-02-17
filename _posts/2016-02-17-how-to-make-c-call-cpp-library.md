---
layout: post
title: "How to make C call CPP library"
description: ""
category: 
tags: []
---
{% include JB/setup %}


#### Make CPP library

> vi print.h

	#include <stdio.h>
	#include "one.h"	
	void print(void)
	{
	   cout<<"Hello world;
	}

> vi print.cpp

	#include <iostream>
	#include "print.h"
	
	using namespace std;
	
	void print(void)
	{
	   cout << "Hello world" << endl;
	}

> g++ -c print.cpp
> 
> ar -rcs libprint.a print.o

#### Make Middleware CPP library

> vi mid.h

	#ifndef __MID_H__
	#define __MID_H__
	
	#ifdef __cplusplus
	extern "C"
	{
	#endif
	
	  void print_mid();
	
	#ifdef __cplusplus
	}
	#endif
	
	#endif

> vi mid.cpp

	#include "print.h"
	#include "mid.h"
	
	extern "C"
	{
		void print_mid()
		{
			print();
		}
	}

> g++ -c mid.cpp
>
> ar -rcs libmid.a mid.o print.o
>
> or
> 
> ar -rcs libmid.a mid.o libprint.a  

#### Main C

> vi main.c

	#include "mid.h"
	int main()
	{
		print_mid();
		return 0;
	}

> gcc -o test main.c libmid.a -lstdc++
>
> or
> 
> gcc -o test main.c -L./ -lmid -lstdc++

#### Test

> ./test

	Hello world


#### Appendix

##### Compile error 1

	libmid.a(mid.o):(.eh_frame+0x12): undefined reference to `__gxx_personality_v0'
	libmid.a(print.o): In function `print()':
	print.cpp:(.text+0x11): undefined reference to `std::cout'
	print.cpp:(.text+0x16): undefined reference to `std::basic_ostream<char, std::char_traits<char> >& std::operator<< <std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&, char const*)'
	print.cpp:(.text+0x1e): undefined reference to `std::basic_ostream<char, std::char_traits<char> >& std::endl<char, std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&)'
	print.cpp:(.text+0x26): undefined reference to `std::basic_ostream<char, std::char_traits<char> >::operator<<(std::basic_ostream<char, std::char_traits<char> >& (*)(std::basic_ostream<char, std::char_traits<char> >&))'
	libmid.a(print.o): In function `__static_initialization_and_destruction_0(int, int)':
	print.cpp:(.text+0x49): undefined reference to `std::ios_base::Init::Init()'
	print.cpp:(.text+0x4e): undefined reference to `std::ios_base::Init::~Init()'
	libmid.a(print.o):(.eh_frame+0x12): undefined reference to `__gxx_personality_v0'
	collect2: ld returned 1 exit status


> Add -lstdc++ to the linkage arguments
>
> gcc -o test main.c libmid.a -lstdc++

#### Compile error 2

	/tmp/cciE7HSV.o: In function `main':
	main.c:(.text+0x7): undefined reference to `print'
	print.o: In function `print()':
	print.cpp:(.text+0x11): undefined reference to `std::cout'
	print.cpp:(.text+0x16): undefined reference to `std::basic_ostream<char, std::char_traits<char> >& std::operator<< <std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&, char const*)'
	print.cpp:(.text+0x1e): undefined reference to `std::basic_ostream<char, std::char_traits<char> >& std::endl<char, std::char_traits<char> >(std::basic_ostream<char, std::char_traits<char> >&)'
	print.cpp:(.text+0x26): undefined reference to `std::basic_ostream<char, std::char_traits<char> >::operator<<(std::basic_ostream<char, std::char_traits<char> >& (*)(std::basic_ostream<char, std::char_traits<char> >&))'
	print.o: In function `__static_initialization_and_destruction_0(int, int)':
	print.cpp:(.text+0x49): undefined reference to `std::ios_base::Init::Init()'
	print.cpp:(.text+0x4e): undefined reference to `std::ios_base::Init::~Init()'
	print.o:(.eh_frame+0x12): undefined reference to `__gxx_personality_v0'
	collect2: ld returned 1 exit status

> *gcc -o test main.c libprint.a* 
> 
> Main C Could not call the CPP library functions directly. You should add a middleware CPP library with "extern "C"".


#### Compile error 3

	In function `xxxx':
	xxxx.cpp:(.text+0xxx): undefined reference to `xxxx'

> Sometimes "ar -rcs libmid.a mid.o libprint.a" is not equal to "ar -rcs libmid.a mid.o print.o", it is prefer to use "ar -rcs libmid.a mid.o print.o" .
>
> But if just have libprint.a without the source code of print.c , then you could use this command to get the *.o files.
> 
> ar -x libprint.a