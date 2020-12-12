DEFINES = -D FULL_OCARINA_OPTIONS -D NO_FLASH -D INVINCIBLE -D FAST_TEXT -D FAST_MOVEMENT
DEFINES =

willow.bin: code/*
	wla-6502 ${DEFINES} -o game.o game.s
	wlalink -S linkfile willow.bin
	rm game.o

nes: willow.bin
	python tools/buildNes.py