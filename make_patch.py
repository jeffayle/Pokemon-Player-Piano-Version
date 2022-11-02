#!/usr/bin/python3

def be_integer(value, size=4):
    digits = []
    for _ in range(size):
        digits.append(value % 256)
        value >>= 8
    if value != 0:
        raise Exception("value does not fit in %d bytes"%size)
    digits.reverse()
    return bytes(digits)

def write_hunk(input_file, output_file, addr):
    while data := input_file.read(0xff):
        output_file.write(be_integer(addr,3))
        output_file.write(be_integer(len(data),2))
        output_file.write(data)
        addr += len(data)

outf = open('PokemonPlayerPianoVersion.ips', 'wb')
outf.write(b'PATCH')
write_hunk(open('output_button_inject', 'rb'), outf, 0x0005fe)
write_hunk(open('output_code', 'rb'), outf, 0x1f14d8)
write_hunk(open('output_table', 'rb'), outf, 0x71a2a0)
outf.write(b'EOF')
