#include "io.h"
#include "tos.h"

_start {
    change_graphic_mode(VIDEO_G_640x350_EGA_16COLORS_A0000);
    uint8_t boot_disk = *(uint8_t *)BOOT_DISK_ADDR;

    print("TOS 1.0\n", WHITE);

    if (boot_disk >= 0x80) {
        print("Booting from HDD", WHITE);
    } else {
        print("Booting from a Floppy Disk", WHITE);
    }

    for (;;) asm("hlt");
}
