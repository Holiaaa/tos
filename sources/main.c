#include "io.h"
#include "tos.h"

_start {
    change_graphic_mode(VIDEO_G_640x350_EGA_16COLORS_A0000);
    print("Hello organized OS!\nHow are you today ?", RED);

    for (;;) asm("hlt");
}
