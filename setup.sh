#!/bin/sh

###
#
# Script to setup a development environment to Teensy 3.6, based on Makefiles
#   and GNU tools.
#
# Felipe Kühne, 12/05/2016
#
# Obvioulsy, this is totally free and open source.
#
##

# if not ran as sudo, exit
#if [ “$(id -u)” != “0” ]; then
#  echo This script must be run as root 2>&1
#  exit 1
#fi

PWD = $(shell pwd)

mkdir -p teeensy && cd teeensy
mkdir -p tools && cd tools

# Donwload cross compiling tools

#if [ `which wget` == 0 ]; then
#  wget https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2 -o gcc-arm-none-eabi.tar.bz2
#elif [ `which curl` == 0 ]; then
  curl https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q3-update/+download/gcc-arm-none-eabi-5_4-2016q3-20160926-mac.tar.bz2 -o gcc-arm-none-eabi.tar.bz2
#else
#  echo Please check if you have wget or curl in your system. 2>&1
#  exit 1
#fi

tar -jxvf gcc-arm-none-eabi-5_4-2016q3-20160926-linux.tar.bz2
rm -f gcc-arm-none-eabi-5_4-2016q3-20160926-mac.tar.bz2

# Download Teensy Core
cd $(PWD)/teeensy/
curl -L https://github.com/PaulStoffregen/cores/archive/master.zip -o teensyCore.zip
unzip teensyCore.zip
rm -f cores-master/teensy3/main.cpp

mv cores-master/teensy3/*.c
