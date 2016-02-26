---
layout: post
title: "Hello, arduino"
description: ""
category: 
tags: []
---
{% include JB/setup %}

### Equipment
* Arduino
* 0.96 OLED SSD1306
* Dupont Lines
* Micro USB line (Android phone charging line)

### Porcess

* Connect the arduino and 0.96 128x64 OLED

		Arduino <==> OLED
		13      <==> D0(CLK)
		11      <==> D1(MOSI)
		10      <==> CS
		9       <==> DC
		REST    <==> RST
		VCC     <==> VCC(2.8V~5.5V)
        GND     <==> GND

* Unzip the U8glib.zip to the libraries directory

* Open the example .\libraries\U8glib\examples\HelloWorld\HelloWorld.ino

* Uncomment the line for the device we used. here the IC is ssd1306, sceen is 0.96 inch.

		U8GLIB_SSD1306_128X64 u8g(13, 11, 10, 9);	// SW SPI Com: SCK = 13, MOSI = 11, CS = 10, A0 = 9
 
* Compile and upload

### Code

		#include "U8glib.h"
		U8GLIB_SSD1306_128X64 u8g(13, 11, 10, 9);	// SW SPI Com: SCK = 13, MOSI = 11, CS = 10, A0 = 9

		void draw(void) {
		  // graphic commands to redraw the complete screen should be placed here  
		  u8g.setFont(u8g_font_unifont);
		  //u8g.setFont(u8g_font_osb21);
		  u8g.drawStr( 0, 22, "Hello World!");
		
		  u8g.drawStr( 0, 44, "Hello Arduino!");
		}
		
		void setup(void) {
		  
		  // flip screen, if required
		  // u8g.setRot180();
		  
		  // set SPI backup if required
		  //u8g.setHardwareBackup(u8g_backup_avr_spi);
		
		  // assign default color value
		  if ( u8g.getMode() == U8G_MODE_R3G3B2 ) {
		    u8g.setColorIndex(255);     // white
		  }
		  else if ( u8g.getMode() == U8G_MODE_GRAY2BIT ) {
		    u8g.setColorIndex(3);         // max intensity
		  }
		  else if ( u8g.getMode() == U8G_MODE_BW ) {
		    u8g.setColorIndex(1);         // pixel on
		  }
		  else if ( u8g.getMode() == U8G_MODE_HICOLOR ) {
		    u8g.setHiColorByRGB(255,255,255);
		  }
		}
		
		void loop(void) {
		  // picture loop
		  u8g.firstPage();  
		  do {
		    draw();
		  } while( u8g.nextPage() );
		  
		  // rebuild the picture after some delay
		  delay(50);
		}