# Téo Operating System

TOS is a 16bit real mode operating system coded in C and Assembly.

## Build 
To build TOS you will need :
- i686-elf-toolchain
- nasm
- qemu
- gnu-utils (such as make, dd, cat...)

`make` : build the bootloader, os and the disk image

`make clean` : remove the build folder

`make run` : run in QEMU the disk image
