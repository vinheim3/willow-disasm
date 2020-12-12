.struct Oam
	Y       db
	tile    db
	attr    db
	X       db
.endst

.struct SoundChannel
	byte00   db
	byte01   db
	byte02   db
	byte03   db
	byte04   db
	byte05   db
	byte06   db
	byte07   db
	byte08   db
	byte09   db
	byte0a   db
	byte0b   db
	byte0c   db
	byte0d   db
	byte0e   db
	byte0f   db
	byte10   db
	freqLo   db ; $11
	freqHi   db ; $12
	byte13   db
	byte14   db
	byte15   db
	byte16   db
	byte17   db
	byte18   db
	byte19   db
	byte1a   db
	byte1b   db
	byte1c   db
	byte1d   db
	byte1e   db
.endst