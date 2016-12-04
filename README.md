# teensy

My experiments with Teensy 3.6 board.

Point here is to have Makefiles instead of having to use Arduino IDE.

teensyCore folder has everything needed to build teensy core object, which will be linked together with the application later.
~make clean removes every build output;
~make or make all builds ./lib/teensyCore.a.

blink folder is a test application that makes the board LED to blink in a loop. It uses teensyCore.a.
~make clean removes every build output;
~make or make all builds ./bin/teensyBlink.{elf,eep,hex};
~make install calls Teensy Loader application and uploads the hex to the board, once it is connected to the USB port.

