#!/usr/bin/python
output = open('inputs.bin', 'wb')

for line in open('inputs.txt').readlines():
    data, = eval(line)
    keys = {
        'w': 0,
        'a': 1<<0,
        'b': 1<<1,
        'st': 1<<3,
        'r': 1<<4,
        'l': 1<<5,
        'u': 1<<6,
        'd': 1<<7,
        'ub': 1<<6 | 1<<1,
        'db': 1<<7 | 1<<1,
        'rb': 1<<4 | 1<<1,
        'lb': 1<<5 | 1<<1
    }[data[0]]
    length = data[1]

    output.write(bytes([ keys, 0, length%256, length//256 ]))
