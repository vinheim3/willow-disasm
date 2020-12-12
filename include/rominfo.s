.memorymap
	defaultslot 2

	slotsize $800
	slot 0 $0000

	slotsize $6000
	slot 1 $6000

	slotsize $4000
	slot 2 $8000

	slotsize $4000
	slot 3 $c000
.endme

.banksize $4000
.rombanks 8

.asciitable
	map "0" to "9" = $00
	map "<" = $28
	map ">" = $29
.enda

.background "original/OR.bin"
.unbackground 0*$4000+$0000 0*$4000+$3fdb
.unbackground 0*$4000+$3fe8 1*$4000+$3f3e
.unbackground 1*$4000+$3fe8 4*$4000+$3fd8
.unbackground 4*$4000+$3fe8 5*$4000+$3bd7
.unbackground 5*$4000+$3bfe 5*$4000+$3bff
.unbackground 5*$4000+$3fe8 6*$4000+$3bff
.unbackground 6*$4000+$3fe8 7*$4000+$2d40
.unbackground 7*$4000+$2da0 7*$4000+$2fab
.unbackground 7*$4000+$3000 7*$4000+$3fda
.unbackground 7*$4000+$3fe8 7*$4000+$3fff
