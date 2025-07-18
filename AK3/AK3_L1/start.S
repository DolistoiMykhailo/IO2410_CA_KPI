.syntax unified
.cpu cortex-m4
.thumb
.global vtable
.global reset_handler

.type vtable, %object
vtable:
    .word __stack_start      @ Початкова адреса стеку
    .word __hard_reset__+1   @ Вектор перезапуску (Thumb-режим)
    .size vtable, .-vtable

__hard_reset__:    
    ldr r0, =__stack_start   @ Ініціалізація стеку
    mov sp, r0
    b __hard_reset__         @ Безкінечний цикл (перезапуск)
