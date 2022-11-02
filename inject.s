.section .key_injection
.thumb

    bl read_key_table
    add r3, r0, #0
    nop
    nop
    nop

.section .rodata

.global table
table:
    .incbin "inputs.bin"
