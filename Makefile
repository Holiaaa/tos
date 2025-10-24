# TOS Makefile

CC	= i686-elf-gcc
LD 	= i686-elf-ld
AS	= nasm
QEMU = qemu-system-i386
CFLAGS = -m16 -ffreestanding -nostdlib -Iinclude
LDFLAGS = -m elf_i386 -Ttext 0x7E00 --oformat binary -e _start

SRCDIR = sources
BOOTLOADERDIR = bootloader
INCLUDEDIR = include
BUILDDIR = build

SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(patsubst $(SRCDIR)/%.c,$(BUILDDIR)/%.o,$(SOURCES))
OSBIN   = $(BUILDDIR)/os.bin
BOOTLOADER = $(BUILDDIR)/boot.bin
DISKIMG = $(BUILDDIR)/tos.img

all: $(BUILDDIR) $(BOOTLOADER) $(OSBIN) $(DISKIMG)

$(BUILDDIR):
	mkdir $(BUILDDIR)

$(BOOTLOADER):
	nasm -f bin $(BOOTLOADERDIR)/boot.asm -o $(BOOTLOADER)

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(OSBIN): $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJECTS) -o $(OSBIN)

$(DISKIMG): $(BOOTLOADER) $(OSBIN)
	dd if=$(BOOTLOADER) of=$(DISKIMG) bs=512 count=1 conv=notrunc
	cat $(OSBIN) >> $(DISKIMG)

clean:
	rm -rf $(BUILDDIR)

run:
	$(QEMU) -hda $(DISKIMG)
