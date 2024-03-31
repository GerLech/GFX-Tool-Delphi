# GFX Tool

  The Adafruit GFX library has functions to display images and to use external fonts.  
+  Images can be drawn with 1-bit / pixel, 8-bits / pixel and 16-bits / pixel. The functions expect the image as a byte array in program memory. For the 16-bit color mode a conversion from usual 24-bit mode (8 bit red, 8 bit green and 8 bit blue) to the 16-bit mode (5 bits red, 6 bits green and 5 bits blue) is required. The GFX tool converts any image to one of the three modes and creates a C header file which can be direct included in a micro controller project. A special funktion in the GFX tool allows to split a stripe with multiple tiles with the same size into an array of image arrays.
+ Fonts have to be in a special format to be used with GFX library. The fonts delivered with the library have only the 7-bit ASCII characters. German umlauts for example dont exist. With the GFX tool you can add missing characters. It is also possible to create a new font from scratch. The output is a header file with the structure required by the library.
+ An other little tool helps you to create a color palette to be used in your project. The tool generates an header file which defines constants for colors in the 16-bit 565 format.
  
**For a more detailed descriptio see the [wiki](https://github.com/GerLech/GFX-Tool-Delphi/wiki).**

The release contains all required source files to build the application with the Delphi 11 community edition.  
If you want, you can also download installation files for [32-bit](https://github.com/GerLech/GFX-Tool-Delphi/raw/master/Win32/GFX_Tool32_Setup.exe) 
and [64-bit](https://github.com/GerLech/GFX-Tool-Delphi/raw/master/Win64/GFX_Tool64_Setup.exe)  Windows.  
