#!/usr/bin/python
rom = open('FR.gba', 'rb')

file_index = -1
in_blank = False
blank_start = None
while byte := rom.read(1):
    file_index += 1
    # start of segment
    if not in_blank and byte==b'\x00':
        in_blank = True
        blank_start = file_index
    # end of segment
    if in_blank and byte!=b'\x00':
        in_blank = False
        size = file_index - blank_start
        if size >= 1024:
            print('0x'+hex(blank_start)+': '+str(size//1024)+'kb')
