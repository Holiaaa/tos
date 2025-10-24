#include "io.h"

void print(const char* str, const uint8_t color) {
    for (int i = 0; i < MAX_PRINT; i++) {
        char c = str[i];
        if (!c) break;
        if (c == '\n') {
            asm volatile (
                "movb $0x0D, %%al\n"
                "movb $0x0E, %%ah\n"
                "int $0x10"
                :
                :
                : "ax"
            );

            asm volatile (
                "movb $0x0A, %%al\n"
                "movb $0x0E, %%ah\n"
                "int $0x10"
                :
                :
                : "ax"
            );

            continue;
        }
        asm volatile (
            "movb %0, %%al\n"
            "movb $0x0E, %%ah\n"
            "movb %1, %%bl\n"
            "int $0x10"
            :
            : "r"(c), "r"(color)
            : "ax", "bx"
        );
    }
}

void change_graphic_mode(uint8_t mode) {
    asm volatile (
        "movb $0x0, %%ah\n"
        "movb %0, %%al\n"
        "int $0x10"
        :
        : "r"(mode)
        : "ax"
    );
}
