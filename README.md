#GFX Tool

  The Adafruit GFX library has functions to display images and to use external fonts.
  Images can be drawn with 1-bit / pixel, 8-bits / pixel and 16-bits / pixel. The functions expect the image as a byte array in program memory. For the 16-bit color mode a conversion from usual 24-bit mode (8 bit red, 8 bit green and 8 bit blue) to the 16-bit mode (5 bits red, 6 bits green and 5 bits blue) is required. The GFX tool converts any image to one of the three modes and creates a C header file which can be direct included in a micro controller project. A special funktion in the GFX tool allows to split a stripe with multiple tiles with the same size into an array of image arrays.
  
