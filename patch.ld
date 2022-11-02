MEMORY
{
    INJECT_KEYS(rwx): ORIGIN = 0x080005fe, LENGTH = 12
    INJECT_CODE(rx): ORIGIN = 0x081f14d6, LENGTH = 5k
    ROM(rx): ORIGIN = 0x0871a2a0, LENGTH = 2m
    RAM(rw): ORIGIN = 0x030074b0, LENGTH = 1k
}

SECTIONS
{
    .text : 
    {
        _start = .;
        KEEP(*(.text*))
    } > INJECT_CODE

    .data :
    {
        *(.key_injection*)
    } > INJECT_KEYS

    .rodata :
    {
        *(.rodata*)
    } > ROM

    .bss (NOLOAD) : 
    {
        *(.bss*)
    } > RAM
}
