.macro waitUntilInVBlank
-	lda PPUSTATUS.w
	bpl -
.endm

.macro waitUntilOutOfVBlank
-	lda PPUSTATUS.w
	bmi -
.endm

.macro dwbe
	.dw (\1>>8)|((\1&$ff)<<8)
.endm