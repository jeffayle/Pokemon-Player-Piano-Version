PokemonPlayerPianoVersion.gba: FR.gba output_table output_button_inject output_code
	cp FR.gba PokemonPlayerPianoVersion.gba
	dd if=output_table of=PokemonPlayerPianoVersion.gba obs=1 seek=7447200 conv=notrunc
	dd if=output_button_inject of=PokemonPlayerPianoVersion.gba obs=1 seek=1534 conv=notrunc
	dd if=output_code of=PokemonPlayerPianoVersion.gba obs=1 seek=2036952 conv=notrunc

PokemonPlayerPianoVersion.ips: FR.gba output_table output_button_inject output_code make_patch.py
	./make_patch.py

clean:
	rm patch.elf
	rm output_table
	rm output_code
	rm inject.o
	rm read_table.o
	rm inputs.bin

patch.elf: inject.o read_table.o patch.ld
	arm-none-eabi-gcc -o patch.elf -mcpu=arm7tdmi -nostartfiles -mthumb -Wl,--script=patch.ld read_table.o inject.o 

output_table: patch.elf
	arm-none-eabi-objcopy -O binary -j .rodata patch.elf output_table

output_button_inject: patch.elf
	# why doesn't this work?
	#arm-none-eabi-objcopy -O binary -j .data patch.elf output_button_inject

output_code: patch.elf
	arm-none-eabi-objcopy -O binary -j .text patch.elf output_code

inject.o: inject.s inputs.bin
	arm-none-eabi-gcc -mcpu=arm7tdmi -nostartfiles -mthumb -c inject.s

read_table.o: read_table.c
	arm-none-eabi-gcc -mcpu=arm7tdmi -nostartfiles -mthumb -c read_table.c

inputs.bin: inputs.txt convert_inputs.py
	./convert_inputs.py
