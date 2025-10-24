:: this file build all the .c file into objects and link everything into a single binaries file that are going to be edited by the PS1 script.

@mkdir build -Force
@i686-elf-gcc -m16 -ffreestanding -nostdlib -Iinclude -c sources/main.c -o build/main.o
@i686-elf-gcc -m16 -ffreestanding -nostdlib -Iinclude -c sources/io.c -o build/io.o
@i686-elf-ld -Ttext 0x7C00 --oformat binary -e _start build/main.o build/io.o -o build/os.bin
@powershell scripts\make_bootimage.ps1

@qemu-system-i386 -fda build\final.bin
