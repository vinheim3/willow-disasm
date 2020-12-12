.define PPUCTRL $2000
.define PPUMASK $2001
.define PPUSTATUS $2002
.define OAMADDR $2003
.define PPUSCROLL $2005
.define PPUADDR $2006
.define PPUDATA $2007

.define CHN_VOL $4000
.define CHN_SWEEP $4001
.define CHN_LO $4002
.define CHN_HI $4003
.define SWEEP_NEGATE $08

.define SQ1_VOL $4000
.define SQ1_SWEEP $4001
.define SQ1_LO $4002
.define SQ1_HI $4003
.define SQ2_VOL $4004
.define SQ2_SWEEP $4005
.define SQ2_LO $4006
.define SQ2_HI $4007
.define TRI_LINEAR $4008
.define TRI_LO $400a
.define TRI_HI $400b
.define NOISE_VOL $400c
.define NOISE_LO $400e
.define NOISE_HI $400f
.define DMC_FREQ $4010
.define DMC_RAW $4011
.define OAMDMA $4014
.define SND_CHN $4015
.define SNDENA_DMC $10
.define SNDENA_NOISE $08
.define SNDENA_TRI $04
.define SNDENA_SQ2 $02
.define SNDENA_SQ1 $01
.define JOY1 $4016
.define JOY2 $4017
.define FRAME_COUNTER_CTRL $4017

.define NAMETABLE0 $2000
.define NAMETABLE0_PAL $23c0
.define NAMETABLE1 $2400
.define NAMETABLE1_PAL $27c0
.define NAMETABLE2 $2800
.define NAMETABLE3 $2c00
.define INTERNAL_PALETTES $3f00

.define PADF_A $80
.define PADF_B $40
.define PADF_SELECT $20
.define PADF_START $10
.define PADF_UP $08
.define PADF_DOWN $04
.define PADF_LEFT $02
.define PADF_RIGHT $01

; MMC1
; shifting 5 times into $8000-$ffff,
; the 5th time, the address determines the control,
; and the bits shifted in determine the data
; $8000-$9fff - Control
.define MMC1_Control $9fff
; $a000-$bfff - Chr Bank 0
.define MMC1_ChrBank0 $bfff
; $c000-$dfff - Chr Bank 1
.define MMC1_ChrBank1 $dfff
; $e000-$ffff - Prg Bank
.define MMC1_PrgBank $efff
