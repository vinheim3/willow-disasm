
begin:
; wait until 4 vblanks finished
	ldx #$04

--	waitUntilInVBlank
	waitUntilOutOfVBlank
	dex
	bne --

; init stack
	ldx #$ff
	txs

; clear hw regs
	inx
	stx PPUCTRL.w
	stx PPUMASK.w
	stx wPPUMask
	stx DMC_FREQ.w
	stx SND_CHN.w
	stx JOY1.w

; 5-step and inhibit irq
	lda #$c0
	sta FRAME_COUNTER_CTRL.w

; clear MMC1 chr and prg bank register states, and init control reg
	lda #$80
	sta MMC1_PrgBank.w
	sta MMC1_ChrBank0.w
	sta MMC1_ChrBank1.w
	jsr initMMC1ControlRegister

; clear display
	jsr fillNametables01With20h
	jsr clearNametables01Palettes

; clear wram
	ldx #$00
	txa
-	sta $100.w, x
	inx
	bne -

	jsr clearWramExceptStackAndOam
	jsr hideAllOam

; nmi on, bg at $1000
	lda #$90
	sta PPUCTRL.w
	sta wPPUCtrl

; ppu mask - show all
	lda #$1e
	sta wPPUMask
	sta PPUMASK.w

	lda #$01
	sta wRngVar2
	lda #$c3
	sta wRngVar1
	jmp begin2


.org $80

nmiVector:
	php
	pha
	tya
	pha
	txa
	pha
	lda wShouldWaitForMajorityNMIFuncsDone
	bne +

	jmp @afterMajorityNMIFuncsDone

; disable nmi while vector running
+	lda wPPUCtrl
	and #$7f
	sta wPPUCtrl
	sta PPUCTRL.w

; during vector, emphasize colours, and show only in left 8 pixels
	lda wPPUMask
	and #$e6
	sta PPUMASK.w

; oam dma transfer
	lda #$00
	sta OAMADDR.w
	lda #>wOam
	sta OAMDMA.w

; updatee internal palettes if needed
	lda wShouldUpdateInternalPalettes
	beq +
	jsr updateInternalPalettes
+
; rle struct source never from 0-page
	lda wRLEStructAddressToCopy+1
	beq +
	jsr updateFromRLEStruct
+
; process outstanding vram queue updates
	jsr updateFromVramQueue

; reset latch, update scroll and ppu mask
	lda PPUSTATUS.w
	lda wPPUScrollX
	sta PPUSCROLL.w
	lda wPPUScrollY
	sta PPUSCROLL.w
	lda wPPUMask
	sta PPUMASK.w

; majority nmi funcs done, inc counter and poll new inputs
	ldx #$00
	stx wShouldWaitForMajorityNMIFuncsDone
	inc wMajorNMIUpdatesCounter
	jsr pollInputs

; make sure nmi on, bg at $1000
	lda wPPUCtrl
	ora #$90
	sta wPPUCtrl
	sta PPUCTRL.w

; keep chr banks updated
	jsr updateChrBank0
	jsr updateChrBank1

@afterMajorityNMIFuncsDone:
; if in the middle of setting prg bank, don't update sound
; next prg bank change will do it
	lda wIsSettingPrgBank
	beq +

	inc wNeedsToUpdateSound
	jmp @done

+	jsr updateSound_todo

@done:
	pla
	tax
	pla
	tay
	pla
	plp
	rti


updateSound_todo:
	lda #:updateSound
	jsr setPrgBankA
	jsr updateSound

@checkNewSoundsToPlay:
	ldx wNumQueuedSounds
	beq @afterPlayingNewSounds

; play new sound if not $fd
	lda wQueuedSoundsToPlay.w-1, x
	cmp #$fe
	bcs +

	cmp #$fd
	bne +

; convert $fd to $8c
	ldy #$8c

+	jsr playSoundA
	dec wNumQueuedSounds
	bne @checkNewSoundsToPlay

@afterPlayingNewSounds:
B7_0115:		lda $d6			; a5 d6
B7_0117:		beq B7_0128 ; @done

B7_0119:		dec $d6			; c6 d6
B7_011b:		bne B7_0128 ; @done

B7_011d:		lda $d7			; a5 d7
B7_011f:		cmp #$09		; c9 09
B7_0121:		beq B7_0128 ; @done

B7_0123:		lda $d5			; a5 d5
B7_0125:		jsr func_7_04ab		; 20 ab c4

@done:
B7_0128:	lda wPrgBank
	jmp setPrgBankA


waitForMajorityOfNMIFuncsDone:
	lda #$01
	sta wShouldWaitForMajorityNMIFuncsDone
-	lda wShouldWaitForMajorityNMIFuncsDone
	bne -
	rts


waitForMajorityOfNMIFuncsDone_spr0HitScreen:
	jsr waitToFlipBGTableAfterSpr0Hit
	lda #$01
	sta wShouldWaitForMajorityNMIFuncsDone
	bne -


waitForAnumberOfMajorityOfNMIFuncsDone:
	sta wGenericCounter
-	jsr waitForMajorityOfNMIFuncsDone
	dec wGenericCounter
	bne -
	rts


waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen:
	sta wGenericCounter
-	jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen
	dec wGenericCounter
	bne -
	rts


setPPUMask_noSprites:
	lda wPPUMask
	and #$e7
	sta wPPUMask
	sta PPUMASK.w
	rts


setPPUMask_addShowAll:
	lda wPPUMask
	ora #$1e
	sta wPPUMask
	rts


setPPUCtrl_noNMI:
	lda wPPUCtrl
	and #$7f
	sta PPUCTRL.w
	sta wPPUCtrl
	rts


setPPUCtrl_addNMI_bgAt1000h:
	lda wPPUCtrl
	ora #$90
	sta wPPUCtrl
	sta PPUCTRL.w
	rts


safeSetDefaultPrgBankA:
	sta wDefaultPrgBank

safeSetPrgBankA:
	sta wPrgBank
	lda #$01
	sta wIsSettingPrgBank

; if we didn't update sound in nmi due to being in the middle
; of setting prg bank, update sound here
	lda wPrgBank
	jsr setPrgBankA
	lda wNeedsToUpdateSound
	beq +

	jsr updateSound_todo
	lda #$00
	sta wNeedsToUpdateSound

+	lda #$00
	sta wIsSettingPrgBank
	rts


safeRestoreDefaultPrgBank:
	lda wDefaultPrgBank
	jmp safeSetPrgBankA


; unused
func_7_019a:
; force changing new prg bank
	pha
	lda wIsSettingPrgBank
	beq +

	jsr clearAndInitMMC1ControlRegister
	lda #$00
	sta wIsSettingPrgBank

+	pla

setPrgBankA:
	sta MMC1_PrgBank.w
	lsr a
	sta MMC1_PrgBank.w
	lsr a
	sta MMC1_PrgBank.w
	lsr a
	sta MMC1_PrgBank.w
	lsr a
	sta MMC1_PrgBank.w
	rts


setInGameSprChrBank:
; $14 to $1b
	lda wSprPaletteSpecAndChrBank			; a5 50
	and #$0f
	clc
	adc #$14

set_wChrBank0:
	sta wChrBank0
	rts


updateChrBank0:
	lda wChrBank0
	sta MMC1_ChrBank0.w
	lsr a
	sta MMC1_ChrBank0.w
	lsr a
	sta MMC1_ChrBank0.w
	lsr a
	sta MMC1_ChrBank0.w
	lsr a
	sta MMC1_ChrBank0.w
	rts


set_wChrBank1:
	sta wChrBank1
	rts


updateChrBank1:
	lda wChrBank1
	sta MMC1_ChrBank1.w
	lsr a
	sta MMC1_ChrBank1.w
	lsr a
	sta MMC1_ChrBank1.w
	lsr a
	sta MMC1_ChrBank1.w
	lsr a
	sta MMC1_ChrBank1.w
	rts


clearAndInitMMC1ControlRegister:
	lda #$80
	sta MMC1_Control.w

; Switch 2 separate 1KB Chr Banks
; Fix last Prg bank at $c000, and $8000 is swappable bank
; Vertical mirroring
initMMC1ControlRegister:
	lda #$1e
	sta MMC1_Control.w
	lsr a
	sta MMC1_Control.w
	lsr a
	sta MMC1_Control.w
	lsr a
	sta MMC1_Control.w
	lsr a
	sta MMC1_Control.w
	rts


pollInputs:
; save old buttons pressed
	lda wJoy1ButtonsPressed
	sta wJoy1OldButtonsPressed
	lda wJoy2ButtonsPressed
	sta wJoy2OldButtonsPressed

; init reading
	ldx #$01
	stx JOY1.w
	dex
	stx JOY1.w

; start from joy 2
	inx

@readAllInputBits:
	ldy #$08
-	lda JOY1.w, x
; check if any of low 2 bits set
	sta wTempButtonPressed
	lsr a
	ora wTempButtonPressed
	lsr a
	rol wJoy1ButtonsPressed, x
	dey
	bne -

; get new button bits set
	lda wJoy1OldButtonsPressed, x
	eor #$ff
	and wJoy1ButtonsPressed, x
	sta wJoy1NewButtonsPressed, x

; repeat for joy 1
	dex
	bpl @readAllInputBits

	rts


jumpTable:
; generic word is addr of new addr to jump to
	asl a
	tay
	iny
	pla
	sta wGenericWord
	pla
	sta wGenericWord+1
	lda (wGenericWord), y
	sta wJumpAddr
	iny
	lda (wGenericWord), y
	sta wJumpAddr+1
	jmp (wJumpAddr)


clearWramExceptStackAndOam:
	ldx #$00
	txa
-	sta $00, x
	sta wEntitiesControlByte.w, x
	sta $0400, x
	sta $0500, x
	sta $0600.w, x
	sta $0700, x
	inx
	bne -
	rts


; unused?
B7_026a:		tsx				; ba 
; store the ret addr of the func that called
; the func that called this
B7_026b:		lda $0103, x	; bd 03 01
B7_026e:		sta $05			; 85 05
B7_0270:		lda $0104, x	; bd 04 01
B7_0273:		sta $06			; 85 06

; 1st 2 bytes after in $00/$01
B7_0275:		ldy #$01		; a0 01
B7_0277:		lda ($05), y	; b1 05
B7_0279:		sta $00			; 85 00
B7_027b:		iny				; c8 
B7_027c:		lda ($05), y	; b1 05
B7_027e:		sta $01			; 85 01

; set return addr to after those 2 bytes
B7_0280:		lda #$02		; a9 02
B7_0282:		clc				; 18 
B7_0283:		adc $05			; 65 05
B7_0285:		sta $0103, x	; 9d 03 01
B7_0288:		lda #$00		; a9 00
B7_028a:		adc $06			; 65 06
B7_028c:		sta $0104, x	; 9d 04 01
B7_028f:		rts				; 60 


clearNametables01Palettes:
	ldx #>NAMETABLE1_PAL

_clearNametable0XPalettes:
	jsr _clearNametablePalettes
	ldx #>NAMETABLE0_PAL

_clearNametablePalettes:
	lda PPUSTATUS.w
	stx PPUADDR.w
	lda #<NAMETABLE0_PAL
	sta PPUADDR.w

; clear the $40 bytes
	ldx #$40
-	lda #$00
	sta PPUDATA.w
	dex
	bne -
	rts


; unused
clearNametables02Palettes:
	ldx #$2b
	bne _clearNametable0XPalettes


fillNametables01With20h:
	ldx #>(NAMETABLE2-NAMETABLE0)
	ldy #$00
B7_02b5:		sta $10			; 85 10

; reset latch and set address
	lda PPUSTATUS.w		; ad 02 20
	lda #>NAMETABLE0		; a9 20
	sta PPUADDR.w		; 8d 06 20
	sty PPUADDR.w		; 8c 06 20

-	lda #$20
	sta PPUDATA.w
	dey
	bne -
B7_02ca:		inc $00			; e6 00
	dex
	bne -
	rts


vramQueueARowOfBlankTilesAtAY:
	ldx wNextVramQueueIdxToFillInFrom
	sta wVramQueue.w, x
	inx
	tya
	sta wVramQueue.w, x
	inx

; copy $20 bytes..
	lda #$20
	sta wVramQueue.w, x
	inx
	tay

; of $20 to vram queue
-	lda #$20
	sta wVramQueue.w, x
	inx
	dey
	bne -

	tya
	sta wVramQueue.w, x
	stx wNextVramQueueIdxToFillInFrom
	rts


; format is:
; word - big-endian ppu address dest
; byte - count byte. if bit 7 set, copy going down
; subsequent bytes - bytes to copy
updateFromVramQueue:
	lda PPUSTATUS.w
	ldx wNextVramQueueIdxToUpdateFrom

@nextVramQueueStruct:
	lda wVramQueue.w, x
	beq @done

	sta PPUADDR.w
	inx
	lda wVramQueue.w, x
	sta PPUADDR.w
	inx
	lda wVramQueue.w, x
	and #$7f
	tay
	lda wVramQueue.w, x
	bpl @copyAcross

; bit 7 set, copy going down
	lda wPPUCtrl
	ora #$04
	bne +

@copyAcross:
	lda wPPUCtrl
	and #$fb

; other bits is number of bytes to copy
+	sta PPUCTRL.w

; start copying bytes
	inx
-	lda wVramQueue.w, x
	sta PPUDATA.w
	inx
	dey
	bne -

	beq @nextVramQueueStruct

@done:
	stx wNextVramQueueIdxToUpdateFrom
	rts


; format is big-endian ppu addr dest
; followed by control byte
; bit 7 set means copy going down
; bit 6 set means copy 1 same byte
; if control byte is 0 after ignoring above 2 bits, copy $40 bytes
; ends when next ppu addr byte is $ff
updateFromRLEStruct:
; reset latch
	lda PPUSTATUS.w
	ldy #$00

	lda (wRLEStructAddressToCopy), y

@nextStructToCopy:
; set ppu address, push high byte to check if internal palettes later
	pha
	sta PPUADDR.w
	iny
	lda (wRLEStructAddressToCopy), y
	sta PPUADDR.w

; push control byte shifted left
	iny
	lda (wRLEStructAddressToCopy), y
	asl a
	pha

; bit 7 set of control byte, copy going down
	lda wPPUCtrl
	ora #$04
	bcs +
	and #$fb
+	sta PPUCTRL.w

; pull shifted control byte and shift again
	pla
	asl a
	php
	bcc @afterBit6Check

; if that bit 6 set, set bit 1
; later shifted to signal copying the same byte
	ora #$02
	iny

@afterBit6Check:
	plp
	clc
	bne +

; if that control byte is 0, sec to copy $40 bytes
	sec

+	ror a
	lsr a
	tax

; if orig bit 6 set, we're copying the same byte
@copyByte:
	bcs +
	iny
+	lda (wRLEStructAddressToCopy), y
	sta PPUDATA.w
	dex
	bne @copyByte

; if internal palettes, do dummy write
	pla
	cmp #>INTERNAL_PALETTES
	bne @afterInternalPalettesDummyWrite

	sta PPUADDR.w
	stx PPUADDR.w
	stx PPUADDR.w
	stx PPUADDR.w

@afterInternalPalettesDummyWrite:
; continue if next byte (ppu addr high byte) is not $ff
	iny
	lda (wRLEStructAddressToCopy), y
	bpl @nextStructToCopy

; signal no need to copy struct as never copying from 0-page
	lda #$00
	sta wRLEStructAddressToCopy+1
	rts


getOffsetOfLastScreenEntity_secIfFound:
	ldx #MAX_ENTITIES-1
	sec

-	lda wEntitiesControlByte.w, x
	bpl @done

	dex
	cpx #FIRST_SCREEN_ENTITY_IDX
	bcs -
@done:
	rts


clearAllEntities:
	ldx #MAX_ENTITIES-1
-	lda #$00
	sta wEntitiesControlByte.w, x
	dex
	bpl -
	rts


hideAllOam:
	lda #$f8
	ldx #$00
-	sta wOam.w, x
	inx
	inx
	inx
	inx
	bne -
	rts


getSwordSwingSpeed:
; process if bf between 4 and 7
B7_03ad:		lda $bf			; a5 bf
B7_03af:		cmp #$04		; c9 04
	bcc @done

; todo:
	cmp #$08
	bcs @done

; start with Y=2 (slowest swing) then down to 0
	lda wEquippedSword
	asl a
	tax
	ldy #$02

-	lda @agilityCheck.w, x
	cmp wCurrAgility
	bcs @setSpeed

	inx
	dey
	bne -

@setSpeed:
	sty wPlayerAnimationDelaySpeed

@done:
	rts

@agilityCheck:
	.db $00 $00
	.db $0a $19
	.db $28 $37
	.db $37 $46
	.db $55 $64
	.db $91 $a0
	.db $a0 $af
	.db $82 $91
	.db $af $be


drawPlayer:
	lda wPrgBank
	pha

	lda #:b4_drawPlayer
	jsr safeSetPrgBankA
	jsr b4_drawPlayer

	pla
	jmp safeSetPrgBankA


initNpcSpecAIdxX:
	sta wNewNpcSpecID
	stx wNewNpcIdx

	lda wPrgBank
	pha

	lda #:b5_initNPC
	jsr safeSetPrgBankA
	jsr b5_initNPC

	ldy wNewNpcPreservedY
	ldx wNewNpcIdx

	pla
	jmp safeSetPrgBankA


drawEntities:
	lda wPrgBank
	pha

	lda #:b4_drawEntities
	jsr safeSetPrgBankA
	jsr b4_drawEntities

	pla
	jmp safeSetPrgBankA


func_7_0412:
B7_0412:		lda #:func_6_33c3		; a9 06
B7_0414:		jsr safeSetPrgBankA		; 20 7a c1
B7_0417:		jmp func_6_33c3		; 4c c3 b3


loadAllScreenRowsForCurrRoom:
	jmp b6_loadAllScreenRowsForCurrRoom


func_7_041d:
B7_041d:		jmp func_7_1f0d		; 4c 0d df


; unused??
func_7_0420:
	jmp mainGameplayLoop


updateScreenEntities:
	lda #:b5_updateScreenEntities
	jsr safeSetPrgBankA
	jsr b5_updateScreenEntities
	jmp safeRestoreDefaultPrgBank


updateMagicEntities:
	lda #:b5_updateMagicEntities
	jsr safeSetPrgBankA
	jsr b5_updateMagicEntities
	jmp safeRestoreDefaultPrgBank


getCollisionValOfRoomTileY:
	lda wPrgBank
	pha

	lda wRoomY
	sta wTempRoomY
	jsr get16x16tileValue

	lda wMetatileTileAddr+1
	clc
	adc #>(roomGroupCollisionVals-metatileTileData_32to16)
	sta wMetatileCollisionAddr+1

	lda (wMetatileCollisionAddr), y
	sta wTileCollisionVal

	pla
	jmp safeSetPrgBankA


unsetGlobalFlag:
	jsr getGlobalFlagOffsetAndBitToCheck
	lda wGlobalFlagBitToCheck
	eor #$ff
	and wGlobalFlags.w, x
	sta wGlobalFlags.w, x
	rts


setGlobalFlag:
	jsr getGlobalFlagOffsetAndBitToCheck
	lda wGlobalFlags.w, x
	ora wGlobalFlagBitToCheck
	sta wGlobalFlags.w, x
	rts


checkGlobalFlag:
	jsr getGlobalFlagOffsetAndBitToCheck
	lda wGlobalFlags.w, x
	and wGlobalFlagBitToCheck
	rts


getGlobalFlagOffsetAndBitToCheck:
	ldx #$01
	stx wGlobalFlagBitToCheck
; from A, upper 5 bits in X - offset into global flags
; lower 3 bits in Y - times to shift 1 to get global flag bit offset
	pha
	lsr a
	lsr a
	lsr a
	tax
	pla
	and #$07
	tay
	beq @done

; here shift for bit to check
-	asl wGlobalFlagBitToCheck
	dey
	bne -

@done:
	rts


getNewRandomVal:
; store vars as word
	lda wRngVar1
	pha
	sta wGenericWord
	lda wRngVar2
	sta wGenericWord+1

; store word * 2
	asl wGenericWord
	rol wGenericWord+1
	clc

; low byte *= 3
	lda wGenericWord
	adc wRngVar1
	sta wRngVar1

; high byte *= 3
	lda wRngVar2
	adc wGenericWord+1
	sta wRngVar2

; word is now orig word * 6
; high byte += orig low byte
	pla
	clc
	adc wRngVar2
	sta wRngVar2
	rts


func_7_04ab:
B7_04ab:		sta $d7			; 85 d7

queueSoundAtoPlay:
	ldy wNumQueuedSounds
	cpy #$10
	bcs +

	sta wQueuedSoundsToPlay.w, y
	inc wNumQueuedSounds

+	rts


func_7_04b9:
B7_04b9:		sec				; 38 
B7_04ba:		ror $5d			; 66 5d
B7_04bc:		lda #$34		; a9 34
B7_04be:		ldy #$04		; a0 04
B7_04c0:		jsr func_7_059f		; 20 9f c5
B7_04c3:		rts				; 60 


func_7_04c4:
B7_04c4:		sec				; 38 
B7_04c5:		ror $5d			; 66 5d
B7_04c7:		ldy #$04		; a0 04
B7_04c9:		jsr func_7_054f		; 20 4f c5
B7_04cc:		rts				; 60 


updateInternalPalettes:
	ldx #$00
	stx wShouldUpdateInternalPalettes

; reset latch and start populating internal palettes
	lda PPUSTATUS.w
	lda #>INTERNAL_PALETTES
	sta PPUADDR.w
	stx PPUADDR.w

; fill from wram
	ldy #$20
-	lda wInternalPalettes.w, x
	sta PPUDATA.w
	inx
	dey
	bne -

; dummy write
	lda #>INTERNAL_PALETTES
	sta PPUADDR.w
	sty PPUADDR.w
	sty PPUADDR.w
	sty PPUADDR.w
	rts


B7_04f7:		lda #$15		; a9 15
B7_04f9:		sta $0c			; 85 0c
B7_04fb:		lda #$0f		; a9 0f
B7_04fd:		sta $0d			; 85 0d
B7_04ff:		lda #$10		; a9 10
B7_0501:		tax				; aa 
B7_0502:		sta $0f			; 85 0f
B7_0504:		stx $0b			; 86 0b
B7_0506:		sty $0e			; 84 0e
B7_0508:		jmp func_7_066b		; 4c 6b c6


B7_050b:		lda #$15		; a9 15
B7_050d:		sta $0c			; 85 0c
B7_050f:		lda #$13		; a9 13
B7_0511:		sta $0d			; 85 0d
B7_0513:		lda #$10		; a9 10
B7_0515:		tax				; aa 
B7_0516:		sta $0f			; 85 0f
B7_0518:		stx $0b			; 86 0b
B7_051a:		sty $0e			; 84 0e
B7_051c:		jmp func_7_066b		; 4c 6b c6


B7_051f:		sty $0e			; 84 0e
B7_0521:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_0524:		lda #$15		; a9 15
B7_0526:		sta $0c			; 85 0c
B7_0528:		lda #$0f		; a9 0f
B7_052a:		sta $0d			; 85 0d
B7_052c:		lda #$30		; a9 30
B7_052e:		ldx #$f0		; a2 f0
B7_0530:		sta $0f			; 85 0f
B7_0532:		stx $0b			; 86 0b
B7_0534:		jmp func_7_066b		; 4c 6b c6


B7_0537:		sty $0e			; 84 0e
B7_0539:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_053c:		lda #$15		; a9 15
B7_053e:		sta $0c			; 85 0c
B7_0540:		lda #$13		; a9 13
B7_0542:		sta $0d			; 85 0d
B7_0544:		lda #$30		; a9 30
B7_0546:		ldx #$f0		; a2 f0
B7_0548:		sta $0f			; 85 0f
B7_054a:		stx $0b			; 86 0b
B7_054c:		jmp func_7_066b		; 4c 6b c6


func_7_054f:
B7_054f:		lda #$01		; a9 01
B7_0551:		sta $0c			; 85 0c
B7_0553:		lda #$ff		; a9 ff
B7_0555:		sta $0d			; 85 0d
B7_0557:		lda #$10		; a9 10
B7_0559:		tax				; aa 
B7_055a:		sta $0f			; 85 0f
B7_055c:		stx $0b			; 86 0b
B7_055e:		sty $0e			; 84 0e
B7_0560:		jmp func_7_066b		; 4c 6b c6


B7_0563:		lda #$07		; a9 07
B7_0565:		sta $0c			; 85 0c
B7_0567:		lda #$03		; a9 03
B7_0569:		sta $0d			; 85 0d
B7_056b:		lda #$10		; a9 10
B7_056d:		tax				; aa 
B7_056e:		sta $0f			; 85 0f
B7_0570:		stx $0b			; 86 0b
B7_0572:		sty $0e			; 84 0e
B7_0574:		jmp func_7_066b		; 4c 6b c6


B7_0577:		lda #$0b		; a9 0b
B7_0579:		sta $0c			; 85 0c
B7_057b:		lda #$07		; a9 07
B7_057d:		sta $0d			; 85 0d
B7_057f:		lda #$10		; a9 10
B7_0581:		tax				; aa 
B7_0582:		sta $0f			; 85 0f
B7_0584:		stx $0b			; 86 0b
B7_0586:		sty $0e			; 84 0e
B7_0588:		jmp func_7_066b		; 4c 6b c6


B7_058b:		lda #$0f		; a9 0f
B7_058d:		sta $0c			; 85 0c
B7_058f:		lda #$0b		; a9 0b
B7_0591:		sta $0d			; 85 0d
B7_0593:		lda #$10		; a9 10
B7_0595:		tax				; aa 
B7_0596:		sta $0f			; 85 0f
B7_0598:		stx $0b			; 86 0b
B7_059a:		sty $0e			; 84 0e
B7_059c:		jmp func_7_066b		; 4c 6b c6


func_7_059f:
B7_059f:		sty $0e			; 84 0e
B7_05a1:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_05a4:		lda #$01		; a9 01
B7_05a6:		sta $0c			; 85 0c
B7_05a8:		lda #$ff		; a9 ff
B7_05aa:		sta $0d			; 85 0d
B7_05ac:		lda #$30		; a9 30
B7_05ae:		ldx #$f0		; a2 f0
B7_05b0:		sta $0f			; 85 0f
B7_05b2:		stx $0b			; 86 0b
B7_05b4:		jmp func_7_066b		; 4c 6b c6


B7_05b7:		sty $0e			; 84 0e
B7_05b9:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_05bc:		lda #$07		; a9 07
B7_05be:		sta $0c			; 85 0c
B7_05c0:		lda #$03		; a9 03
B7_05c2:		sta $0d			; 85 0d
B7_05c4:		lda #$30		; a9 30
B7_05c6:		ldx #$f0		; a2 f0
B7_05c8:		sta $0f			; 85 0f
B7_05ca:		stx $0b			; 86 0b
B7_05cc:		jmp func_7_066b		; 4c 6b c6


func_7_05cf:
B7_05cf:		sty $0e			; 84 0e
B7_05d1:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_05d4:		lda #$0b		; a9 0b
B7_05d6:		sta $0c			; 85 0c
B7_05d8:		lda #$07		; a9 07
B7_05da:		sta $0d			; 85 0d
B7_05dc:		lda #$30		; a9 30
B7_05de:		ldx #$f0		; a2 f0
B7_05e0:		sta $0f			; 85 0f
B7_05e2:		stx $0b			; 86 0b
B7_05e4:		jmp func_7_066b		; 4c 6b c6


func_7_05e7:
B7_05e7:		sty wInternalPaletteFramesBetweenEachFade			; 84 0e
B7_05e9:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_05ec:		lda #$0f		; a9 0f
B7_05ee:		sta wInternalPaletteLastIdxToFade			; 85 0c
B7_05f0:		lda #$0b		; a9 0b
B7_05f2:		sta wInternalPalette1stIdxMinus1toFade			; 85 0d
B7_05f4:		lda #$30		; a9 30
B7_05f6:		ldx #$f0		; a2 f0
B7_05f8:		sta wInternalPaletteInitialFadeVal			; 85 0f
B7_05fa:		stx wInternalPaletteValToAddToFade			; 86 0b
B7_05fc:		jmp func_7_066b		; 4c 6b c6


palettesBGFadeOut_saveSpecADelayY:
	sty wInternalPaletteFramesBetweenEachFade
	jsr updateSavedInternalPalettesFromSpecA

; fade out bg specified Y delay
	lda #$10
	sta wInternalPaletteLastIdxToFade
	lda #$ff
	sta wInternalPalette1stIdxMinus1toFade
	bne palettesPreSpecifiedRangeFadeOutDelayY

palettesBGFadeOut:
; bg range
	lda #$10
	sta wInternalPaletteLastIdxToFade
	lda #$ff
	sta wInternalPalette1stIdxMinus1toFade

; start at $10, slight fade, inc $10 for fade out
	lda #$10
	tax
	bne paletteFadeStartingAIncingXDelayY

palettesSprFadeOut:
B7_061b:		lda $5d			; a5 5d
B7_061d:		ora #$40		; 09 40
B7_061f:		sta $5d			; 85 5d

; fade out sprites
	lda #$1f
	sta wInternalPaletteLastIdxToFade
	lda #$0f
	sta wInternalPalette1stIdxMinus1toFade
	lda #$10
	tax
	bne paletteFadeStartingAIncingXDelayY


; A is palette spec to use
paletteSpecAFadeIn:
	sty wInternalPaletteFramesBetweenEachFade
	jsr update_wInternalPalettesFromSpecA
	jmp +


func_7_0636:
B7_0636:		sty wInternalPaletteFramesBetweenEachFade			; 84 0e
B7_0638:		jsr updateSavedInternalPalettesFromSpecA		; 20 b0 c6

+
; fade all palettes
	lda #$1f
	sta wInternalPaletteLastIdxToFade
	lda #$ff
	sta wInternalPalette1stIdxMinus1toFade

palettesPreSpecifiedRangeFadeOutDelayY:
; start with everything dark, then subtract -$10 each time
; to gradually get bright
	lda #$30
	ldx #$f0
	sta wInternalPaletteInitialFadeVal
	stx wInternalPaletteValToAddToFade
	bne loopUntilPaletteFadeComplete


palettesAllFadeOutDelayY:
; fade all palettes
	lda #$1f
	sta wInternalPaletteLastIdxToFade
	lda #$ff
	sta wInternalPalette1stIdxMinus1toFade

; start with everything slightly faded, then add $10 each tiem
; to fade slightly more until all black
	lda #$10
	tax

paletteFadeStartingAIncingXDelayY:
	sta wInternalPaletteInitialFadeVal
	stx wInternalPaletteValToAddToFade
	sty wInternalPaletteFramesBetweenEachFade

loopUntilPaletteFadeComplete:
; update from correct spr chr palette idx
	lda wSprPaletteSpecAndChrBank
	lsr a
	lsr a
	lsr a
	lsr a
	clc
	adc #$10

B7_0667:		bit $5d			; 24 5d
	bvs +

func_7_066b:
B7_066b:		lda wInternalPalettesSpecIdx			; a5 2e
+	jsr update_wInternalPalettesFromSpecA		; 20 b2 c6

; fade all palettes by specified amount
	ldy wInternalPaletteLastIdxToFade
-	lda wInternalPalettes.w, y
	sec
	sbc wInternalPaletteInitialFadeVal
	bpl +

; set for specified range
	lda #$0f
+	sta wInternalPalettes.w, y
	dey
	cpy wInternalPalette1stIdxMinus1toFade
	bne -

; wait a number of frames
B7_0684:		lda wInternalPaletteFramesBetweenEachFade			; a5 0e
@loop:
B7_0686:		pha				; 48 
B7_0687:		bit $5d			; 24 5d
	bpl +

B7_068b:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
	jmp @next

+	jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1

@next:
	pla
	sec
	sbc #$01
B7_0698:		bne B7_0686 ; @loop

; add onto fade value for next palette levels
	lda wInternalPaletteInitialFadeVal
	clc
	adc wInternalPaletteValToAddToFade
	sta wInternalPaletteInitialFadeVal

; if palette past the highest or lowest vals, stop fading
	cmp #$50
	beq +

	bit wInternalPaletteInitialFadeVal
	bpl loopUntilPaletteFadeComplete ; 10 b5

+	lda #$00		; a9 00
B7_06ab:		sta $5d			; 85 5d
B7_06ad:		rts				; 60 


update_wInternalPalettesFromSavedPaletteIdx:
	lda wSavedInternalPalettesSpecIdx

updateSavedInternalPalettesFromSpecA:
	sta wSavedInternalPalettesSpecIdx

update_wInternalPalettesFromSpecA:
	sta wInternalPalettesSpecIdx
	tax
	lda internalPaletteSpecs_lo.w, x
	sta wInternalPaletteSpecAddr
	lda internalPaletteSpecs_hi.w, x
	sta wInternalPaletteSpecAddr+1

; 1st byte is starting idx to copy to internal palettes
	ldy #$00
	lda (wInternalPaletteSpecAddr), y
	tax

; copy to internal palettes ram, until bit 7 encountered
-	iny
	lda (wInternalPaletteSpecAddr), y
	bmi @done

	sta wInternalPalettes.w, x
	inx
	bne -

@done:
	sty wShouldUpdateInternalPalettes
	rts


.include "data/internalPalettes.s"


waitToFlipBGTableAfterSpr0Hit:
; wait for pre-render scanline
-	bit PPUSTATUS.w
	bvs -

; wait for sprite 0 hit
-	bit PPUSTATUS.w
	bvc -

; flip which table bg uses
	lda wPPUCtrl
	eor #$10
	sta PPUCTRL.w
	rts


func_7_11b6:
B7_11b6:		lda #$a0		; a9 a0
B7_11b8:		sta wOam.Y.w		; 8d 00 02

func_7_11bb:
B7_11bb:		lda #$20		; a9 20
B7_11bd:		sta wOam.tile.w		; 8d 01 02
B7_11c0:		lda #$22		; a9 22
B7_11c2:		sta wOam.attr.w		; 8d 02 02
B7_11c5:		lda #$f8		; a9 f8
B7_11c7:		sta wOam.X.w		; 8d 03 02
B7_11ca:		rts				; 60 


B7_11cb:		.db $00				; 00
B7_11cc:		ora ($02, x)	; 01 02
B7_11ce:	.db $03
B7_11cf:	.db $04
B7_11d0:		ora $06			; 05 06
B7_11d2:	.db $07
B7_11d3:		php				; 08 
B7_11d4:		ora #$0a		; 09 0a
B7_11d6:	.db $0b
B7_11d7:	.db $0c
B7_11d8:		ora $0f0e		; 0d 0e 0f
B7_11db:		.db $00				; 00
B7_11dc:		ora ($02, x)	; 01 02
B7_11de:	.db $03
B7_11df:	.db $04
B7_11e0:		ora $06			; 05 06
B7_11e2:	.db $07
B7_11e3:		php				; 08 
B7_11e4:		ora #$0a		; 09 0a
B7_11e6:	.db $0b
B7_11e7:	.db $0c
B7_11e8:		ora $0f0e		; 0d 0e 0f


levelAgility:
	.db $0a $19 $28 $37
	.db $46 $55 $64 $73
	.db $82 $91 $a0 $af
	.db $be $cd $dc $eb


levelMaxHealth:
	.db $18 $2e $48 $60
	.db $78 $84 $90 $9c
	.db $a8 $b4 $c0 $da
	.db $e4 $ea $ee $f0


levelMaxMP:
	.db $11 $22 $33 $44
	.db $55 $66 $77 $88
	.db $99 $aa $bb $cc
	.db $dd $ee $f3 $ff


levelExpReqs:
	.db $00 $00 $01 $05 $00
	.db $00 $00 $03 $00 $00
	.db $00 $00 $07 $01 $00
	.db $00 $02 $00 $00 $00
	.db $00 $03 $09 $05 $00
	.db $00 $06 $02 $03 $00
	.db $00 $09 $01 $06 $00
	.db $01 $02 $05 $08 $00
	.db $01 $07 $01 $06 $00
	.db $02 $02 $08 $07 $00
	.db $02 $09 $06 $02 $00
	.db $03 $09 $03 $04 $00
	.db $05 $03 $03 $03 $00
	.db $07 $02 $06 $01 $00
	.db $09 $09 $09 $09 $00
	.db $09 $09 $09 $09 $00


weaponStrength:
B7_126b:		.db $00				; 00
B7_126c:		asl $14			; 06 14
B7_126e:		asl $0128, x	; 1e 28 01
B7_1271:	.db $5a
B7_1272:	.db $3a
B7_1273:	.db $43
B7_1274:		.db $00				; 00
B7_1275:		asl $0f			; 06 0f
B7_1277:		ora $3223, y	; 19 23 32
B7_127a:	.db $3c
B7_127b:	.db $4b
B7_127c:		bvc B7_127e ; 50 00

B7_127e:		php				; 08 
B7_127f:		php				; 08 
B7_1280:		php				; 08 
B7_1281:	.db $04
B7_1282:	.db $04
B7_1283:		.db $00				; 00
B7_1284:		.db $00				; 00
B7_1285:		.db $00				; 00
B7_1286:		.db $00				; 00
B7_1287:		.db $00				; 00
B7_1288:		.db $00				; 00
B7_1289:		bpl B7_129b ; 10 10

B7_128b:	.db $04
B7_128c:		.db $00				; 00
B7_128d:		.db $00				; 00
B7_128e:		.db $00				; 00
B7_128f:		.db $00				; 00
B7_1290:		.db $00				; 00
B7_1291:		.db $00				; 00
B7_1292:		.db $00				; 00
B7_1293:		.db $00				; 00
B7_1294:		.db $00				; 00
B7_1295:		asl a			; 0a
B7_1296:		asl a			; 0a
B7_1297:		asl a			; 0a
B7_1298:		asl a			; 0a
B7_1299:		asl a			; 0a
B7_129a:		asl a			; 0a
B7_129b:		asl a			; 0a
B7_129c:		asl a			; 0a
B7_129d:		asl a			; 0a
B7_129e:	.db $14
B7_129f:	.db $14
B7_12a0:	.db $14
B7_12a1:		.db $00				; 00
B7_12a2:		asl a			; 0a
B7_12a3:		.db $00				; 00
B7_12a4:		.db $00				; 00
B7_12a5:	.db $14
B7_12a6:		.db $00				; 00
B7_12a7:		.db $00				; 00
B7_12a8:		.db $00				; 00
B7_12a9:		.db $00				; 00
B7_12aa:		.db $00				; 00
B7_12ab:		.db $00				; 00
B7_12ac:		asl $06			; 06 06
B7_12ae:	.db $02
B7_12af:	.db $02
B7_12b0:	.db $02
B7_12b1:		.db $00				; 00
B7_12b2:		.db $00				; 00
B7_12b3:		.db $00				; 00
B7_12b4:		.db $00				; 00
B7_12b5:		.db $00				; 00
B7_12b6:		.db $00				; 00
B7_12b7:		.db $00				; 00
B7_12b8:		.db $00				; 00
B7_12b9:		.db $00				; 00
B7_12ba:		.db $00				; 00
B7_12bb:		.db $00				; 00
B7_12bc:		.db $00				; 00
B7_12bd:		.db $00				; 00
B7_12be:		.db $00				; 00
B7_12bf:		.db $00				; 00
B7_12c0:		.db $00				; 00
B7_12c1:		.db $00				; 00
B7_12c2:		.db $00				; 00
B7_12c3:		.db $00				; 00
B7_12c4:		.db $00				; 00
B7_12c5:		.db $00				; 00
B7_12c6:		.db $00				; 00
B7_12c7:		.db $00				; 00
B7_12c8:		.db $00				; 00
B7_12c9:		.db $00				; 00
B7_12ca:		.db $00				; 00
B7_12cb:		.db $00				; 00
B7_12cc:		.db $00				; 00
B7_12cd:		.db $00				; 00
B7_12ce:		.db $00				; 00
B7_12cf:		.db $00				; 00
B7_12d0:		.db $00				; 00
B7_12d1:		.db $00				; 00
B7_12d2:		.db $00				; 00
B7_12d3:		.db $00				; 00
B7_12d4:	.db $0c
B7_12d5:	.db $0c
B7_12d6:	.db $1e $00 $00
B7_12d9:		.db $00				; 00
B7_12da:		.db $00				; 00
B7_12db:		.db $00				; 00
B7_12dc:		.db $00				; 00
B7_12dd:		.db $00				; 00
B7_12de:		.db $00				; 00
B7_12df:		.db $00				; 00
B7_12e0:		asl a			; 0a
B7_12e1:		asl a			; 0a
B7_12e2:		php				; 08 
B7_12e3:		php				; 08 
B7_12e4:		.db $00				; 00
B7_12e5:		.db $00				; 00
B7_12e6:		.db $00				; 00
B7_12e7:		asl a			; 0a
B7_12e8:		asl a			; 0a
B7_12e9:		asl a			; 0a
B7_12ea:		asl a			; 0a
B7_12eb:		asl a			; 0a
B7_12ec:		.db $00				; 00
B7_12ed:		.db $00				; 00
B7_12ee:		.db $00				; 00
B7_12ef:		asl a			; 0a
B7_12f0:		asl a			; 0a
B7_12f1:		asl a			; 0a
B7_12f2:		.db $00				; 00
B7_12f3:		asl a			; 0a
B7_12f4:		asl a			; 0a
B7_12f5:		asl a			; 0a
B7_12f6:		asl a			; 0a
B7_12f7:		.db $00				; 00
B7_12f8:		asl a			; 0a
B7_12f9:		.db $00				; 00
B7_12fa:		bpl B7_131a ; 10 1e

B7_12fc:		lsr $46			; 46 46
B7_12fe:		lsr $46			; 46 46
B7_1300:		lsr $24			; 46 24
B7_1302:		bit $24			; 24 24
B7_1304:		.db $00				; 00
B7_1305:		.db $00				; 00
B7_1306:		asl a			; 0a
B7_1307:		asl a			; 0a
B7_1308:		lsr $1e			; 46 1e
B7_130a:		asl a			; 0a
B7_130b:	.db $1e $00 $00
B7_130e:		ora $05			; 05 05
B7_1310:		ora $01			; 05 01
B7_1312:		ora ($00, x)	; 01 00
B7_1314:		.db $00				; 00
B7_1315:		.db $00				; 00
B7_1316:		.db $00				; 00
B7_1317:		.db $00				; 00
B7_1318:		.db $00				; 00
B7_1319:	.db $02
B7_131a:	.db $02
B7_131b:		ora ($00, x)	; 01 00
B7_131d:		.db $00				; 00
B7_131e:		.db $00				; 00
B7_131f:		.db $00				; 00
B7_1320:		.db $00				; 00
B7_1321:		.db $00				; 00
B7_1322:		.db $00				; 00
B7_1323:		.db $00				; 00
B7_1324:		.db $00				; 00
B7_1325:		asl a			; 0a
B7_1326:		asl a			; 0a
B7_1327:		asl a			; 0a
B7_1328:		asl a			; 0a
B7_1329:		asl a			; 0a
B7_132a:		asl a			; 0a
B7_132b:		.db $00				; 00
B7_132c:		.db $00				; 00
B7_132d:		.db $00				; 00
B7_132e:		asl a			; 0a
B7_132f:		asl a			; 0a
B7_1330:		asl a			; 0a
B7_1331:		.db $00				; 00
B7_1332:		ora $00			; 05 00
B7_1334:		.db $00				; 00
B7_1335:		.db $00				; 00
B7_1336:		.db $00				; 00
B7_1337:		.db $00				; 00
B7_1338:		.db $00				; 00
B7_1339:		.db $00				; 00
B7_133a:		.db $00				; 00
B7_133b:		.db $00				; 00
B7_133c:	.db $02
B7_133d:	.db $02
B7_133e:		ora ($01, x)	; 01 01
B7_1340:		.db $00				; 00
B7_1341:		.db $00				; 00
B7_1342:		.db $00				; 00
B7_1343:		.db $00				; 00
B7_1344:		.db $00				; 00
B7_1345:		.db $00				; 00
B7_1346:		.db $00				; 00
B7_1347:		.db $00				; 00
B7_1348:		.db $00				; 00
B7_1349:		.db $00				; 00
B7_134a:		.db $00				; 00
B7_134b:		.db $00				; 00
B7_134c:		.db $00				; 00
B7_134d:		.db $00				; 00
B7_134e:		.db $00				; 00
B7_134f:		.db $00				; 00
B7_1350:		.db $00				; 00
B7_1351:		.db $00				; 00
B7_1352:		.db $00				; 00
B7_1353:		.db $00				; 00
B7_1354:		.db $00				; 00
B7_1355:		.db $00				; 00
B7_1356:		.db $00				; 00
B7_1357:		.db $00				; 00
B7_1358:		.db $00				; 00
B7_1359:		.db $00				; 00
B7_135a:		.db $00				; 00
B7_135b:		.db $00				; 00
B7_135c:		.db $00				; 00
B7_135d:		.db $00				; 00
B7_135e:		.db $00				; 00
B7_135f:		.db $00				; 00
B7_1360:		.db $00				; 00
B7_1361:		.db $00				; 00
B7_1362:		.db $00				; 00
B7_1363:		.db $00				; 00
B7_1364:	.db $02
B7_1365:	.db $02
B7_1366:		ora ($00, x)	; 01 00
B7_1368:		.db $00				; 00
B7_1369:		.db $00				; 00
B7_136a:		.db $00				; 00
B7_136b:		.db $00				; 00
B7_136c:		.db $00				; 00
B7_136d:		.db $00				; 00
B7_136e:		.db $00				; 00
B7_136f:		.db $00				; 00
B7_1370:	.db $02
B7_1371:		.db $00				; 00
B7_1372:		.db $00				; 00
B7_1373:		.db $00				; 00
B7_1374:		.db $00				; 00
B7_1375:		.db $00				; 00
B7_1376:	.db $14
B7_1377:	.db $02
B7_1378:	.db $02
B7_1379:		php				; 08 
B7_137a:	.db $03
B7_137b:	.db $03
B7_137c:		.db $00				; 00
B7_137d:		.db $00				; 00
B7_137e:		.db $00				; 00
B7_137f:		php				; 08 
B7_1380:		php				; 08 
B7_1381:		php				; 08 
B7_1382:		.db $00				; 00
B7_1383:		php				; 08 
B7_1384:		php				; 08 
B7_1385:		php				; 08 
B7_1386:		php				; 08 
B7_1387:		.db $00				; 00
B7_1388:		lsr $00			; 46 00
B7_138a:		.db $00				; 00
B7_138b:		.db $00				; 00
B7_138c:	.db $20 $20 $00
B7_138f:	.db $f4
B7_1390:		.db $00				; 00
B7_1391:		iny				; c8 
B7_1392:		iny				; c8 
B7_1393:		.db $00				; 00
B7_1394:		.db $00				; 00
B7_1395:		.db $00				; 00
B7_1396:		.db $00				; 00
B7_1397:		.db $00				; 00
B7_1398:		.db $00				; 00
B7_1399:		.db $00				; 00
B7_139a:		.db $00				; 00
B7_139b:		.db $00				; 00
B7_139c:		.db $00				; 00
B7_139d:		.db $00				; 00
B7_139e:		.db $00				; 00
B7_139f:		.db $00				; 00
B7_13a0:		.db $00				; 00
B7_13a1:		.db $00				; 00
B7_13a2:		.db $00				; 00
B7_13a3:		.db $00				; 00
B7_13a4:		.db $00				; 00
B7_13a5:		.db $00				; 00
B7_13a6:		.db $00				; 00
B7_13a7:		.db $00				; 00
B7_13a8:		.db $00				; 00
B7_13a9:		.db $00				; 00
B7_13aa:		.db $00				; 00
B7_13ab:		.db $00				; 00
B7_13ac:		.db $00				; 00


func_7_13ad:
B7_13ad:		lda #$07		; a9 07
B7_13af:		sta $02			; 85 02
B7_13b1:		lda #$08		; a9 08
B7_13b3:		sta $03			; 85 03
B7_13b5:		lda wPlayerY			; a5 cc
B7_13b7:		sta $04			; 85 04
B7_13b9:		lda wPlayerX			; a5 ce
B7_13bb:		sta $05			; 85 05
B7_13bd:		jsr $d8c4		; 20 c4 d8
B7_13c0:		bcs B7_1430 ; b0 6e

B7_13c2:		lda wEntitiesId.w, x	; bd 18 03
B7_13c5:		cmp #$7a		; c9 7a
B7_13c7:		beq B7_13d4 ; f0 0b

B7_13c9:		cmp #$87		; c9 87
B7_13cb:		beq B7_13e2 ; f0 15

B7_13cd:		cmp #$90		; c9 90
B7_13cf:		bcc B7_13f0 ; 90 1f

B7_13d1:		jmp $d4a9		; 4c a9 d4

B7_13d4:		lda #$00		; a9 00
B7_13d6:		sta wEntitiesControlByte.w, x	; 9d 00 03
B7_13d9:		lda wEntities_348.w, x	; bd 48 03
B7_13dc:		clc				; 18 
B7_13dd:		adc $76			; 65 76
B7_13df:		sta wMPGiven			; 85 76
B7_13e1:		rts				; 60 

B7_13e2:		lda #$00		; a9 00
B7_13e4:		sta wEntitiesControlByte.w, x	; 9d 00 03
B7_13e7:		lda wEntities_348.w, x	; bd 48 03
B7_13ea:		clc				; 18 
B7_13eb:		adc wHealthGiven			; 65 77
B7_13ed:		sta wHealthGiven			; 85 77
B7_13ef:		rts				; 60 

B7_13f0:		lda wEntitiesControlByte.w, x	; bd 00 03
B7_13f3:		and #$02		; 29 02
B7_13f5:		beq B7_143b ; f0 44

B7_13f7:		lda $bf			; a5 bf
B7_13f9:		cmp #$02		; c9 02
B7_13fb:		bcc B7_143b ; 90 3e

B7_13fd:		cmp #$04		; c9 04
B7_13ff:		bcs B7_143b ; b0 3a

B7_1401:		lda wEntities_408.w, x	; bd 08 04
B7_1404:		ldy $c9			; a4 c9
B7_1406:		cpy #$02		; c0 02
B7_1408:		bne B7_140d ; d0 03

B7_140a:		clc				; 18 
B7_140b:		adc #$08		; 69 08
B7_140d:		and #$1f		; 29 1f
B7_140f:		cmp $d4cf, y	; d9 cf d4
B7_1412:		bcc B7_143b ; 90 27

B7_1414:		cmp $d4d3, y	; d9 d3 d4
B7_1417:		bcs B7_143b ; b0 22

B7_1419:		ldy wEntitiesId.w, x	; bc 18 03
B7_141c:		lda $d27d, y	; b9 7d d2
B7_141f:		sec				; 38 
B7_1420:		sbc $b4			; e5 b4
B7_1422:		beq B7_1426 ; f0 02

B7_1424:		bcs B7_1431 ; b0 0b

B7_1426:		lda #$00		; a9 00
B7_1428:		sta wEntitiesControlByte.w, x	; 9d 00 03
B7_142b:		lda #$22		; a9 22
B7_142d:		jsr queueSoundAtoPlay		; 20 ad c4
B7_1430:		rts				; 60 

B7_1431:		pha				; 48 
B7_1432:		lda #$23		; a9 23
B7_1434:		jsr queueSoundAtoPlay		; 20 ad c4
B7_1437:		pla				; 68 
B7_1438:		jmp B7_1470		; 4c 70 d4

B7_143b:		lda wEntitiesId.w, x	; bd 18 03
B7_143e:		beq B7_1499 ; f0 59

B7_1440:		cmp #$0c		; c9 0c
B7_1442:		beq B7_144c ; f0 08

B7_1444:		cmp #$0d		; c9 0d
B7_1446:		beq B7_144c ; f0 04

B7_1448:		cmp #$2f		; c9 2f
B7_144a:		bne B7_1451 ; d0 05

B7_144c:		lda #$02		; a9 02
B7_144e:		sta wEntitiesState.w, x	; 9d f0 03
B7_1451:		lda #$20		; a9 20
B7_1453:		jsr queueSoundAtoPlay		; 20 ad c4
B7_1456:		lda wEntityDataByte1			; a5 51
B7_1458:		and #$18		; 29 18
B7_145a:		beq B7_146a ; f0 0e

B7_145c:		ldy #$0a		; a0 0a
B7_145e:		and #$10		; 29 10
B7_1460:		beq B7_1464 ; f0 02

B7_1462:		ldy #$14		; a0 14
B7_1464:		tya				; 98 
B7_1465:		clc				; 18 
B7_1466:		adc wHealthTaken			; 65 79
B7_1468:		sta wHealthTaken			; 85 79
B7_146a:		ldy wEntitiesId.w, x	; bc 18 03
B7_146d:		lda $d27d, y	; b9 7d d2

B7_1470:		clc				; 18 
B7_1471:		adc wHealthTaken			; 65 79
B7_1473:		sta wHealthTaken			; 85 79
B7_1475:		sta $86			; 85 86
B7_1477:		lda wCurrHealth			; a5 7b
B7_1479:		sec				; 38 
B7_147a:		sbc $79			; e5 79
B7_147c:		beq B7_1480 ; f0 02

B7_147e:		bcs B7_1487 ; b0 07

B7_1480:		lda $c0			; a5 c0
B7_1482:		ora #$04		; 09 04
B7_1484:		sta $c0			; 85 c0
B7_1486:		rts				; 60 

B7_1487:		lda wEntities_408.w, x	; bd 08 04
B7_148a:		clc				; 18 
B7_148b:		adc #$04		; 69 04
B7_148d:		and #$1f		; 29 1f
B7_148f:		lsr a			; 4a
B7_1490:		lsr a			; 4a
B7_1491:		lsr a			; 4a
B7_1492:		sta wPlayerDirection			; 85 c3
B7_1494:		lda #$24		; a9 24
B7_1496:		sta wPlayerKnockbackCounter			; 85 c7
B7_1498:		rts				; 60 


B7_1499:		lda $bf			; a5 bf
B7_149b:		cmp #$09		; c9 09
B7_149d:		beq B7_14a4 ; f0 05

B7_149f:		lda #$03		; a9 03
B7_14a1:		sta $55			; 85 55
B7_14a3:		rts				; 60 


B7_14a4:		bit wEntityDataByte2			; 24 52
B7_14a6:		bmi B7_149f ; 30 f7

B7_14a8:		rts				; 60 


B7_14a9:		bit $56			; 24 56
B7_14ab:		bmi B7_14a4 ; 30 f7

B7_14ad:		lda #$80		; a9 80
B7_14af:		sta $56			; 85 56
B7_14b1:		lda wTempPlayerY			; a5 ca
B7_14b3:		sta wPlayerY			; 85 cc
B7_14b5:		lda wTempPlayerX			; a5 cb
B7_14b7:		sta wPlayerX			; 85 ce
B7_14b9:		jmp func_7_0412		; 4c 12 c4


B7_14bc:		lda wEntities_408.w, x	; bd 08 04
B7_14bf:		and #$1f		; 29 1f
B7_14c1:		cmp $d4cf, y	; d9 cf d4
B7_14c4:		bcc B7_14cd ; 90 07

B7_14c6:		cmp $d4d3, y	; d9 d3 d4
B7_14c9:		bcs B7_14cd ; b0 02

B7_14cb:		sec				; 38 
B7_14cc:		rts				; 60 


B7_14cd:		clc				; 18 
B7_14ce:		rts				; 60 


B7_14cf:		ora #$11		; 09 11
B7_14d1:		ora ($01, x)	; 01 01
B7_14d3:		clc				; 18 
B7_14d4:		jsr $1010		; 20 10 10
B7_14d7:		lda $f2			; a5 f2
B7_14d9:		and #$20		; 29 20
B7_14db:		beq B7_14de ; f0 01

B7_14dd:		rts				; 60 


B7_14de:		bit $f2			; 24 f2
B7_14e0:		bmi B7_14e8 ; 30 06

B7_14e2:		bvc B7_14e7 ; 50 03

B7_14e4:		jmp $d5ca		; 4c ca d5


B7_14e7:		rts				; 60 


B7_14e8:		lda #$04		; a9 04
B7_14ea:		sta $02			; 85 02
B7_14ec:		sta $03			; 85 03
B7_14ee:		lda $f0			; a5 f0
B7_14f0:		sta $04			; 85 04
B7_14f2:		lda $f1			; a5 f1
B7_14f4:		sta $05			; 85 05
B7_14f6:		jsr $d8c4		; 20 c4 d8
B7_14f9:		bcs B7_14e7 ; b0 ec

B7_14fb:		lda wEntitiesId.w, x	; bd 18 03
B7_14fe:		cmp #$7a		; c9 7a
B7_1500:		beq B7_1509 ; f0 07

B7_1502:		cmp #$87		; c9 87
B7_1504:		bne B7_150c ; d0 06

B7_1506:		jmp $d3e2		; 4c e2 d3


B7_1509:		jmp $d3d4		; 4c d4 d3


B7_150c:		cmp #$01		; c9 01
B7_150e:		beq B7_1518 ; f0 08

B7_1510:		cmp #$02		; c9 02
B7_1512:		beq B7_1518 ; f0 04

B7_1514:		cmp #$03		; c9 03
B7_1516:		bne B7_1539 ; d0 21

B7_1518:		lda wEntities_438.w, x	; bd 38 04
B7_151b:		cmp #$04		; c9 04
B7_151d:		beq B7_1539 ; f0 1a

B7_151f:		lda wEntitiesControlByte.w, x	; bd 00 03
B7_1522:		and #$40		; 29 40
B7_1524:		asl a			; 0a
B7_1525:		asl a			; 0a
B7_1526:		adc wEntitiesId.w, x	; 7d 18 03
B7_1529:		tay				; a8 
B7_152a:		lda $d543, y	; b9 43 d5
B7_152d:		cmp $c9			; c5 c9
B7_152f:		bne B7_1539 ; d0 08

B7_1531:		lda #$22		; a9 22
B7_1533:		jsr queueSoundAtoPlay		; 20 ad c4
B7_1536:		jmp $d5bc		; 4c bc d5


B7_1539:		lda wEntities_3c0.w, x	; bd c0 03
B7_153c:		bpl B7_1548 ; 10 0a

B7_153e:		lda #$22		; a9 22
B7_1540:		jsr queueSoundAtoPlay		; 20 ad c4
B7_1543:		rts				; 60 


B7_1544:		.db $00				; 00
B7_1545:	.db $02
B7_1546:		ora ($03, x)	; 01 03
B7_1548:		lda wEntities_348.w, x	; bd 48 03
B7_154b:		sec				; 38 
B7_154c:		sbc $b3			; e5 b3
B7_154e:		sta wEntities_348.w, x	; 9d 48 03
B7_1551:		beq B7_1555 ; f0 02

B7_1553:		bcs B7_15a4 ; b0 4f

B7_1555:		lda $d4			; a5 d4
B7_1557:		beq B7_1568 ; f0 0f

B7_1559:		dec $d4			; c6 d4
B7_155b:		bne B7_1565 ; d0 08

B7_155d:		lda wEntities_348.w, x	; bd 48 03
B7_1560:		bne B7_1565 ; d0 03

B7_1562:		dec wEntities_348.w, x	; de 48 03
B7_1565:		jmp $d5a4		; 4c a4 d5


B7_1568:		lda $f8			; a5 f8
B7_156a:		beq B7_1573 ; f0 07

B7_156c:		cpx #$17		; e0 17
B7_156e:		bne B7_1573 ; d0 03

B7_1570:		jmp $d5e5		; 4c e5 d5


B7_1573:		lda wEntityDataByte1			; a5 51
B7_1575:		and #$18		; 29 18
B7_1577:		beq B7_1585 ; f0 0c

B7_1579:		ldy #$01		; a0 01
B7_157b:		and #$10		; 29 10
B7_157d:		beq B7_1581 ; f0 02

B7_157f:		ldy #$02		; a0 02
B7_1581:		tya				; 98 
B7_1582:		jsr $d5d9		; 20 d9 d5
B7_1585:		ldy wEntitiesId.w, x	; bc 18 03
B7_1588:		lda $d30d, y	; b9 0d d3
B7_158b:		jsr $d5d9		; 20 d9 d5
B7_158e:		lda wEntitiesId.w, x	; bd 18 03
B7_1591:		sta wEntities_3a8.w, x	; 9d a8 03
B7_1594:		ldy wEntities_360.w, x	; bc 60 03
B7_1597:		lda wMajorNMIUpdatesCounter			; a5 23
B7_1599:		cmp #$65		; c9 65
B7_159b:		bne B7_159f ; d0 02

B7_159d:		ldy #$5e		; a0 5e
B7_159f:		tya				; 98 
B7_15a0:		jsr initNpcSpecAIdxX		; 20 ec c3
B7_15a3:		rts				; 60 


B7_15a4:		lda $f8			; a5 f8
B7_15a6:		beq B7_15b7 ; f0 0f

B7_15a8:		sta wEntities_3a8.w, x	; 9d a8 03
B7_15ab:		cmp #$03		; c9 03
B7_15ad:		bne B7_15b7 ; d0 08

B7_15af:		lda wEntities_3c0.w, x	; bd c0 03
B7_15b2:		ora #$20		; 09 20
B7_15b4:		sta wEntities_3c0.w, x	; 9d c0 03
B7_15b7:		lda #$21		; a9 21
B7_15b9:		jsr queueSoundAtoPlay		; 20 ad c4
B7_15bc:		lda #$07		; a9 07
B7_15be:		sta wEntities_420.w, x	; 9d 20 04
B7_15c1:		lda $c9			; a5 c9
B7_15c3:		asl a			; 0a
B7_15c4:		asl a			; 0a
B7_15c5:		asl a			; 0a
B7_15c6:		sta wEntities_3d8.w, x	; 9d d8 03
B7_15c9:		rts				; 60 


B7_15ca:		ldy $c9			; a4 c9
B7_15cc:		lda $d8bc, y	; b9 bc d8
B7_15cf:		sta $02			; 85 02
B7_15d1:		lda $d8c0, y	; b9 c0 d8
B7_15d4:		sta $03			; 85 03
B7_15d6:		jmp $d4ee		; 4c ee d4


B7_15d9:		clc				; 18 
B7_15da:		adc $74			; 65 74
B7_15dc:		sta $74			; 85 74
B7_15de:		lda $75			; a5 75
B7_15e0:		adc #$00		; 69 00
B7_15e2:		sta $75			; 85 75
B7_15e4:		rts				; 60 


B7_15e5:		lda $f8			; a5 f8
B7_15e7:		cmp #$02		; c9 02
B7_15e9:		bne B7_15f5 ; d0 0a

B7_15eb:		lda wItemGlobalFlags0.w		; ad 07 06
B7_15ee:		and #$40		; 29 40
B7_15f0:		bne B7_15f5 ; d0 03

B7_15f2:		jmp $d5a4		; 4c a4 d5


B7_15f5:		lda wEntitiesControlByte.w, x	; bd 00 03
B7_15f8:		and #$f8		; 29 f8
B7_15fa:		sta wEntitiesControlByte.w, x	; 9d 00 03
B7_15fd:		lda #$00		; a9 00
B7_15ff:		sta wEntities_348.w, x	; 9d 48 03
B7_1602:		ldy wEntitiesId.w, x	; bc 18 03
B7_1605:		lda $d30d, y	; b9 0d d3
B7_1608:		clc				; 18 
B7_1609:		adc $74			; 65 74
B7_160b:		sta $74			; 85 74
B7_160d:		lda $75			; a5 75
B7_160f:		adc #$00		; 69 00
B7_1611:		clc				; 18 
B7_1612:		adc $f9			; 65 f9
B7_1614:		sta $75			; 85 75
B7_1616:		lda $f8			; a5 f8
B7_1618:		ora #$80		; 09 80
B7_161a:		sta $f8			; 85 f8
B7_161c:		and #$7f		; 29 7f
B7_161e:		cmp #$03		; c9 03
B7_1620:		beq B7_1627 ; f0 05

B7_1622:		cmp #$04		; c9 04
B7_1624:		beq B7_1627 ; f0 01

B7_1626:		rts				; 60 


B7_1627:		lda wEntities_360.w, x	; bd 60 03
B7_162a:		jsr initNpcSpecAIdxX		; 20 ec c3
B7_162d:		rts				; 60 


B7_162e:		lda wEquippedMagic			; a5 b8
B7_1630:		and #$7f		; 29 7f
B7_1632:		cmp #$08		; c9 08
	bcs @stub

	jsr jumpTable
	.dw @stub
	.dw func_7_16d7
	.dw func_7_1697
	.dw func_7_164a
	.dw func_7_16b7
	.dw func_7_177d
	.dw func_7_171a
	.dw func_7_17c2

@stub:
	rts


func_7_164a:
B7_164a:		bit $b2			; 24 b2
B7_164c:		bmi B7_1673 ; 30 25

B7_164e:		txa				; 8a 
B7_164f:		pha				; 48 
B7_1650:		ldy $b2			; a4 b2
B7_1652:		lda $d67f, y	; b9 7f d6
B7_1655:		sta wSprPaletteSpecAndChrBank			; 85 50
B7_1657:		lda $d68f, y	; b9 8f d6
B7_165a:		sta $51			; 85 51
B7_165c:		cpy #$04		; c0 04
B7_165e:		beq B7_1664 ; f0 04

B7_1660:		cpy #$05		; c0 05
B7_1662:		bne B7_1668 ; d0 04

B7_1664:		lda #$15		; a9 15
B7_1666:		sta wEntityDataByte2			; 85 52
B7_1668:		jsr setInGameSprChrBank		; 20 bb c1
B7_166b:		lda $b2			; a5 b2
B7_166d:		ora #$80		; 09 80
B7_166f:		sta $b2			; 85 b2
B7_1671:		pla				; 68 
B7_1672:		tax				; aa 
B7_1673:		lda $b2			; a5 b2
B7_1675:		and #$7f		; 29 7f
B7_1677:		tay				; a8 
B7_1678:		lda $d687, y	; b9 87 d6
B7_167b:		jsr initNpcSpecAIdxX		; 20 ec c3
B7_167e:		rts				; 60 


B7_167f:		dec $00, x		; d6 00
B7_1681:	.db $22
B7_1682:		ora ($73), y	; 11 73
B7_1684:	.db $c3
B7_1685:	.db $80
B7_1686:	.db $82
B7_1687:		.db $70 $bf

B7_1689:	.db $83
B7_168a:	.db $0f
B7_168b:		sta ($94), y	; 91 94
B7_168d:		cmp $81			; c5 81
B7_168f:		.db $00				; 00
B7_1690:		php				; 08 
B7_1691:		bpl B7_1693 ; 10 00

B7_1693:		php				; 08 
B7_1694:		php				; 08 
B7_1695:		;removed
	.db $10 $08


func_7_1697:
B7_1697:		lda wEntities_348.w, x	; bd 48 03
B7_169a:		sec				; 38 
B7_169b:		sbc #$aa		; e9 aa
B7_169d:		sta wEntities_348.w, x	; 9d 48 03
B7_16a0:		bcc B7_1717 ; 90 75

B7_16a2:		beq B7_1717 ; f0 73

B7_16a4:		lda #$21		; a9 21
B7_16a6:		jsr queueSoundAtoPlay		; 20 ad c4
B7_16a9:		lda #$07		; a9 07
B7_16ab:		sta wEntities_420.w, x	; 9d 20 04
B7_16ae:		lda wEntities_3c0.w, x	; bd c0 03
B7_16b1:		ora #$20		; 09 20
B7_16b3:		sta wEntities_3c0.w, x	; 9d c0 03
B7_16b6:		rts				; 60 


func_7_16b7:
B7_16b7:		lda wEntities_348.w, x	; bd 48 03
B7_16ba:		sec				; 38 
B7_16bb:		sbc #$ff		; e9 ff
B7_16bd:		sta wEntities_348.w, x	; 9d 48 03
B7_16c0:		bcc B7_1717 ; 90 55

B7_16c2:		beq B7_1717 ; f0 53

B7_16c4:		lda #$21		; a9 21
B7_16c6:		jsr queueSoundAtoPlay		; 20 ad c4
B7_16c9:		lda #$07		; a9 07
B7_16cb:		sta wEntities_420.w, x	; 9d 20 04
B7_16ce:		lda wEntities_3c0.w, x	; bd c0 03
B7_16d1:		ora #$20		; 09 20
B7_16d3:		sta wEntities_3c0.w, x	; 9d c0 03
B7_16d6:		rts				; 60 


func_7_16d7:
B7_16d7:		lda #$03		; a9 03
B7_16d9:		sta $02			; 85 02
B7_16db:		lda #$03		; a9 03
B7_16dd:		sta $03			; 85 03
B7_16df:		lda $0487		; ad 87 04
B7_16e2:		sta $04			; 85 04
B7_16e4:		lda $04b7		; ad b7 04
B7_16e7:		sta $05			; 85 05
B7_16e9:		jsr $d8c4		; 20 c4 d8
B7_16ec:		bcs B7_16b6 ; b0 c8

B7_16ee:		lda #$00		; a9 00
B7_16f0:		sta $0307		; 8d 07 03
B7_16f3:		lda wEquippedMagic			; a5 b8
B7_16f5:		and #$7f		; 29 7f
B7_16f7:		sta wEquippedMagic			; 85 b8
B7_16f9:		lda wEntities_330.w, x	; bd 30 03
B7_16fc:		and $b9			; 25 b9
B7_16fe:		beq B7_1706 ; f0 06

B7_1700:		lda #$22		; a9 22
B7_1702:		jsr queueSoundAtoPlay		; 20 ad c4
B7_1705:		rts				; 60 


B7_1706:		lda wEntitiesControlByte.w, x	; bd 00 03
B7_1709:		ora #$08		; 09 08
B7_170b:		sta wEntitiesControlByte.w, x	; 9d 00 03
B7_170e:		lda wEntities_3c0.w, x	; bd c0 03
B7_1711:		ora #$10		; 09 10
B7_1713:		sta wEntities_3c0.w, x	; 9d c0 03
B7_1716:		rts				; 60 


B7_1717:		jmp $d555		; 4c 55 d5


func_7_171a:
B7_171a:		lda #$03		; a9 03
B7_171c:		sta $02			; 85 02
B7_171e:		lda #$03		; a9 03
B7_1720:		sta $03			; 85 03
B7_1722:		lda $0486		; ad 86 04
B7_1725:		sta $04			; 85 04
B7_1727:		lda $04b6		; ad b6 04
B7_172a:		sta $05			; 85 05
B7_172c:		jsr $d8c4		; 20 c4 d8
B7_172f:		bcs B7_1705 ; b0 d4

B7_1731:		lda #$00		; a9 00
B7_1733:		sta $0306		; 8d 06 03
B7_1736:		lda wEquippedMagic			; a5 b8
B7_1738:		and #$7f		; 29 7f
B7_173a:		sta wEquippedMagic			; 85 b8
B7_173c:		lda wEntities_330.w, x	; bd 30 03
B7_173f:		and $b9			; 25 b9
B7_1741:		beq B7_1749 ; f0 06

B7_1743:		lda #$22		; a9 22
B7_1745:		jsr queueSoundAtoPlay		; 20 ad c4
B7_1748:		rts				; 60 


B7_1749:		ldy #$00		; a0 00
B7_174b:		lda wStoryGlobalFlags0.w		; ad 00 06
B7_174e:		and #$10		; 29 10
B7_1750:		beq B7_1754 ; f0 02

B7_1752:		ldy #$66		; a0 66
B7_1754:		sty $b0			; 84 b0
B7_1756:		lda wEntities_348.w, x	; bd 48 03
B7_1759:		sec				; 38 
B7_175a:		sbc #$05		; e9 05
B7_175c:		sta wEntities_348.w, x	; 9d 48 03
B7_175f:		bcc B7_1717 ; 90 b6

B7_1761:		beq B7_1717 ; f0 b4

B7_1763:		sbc $b0			; e5 b0
B7_1765:		sta wEntities_348.w, x	; 9d 48 03
B7_1768:		bcc B7_1717 ; 90 ad

B7_176a:		beq B7_1717 ; f0 ab

B7_176c:		lda #$21		; a9 21
B7_176e:		jsr queueSoundAtoPlay		; 20 ad c4
B7_1771:		lda #$07		; a9 07
B7_1773:		sta wEntities_420.w, x	; 9d 20 04
B7_1776:		lda $040e		; ad 0e 04
B7_1779:		sta wEntities_3d8.w, x	; 9d d8 03
B7_177c:		rts				; 60 


func_7_177d:
B7_177d:		ldy #$07		; a0 07
B7_177f:		lda wEntitiesControlByte.w, y	; b9 00 03
B7_1782:		bpl B7_179b ; 10 17

B7_1784:		lda #$03		; a9 03
B7_1786:		sta $02			; 85 02
B7_1788:		lda #$03		; a9 03
B7_178a:		sta $03			; 85 03
B7_178c:		lda wEntitiesY.w, y	; b9 80 04
B7_178f:		sta $04			; 85 04
B7_1791:		lda wEntitiesX.w, y	; b9 b0 04
B7_1794:		sta $05			; 85 05
B7_1796:		jsr $d8c4		; 20 c4 d8
B7_1799:		bcc B7_179f ; 90 04

B7_179b:		dey				; 88 
B7_179c:		bpl B7_177f ; 10 e1

B7_179e:		rts				; 60 


B7_179f:		lda wEntities_348.w, x	; bd 48 03
B7_17a2:		sec				; 38 
B7_17a3:		sbc #$14		; e9 14
B7_17a5:		sta wEntities_348.w, x	; 9d 48 03
B7_17a8:		beq B7_17ac ; f0 02

B7_17aa:		bcs B7_17af ; b0 03

B7_17ac:		jmp $d555		; 4c 55 d5


B7_17af:		lda #$07		; a9 07
B7_17b1:		sta wEntities_420.w, x	; 9d 20 04
B7_17b4:		lda wEntities_408.w, y	; b9 08 04
B7_17b7:		eor #$10		; 49 10
B7_17b9:		sta wEntities_3d8.w, x	; 9d d8 03
B7_17bc:		lda #$21		; a9 21
B7_17be:		jsr queueSoundAtoPlay		; 20 ad c4
B7_17c1:		rts				; 60 


func_7_17c2:
B7_17c2:		lda wEntities_3c0.w, x	; bd c0 03
B7_17c5:		and #$af		; 29 af
B7_17c7:		ora #$08		; 09 08
B7_17c9:		sta wEntities_3c0.w, x	; 9d c0 03
B7_17cc:		lda wEntitiesControlByte.w, x	; bd 00 03
B7_17cf:		ora #$08		; 09 08
B7_17d1:		sta wEntitiesControlByte.w, x	; 9d 00 03
B7_17d4:		rts				; 60 


func_7_17d5:
B7_17d5:		lda #$00		; a9 00
B7_17d7:		sta $f2			; 85 f2
B7_17d9:		lda $bf			; a5 bf
B7_17db:		cmp #$04		; c9 04
B7_17dd:		bcc B7_17f4 ; 90 15

B7_17df:		cmp #$06		; c9 06
B7_17e1:		bcc B7_17ea ; 90 07

B7_17e3:		cmp #$08		; c9 08
B7_17e5:		bcs B7_17f4 ; b0 0d

B7_17e7:		jmp B7_1815		; 4c 15 d8

B7_17ea:		lda wPlayerAnimationDataOffset			; a5 c5
B7_17ec:		cmp #$01		; c9 01
B7_17ee:		bcc B7_17f4 ; 90 04

B7_17f0:		cmp #$08		; c9 08
B7_17f2:		bcc B7_17f5 ; 90 01

B7_17f4:		rts				; 60 

B7_17f5:		lda $c9			; a5 c9
B7_17f7:		asl a			; 0a
B7_17f8:		asl a			; 0a
B7_17f9:		asl a			; 0a
B7_17fa:		clc				; 18 
B7_17fb:		adc $c5			; 65 c5
B7_17fd:		tay				; a8 
B7_17fe:		lda $d874, y	; b9 74 d8
B7_1801:		tay				; a8 
B7_1802:		lda $d894, y	; b9 94 d8
B7_1805:		jsr $d84c		; 20 4c d8
B7_1808:		lda $d8a4, y	; b9 a4 d8
B7_180b:		jsr $d860		; 20 60 d8
B7_180e:		lda #$80		; a9 80
B7_1810:		sta $f2			; 85 f2
B7_1812:		jmp $d82d		; 4c 2d d8

B7_1815:		lda wPlayerAnimationDataOffset			; a5 c5
B7_1817:		cmp #$03		; c9 03
B7_1819:		bne B7_1812 ; d0 f7

B7_181b:		ldy $c9			; a4 c9
B7_181d:		lda $d8b4, y	; b9 b4 d8
B7_1820:		jsr $d84c		; 20 4c d8
B7_1823:		lda $d8b8, y	; b9 b8 d8
B7_1826:		jsr $d860		; 20 60 d8
B7_1829:		lda #$40		; a9 40
B7_182b:		sta $f2			; 85 f2
B7_182d:		ldy #$15		; a0 15
B7_182f:		cpy $52			; c4 52
B7_1831:		bne B7_1840 ; d0 0d

B7_1833:		lda wEquippedSword			; a5 b6
B7_1835:		cmp #$06		; c9 06
B7_1837:		beq B7_183f ; f0 06

B7_1839:		lda $f2			; a5 f2
B7_183b:		ora #$20		; 09 20
B7_183d:		sta $f2			; 85 f2
B7_183f:		rts				; 60 

B7_1840:		iny				; c8 
B7_1841:		cpy #$19		; c0 19
B7_1843:		bcc B7_182f ; 90 ea

B7_1845:		lda wEquippedSword			; a5 b6
B7_1847:		cmp #$06		; c9 06
B7_1849:		beq B7_1839 ; f0 ee

B7_184b:		rts				; 60 


;
B7_184c:		clc				; 18 
B7_184d:		bmi B7_1857 ; 30 08

B7_184f:		adc wPlayerY			; 65 cc
B7_1851:		bcc B7_185d ; 90 0a

B7_1853:		lda #$ff		; a9 ff
B7_1855:		bne B7_185d ; d0 06

B7_1857:		adc wPlayerY			; 65 cc
B7_1859:		bcs B7_185d ; b0 02

B7_185b:		lda #$00		; a9 00
B7_185d:		sta $f0			; 85 f0
B7_185f:		rts				; 60 


B7_1860:		clc				; 18 
B7_1861:		bmi B7_186b ; 30 08

B7_1863:		adc wPlayerX			; 65 ce
B7_1865:		bcc B7_1871 ; 90 0a

B7_1867:		lda #$ff		; a9 ff
B7_1869:		bne B7_1871 ; d0 06

B7_186b:		adc wPlayerX			; 65 ce
B7_186d:		bcs B7_1871 ; b0 02

B7_186f:		lda #$00		; a9 00
B7_1871:		sta $f1			; 85 f1
B7_1873:		rts				; 60 


B7_1874:		.db $00				; 00
B7_1875:	.db $03
B7_1876:	.db $02
B7_1877:		ora ($00, x)	; 01 00
B7_1879:	.db $0f
B7_187a:	.db $0e $0d $00
B7_187d:		.db $00				; 00
B7_187e:		ora ($02, x)	; 01 02
B7_1880:	.db $03
B7_1881:	.db $04
B7_1882:		ora $06			; 05 06
B7_1884:		.db $00				; 00
B7_1885:	.db $0b
B7_1886:		asl a			; 0a
B7_1887:		ora #$08		; 09 08
B7_1889:	.db $07
B7_188a:		asl $05			; 06 05
B7_188c:		.db $00				; 00
B7_188d:		.db $00				; 00
B7_188e:	.db $0f
B7_188f:		asl $0c0d		; 0e 0d 0c
B7_1892:	.db $0b
B7_1893:		asl a			; 0a
B7_1894:		cpx $f2ed		; ec ed f2
B7_1897:		sed				; f8 
B7_1898:		.db $00				; 00
B7_1899:		php				; 08 
B7_189a:		asl $1413		; 0e 13 14
B7_189d:	.db $13
B7_189e:	.db $0e $08 $00
B7_18a1:		sed				; f8 
B7_18a2:	.db $f2
B7_18a3:		sbc $0800		; ed00 08
B7_18a6:		asl $1413		; 0e 13 14
B7_18a9:	.db $13
B7_18aa:	.db $0e $08 $00
B7_18ad:		sed				; f8 
B7_18ae:	.db $f2
B7_18af:		sbc $edec		; edec ed
B7_18b2:	.db $f2
B7_18b3:		sed				; f8 
B7_18b4:		inc $1200		; ee 00 12
B7_18b7:		.db $00				; 00
B7_18b8:		.db $00				; 00
B7_18b9:	.db $14
B7_18ba:		.db $00				; 00
B7_18bb:		cpx $040a		; ec 0a 04
B7_18be:	.db $0c
B7_18bf:	.db $04
B7_18c0:	.db $04
B7_18c1:	.db $0c
B7_18c2:	.db $04
B7_18c3:	.db $0c
B7_18c4:		lda $02			; a5 02
B7_18c6:		clc				; 18 
B7_18c7:		adc $00			; 65 00
B7_18c9:		sta $02			; 85 02
B7_18cb:		lda $04			; a5 04
B7_18cd:		sec				; 38 
B7_18ce:		sbc wEntitiesY.w, x	; fd 80 04
B7_18d1:		bcs B7_18d7 ; b0 04

B7_18d3:		eor #$ff		; 49 ff
B7_18d5:		adc #$01		; 69 01
B7_18d7:		cmp $02			; c5 02
B7_18d9:		bcc B7_18de ; 90 03

B7_18db:		beq B7_18de ; f0 01

B7_18dd:		rts				; 60 


B7_18de:		lda $03			; a5 03
B7_18e0:		clc				; 18 
B7_18e1:		adc $01			; 65 01
B7_18e3:		sta $03			; 85 03
B7_18e5:		lda $05			; a5 05
B7_18e7:		sec				; 38 
B7_18e8:		sbc wEntitiesX.w, x	; fd b0 04
B7_18eb:		bcs B7_18f1 ; b0 04

B7_18ed:		eor #$ff		; 49 ff
B7_18ef:		adc #$01		; 69 01
B7_18f1:		cmp $03			; c5 03
B7_18f3:		bne B7_18f6 ; d0 01

B7_18f5:		clc				; 18 
B7_18f6:		rts				; 60 


func_7_18f7:
B7_18f7:		lda $4c			; a5 4c
B7_18f9:		jsr jumpTable		; 20 3d c2
	.dw loadHalfARowOf16x16roomTiles
	.dw rts_7_191c
	.dw rts_7_191c
	.dw rts_7_191c
	.dw load2ndHalfARowOf16x16roomTiles
	.dw rts_7_191c
	.dw rts_7_191c
	.dw rts_7_191c
	.dw vramQueueARowOfScreenPalettes
	.dw rts_7_191c
	.dw rts_7_191c
	.dw rts_7_191c
	.dw func_7_19c9
	.dw rts_7_191c
	.dw rts_7_191c
	.dw rts_7_191c

rts_7_191c:
	rts

load2ndHalfARowOf16x16roomTiles:
	lda #$08
	sta w16x16tileIdxToLoad
	jsr +
B7_1924:		jmp func_7_19b3		; 4c b3 d9


loadHalfARowOf16x16roomTiles:
	lda #$00
	sta wRoomLoadingColIdx
	jsr getRoomLoadingDestAddrForRow

	lda #$00
	sta w16x16tileIdxToLoad

+	jsr setCurrRoomGroupAndShapeIdx_ret16x16tileVal

@next16x16tile:
	jsr get16x16tileValue
	sta w16x16TileValue

; x is double idx, since 2 cols per 16x16 tile
	lda w16x16tileIdxToLoad
	asl a
	tax

; actual tiles use 0,1,2,3 as lower 2 bits
	lda w16x16TileValue
	and #$3f
	asl a
	asl a

; store 16x16's 8x8 tiles as follows:
; 0 2
; 1 3
	sta wRoomLoadingRow1ToCopy.w, x
	tay
	iny
	tya
	sta wRoomLoadingRow2ToCopy.w, x
	tay
	iny
	tya
	inx
	sta wRoomLoadingRow1ToCopy.w, x
	tay
	iny
	tya
	sta wRoomLoadingRow2ToCopy.w, x

	jsr getOffsetIntoRoomPalettesFor16x16tile

; set 2 palette bits of 16x16 tile
	lda #$00
	sta wCurrTilePaletteBits
	lda w16x16TileValue
	asl a
	rol wCurrTilePaletteBits
	asl a
	rol wCurrTilePaletteBits

; set mask of other bits
	lda #$fc
	sta wCurrTilePaletteOtherBitsMask
	lda wRoomLoadingRowIdx
	lsr a
	bcc +

; if bottom row of 32x32 metatile
; bring palette bits to upper nybble
; bring mask of other bits too
	asl wCurrTilePaletteBits
	asl wCurrTilePaletteBits
	asl wCurrTilePaletteBits
	asl wCurrTilePaletteBits
	sec
	rol wCurrTilePaletteOtherBitsMask
	rol wCurrTilePaletteOtherBitsMask
	rol wCurrTilePaletteOtherBitsMask
	rol wCurrTilePaletteOtherBitsMask

+	lda wRoomLoadingColIdx
	lsr a
	bcc +

; if right side of 32x32 metatile
; bring palette bits to upper part of nybble
; bring mask again
	asl wCurrTilePaletteBits
	asl wCurrTilePaletteBits
	sec
	rol wCurrTilePaletteOtherBitsMask
	rol wCurrTilePaletteOtherBitsMask

; update the current 32x32 palettes
+	lda wRoomPalettes.w, x
	and wCurrTilePaletteOtherBitsMask
	ora wCurrTilePaletteBits
	sta wRoomPalettes.w, x

	lda w16x16tileIdxToLoad
	bne +

; store room palette offset for 1st tile
	stx wCurr16x16tileRoomPaletteOffset

+	
; inc vars, done when on right side of nt0 or nt1's
; 8 palettes for the row
	inc wRoomLoadingColIdx
	inc w16x16tileIdxToLoad
	lda w16x16tileIdxToLoad
	cmp #$08
	beq @done

	cmp #$10
	beq @done

	jmp @next16x16tile

@done:
	rts


func_7_19b3:
B7_19b3:		ldx #$00		; a2 00
B7_19b5:		ldy #$00		; a0 00
B7_19b7:		bit $4a			; 24 4a
B7_19b9:		bpl B7_19be ; 10 03

; bit 7 set means dest+$20, from screen row 2
B7_19bb:		inx				; e8 
B7_19bc:		ldy #$20		; a0 20

; else dest, from screen row 1
B7_19be:		lda wRoomLoadingDestAddr			; a5 47
B7_19c0:		clc				; 18 
B7_19c1:		adc data_7_1b78.w, x	; 7d 78 db
B7_19c4:		sta wRoomLoadingDestAddr			; 85 47

B7_19c6:		jmp vramQueueARowOfNewScreenTiles		; 4c 0d db


func_7_19c9:
B7_19c9:		ldx #$00		; a2 00
B7_19cb:		ldy #$20		; a0 20
B7_19cd:		bit $4a			; 24 4a
B7_19cf:		bpl B7_19d4 ; 10 03

; bit 7 set means dest-$20, from screen row 1
B7_19d1:		ldy #$00		; a0 00
B7_19d3:		inx				; e8 

; else dest+$20, from screen row 2
B7_19d4:		lda wRoomLoadingDestAddr			; a5 47
B7_19d6:		clc				; 18 
B7_19d7:		adc data_7_1b7a.w, x	; 7d 7a db
B7_19da:		sta wRoomLoadingDestAddr			; 85 47

B7_19dc:		jsr vramQueueARowOfNewScreenTiles		; 20 0d db

B7_19df:		rts				; 60 


vramQueueARowOfScreenPalettes:
; if using palette offsets x8 to xf, it's nt1
	ldx wNextVramQueueIdxToFillInFrom
	ldy #>NAMETABLE0_PAL

	lda wCurr16x16tileRoomPaletteOffset
	and #$08
	beq +

	ldy #>NAMETABLE1_PAL

+
; store upper byte of screen palettes
	tya
	sta wVramQueue.w, x

; store offset into nt hw palettes
	inx
	lda wCurr16x16tileRoomPaletteOffset
	pha

; equals offset into row
	and #$07
	sta wCurrScreenPaletteOffset
	pla

; plus row * 8
	and #$f0
	lsr a
	clc
	adc wCurrScreenPaletteOffset
	clc
	adc #<NAMETABLE0_PAL
	sta wVramQueue.w, x

; set to copy 8 bytes for the row
	inx
	lda #$08
	sta wVramQueue.w, x
	sta wCurrScreenPalettesToCopy

; copy the bytes
	inx
	ldy wCurr16x16tileRoomPaletteOffset
-	lda wRoomPalettes.w, y
	sta wVramQueue.w, x
	inx
	iny
	dec wCurrScreenPalettesToCopy
	bne -

; set new palette offset, and close vram queue
	sty wCurr16x16tileRoomPaletteOffset
	lda #$00
	sta wVramQueue.w, x
	stx wNextVramQueueIdxToFillInFrom
	rts


getRoomLoadingDestAddrForRow:
; get col tile idx, metatiles are 2x2
	lda wRoomLoadingColIdx
	asl a
	sta wRoomLoadingDestOffset

; get row tile idx
	lda #$00
	sta wRoomLoadingDestOffset+1
	lda wRoomLoadingRowIdx
	asl a
	asl a
	asl a
	asl a
	rol wRoomLoadingDestOffset+1
	asl a
	rol wRoomLoadingDestOffset+1
	asl a
	rol wRoomLoadingDestOffset+1

; add together, and store in dest addr
	clc
	adc wRoomLoadingDestOffset
	sta wRoomLoadingDestAddr

; alternate nt's from left to right rooms
	lda wTempRoomX
	lsr a
	ldx #>NAMETABLE0
	bcc +

	ldx #>NAMETABLE1

+	txa
	clc
	adc wRoomLoadingDestOffset+1
	sta wRoomLoadingDestAddr+1
	rts


setCurrRoomGroupAndShapeIdx_ret16x16tileVal:
	lda #$00
	sta wRoomGroupAndShapeIdxAddr+1

; get double room x
	lda wTempRoomX
	asl a
	sta wDoubleTempRoomX

; room y *= $40 ($20 tiles wide * word for address)
	lda wTempRoomY
	asl a
	asl a
	asl a
	rol wRoomGroupAndShapeIdxAddr+1
	asl a
	rol wRoomGroupAndShapeIdxAddr+1
	asl a
	rol wRoomGroupAndShapeIdxAddr+1
	asl a
	rol wRoomGroupAndShapeIdxAddr+1

; low byte += double room x (word for each room)
	clc
	adc wDoubleTempRoomX
	sta wRoomGroupAndShapeIdxAddr

; high byte += base addr containing group and shape idxes
	lda wRoomGroupAndShapeIdxAddr+1
	clc
	adc #>roomGroupAndShapeIdxData
	sta wRoomGroupAndShapeIdxAddr+1

; bank of above data
	lda #$03
	jsr safeSetPrgBankA

; now get addresses from the 2 room bytes
	ldy #$00
	sty wRoomsMetatilesAddr+1

; get group val (1st byte)
	lda (wRoomGroupAndShapeIdxAddr), y
	asl a
	asl a
	sta wRoomGroup

; 2nd byte (shape idx) * $40 (room metatiles)
	iny
	lda (wRoomGroupAndShapeIdxAddr), y
	asl a
	rol wRoomsMetatilesAddr+1
	asl a
	rol wRoomsMetatilesAddr+1
	asl a
	rol wRoomsMetatilesAddr+1
	asl a
	rol wRoomsMetatilesAddr+1
	asl a
	rol wRoomsMetatilesAddr+1
	asl a
	rol wRoomsMetatilesAddr+1
	sta wRoomsMetatilesAddr

	lda wRoomsMetatilesAddr+1
	clc
; roomGroup4to5shapes if room y is $1d or $1e
; room y $1e rooms are 00 to 0e
	adc #>roomGroup0to3shapes
	sta wRoomsMetatilesAddr+1

get16x16tileValue:
; set Y based on the tile we're trying to get in a metatile
; eg 0 1
;    2 3
	jsr getMetatileTilesAddr
	ldy #$00

; if bottom row of metatile, add 2 to Y
	lda wRoomLoadingRowIdx
	lsr a
	bcc +
	iny
	iny
+
; if right col of metatile, add 1 to Y
	lda wRoomLoadingColIdx
	lsr a
	bcc +
	iny
+
; return tile value of 16x16 tile
	lda (wMetatileTileAddr), y
	rts


getMetatileTilesAddr:
; for room metatiles,
; inner rooms in bank 3, overworld rooms in bank 2
	ldx #$02
	lda wTempRoomY

	cmp #$1d
	bcc +
	inx
+	txa
	jsr safeSetPrgBankA

; start getting metatile offset for 16x16 tile
	lda #$00
	sta wMetatileTileAddr+1

	lda wRoomLoadingColIdx
	lsr a
	sta wHalfColIdx

; idx into metatiles is row // 2 * 4 + col idx
	lda wRoomLoadingRowIdx
	lsr a
	asl a
	asl a
	asl a
	adc wHalfColIdx
	tay

; get metatile value
	lda (wRoomsMetatilesAddr), y

; get address for 4 16x16 tiles for metatile
	asl a
	rol wMetatileTileAddr+1
	asl a
	rol wMetatileTileAddr+1
	sta wMetatileTileAddr
	lda wMetatileTileAddr+1
	clc
	adc #>metatileTileData_32to16
	clc
	adc wRoomGroup
	sta wMetatileTileAddr+1

; metatile tile data in bank 3
	lda #$03
	jsr safeSetPrgBankA
	rts


getOffsetIntoRoomPalettesFor16x16tile:
; x = 8 * 16x16 row (8 bytes for nt0 and 8 for nt1)
	lda wRoomLoadingRowIdx
	lsr a
	asl a
	asl a
	asl a
	asl a
	tax

; if alternate room x, x += 8
	lda wTempRoomX
	lsr a
	bcc +

	txa
	adc #$07
	tax

+
; x += half col (2 16x16 tiles share a byte)
	stx wHalfColIdx
	lda wRoomLoadingColIdx
	lsr a
	clc
	adc wHalfColIdx
	tax
	rts


vramQueueARowOfNewScreenTiles:
	ldx wNextVramQueueIdxToFillInFrom

; set ppu addr
	lda wRoomLoadingDestAddr+1
	sta wVramQueue.w, x
	inx
	lda wRoomLoadingDestAddr
	sta wVramQueue.w, x

; copy $20 bytes
	inx
	lda #$20
	sta wVramQueue.w, x
	sta wNumBytesToCopyRoomRow
	inx

; another func calling this will also do row 2
-	lda wRoomLoadingRow1ToCopy.w, y
	sta wVramQueue.w, x
	inx
	iny
	dec wNumBytesToCopyRoomRow
	bne -

	lda #$00
	sta wVramQueue.w, x
	stx wNextVramQueueIdxToFillInFrom
	rts


func_7_1b37:
B7_1b37:		jsr loadHalfARowOf16x16roomTiles		; 20 27 d9
B7_1b3a:		jsr load2ndHalfARowOf16x16roomTiles		; 20 1d d9
B7_1b3d:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1b40:		jsr vramQueueARowOfScreenPalettes		; 20 e0 d9
B7_1b43:		jsr func_7_19c9		; 20 c9 d9
B7_1b46:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1b49:		rts				; 60 


; called with $0c = $0e to $00
func_7_1b4a:
B7_1b4a:		jsr loadHalfARowOf16x16roomTiles		; 20 27 d9
B7_1b4d:		jsr load2ndHalfARowOf16x16roomTiles		; 20 1d d9
B7_1b50:		jsr vramQueueARowOfScreenPalettes		; 20 e0 d9
B7_1b53:		jsr func_7_19c9		; 20 c9 d9
B7_1b56:		jsr updateFromVramQueue		; 20 f2 c2
B7_1b59:		rts				; 60 


func_7_1b5a:
B7_1b5a:		lda wPrgBank			; a5 35
B7_1b5c:		pha				; 48 
B7_1b5d:		lda wRoomX			; a5 42
B7_1b5f:		ldx wRoomY			; a6 43
; 4 loops
B7_1b61:		ldy #$03		; a0 03
B7_1b63:		sta wTempRoomX			; 85 0f
B7_1b65:		sty $0c			; 84 0c
B7_1b67:		stx wTempRoomY			; 86 0d
B7_1b69:		lda #$80		; a9 80
B7_1b6b:		sta $4a			; 85 4a
-	jsr func_7_1b37		; 20 37 db
B7_1b70:		dec $0c			; c6 0c
	bpl -

B7_1b74:		pla				; 68 
B7_1b75:		jmp safeSetPrgBankA		; 4c 7a c1


data_7_1b78:
	.db $00 $20
	
data_7_1b7a:
	.db $20 $e0


handleScrollingRoomTransitions:
B7_1b7c:		lda wPlayerKnockbackCounter			; a5 c7
B7_1b7e:		beq B7_1b81 ; f0 01

B7_1b80:		rts				; 60 

B7_1b81:		lda $bf			; a5 bf
B7_1b83:		cmp #$08		; c9 08
B7_1b85:		beq B7_1b80 ; f0 f9

B7_1b87:		lda #$db		; a9 db
B7_1b89:		pha				; 48 
B7_1b8a:		lda #$b1		; a9 b1
B7_1b8c:		pha				; 48 
B7_1b8d:		lda wPlayerY			; a5 cc
B7_1b8f:		cmp #$18		; c9 18
B7_1b91:		bne B7_1b96 ; d0 03

B7_1b93:		jmp roomTransitionUp		; 4c bb db

B7_1b96:		cmp #$d8		; c9 d8
B7_1b98:		bne B7_1b9d ; d0 03

B7_1b9a:		jmp roomTransitionDown		; 4c 06 dc

B7_1b9d:		lda wPlayerX			; a5 ce
B7_1b9f:		cmp #$10		; c9 10
B7_1ba1:		bne B7_1ba6 ; d0 03

B7_1ba3:		jmp roomTransitionLeft		; 4c 81 dc

B7_1ba6:		cmp #$f0		; c9 f0
B7_1ba8:		bne B7_1bad ; d0 03

B7_1baa:		jmp roomTransitionRight		; 4c 55 dc

B7_1bad:		pla				; 68 
B7_1bae:		pla				; 68 
B7_1baf:		jmp safeRestoreDefaultPrgBank		; 4c 95 c1


B7_1bb2:		jsr func_7_3000		; 20 00 f0
B7_1bb5:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1bb8:		jmp safeRestoreDefaultPrgBank		; 4c 95 c1


roomTransitionUp:
B7_1bbb:		jsr func_7_1cf1		; 20 f1 dc
B7_1bbe:		dec wRoomY			; c6 43
B7_1bc0:		jsr safeRestoreDefaultPrgBank		; 20 95 c1
B7_1bc3:		jsr roomTransitionUpdateChrPalMus2EntityBytes		; 20 c9 9d
B7_1bc6:		jsr roomTransitionLoadScreenEntitiesUpdateSprChrPal		; 20 31 dd
B7_1bc9:		lda #$1e		; a9 1e
B7_1bcb:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_1bce:		lda #$0e		; a9 0e
B7_1bd0:		sta $0c			; 85 0c
B7_1bd2:		lda wRoomY			; a5 43
B7_1bd4:		sta $0d			; 85 0d
B7_1bd6:		lda wRoomX			; a5 42
B7_1bd8:		sta $0f			; 85 0f
B7_1bda:		lda #$80		; a9 80
B7_1bdc:		sta $4a			; 85 4a

@loop:
B7_1bde:		jsr func_7_18f7		; 20 f7 d8
B7_1be1:		lda wPPUScrollY			; a5 24
B7_1be3:		sec				; 38 
B7_1be4:		sbc #$04		; e9 04
B7_1be6:		cmp #$f0		; c9 f0
	bcc +

B7_1bea:		sbc #$10		; e9 10
+	sta wPPUScrollY			; 85 24
B7_1bee:		jsr func_7_1cea		; 20 ea dc
B7_1bf1:		jsr safeRestoreDefaultPrgBank		; 20 95 c1
B7_1bf4:		ldx #$08		; a2 08
B7_1bf6:		jsr $86c0		; 20 c0 86
B7_1bf9:		jsr drawPlayerWaitForNMIFuncsDone		; 20 e3 dc
B7_1bfc:		jsr func_7_1ccd		; 20 cd dc
B7_1bff:		bne B7_1bde ; @loop

B7_1c01:		dec $0c			; c6 0c
B7_1c03:		bpl B7_1bde ; @loop

B7_1c05:		rts				; 60 


roomTransitionDown:
B7_1c06:		jsr func_7_1cf1		; 20 f1 dc
B7_1c09:		inc wRoomY			; e6 43
B7_1c0b:		jsr safeRestoreDefaultPrgBank		; 20 95 c1
B7_1c0e:		jsr roomTransitionUpdateChrPalMus2EntityBytes		; 20 c9 9d
B7_1c11:		jsr roomTransitionLoadScreenEntitiesUpdateSprChrPal		; 20 31 dd
B7_1c14:		lda #$1e		; a9 1e
B7_1c16:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_1c19:		lda #$00		; a9 00
B7_1c1b:		sta $0c			; 85 0c
B7_1c1d:		lda wRoomY			; a5 43
B7_1c1f:		sta $0d			; 85 0d
B7_1c21:		lda wRoomX			; a5 42
B7_1c23:		sta $0f			; 85 0f
B7_1c25:		lda #$00		; a9 00
B7_1c27:		sta $4a			; 85 4a
B7_1c29:		jsr func_7_18f7		; 20 f7 d8
B7_1c2c:		lda wPPUScrollY			; a5 24
B7_1c2e:		clc				; 18 
B7_1c2f:		adc #$04		; 69 04
B7_1c31:		cmp #$f0		; c9 f0
B7_1c33:		bcc B7_1c37 ; 90 02

B7_1c35:		adc #$0f		; 69 0f
B7_1c37:		sta wPPUScrollY			; 85 24
B7_1c39:		jsr func_7_1cea		; 20 ea dc
B7_1c3c:		jsr safeRestoreDefaultPrgBank		; 20 95 c1
B7_1c3f:		ldx #$09		; a2 09
B7_1c41:		jsr $86c0		; 20 c0 86
B7_1c44:		jsr drawPlayerWaitForNMIFuncsDone		; 20 e3 dc
B7_1c47:		jsr func_7_1ccd		; 20 cd dc
B7_1c4a:		bne B7_1c29 ; d0 dd

B7_1c4c:		inc $0c			; e6 0c
B7_1c4e:		lda $0c			; a5 0c
B7_1c50:		cmp #$0f		; c9 0f
B7_1c52:		bne B7_1c29 ; d0 d5

B7_1c54:		rts				; 60 


roomTransitionRight:
B7_1c55:		jsr func_7_1cf1		; 20 f1 dc
B7_1c58:		inc wRoomX			; e6 42
B7_1c5a:		jsr safeRestoreDefaultPrgBank		; 20 95 c1
B7_1c5d:		jsr roomTransitionUpdateChrPalMus2EntityBytes		; 20 c9 9d
B7_1c60:		jsr roomTransitionLoadScreenEntitiesUpdateSprChrPal		; 20 31 dd
B7_1c63:		jsr func_7_1cb3		; 20 b3 dc

B7_1c66:		jsr func_7_1cea		; 20 ea dc
B7_1c69:		jsr safeRestoreDefaultPrgBank		; 20 95 c1
B7_1c6c:		ldx #$09		; a2 09
B7_1c6e:		jsr $869b		; 20 9b 86
B7_1c71:		jsr drawPlayerWaitForNMIFuncsDone		; 20 e3 dc
B7_1c74:		lda wPPUScrollX			; a5 25
B7_1c76:		clc				; 18 
B7_1c77:		adc #$04		; 69 04
B7_1c79:		sta wPPUScrollX			; 85 25
B7_1c7b:		bne B7_1c66 ; d0 e9

B7_1c7d:		jsr setNametable1IfOddRoomX		; 20 d7 dc
B7_1c80:		rts				; 60 


roomTransitionLeft:
B7_1c81:		jsr func_7_1cf1		; 20 f1 dc
B7_1c84:		dec wRoomX			; c6 42
B7_1c86:		jsr safeRestoreDefaultPrgBank		; 20 95 c1
B7_1c89:		jsr roomTransitionUpdateChrPalMus2EntityBytes		; 20 c9 9d
B7_1c8c:		jsr roomTransitionLoadScreenEntitiesUpdateSprChrPal		; 20 31 dd
B7_1c8f:		jsr func_7_1cb3		; 20 b3 dc
B7_1c92:		jsr setNametable1IfOddRoomX		; 20 d7 dc
B7_1c95:		jsr func_7_1cea		; 20 ea dc
B7_1c98:		jsr safeRestoreDefaultPrgBank		; 20 95 c1
B7_1c9b:		ldx #$08		; a2 08
B7_1c9d:		jsr $869b		; 20 9b 86
B7_1ca0:		lda wPPUScrollX			; a5 25
B7_1ca2:		sec				; 38 
B7_1ca3:		sbc #$04		; e9 04
B7_1ca5:		sta wPPUScrollX			; 85 25
B7_1ca7:		beq B7_1caf ; f0 06

B7_1ca9:		jsr drawPlayerWaitForNMIFuncsDone		; 20 e3 dc
B7_1cac:		jmp $dc95		; 4c 95 dc

B7_1caf:		jsr drawPlayerWaitForNMIFuncsDone		; 20 e3 dc
B7_1cb2:		rts				; 60 


func_7_1cb3:
B7_1cb3:		lda wRoomY			; a5 43
B7_1cb5:		sta wTempRoomY			; 85 0d
B7_1cb7:		lda wRoomX			; a5 42
B7_1cb9:		sta wTempRoomX			; 85 0f

B7_1cbb:		lda #$0e		; a9 0e
B7_1cbd:		sta $0c			; 85 0c
B7_1cbf:		lda #$80		; a9 80
B7_1cc1:		sta $4a			; 85 4a
B7_1cc3:		jsr func_7_1b37		; 20 37 db
B7_1cc6:		dec $0c			; c6 0c
B7_1cc8:		bpl B7_1cc3 ; 10 f9

B7_1cca:		jmp safeRestoreDefaultPrgBank		; 4c 95 c1


func_7_1ccd:
B7_1ccd:		lda $4c			; a5 4c
B7_1ccf:		clc				; 18 
B7_1cd0:		adc #$04		; 69 04
B7_1cd2:		and #$0f		; 29 0f
B7_1cd4:		sta $4c			; 85 4c
B7_1cd6:		rts				; 60 


setNametable1IfOddRoomX:
	lda wPPUCtrl
	lsr a
	pha
	lda wRoomX
	lsr a
	pla
	rol a
	sta wPPUCtrl
	rts


drawPlayerWaitForNMIFuncsDone:
	jsr drawPlayer
	jsr waitForMajorityOfNMIFuncsDone
	rts


func_7_1cea:
B7_1cea:		lda $c0			; a5 c0
B7_1cec:		and #$f7		; 29 f7
B7_1cee:		sta $c0			; 85 c0
B7_1cf0:		rts				; 60 


func_7_1cf1:
B7_1cf1:		lda $bf			; a5 bf
B7_1cf3:		cmp #$04		; c9 04
B7_1cf5:		bcc B7_1cfa ; 90 03

B7_1cf7:		jsr func_6_02a1		; 20 a1 82
B7_1cfa:		lda $bf			; a5 bf
B7_1cfc:		cmp #$09		; c9 09
B7_1cfe:		beq B7_1d04 ; f0 04

B7_1d00:		asl $b8			; 06 b8
B7_1d02:		lsr $b8			; 46 b8
B7_1d04:		lda wBGChrBank			; a5 53
B7_1d06:		cmp #$03		; c9 03
B7_1d08:		bcs B7_1d11 ; b0 07

B7_1d0a:		lda #$00		; a9 00
B7_1d0c:		sta wBGChrBank			; 85 53
B7_1d0e:		jsr set_wChrBank1		; 20 db c1
B7_1d11:		jsr clearAllEntities		; 20 94 c3
B7_1d14:		jsr drawEntities		; 20 03 c4
B7_1d17:		jsr drawPlayer		; 20 dd c3
B7_1d1a:		lda $d5			; a5 d5
B7_1d1c:		cmp $d7			; c5 d7
B7_1d1e:		beq B7_1d27 ; f0 07

B7_1d20:		ldx #$00		; a2 00
B7_1d22:		stx $d6			; 86 d6
B7_1d24:		jsr func_7_04ab		; 20 ab c4
B7_1d27:		jsr func_7_1b5a		; 20 5a db
B7_1d2a:		lda #$00		; a9 00
B7_1d2c:		sta $55			; 85 55
B7_1d2e:		sta $59			; 85 59
B7_1d30:		rts				; 60 


roomTransitionLoadScreenEntitiesUpdateSprChrPal:
	lda wEntityDataByte2
	beq +

	lda #:b5_loadScreenEntitiesOnRoomTransition
	jsr safeSetPrgBankA
	jsr b5_loadScreenEntitiesOnRoomTransition

setSprPalAndChr_updateCurrScreensSprPalettes:
	jsr setInGameSprChrBank

updateCurrScreensSprPalettes:
	lda wSprPaletteSpecAndChrBank
	lsr a
	lsr a
	lsr a
	lsr a
	clc
	adc #$10
	jsr update_wInternalPalettesFromSpecA

+	rts


loadRoom2EntityBytes:
	lda #$00
	sta $01
; room y * $20 + room x (1 room byte in struct)
	lda wRoomY
	asl a
	asl a
	asl a
	rol wRoomEntityBytesAddr+1
	asl a
	rol wRoomEntityBytesAddr+1
	asl a
	rol wRoomEntityBytesAddr+1
	clc
	adc wRoomX
	sta wRoomEntityBytesAddr
	lda wRoomEntityBytesAddr+1
	clc
	adc #>entityBytes1
	sta wRoomEntityBytesAddr+1

	lda #:entityBytes1
	jsr safeSetPrgBankA

	ldx #$00
	ldy #$00
-	lda (wRoomEntityBytesAddr), y
; loop twice for wEntityDataByte2 too
	sta wEntityDataByte1, x
	lda wRoomEntityBytesAddr+1
	clc
	adc #>(entityBytes2-entityBytes1)
	sta wRoomEntityBytesAddr+1

	inx
	cpx #$02
	bne -

	jmp safeRestoreDefaultPrgBank


B7_1d86:		sed				; f8 
B7_1d87:		sed				; f8 
B7_1d88:		sed				; f8 
B7_1d89:		sed				; f8 
B7_1d8a:		php				; 08 
B7_1d8b:		php				; 08 
B7_1d8c:		php				; 08 
B7_1d8d:		php				; 08 
B7_1d8e:		jsr $f020		; 20 20 f0
B7_1d91:		sed				; f8 
B7_1d92:		.db $00				; 00
B7_1d93:		php				; 08 
B7_1d94:		beq B7_1d8e ; f0 f8

B7_1d96:		.db $00				; 00
B7_1d97:		php				; 08 
B7_1d98:		cpx #$e8		; e0 e8


begin2:
	lda #$00
	jsr safeSetDefaultPrgBankA
	
B7_1d9f:		jsr handleUpToBeforeStartPwScreen		; 20 e0 b3

B7_1da2:		lda #$06		; a9 06
B7_1da4:		jsr safeSetDefaultPrgBankA		; 20 78 c1
B7_1da7:		jsr setPPUMask_noSprites		; 20 53 c1
B7_1daa:		jsr setPPUCtrl_noNMI		; 20 64 c1
B7_1dad:		jsr fillNametables01With20h		; 20 b1 c2
B7_1db0:		jsr clearNametables01Palettes		; 20 90 c2
B7_1db3:		jsr clearAllEntities		; 20 94 c3
B7_1db6:		jsr hideAllOam		; 20 9f c3

B7_1db9:		lda #$1e		; a9 1e
B7_1dbb:		sta wRoomY			; 85 43
B7_1dbd:		lda #$1a		; a9 1a
B7_1dbf:		sta wRoomX			; 85 42
B7_1dc1:		jsr b6_loadAllScreenRowsForCurrRoom		; 20 f3 de

; base nametable address at $2000
B7_1dc4:		lda wPPUCtrl			; a5 20
B7_1dc6:		and #$fe		; 29 fe
B7_1dc8:		sta wPPUCtrl			; 85 20
B7_1dca:		sta PPUCTRL.w		; 8d 00 20

B7_1dcd:		lda #$13		; a9 13
B7_1dcf:		jsr set_wChrBank1		; 20 db c1
B7_1dd2:		lda #$1f		; a9 1f
B7_1dd4:		jsr set_wChrBank0		; 20 c2 c1

B7_1dd7:		lda #<rleData_7_208e		; a9 8e
B7_1dd9:		sta wRLEStructAddressToCopy			; 85 33
B7_1ddb:		lda #>rleData_7_208e		; a9 e0
B7_1ddd:		sta wRLEStructAddressToCopy+1			; 85 34

B7_1ddf:		jsr updateFromRLEStruct		; 20 2f c3
B7_1de2:		jsr setPPUCtrl_addNMI_bgAt1000h		; 20 6e c1
B7_1de5:		jsr setPPUMask_addShowAll		; 20 5d c1
B7_1de8:		lda #$05		; a9 05
B7_1dea:		ldy #$04		; a0 04
B7_1dec:		jsr func_7_0636		; 20 36 c6
B7_1def:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1df2:		lda #$68		; a9 68
B7_1df4:		sta $0204		; 8d 04 02
B7_1df7:		lda #$83		; a9 83
B7_1df9:		sta $0205		; 8d 05 02
B7_1dfc:		lda #$01		; a9 01
B7_1dfe:		sta $0206		; 8d 06 02
B7_1e01:		lda #$50		; a9 50
B7_1e03:		sta $0207		; 8d 07 02

B7_1e06:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1e09:		lda wJoy1NewButtonsPressed			; a5 29
B7_1e0b:		and #PADF_START		; 29 10
B7_1e0d:		bne B7_1e26 ; d0 17

B7_1e0f:		lda wJoy1NewButtonsPressed			; a5 29
B7_1e11:		and #PADF_SELECT|PADF_UP|PADF_DOWN		; 29 2c
B7_1e13:		beq B7_1e06 ; f0 f1

B7_1e15:		ldx #$68		; a2 68
B7_1e17:		lda $0204		; ad 04 02
B7_1e1a:		cmp #$70		; c9 70
B7_1e1c:		bcs B7_1e20 ; b0 02

B7_1e1e:		ldx #$78		; a2 78
B7_1e20:		stx $0204		; 8e 04 02
B7_1e23:		jmp B7_1e06		; 4c 06 de

B7_1e26:		lda $0204		; ad 04 02
B7_1e29:		cmp #$70		; c9 70
B7_1e2b:		bcc B7_1e77 ; 90 4a

B7_1e2d:		ldy #$04		; a0 04
B7_1e2f:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_1e32:		jsr func_6_33e4		; 20 e4 b3
B7_1e35:		ldy #$04		; a0 04
B7_1e37:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_1e3a:		lda #$ff		; a9 ff
B7_1e3c:		sta $d7			; 85 d7
B7_1e3e:		jsr setRespawnVars		; 20 71 b8
B7_1e41:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1e44:		jsr setPPUMask_noSprites		; 20 53 c1
B7_1e47:		jsr roomTransitionUpdateChrPalMus2EntityBytes		; 20 c9 9d
B7_1e4a:		lda #$00		; a9 00
B7_1e4c:		sta $6c			; 85 6c
B7_1e4e:		sta wEntityDataByte2			; 85 52
B7_1e50:		sta $d6			; 85 d6
B7_1e52:		sta $55			; 85 55
B7_1e54:		lda $d5			; a5 d5
B7_1e56:		sta $d7			; 85 d7
B7_1e58:		sta wQueuedSoundsToPlay.w		; 8d 90 06
B7_1e5b:		lda #$01		; a9 01
B7_1e5d:		sta $d9			; 85 d9
B7_1e5f:		jsr setNametable1IfOddRoomX		; 20 d7 dc
B7_1e62:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1e65:		jsr b6_loadAllScreenRowsForCurrRoom		; 20 f3 de
B7_1e68:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1e6b:		jsr func_7_3000		; 20 00 f0
B7_1e6e:		jsr setPPUMask_addShowAll		; 20 5d c1
B7_1e71:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1e74:		jmp mainLoop		; 4c a9 de

B7_1e77:		lda #$24		; a9 24
B7_1e79:		jsr queueSoundAtoPlay		; 20 ad c4
B7_1e7c:		lda #$3e		; a9 3e
B7_1e7e:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_1e81:		jsr setPPUMask_noSprites		; 20 53 c1
B7_1e84:		jsr setPPUCtrl_noNMI		; 20 64 c1
B7_1e87:		jsr hideAllOam		; 20 9f c3
B7_1e8a:		jsr initGameVars		; 20 b2 de
B7_1e8d:		jsr b6_loadAllScreenRowsForCurrRoom		; 20 f3 de
B7_1e90:		jsr setNametable1IfOddRoomX		; 20 d7 dc
B7_1e93:		jsr setPPUCtrl_addNMI_bgAt1000h		; 20 6e c1
B7_1e96:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1e99:		jsr func_7_3000		; 20 00 f0
B7_1e9c:		jsr setPPUMask_addShowAll		; 20 5d c1
B7_1e9f:		lda #$04		; a9 04
B7_1ea1:		sta $d5			; 85 d5
B7_1ea3:		jsr func_7_04ab		; 20 ab c4
B7_1ea6:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1

; todo: just a guess
mainLoop:
B7_1ea9:		jsr execRoomSpecificEvent		; 20 4c df
B7_1eac:		jsr mainGameplayLoop		; 20 27 df
B7_1eaf:		jmp mainLoop		; 4c a9 de


initGameVars:
B7_1eb2:		lda #$1c		; a9 1c
B7_1eb4:		sta wRoomY			; 85 43
B7_1eb6:		lda #$0f		; a9 0f
B7_1eb8:		sta wRoomX			; 85 42
B7_1eba:		lda #$18		; a9 18
B7_1ebc:		sta wCurrHealth			; 85 7b
B7_1ebe:		lda #$00		; a9 00
B7_1ec0:		sta $b3			; 85 b3
B7_1ec2:		sta $b4			; 85 b4
B7_1ec4:		lda #$0a		; a9 0a
B7_1ec6:		sta wCurrAgility			; 85 b5
B7_1ec8:		lda #$80		; a9 80
B7_1eca:		sta $c0			; 85 c0
B7_1ecc:		lda #$84		; a9 84
B7_1ece:		sta wPlayerY			; 85 cc
B7_1ed0:		lda #$90		; a9 90
B7_1ed2:		sta wPlayerX			; 85 ce
B7_1ed4:		lda #$02		; a9 02
B7_1ed6:		sta wNewPlayerAnimationIdx			; 85 c1
B7_1ed8:		lda #$06		; a9 06
B7_1eda:		sta wPlayerAnimationDelaySpeed			; 85 c8
B7_1edc:		lda #$04		; a9 04
B7_1ede:		sta wBGChrBank			; 85 53
B7_1ee0:		jsr set_wChrBank1		; 20 db c1
B7_1ee3:		lda #$00		; a9 00
B7_1ee5:		jsr setInGameSprChrBank		; 20 bb c1
B7_1ee8:		lda #$04		; a9 04
B7_1eea:		jsr updateSavedInternalPalettesFromSpecA		; 20 b0 c6
B7_1eed:		lda #$10		; a9 10
B7_1eef:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_1ef2:		rts				; 60 


b6_loadAllScreenRowsForCurrRoom:
	lda wRoomY
	sta wTempRoomY
	lda wRoomX
	sta wTempRoomX

; loop 15 16-high rows
loadAllScreenRowsForSpecifiedRoom:
	lda #$0e
	sta wRoomLoadingRowIdx

B7_1eff:		lda #$80		; a9 80
B7_1f01:		sta $4a			; 85 4a
-	jsr func_7_1b4a		; 20 4a db
	dec wRoomLoadingRowIdx
	bpl -

	jmp safeRestoreDefaultPrgBank


func_7_1f0d:
B7_1f0d:		lda wRoomY			; a5 43
B7_1f0f:		sta $0d			; 85 0d
B7_1f11:		lda wRoomX			; a5 42
B7_1f13:		sta $0f			; 85 0f
B7_1f15:		lda #$0e		; a9 0e
B7_1f17:		sta $0c			; 85 0c
B7_1f19:		lda #$80		; a9 80
B7_1f1b:		sta $4a			; 85 4a
B7_1f1d:		jsr func_7_1b37		; 20 37 db
B7_1f20:		dec $0c			; c6 0c
B7_1f22:		bpl B7_1f1d ; 10 f9

B7_1f24:		jmp safeRestoreDefaultPrgBank		; 4c 95 c1


mainGameplayLoop:
	lda wPrgBank
	pha

B7_1f2a:		jsr func_7_20a3		; inits npcs
	jsr processPlayerInputInGame
	jsr handleScrollingRoomTransitions
B7_1f33:		jsr updateMagicEntities		; 20 2e c4
	jsr updateScreenEntities
B7_1f39:		jsr drawEntities		; deals with drawing npcs
B7_1f3c:		jsr drawPlayer		; 20 dd c3
B7_1f3f:		jsr processExp_etc_todo		; 20 44 f3
	jsr getNewRandomVal		; 20 8a c4
	jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1

	pla
	jmp safeSetPrgBankA


execRoomSpecificEvent:
	ldx #$00
@tryNext:
	lda roomEventYXs.w, x
	cmp #$ff
	beq @notFound

	cmp wRoomY
	bne +

	lda roomEventYXs.w+1, x
	cmp wRoomX
	beq @found

+	inx
	inx
	bne @tryNext

@notFound
	rts

@found:
; first 8 set global flags, others have code
	cpx #$10
	bcs @roomEventFuncs

	txa
	lsr a
	tax
	lda screenVisitedGlobalFlags.w, x
	jsr setGlobalFlag
	rts

@roomEventFuncs:
	txa
	lsr a
	sec
	sbc #$08
	jsr jumpTable

	.dw roomEvent_bogarda
	.dw roomEvent_muzh
	.dw roomEvent_eborsisk
	.dw roomEvent_kaelFight
	.dw roomEvent_bavmorda
	.dw roomEvent_prison
	.dw roomEvent_climbingOutOfWater
	.dw roomEvent_crossFluteIsland

roomEvent_prison:
	lda #GF_TALKED_TO_KAEL_IN_PRISON
	jsr checkGlobalFlag
	bne roomEvent_done

B7_1f92:		lda #$24		; a9 24
B7_1f94:		jsr queueSoundAtoPlay		; 20 ad c4
B7_1f97:		jsr func_6_22bf		; 20 bf a2
B7_1f9a:		jsr func_6_02a7		; 20 a7 82
B7_1f9d:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1fa0:		inc $5e			; e6 5e
B7_1fa2:		lda #$e4		; a9 e4
B7_1fa4:		sta wSprPaletteSpecAndChrBank			; 85 50
B7_1fa6:		jsr setSprPalAndChr_updateCurrScreensSprPalettes		; 20 3d dd
B7_1fa9:		lda #$a3		; a9 a3
B7_1fab:		ldx #$17		; a2 17
B7_1fad:		jsr initNpcSpecAIdxX		; 20 ec c3
B7_1fb0:		lda #$58		; a9 58
B7_1fb2:		sta wEntitiesY.w, x	; 9d 80 04
B7_1fb5:		lda #$30		; a9 30
B7_1fb7:		sta wEntitiesX.w, x	; 9d b0 04
B7_1fba:		jsr drawEntities		; 20 03 c4
B7_1fbd:		jsr drawPlayer		; 20 dd c3
B7_1fc0:		lda #$ff		; a9 ff
B7_1fc2:		sta $d5			; 85 d5
B7_1fc4:		lda #$80		; a9 80
B7_1fc6:		sta $d6			; 85 d6
B7_1fc8:		lda #$fd		; a9 fd
B7_1fca:		jsr queueSoundAtoPlay		; 20 ad c4
-	jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_1fd0:		lda $d6			; a5 d6
	bne -

B7_1fd4:		lda #$7e		; a9 7e
B7_1fd6:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_1fd9:		lda #$1f		; a9 1f
B7_1fdb:		sta wRoomY			; 85 43
B7_1fdd:		lda #$1e		; a9 1e
B7_1fdf:		sta wRoomX			; 85 42
B7_1fe1:		jmp func_7_203c		; 4c 3c e0

roomEvent_done:
	rts


roomEvent_crossFluteIsland:
	lda #GF_FLUTE_ITEM
	jsr checkGlobalFlag
	bne roomEvent_done

B7_1fec:		jsr func_6_22bf		; 20 bf a2
B7_1fef:		jsr func_6_02a7		; 20 a7 82
B7_1ff2:		lda #$0a		; a9 0a
B7_1ff4:		sta $00			; 85 00
B7_1ff6:		lda #$06		; a9 06
B7_1ff8:		bne B7_200d ; d0 13


roomEvent_climbingOutOfWater:
	lda #GF_CANE_MAGIC
	jsr checkGlobalFlag
	bne roomEvent_done

B7_2001:		jsr func_6_22bf		; 20 bf a2
B7_2004:		jsr func_6_02a7		; 20 a7 82

; morph this timess $40 frames
	lda #$13
	sta wScreenMorphFramesCounter

B7_200b:		lda #$07		; a9 07

B7_200d:		sta $d5			; 85 d5
B7_200f:		lda #$80		; a9 80
B7_2011:		sta $d6			; 85 d6
B7_2013:		lda #$fd		; a9 fd
B7_2015:		jsr queueSoundAtoPlay		; 20 ad c4
-	jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_201b:		lda $d6			; a5 d6
	bne -

; morph for #$13 * #$40 frames
--	lda #$3f
	sta wScreenMorphFramesCounter+1			; 85 01
-	jsr screenMorphEffect
	jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
	dec wScreenMorphFramesCounter+1			; c6 01
	bne -
	dec wScreenMorphFramesCounter			; c6 00
	bne --

B7_2031:		lda #$00		; a9 00
B7_2033:		sta wBGChrBank			; 85 53
B7_2035:		sta $d7			; 85 d7
B7_2037:		sta $d5			; 85 d5
B7_2039:		jsr set_wChrBank1		; 20 db c1

func_7_203c:
B7_203c:		jsr func_7_2045		; 20 45 e0
B7_203f:		ldx #$ff		; a2 ff
B7_2041:		txs				; 9a 
B7_2042:		jmp mainLoop		; 4c a9 de


func_7_2045:
B7_2045:		lda #$80		; a9 80
B7_2047:		sta $56			; 85 56

	ldy #$04
	jsr palettesAllFadeOutDelayY

B7_204e:		jsr func_6_1fa0		; 20 a0 9f
B7_2051:		jsr func_6_02a1		; 20 a1 82

	lda #DIR_DOWN
	sta wPlayerDirectionFacing

B7_2058:		jsr setPlayerMovementAnimationDetails		; 20 c4 82

	jsr drawEntities
	jsr drawPlayer
	jsr waitForMajorityOfNMIFuncsDone
	rts


roomEventYXs:
; compare room y then x
	.db $1a $0e
	.db $13 $0f
	.db $13 $03
	.db $0a $09
	.db $0f $19
	.db $02 $18
	.db $08 $03
	.db $0c $10

; boss rooms
	.db $02 $02 ; bogarda
	.db $04 $15 ; muzh
	.db $18 $11 ; eborsisk
	.db $00 $13 ; kael
	.db $11 $1b ; bavmorda
	.db $1c $02 ; prison
	.db $14 $0a ; after climing out of water
	.db $0b $03 ; confusing caves island w/ bridge
	.db $ff


screenVisitedGlobalFlags:
	.db GF_VISITED_NELWYN
	.db GF_VISITED_DEW
	.db GF_VISITED_POS_HOUSE
	.db GF_VISITED_BAR
	.db GF_VISITED_TIR_ASLEEN
	.db GF_VISITED_NOCKMAAR
	.db GF_VISITED_SACRED_TOWERS_HOUSE
	.db GF_VISITED_CANYON_MAZE_HOUSE


rleData_7_208e:
	dwbe $21ac
	.db $05
	.db $46 $47 $2a $45 $47

	dwbe $21ec
	.db $09
	.db $43 $2a $46 $46 $80 $27 $1e $45 $2d

	.db $ff


func_7_20a3:
B7_20a3:		bit wEntityDataByte2			; 24 52
B7_20a5:		bmi B7_20b1 ; 30 0a

B7_20a7:		lda $bf			; a5 bf
B7_20a9:		cmp #$09		; c9 09
B7_20ab:		bne B7_20b1 ; d0 04

B7_20ad:		lda $55			; a5 55
B7_20af:		beq B7_20b5 ; f0 04

B7_20b1:		lda $55			; a5 55
B7_20b3:		bne B7_20b6 ; d0 01

B7_20b5:		rts				; 60

B7_20b6:		cmp #$03		; c9 03
B7_20b8:		bne B7_20dc ; d0 22

B7_20ba:		ldx #$17		; a2 17
B7_20bc:		lda wEntitiesId.w, x	; bd 18 03
B7_20bf:		bne B7_20c4 ; d0 03

B7_20c1:		sta wEntitiesControlByte.w, x	; 9d 00 03
B7_20c4:		dex				; ca 
B7_20c5:		bpl B7_20bc ; 10 f5

B7_20c7:		lda $d5			; a5 d5
B7_20c9:		cmp #$04		; c9 04
B7_20cb:		beq B7_20da ; f0 0d

B7_20cd:		bit wEntityDataByte2			; 24 52
B7_20cf:		bmi B7_20da ; 30 09

B7_20d1:		bit $58			; 24 58
B7_20d3:		bvs B7_20da ; 70 05

B7_20d5:		lda #$09		; a9 09
B7_20d7:		jsr func_7_04ab		; 20 ab c4
B7_20da:		lda $55			; a5 55
B7_20dc:		cmp #$01		; c9 01
B7_20de:		beq B7_20ec ; f0 0c

B7_20e0:		sec				; 38 
B7_20e1:		sbc #$01		; e9 01
B7_20e3:		sta $55			; 85 55
B7_20e5:		cmp #$01		; c9 01
B7_20e7:		bne B7_2117 ; d0 2e

B7_20e9:		jsr loadScreenEntities		; 20 3c e1
B7_20ec:		ldx #$17		; a2 17
B7_20ee:		lda wEntitiesControlByte.w, x	; bd 00 03
B7_20f1:		bmi B7_2117 ; 30 24

B7_20f3:		dex				; ca 
B7_20f4:		cpx #$07		; e0 07
B7_20f6:		bne B7_20ee ; d0 f6

B7_20f8:		lda $d6			; a5 d6
B7_20fa:		bne B7_2105 ; d0 09

B7_20fc:		lda $d5			; a5 d5
B7_20fe:		cmp $d7			; c5 d7
B7_2100:		beq B7_2105 ; f0 03

B7_2102:		jsr func_7_04ab		; 20 ab c4
B7_2105:		lda wBGChrBank			; a5 53
B7_2107:		cmp #$03		; c9 03
B7_2109:		bcs B7_2112 ; b0 07

B7_210b:		lda #$00		; a9 00
B7_210d:		sta wBGChrBank			; 85 53
B7_210f:		jsr set_wChrBank1		; 20 db c1
B7_2112:		lda #$00		; a9 00
B7_2114:		sta $55			; 85 55
B7_2116:		rts				; 60 

B7_2117:		lda wBGChrBank			; a5 53
B7_2119:		cmp #$03		; c9 03
B7_211b:		bcs B7_2137 ; b0 1a

B7_211d:		bit wEntityDataByte2			; 24 52
B7_211f:		bmi B7_2137 ; 30 16

screenMorphEffect:
; morph every 8 frames
B7_2121:		lda wMajorNMIUpdatesCounter			; a5 23
B7_2123:		and #$07		; 29 07
B7_2125:		bne B7_2137 ; @done

; scroll through 4 values
B7_2127:		lda wMajorNMIUpdatesCounter			; a5 23
B7_2129:		and #$18		; 29 18
B7_212b:		lsr a			; 4a
B7_212c:		lsr a			; 4a
B7_212d:		lsr a			; 4a
B7_212e:		tay				; a8 
B7_212f:		lda data_7_2138.w, y	; b9 38 e1
B7_2132:		sta wBGChrBank			; 85 53
B7_2134:		jsr set_wChrBank1		; 20 db c1

B7_2137:		rts				; 60 

data_7_2138:
	.db $00 $01 $00 $02


loadScreenEntities:
	lda wPrgBank
	pha

	lda #:b5_loadScreenEntities
	jsr safeSetPrgBankA
	jsr b5_loadScreenEntities

	pla
	jmp safeSetPrgBankA


B7_214b:		ldy #$10		; a0 10
B7_214d:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_2150:		lda #$00		; a9 00
B7_2152:		sta $c0			; 85 c0
B7_2154:		jsr setPPUMask_noSprites		; 20 53 c1
B7_2157:		jsr setPPUCtrl_noNMI		; 20 64 c1
B7_215a:		jsr fillNametables01With20h		; 20 b1 c2
B7_215d:		jsr clearNametables01Palettes		; 20 90 c2
B7_2160:		jsr clearAllEntities		; 20 94 c3
B7_2163:		jsr hideAllOam		; 20 9f c3
B7_2166:		lda #$12		; a9 12
B7_2168:		jsr set_wChrBank1		; 20 db c1
B7_216b:		lda #$14		; a9 14
B7_216d:		jsr set_wChrBank0		; 20 c2 c1
B7_2170:		lda #$05		; a9 05
B7_2172:		sta wRoomX			; 85 42
B7_2174:		lda #$1f		; a9 1f
B7_2176:		sta wRoomY			; 85 43
B7_2178:		jsr loadAllScreenRowsForCurrRoom		; 20 1a c4
B7_217b:		lda wPPUCtrl			; a5 20
B7_217d:		ora #$01		; 09 01
B7_217f:		sta wPPUCtrl			; 85 20
B7_2181:		jsr $e62e		; 20 2e e6
B7_2184:		jsr setPPUCtrl_addNMI_bgAt1000h		; 20 6e c1
B7_2187:		jsr setPPUMask_addShowAll		; 20 5d c1
B7_218a:		jsr func_7_11b6		; 20 b6 d1
B7_218d:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_2190:		lda #$69		; a9 69
B7_2192:		ldy #$04		; a0 04
B7_2194:		jsr paletteSpecAFadeIn		; 20 2e c6
B7_2197:		lda #$14		; a9 14
B7_2199:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_219c:		lda #$7e		; a9 7e
B7_219e:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_21a1:		ldy #$04		; a0 04
B7_21a3:		jsr palettesBGFadeOut		; 20 0e c6
B7_21a6:		lda #$2f		; a9 2f
B7_21a8:		jsr queueSoundAtoPlay		; 20 ad c4
B7_21ab:		lda #$00		; a9 00
B7_21ad:		sta $b0			; 85 b0
B7_21af:		ldx #$05		; a2 05
B7_21b1:		ldy $b0			; a4 b0
B7_21b3:		lda $8e21, y	; b9 21 8e
B7_21b6:		sta wEntitiesY.w, x	; 9d 80 04
B7_21b9:		lda $8e37, y	; b9 37 8e
B7_21bc:		sta wEntitiesX.w, x	; 9d b0 04
B7_21bf:		lda $8e4d, y	; b9 4d 8e
B7_21c2:		jsr initNpcSpecAIdxX		; 20 ec c3
B7_21c5:		inc $b0			; e6 b0
B7_21c7:		lda $b0			; a5 b0
B7_21c9:		cmp #$0b		; c9 0b
B7_21cb:		beq B7_21ec ; f0 1f

B7_21cd:		cmp #$16		; c9 16
B7_21cf:		bcs B7_21f4 ; b0 23

B7_21d1:		jsr drawEntities		; 20 03 c4
B7_21d4:		jsr drawPlayer		; 20 dd c3
B7_21d7:		ldx #$02		; a2 02
B7_21d9:		lda wMajorNMIUpdatesCounter			; a5 23
B7_21db:		and #$04		; 29 04
B7_21dd:		bne B7_21e1 ; d0 02

B7_21df:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B7_21e1:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B7_21e1:	.db $ea $ea $ea
.endif
B7_21e4:		stx $30			; 86 30
B7_21e6:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_21e9:		jmp $e1af		; 4c af e1


B7_21ec:		lda #$2f		; a9 2f
B7_21ee:		jsr queueSoundAtoPlay		; 20 ad c4
B7_21f1:		jmp $e1d1		; 4c d1 e1


B7_21f4:		jsr drawEntities		; 20 03 c4
B7_21f7:		jsr drawPlayer		; 20 dd c3
B7_21fa:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_21fd:		ldx #$07		; a2 07
B7_21ff:		lda #$00		; a9 00
B7_2201:		sta wEntitiesControlByte.w, x	; 9d 00 03
B7_2204:		dex				; ca 
B7_2205:		bpl B7_21ff ; 10 f8

B7_2207:		jsr drawEntities		; 20 03 c4
B7_220a:		jsr drawPlayer		; 20 dd c3
B7_220d:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B7_220f:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B7_220f:	.db $ea $ea $ea
.endif
B7_2212:		stx $30			; 86 30
B7_2214:		lda #$69		; a9 69
B7_2216:		ldy #$04		; a0 04
B7_2218:		jsr paletteSpecAFadeIn		; 20 2e c6
B7_221b:		lda #$14		; a9 14
B7_221d:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_2220:		lda #$50		; a9 50
B7_2222:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_2225:		lda #$0c		; a9 0c
B7_2227:		sta $b0			; 85 b0
B7_2229:		ldx #$0f		; a2 0f
B7_222b:		lda wMajorNMIUpdatesCounter			; a5 23
B7_222d:		and #$04		; 29 04
B7_222f:		bne B7_2242 ; d0 11

B7_2231:		lda wMajorNMIUpdatesCounter			; a5 23
B7_2233:		and #$03		; 29 03
B7_2235:		bne B7_2240 ; d0 09

B7_2237:		lda #$23		; a9 23
B7_2239:		jsr queueSoundAtoPlay		; 20 ad c4
B7_223c:		dec $b0			; c6 b0
B7_223e:		beq B7_224d ; f0 0d

B7_2240:		ldx #$20		; a2 20
.ifndef NO_FLASH
B7_2242:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B7_2242:	.db $ea $ea $ea
.endif
B7_2245:		stx $30			; 86 30
B7_2247:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_224a:		jmp $e229		; 4c 29 e2


B7_224d:		lda #$14		; a9 14
B7_224f:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_2252:		lda #$5d		; a9 5d
B7_2254:		ldx #$00		; a2 00
B7_2256:		jsr initNpcSpecAIdxX		; 20 ec c3
B7_2259:		lda wEntities_330.w, x	; bd 30 03
B7_225c:		sta wEntitiesY.w, x	; 9d 80 04
B7_225f:		lda wEntities_348.w, x	; bd 48 03
B7_2262:		sta wEntitiesX.w, x	; 9d b0 04
B7_2265:		jsr drawEntities		; 20 03 c4
B7_2268:		jsr drawPlayer		; 20 dd c3
B7_226b:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B7_226e:		inc wEntities_468.w		; ee 68 04
B7_2271:		lda wEntities_468.w		; ad 68 04
B7_2274:		lsr a			; 4a
B7_2275:		bcc B7_227a ; 90 03

B7_2277:		dec wEntitiesY.w		; ce 80 04
B7_227a:		lda wEntitiesY.w		; ad 80 04
B7_227d:		cmp #$f8		; c9 f8
B7_227f:		bne B7_2265 ; d0 e4

B7_2281:		lda #$00		; a9 00
B7_2283:		sta wEntitiesControlByte.w		; 8d 00 03
B7_2286:		jsr drawEntities		; 20 03 c4
B7_2289:		jsr drawPlayer		; 20 dd c3
B7_228c:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_228f:		lda #$1c		; a9 1c
B7_2291:		jsr set_wChrBank0		; 20 c2 c1
B7_2294:		lda #$00		; a9 00
B7_2296:		jsr $e691		; 20 91 e6
B7_2299:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B7_229b:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B7_229b:	.db $ea $ea $ea
.endif
B7_229e:		stx $30			; 86 30
B7_22a0:		jsr func_7_04b9		; 20 b9 c4
B7_22a3:		lda #$11		; a9 11
B7_22a5:		jsr queueSoundAtoPlay		; 20 ad c4
B7_22a8:		lda #$fc		; a9 fc
B7_22aa:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_22ad:		jsr func_7_04c4		; 20 c4 c4
B7_22b0:		jsr $e64d		; 20 4d e6
B7_22b3:		lda #$01		; a9 01
B7_22b5:		jsr $e691		; 20 91 e6
B7_22b8:		lda #$08		; a9 08
B7_22ba:		jsr $e691		; 20 91 e6
B7_22bd:		jsr func_7_04b9		; 20 b9 c4
B7_22c0:		lda #$fc		; a9 fc
B7_22c2:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_22c5:		lda #$bd		; a9 bd
B7_22c7:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_22ca:		jsr func_7_04c4		; 20 c4 c4
B7_22cd:		jsr $e64d		; 20 4d e6
B7_22d0:		lda #$02		; a9 02
B7_22d2:		jsr $e691		; 20 91 e6
B7_22d5:		lda #$09		; a9 09
B7_22d7:		jsr $e691		; 20 91 e6
B7_22da:		jsr func_7_04b9		; 20 b9 c4
B7_22dd:		lda #$fc		; a9 fc
B7_22df:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_22e2:		lda #$bd		; a9 bd
B7_22e4:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_22e7:		jsr func_7_04c4		; 20 c4 c4
B7_22ea:		jsr $e64d		; 20 4d e6
B7_22ed:		lda #$03		; a9 03
B7_22ef:		jsr $e691		; 20 91 e6
B7_22f2:		lda #$0a		; a9 0a
B7_22f4:		jsr $e691		; 20 91 e6
B7_22f7:		jsr func_7_04b9		; 20 b9 c4
B7_22fa:		lda #$fc		; a9 fc
B7_22fc:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_22ff:		lda #$bd		; a9 bd
B7_2301:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_2304:		jsr func_7_04c4		; 20 c4 c4
B7_2307:		lda #$6a		; a9 6a
B7_2309:		sta $00			; 85 00
B7_230b:		lda $00			; a5 00
B7_230d:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_2310:		lda #$08		; a9 08
B7_2312:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_2315:		inc $00			; e6 00
B7_2317:		lda $00			; a5 00
B7_2319:		cmp #$70		; c9 70
B7_231b:		bne B7_230b ; d0 ee

B7_231d:		jsr $e64d		; 20 4d e6
B7_2320:		lda #$04		; a9 04
B7_2322:		jsr $e691		; 20 91 e6
B7_2325:		lda #$06		; a9 06
B7_2327:		jsr $e691		; 20 91 e6
B7_232a:		jsr func_7_04b9		; 20 b9 c4
B7_232d:		lda #$bd		; a9 bd
B7_232f:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_2332:		lda #$bd		; a9 bd
B7_2334:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_2337:		jsr func_7_04c4		; 20 c4 c4
B7_233a:		jsr $e64d		; 20 4d e6
B7_233d:		lda #$05		; a9 05
B7_233f:		jsr $e691		; 20 91 e6
B7_2342:		lda #$07		; a9 07
B7_2344:		jsr $e691		; 20 91 e6
B7_2347:		jsr func_7_04b9		; 20 b9 c4
B7_234a:		lda #$fc		; a9 fc
B7_234c:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_234f:		lda #$bd		; a9 bd
B7_2351:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B7_2354:		sec				; 38 
B7_2355:		ror $5d			; 66 5d
B7_2357:		ldy #$04		; a0 04
B7_2359:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_235c:		jsr setPPUMask_noSprites		; 20 53 c1
B7_235f:		lda #$00		; a9 00
B7_2361:		sta $d0			; 85 d0
B7_2363:		jsr hideAllOam		; 20 9f c3
B7_2366:		lda #$13		; a9 13
B7_2368:		jsr set_wChrBank0		; 20 c2 c1
B7_236b:		ldx #$00		; a2 00
B7_236d:		jsr $e762		; 20 62 e7
B7_2370:		lda #$21		; a9 21
B7_2372:		ldy #$8b		; a0 8b
B7_2374:		jsr func_7_2716		; 20 16 e7
B7_2377:		lda #$00		; a9 00
B7_2379:		jsr $e6a1		; 20 a1 e6
B7_237c:		lda #$3f		; a9 3f
B7_237e:		ldy #$04		; a0 04
B7_2380:		jsr $c51f		; 20 1f c5
B7_2383:		lda #$bd		; a9 bd
B7_2385:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_2388:		ldy #$04		; a0 04
B7_238a:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_238d:		jsr setPPUMask_noSprites		; 20 53 c1
B7_2390:		jsr hideAllOam		; 20 9f c3
B7_2393:		ldx #$01		; a2 01
B7_2395:		jsr $e762		; 20 62 e7
B7_2398:		jsr $e6f3		; 20 f3 e6
B7_239b:		lda #$01		; a9 01
B7_239d:		jsr $e6a1		; 20 a1 e6
B7_23a0:		lda #$06		; a9 06
B7_23a2:		jsr $e6a1		; 20 a1 e6
B7_23a5:		lda #$3f		; a9 3f
B7_23a7:		ldy #$04		; a0 04
B7_23a9:		jsr $c51f		; 20 1f c5
B7_23ac:		lda #$bd		; a9 bd
B7_23ae:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_23b1:		ldy #$04		; a0 04
B7_23b3:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_23b6:		jsr setPPUMask_noSprites		; 20 53 c1
B7_23b9:		jsr hideAllOam		; 20 9f c3
B7_23bc:		ldx #$02		; a2 02
B7_23be:		jsr $e762		; 20 62 e7
B7_23c1:		jsr $e6f3		; 20 f3 e6
B7_23c4:		lda #$02		; a9 02
B7_23c6:		jsr $e6a1		; 20 a1 e6
B7_23c9:		lda #$07		; a9 07
B7_23cb:		jsr $e6a1		; 20 a1 e6
B7_23ce:		lda #$3f		; a9 3f
B7_23d0:		ldy #$04		; a0 04
B7_23d2:		jsr $c51f		; 20 1f c5
B7_23d5:		lda #$bd		; a9 bd
B7_23d7:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_23da:		ldy #$04		; a0 04
B7_23dc:		jsr $c50b		; 20 0b c5
B7_23df:		jsr hideAllOam		; 20 9f c3
B7_23e2:		lda #$02		; a9 02
B7_23e4:		jsr $e6a1		; 20 a1 e6
B7_23e7:		lda #$08		; a9 08
B7_23e9:		jsr $e6a1		; 20 a1 e6
B7_23ec:		lda #$87		; a9 87
B7_23ee:		ldy #$04		; a0 04
B7_23f0:		jsr $c537		; 20 37 c5
B7_23f3:		lda #$bd		; a9 bd
B7_23f5:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_23f8:		ldy #$04		; a0 04
B7_23fa:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_23fd:		jsr setPPUMask_noSprites		; 20 53 c1
B7_2400:		jsr hideAllOam		; 20 9f c3
B7_2403:		ldx #$03		; a2 03
B7_2405:		jsr $e762		; 20 62 e7
B7_2408:		jsr $e6f3		; 20 f3 e6
B7_240b:		lda #$03		; a9 03
B7_240d:		jsr $e6a1		; 20 a1 e6
B7_2410:		lda #$09		; a9 09
B7_2412:		jsr $e6a1		; 20 a1 e6
B7_2415:		lda #$3f		; a9 3f
B7_2417:		ldy #$04		; a0 04
B7_2419:		jsr $c51f		; 20 1f c5
B7_241c:		lda #$bd		; a9 bd
B7_241e:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_2421:		ldy #$04		; a0 04
B7_2423:		jsr $c50b		; 20 0b c5
B7_2426:		jsr hideAllOam		; 20 9f c3
B7_2429:		lda #$03		; a9 03
B7_242b:		jsr $e6a1		; 20 a1 e6
B7_242e:		lda #$0a		; a9 0a
B7_2430:		jsr $e6a1		; 20 a1 e6
B7_2433:		lda #$87		; a9 87
B7_2435:		ldy #$04		; a0 04
B7_2437:		jsr $c537		; 20 37 c5
B7_243a:		lda #$bd		; a9 bd
B7_243c:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_243f:		ldy #$04		; a0 04
B7_2441:		jsr $c50b		; 20 0b c5
B7_2444:		jsr hideAllOam		; 20 9f c3
B7_2447:		lda #$03		; a9 03
B7_2449:		jsr $e6a1		; 20 a1 e6
B7_244c:		lda #$0b		; a9 0b
B7_244e:		jsr $e6a1		; 20 a1 e6
B7_2451:		lda #$87		; a9 87
B7_2453:		ldy #$04		; a0 04
B7_2455:		jsr $c537		; 20 37 c5
B7_2458:		lda #$bd		; a9 bd
B7_245a:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_245d:		ldy #$04		; a0 04
B7_245f:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_2462:		jsr setPPUMask_noSprites		; 20 53 c1
B7_2465:		jsr hideAllOam		; 20 9f c3
B7_2468:		ldx #$04		; a2 04
B7_246a:		jsr $e762		; 20 62 e7
B7_246d:		jsr $e6f3		; 20 f3 e6
B7_2470:		lda #$04		; a9 04
B7_2472:		jsr $e6a1		; 20 a1 e6
B7_2475:		lda #$0c		; a9 0c
B7_2477:		jsr $e6a1		; 20 a1 e6
B7_247a:		lda #$3f		; a9 3f
B7_247c:		ldy #$04		; a0 04
B7_247e:		jsr $c51f		; 20 1f c5
B7_2481:		lda #$bd		; a9 bd
B7_2483:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_2486:		ldy #$04		; a0 04
B7_2488:		jsr $c50b		; 20 0b c5
B7_248b:		jsr hideAllOam		; 20 9f c3
B7_248e:		lda #$04		; a9 04
B7_2490:		jsr $e6a1		; 20 a1 e6
B7_2493:		lda #$0d		; a9 0d
B7_2495:		jsr $e6a1		; 20 a1 e6
B7_2498:		lda #$87		; a9 87
B7_249a:		ldy #$04		; a0 04
B7_249c:		jsr $c537		; 20 37 c5
B7_249f:		lda #$bd		; a9 bd
B7_24a1:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_24a4:		ldy #$04		; a0 04
B7_24a6:		jsr $c50b		; 20 0b c5
B7_24a9:		jsr hideAllOam		; 20 9f c3
B7_24ac:		lda #$04		; a9 04
B7_24ae:		jsr $e6a1		; 20 a1 e6
B7_24b1:		lda #$0e		; a9 0e
B7_24b3:		jsr $e6a1		; 20 a1 e6
B7_24b6:		lda #$87		; a9 87
B7_24b8:		ldy #$04		; a0 04
B7_24ba:		jsr $c537		; 20 37 c5
B7_24bd:		lda #$bd		; a9 bd
B7_24bf:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_24c2:		ldy #$04		; a0 04
B7_24c4:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_24c7:		jsr setPPUMask_noSprites		; 20 53 c1
B7_24ca:		jsr hideAllOam		; 20 9f c3
B7_24cd:		ldx #$05		; a2 05
B7_24cf:		jsr $e762		; 20 62 e7
B7_24d2:		jsr $e6f3		; 20 f3 e6
B7_24d5:		lda #$05		; a9 05
B7_24d7:		jsr $e6a1		; 20 a1 e6
B7_24da:		lda #$0f		; a9 0f
B7_24dc:		jsr $e6a1		; 20 a1 e6
B7_24df:		lda #$3f		; a9 3f
B7_24e1:		ldy #$04		; a0 04
B7_24e3:		jsr $c51f		; 20 1f c5
B7_24e6:		lda #$bd		; a9 bd
B7_24e8:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_24eb:		ldy #$04		; a0 04
B7_24ed:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_24f0:		jsr setPPUMask_noSprites		; 20 53 c1
B7_24f3:		jsr hideAllOam		; 20 9f c3
B7_24f6:		ldx #$06		; a2 06
B7_24f8:		jsr $e762		; 20 62 e7
B7_24fb:		jsr $e6f3		; 20 f3 e6
B7_24fe:		lda #$14		; a9 14
B7_2500:		jsr $e6a1		; 20 a1 e6
B7_2503:		lda #$15		; a9 15
B7_2505:		jsr $e6a1		; 20 a1 e6
B7_2508:		lda #$3f		; a9 3f
B7_250a:		ldy #$04		; a0 04
B7_250c:		jsr $c51f		; 20 1f c5
B7_250f:		lda #$bd		; a9 bd
B7_2511:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_2514:		ldy #$04		; a0 04
B7_2516:		jsr $c50b		; 20 0b c5
B7_2519:		jsr hideAllOam		; 20 9f c3
B7_251c:		lda #$14		; a9 14
B7_251e:		jsr $e6a1		; 20 a1 e6
B7_2521:		lda #$16		; a9 16
B7_2523:		jsr $e6a1		; 20 a1 e6
B7_2526:		lda #$87		; a9 87
B7_2528:		ldy #$04		; a0 04
B7_252a:		jsr $c537		; 20 37 c5
B7_252d:		lda #$bd		; a9 bd
B7_252f:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_2532:		ldy #$04		; a0 04
B7_2534:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_2537:		jsr setPPUMask_noSprites		; 20 53 c1
B7_253a:		jsr hideAllOam		; 20 9f c3
B7_253d:		ldx #$07		; a2 07
B7_253f:		jsr $e762		; 20 62 e7
B7_2542:		jsr $e6f3		; 20 f3 e6
B7_2545:		lda #$10		; a9 10
B7_2547:		jsr $e6a1		; 20 a1 e6
B7_254a:		lda #$13		; a9 13
B7_254c:		jsr $e6a1		; 20 a1 e6
B7_254f:		lda #$3f		; a9 3f
B7_2551:		ldy #$04		; a0 04
B7_2553:		jsr $c51f		; 20 1f c5
B7_2556:		lda #$bd		; a9 bd
B7_2558:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_255b:		ldy #$04		; a0 04
B7_255d:		jsr $c50b		; 20 0b c5
B7_2560:		jsr hideAllOam		; 20 9f c3
B7_2563:		lda #$10		; a9 10
B7_2565:		jsr $e6a1		; 20 a1 e6
B7_2568:		lda #$11		; a9 11
B7_256a:		jsr $e6a1		; 20 a1 e6
B7_256d:		lda #$87		; a9 87
B7_256f:		ldy #$04		; a0 04
B7_2571:		jsr $c537		; 20 37 c5
B7_2574:		lda #$bd		; a9 bd
B7_2576:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_2579:		ldy #$04		; a0 04
B7_257b:		jsr $c50b		; 20 0b c5
B7_257e:		jsr hideAllOam		; 20 9f c3
B7_2581:		lda #$10		; a9 10
B7_2583:		jsr $e6a1		; 20 a1 e6
B7_2586:		lda #$12		; a9 12
B7_2588:		jsr $e6a1		; 20 a1 e6
B7_258b:		lda #$87		; a9 87
B7_258d:		ldy #$04		; a0 04
B7_258f:		jsr $c537		; 20 37 c5
B7_2592:		lda #$bd		; a9 bd
B7_2594:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_2597:		lda #$7e		; a9 7e
B7_2599:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_259c:		ldy #$04		; a0 04
B7_259e:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B7_25a1:		jsr setPPUMask_noSprites		; 20 53 c1
B7_25a4:		jsr hideAllOam		; 20 9f c3
B7_25a7:		lda #$1f		; a9 1f
B7_25a9:		jsr set_wChrBank0		; 20 c2 c1
B7_25ac:		ldx #$08		; a2 08
B7_25ae:		jsr $e762		; 20 62 e7
B7_25b1:		lda #$1f		; a9 1f
B7_25b3:		sta wRoomY			; 85 43
B7_25b5:		lda #$05		; a9 05
B7_25b7:		sta wRoomX			; 85 42
B7_25b9:		lda #$3f		; a9 3f
B7_25bb:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_25be:		lda #$00		; a9 00
B7_25c0:		sta $cd			; 85 cd
B7_25c2:		inc wRoomX			; e6 42
B7_25c4:		inc wRoomX			; e6 42
B7_25c6:		lda #$0e		; a9 0e
B7_25c8:		sta $0c			; 85 0c
B7_25ca:		lda wRoomY			; a5 43
B7_25cc:		sta $0d			; 85 0d
B7_25ce:		lda wRoomX			; a5 42
B7_25d0:		sta $0f			; 85 0f
B7_25d2:		lda #$80		; a9 80
B7_25d4:		sta $4a			; 85 4a
B7_25d6:		jsr func_7_18f7		; 20 f7 d8
B7_25d9:		lda wPPUScrollY			; a5 24
B7_25db:		sec				; 38 
B7_25dc:		sbc #$01		; e9 01
B7_25de:		cmp #$f0		; c9 f0
B7_25e0:		bcc B7_25e4 ; 90 02

B7_25e2:		sbc #$10		; e9 10
B7_25e4:		sta wPPUScrollY			; 85 24
B7_25e6:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_25e9:		lda $4c			; a5 4c
B7_25eb:		clc				; 18 
B7_25ec:		adc #$01		; 69 01
B7_25ee:		and #$0f		; 29 0f
B7_25f0:		sta $4c			; 85 4c
B7_25f2:		bne B7_25d6 ; d0 e2

B7_25f4:		lda wRoomX			; a5 42
B7_25f6:		cmp #$07		; c9 07
B7_25f8:		bne B7_260a ; d0 10

B7_25fa:		lda $0c			; a5 0c
B7_25fc:		cmp #$03		; c9 03
B7_25fe:		bne B7_260a ; d0 0a

B7_2600:		lda #$12		; a9 12
B7_2602:		jsr set_wChrBank1		; 20 db c1
B7_2605:		lda #$67		; a9 67
B7_2607:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_260a:		dec $0c			; c6 0c
B7_260c:		bpl B7_25d6 ; 10 c8

B7_260e:		lda wRoomX			; a5 42
B7_2610:		cmp #$0d		; c9 0d
B7_2612:		bcc B7_25c2 ; 90 ae

B7_2614:		lda #$bd		; a9 bd
B7_2616:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_2619:		jsr hideAllOam		; 20 9f c3
B7_261c:		lda #$17		; a9 17
B7_261e:		jsr $e6a1		; 20 a1 e6
B7_2621:		lda #$63		; a9 63
B7_2623:		ldy #$08		; a0 08
B7_2625:		jsr $c51f		; 20 1f c5
B7_2628:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_262b:		jmp $e628		; 4c 28 e6


B7_262e:		lda PPUSTATUS.w		; ad 02 20
B7_2631:		ldx #$26		; a2 26
B7_2633:		stx PPUADDR.w		; 8e 06 20
B7_2636:		lda #$80		; a9 80
B7_2638:		sta PPUADDR.w		; 8d 06 20
B7_263b:		ldx #$00		; a2 00
B7_263d:		ldy #$02		; a0 02
B7_263f:		lda #$20		; a9 20
B7_2641:		sta PPUDATA.w		; 8d 07 20
B7_2644:		inx				; e8 
B7_2645:		cpx #$40		; e0 40
B7_2647:		bne B7_263f ; d0 f6

B7_2649:		dey				; 88 
B7_264a:		bne B7_263f ; d0 f3

B7_264c:		rts				; 60 


B7_264d:		lda #$26		; a9 26
B7_264f:		ldy #$c0		; a0 c0
B7_2651:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2
B7_2654:		lda #$26		; a9 26
B7_2656:		ldy #$e0		; a0 e0
B7_2658:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2
B7_265b:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B7_265e:		lda #$27		; a9 27
B7_2660:		ldy #$00		; a0 00
B7_2662:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2
B7_2665:		lda #$27		; a9 27
B7_2667:		ldy #$20		; a0 20
B7_2669:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2
B7_266c:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B7_266f:		lda #$27		; a9 27
B7_2671:		ldy #$40		; a0 40
B7_2673:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2
B7_2676:		lda #$27		; a9 27
B7_2678:		ldy #$60		; a0 60
B7_267a:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2
B7_267d:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B7_2680:		rts				; 60 


B7_2681:		asl a			; 0a
B7_2682:		tay				; a8 
B7_2683:		lda $e7bf, y	; b9 bf e7
B7_2686:		sta wRLEStructAddressToCopy			; 85 33
B7_2688:		lda $e7c0, y	; b9 c0 e7
B7_268b:		sta wRLEStructAddressToCopy+1			; 85 34
B7_268d:		jsr updateFromRLEStruct		; 20 2f c3
B7_2690:		rts				; 60 


B7_2691:		asl a			; 0a
B7_2692:		tay				; a8 
B7_2693:		lda $e7bf, y	; b9 bf e7
B7_2696:		sta wRLEStructAddressToCopy			; 85 33
B7_2698:		lda $e7c0, y	; b9 c0 e7
B7_269b:		sta wRLEStructAddressToCopy+1			; 85 34
B7_269d:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B7_26a0:		rts				; 60 


B7_26a1:		asl a			; 0a
B7_26a2:		tay				; a8 
B7_26a3:		lda $e99e, y	; b9 9e e9
B7_26a6:		sta $00			; 85 00
B7_26a8:		lda $e99f, y	; b9 9f e9
B7_26ab:		sta $01			; 85 01
B7_26ad:		ldy #$00		; a0 00
B7_26af:		lda ($00), y	; b1 00
B7_26b1:		sta $02			; 85 02
B7_26b3:		iny				; c8 
B7_26b4:		lda ($00), y	; b1 00
B7_26b6:		sta $03			; 85 03
B7_26b8:		iny				; c8 
B7_26b9:		lda ($00), y	; b1 00
B7_26bb:		sta $05			; 85 05
B7_26bd:		iny				; c8 
B7_26be:		lda ($00), y	; b1 00
B7_26c0:		sta $06			; 85 06
B7_26c2:		ldx $d0			; a6 d0
B7_26c4:		lda $03			; a5 03
B7_26c6:		sta wOam.Y.w, x	; 9d 00 02
B7_26c9:		lda $05			; a5 05
B7_26cb:		sta wOam.attr.w, x	; 9d 02 02
B7_26ce:		lda $06			; a5 06
B7_26d0:		sta wOam.X.w, x	; 9d 03 02
B7_26d3:		clc				; 18 
B7_26d4:		adc #$08		; 69 08
B7_26d6:		sta $06			; 85 06
B7_26d8:		iny				; c8 
B7_26d9:		lda ($00), y	; b1 00
B7_26db:		cmp #$20		; c9 20
B7_26dd:		beq B7_26ce ; f0 ef

B7_26df:		sta wOam.tile.w, x	; 9d 01 02
B7_26e2:		lda $d0			; a5 d0
B7_26e4:		clc				; 18 
B7_26e5:		adc #$04		; 69 04
B7_26e7:		sta $d0			; 85 d0
B7_26e9:		dec $02			; c6 02
B7_26eb:		bne B7_26c2 ; d0 d5

B7_26ed:		iny				; c8 
B7_26ee:		lda ($00), y	; b1 00
B7_26f0:		bne B7_26b1 ; d0 bf

B7_26f2:		rts				; 60 


B7_26f3:		ldx #$21		; a2 21
B7_26f5:		lda wRoomX			; a5 42
B7_26f7:		lsr a			; 4a
B7_26f8:		bcc B7_26fe ; 90 04

B7_26fa:		inx				; e8 
B7_26fb:		inx				; e8 
B7_26fc:		inx				; e8 
B7_26fd:		inx				; e8 
B7_26fe:		txa				; 8a 
B7_26ff:		ldy #$48		; a0 48
B7_2701:		jsr func_7_2716		; 20 16 e7
B7_2704:		ldx #$22		; a2 22
B7_2706:		lda wRoomX			; a5 42
B7_2708:		lsr a			; 4a
B7_2709:		bcc B7_270f ; 90 04

B7_270b:		inx				; e8 
B7_270c:		inx				; e8 
B7_270d:		inx				; e8 
B7_270e:		inx				; e8 
B7_270f:		txa				; 8a 
B7_2710:		ldy #$0e		; a0 0e
B7_2712:		jsr func_7_2716		; 20 16 e7
B7_2715:		rts				; 60 


func_7_2716:
B7_2716:		sta $00			; 85 00
B7_2718:		sty $01			; 84 01
B7_271a:		jsr func_7_2727		; 20 27 e7
B7_271d:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_2720:		jsr func_7_2727		; 20 27 e7
B7_2723:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_2726:		rts				; 60 


func_7_2727:
B7_2727:		lda #$02		; a9 02
B7_2729:		sta $02			; 85 02
B7_272b:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B7_272d:		lda $00			; a5 00
B7_272f:		sta wVramQueue.w, x	; 9d 00 05
B7_2732:		inx				; e8 
B7_2733:		lda $01			; a5 01
B7_2735:		sta wVramQueue.w, x	; 9d 00 05
B7_2738:		inx				; e8 
B7_2739:		lda #$0a		; a9 0a
B7_273b:		sta wVramQueue.w, x	; 9d 00 05
B7_273e:		inx				; e8 
B7_273f:		tay				; a8 
B7_2740:		lda #$20		; a9 20
B7_2742:		sta wVramQueue.w, x	; 9d 00 05
B7_2745:		inx				; e8 
B7_2746:		dey				; 88 
B7_2747:		bne B7_2740 ; d0 f7

B7_2749:		lda $01			; a5 01
B7_274b:		clc				; 18 
B7_274c:		adc #$20		; 69 20
B7_274e:		sta $01			; 85 01
B7_2750:		lda $00			; a5 00
B7_2752:		adc #$00		; 69 00
B7_2754:		sta $00			; 85 00
B7_2756:		dec $02			; c6 02
B7_2758:		bne B7_272d ; d0 d3

B7_275a:		lda #$00		; a9 00
B7_275c:		sta wVramQueue.w, x	; 9d 00 05
B7_275f:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B7_2761:		rts				; 60 


B7_2762:		jsr $e786		; 20 86 e7
B7_2765:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_2768:		jsr b6_loadAllScreenRowsForCurrRoom		; 20 f3 de
B7_276b:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_276e:		lda wBGChrBank			; a5 53
B7_2770:		jsr set_wChrBank1		; 20 db c1
B7_2773:		jsr setNametable1IfOddRoomX		; 20 d7 dc
B7_2776:		jsr setPPUMask_addShowAll		; 20 5d c1
B7_2779:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B7_277b:		ldy #$04		; a0 04
B7_277d:		jsr palettesBGFadeOut_saveSpecADelayY		; 20 ff c5
B7_2780:		lda #$3f		; a9 3f
B7_2782:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_2785:		rts				; 60 


B7_2786:		lda $e7a4, x	; bd a4 e7
B7_2789:		sta wRoomY			; 85 43
B7_278b:		lda $e7ad, x	; bd ad e7
B7_278e:		sta wRoomX			; 85 42
B7_2790:		lda $e7b6, x	; bd b6 e7
B7_2793:		asl a			; 0a
B7_2794:		clc				; 18 
B7_2795:		adc $e7b6, x	; 7d b6 e7
B7_2798:		tay				; a8 
B7_2799:		lda $9ee9, y	; b9 e9 9e
B7_279c:		sta wBGChrBank			; 85 53
B7_279e:		lda $9eea, y	; b9 ea 9e
B7_27a1:		sta wSavedInternalPalettesSpecIdx			; 85 2f
B7_27a3:		rts				; 60 


B7_27a4:		ora $120f		; 0d 0f 12
B7_27a7:		.db $00				; 00
B7_27a8:		ora ($08, x)	; 01 08
B7_27aa:	.db $0b
B7_27ab:	.db $1c
B7_27ac:		ora #$0e		; 09 0e
B7_27ae:	.db $1a
B7_27af:	.db $02
B7_27b0:		clc				; 18 
B7_27b1:		asl $02, x		; 16 02
B7_27b3:	.db $02
B7_27b4:	.db $0f
B7_27b5:		ora $0500.w, y	; 19 00 05
B7_27b8:		asl $1602		; 0e 02 16
B7_27bb:		ora ($00, x)	; 01 00
B7_27bd:	.db $04
B7_27be:		asl $e7d5, x	; 1e d5 e7
B7_27c1:		ora $4ce8		; 0d e8 4c
B7_27c4:		inx				; e8 
B7_27c5:		lda ($e8, x)	; a1 e8
B7_27c7:		beq B7_27b1 ; f0 e8

B7_27c9:	.db $2f
B7_27ca:		sbc #$12		; e9 12
B7_27cc:		sbc #$6a		; e9 6a
B7_27ce:		sbc #$12		; e9 12
B7_27d0:		inx				; e8 
B7_27d1:		sty $e8			; 84 e8
B7_27d3:	.db $c3
B7_27d4:		inx				; e8 
B7_27d5:	.db $27
B7_27d6:		ora $16			; 05 16
B7_27d8:		eor ($4e, x)	; 41 4e
B7_27da:	.db $44
B7_27db:		jsr $4f53		; 20 53 4f
B7_27de:		jsr $4e45		; 20 45 4e
B7_27e1:	.db $44
B7_27e2:		eor $44			; 45 44
B7_27e4:		jsr $4142		; 20 42 41
B7_27e7:		lsr $4d, x		; 56 4d
B7_27e9:	.db $4f
B7_27ea:	.db $52
B7_27eb:	.db $44
B7_27ec:		eor ($2c, x)	; 41 2c
B7_27ee:	.db $27
B7_27ef:	.db $43
B7_27f0:	.db $1b
B7_27f1:	.db $54
B7_27f2:		pha				; 48 
B7_27f3:		eor $20			; 45 20
B7_27f5:		eor $5345		; 4d 45 53
B7_27f8:	.db $53
B7_27f9:		eor $4e			; 45 4e
B7_27fb:	.db $47
B7_27fc:		eor $52			; 45 52
B7_27fe:		jsr $464f		; 20 4f 46
B7_2801:		jsr $4854		; 20 54 48
B7_2804:		eor $20			; 45 20
B7_2806:	.db $53
B7_2807:	.db $4b
B7_2808:		eor #$45		; 49 45
B7_280a:	.db $53
B7_280b:		rol $26ff		; 2e ff 26
B7_280e:	.db $e2
B7_280f:		ora ($20, x)	; 01 20
B7_2811:	.db $ff
B7_2812:	.db $27
B7_2813:	.db $03
B7_2814:	.db $1a
B7_2815:	.db $57
B7_2816:		pha				; 48 
B7_2817:	.db $4f
B7_2818:		jsr $5543		; 20 43 55
B7_281b:	.db $54
B7_281c:		jsr $4954		; 20 54 49
B7_281f:		eor $53			; 45 53
B7_2821:		jsr $4e45		; 20 45 4e
B7_2824:	.db $54
B7_2825:		eor #$52		; 49 52
B7_2827:		eor $4c			; 45 4c
B7_2829:		eor $5720, y	; 59 20 57
B7_282c:		eor #$54		; 49 54
B7_282e:		pha				; 48 
B7_282f:	.db $27
B7_2830:	.db $43
B7_2831:		ora $4854, y	; 19 54 48
B7_2834:		eor $20			; 45 20
B7_2836:	.db $53
B7_2837:		bvc B7_2882 ; 50 49

B7_2839:	.db $52
B7_283a:		eor #$54		; 49 54
B7_283c:	.db $53
B7_283d:		jsr $464f		; 20 4f 46
B7_2840:		jsr $4854		; 20 54 48
B7_2843:		eor $20			; 45 20
B7_2845:	.db $53
B7_2846:	.db $4b
B7_2847:		eor #$45		; 49 45
B7_2849:	.db $53
B7_284a:		rol $26ff		; 2e ff 26
B7_284d:	.db $e3
B7_284e:		ora $4e4f, y	; 19 4f 4e
B7_2851:		jmp $2059		; 4c 59 20


B7_2854:	.db $54
B7_2855:		pha				; 48 
B7_2856:	.db $52
B7_2857:	.db $4f
B7_2858:		eor $47, x		; 55 47
B7_285a:		pha				; 48 
B7_285b:		jsr $4854		; 20 54 48
B7_285e:		eor $20			; 45 20
B7_2860:		;removed
	.db $50 $4f

B7_2862:	.db $57
B7_2863:		eor $52			; 45 52
B7_2865:		lsr $55			; 46 55
B7_2867:		jmp $2427		; 4c 27 24


B7_286a:		clc				; 18 
B7_286b:		eor $4741		; 4d 41 47
B7_286e:		eor #$43		; 49 43
B7_2870:		jsr $464f		; 20 4f 46
B7_2873:		jsr $4946		; 20 46 49
B7_2876:		lsr $5220		; 4e 20 52
B7_2879:		eor ($5a, x)	; 41 5a
B7_287b:		eor #$45		; 49 45
B7_287d:		jmp $202c		; 4c 2c 20


B7_2880:	.db $54
B7_2881:		pha				; 48 
B7_2882:		eor $ff			; 45 ff
B7_2884:	.db $27
B7_2885:	.db $64
B7_2886:		ora $4942, y	; 19 42 49
B7_2889:	.db $52
B7_288a:	.db $54
B7_288b:		pha				; 48 
B7_288c:		jsr $464f		; 20 4f 46
B7_288f:		jsr $4c45		; 20 45 4c
B7_2892:	.db $4f
B7_2893:	.db $52
B7_2894:		eor ($20, x)	; 41 20
B7_2896:	.db $44
B7_2897:		eor ($4e, x)	; 41 4e
B7_2899:		eor ($4e, x)	; 41 4e
B7_289b:		bit $4120		; 2c 20 41
B7_289e:		lsr $ff44		; 4e 44 ff
B7_28a1:		rol $e1			; 26 e1
B7_28a3:		asl $4957, x	; 1e 57 49
B7_28a6:		jmp $4f4c		; 4c 4c 4f


B7_28a9:	.db $57
B7_28aa:		bit $5420		; 2c 20 54
B7_28ad:		pha				; 48 
B7_28ae:		eor $20			; 45 20
B7_28b0:		eor $4e41		; 4d 41 4e
B7_28b3:		jsr $464f		; 20 4f 46
B7_28b6:		jsr $4f43		; 20 43 4f
B7_28b9:		eor $52, x		; 55 52
B7_28bb:		eor ($47, x)	; 41 47
B7_28bd:		eor $20			; 45 20
B7_28bf:		eor ($4e, x)	; 41 4e
B7_28c1:	.db $44
B7_28c2:	.db $ff
B7_28c3:	.db $27
B7_28c4:		and ($1d, x)	; 21 1d
B7_28c6:	.db $42
B7_28c7:		eor $4c			; 45 4c
B7_28c9:		eor #$45		; 49 45
B7_28cb:		lsr $2c			; 46 2c
B7_28cd:		jsr $4157		; 20 57 41
B7_28d0:	.db $53
B7_28d1:		jsr $4142		; 20 42 41
B7_28d4:		lsr $4d, x		; 56 4d
B7_28d6:	.db $4f
B7_28d7:	.db $52
B7_28d8:	.db $44
B7_28d9:		eor ($27, x)	; 41 27
B7_28db:	.db $53
B7_28dc:		jsr $454d		; 20 4d 45
B7_28df:		lsr $4341		; 4e 41 43
B7_28e2:		eor $27			; 45 27
B7_28e4:		jmp ($5409)		; 6c 09 54


B7_28e7:		pha				; 48 
B7_28e8:	.db $57
B7_28e9:		eor ($52, x)	; 41 52
B7_28eb:	.db $54
B7_28ec:		eor $44			; 45 44
B7_28ee:		rol $27ff		; 2e ff 27
B7_28f1:	.db $02
B7_28f2:		asl $4854, x	; 1e 54 48
B7_28f5:		eor $20			; 45 20
B7_28f7:	.db $53
B7_28f8:		bvc B7_294c ; 50 52

B7_28fa:		eor #$54		; 49 54
B7_28fc:		jsr $464f		; 20 4f 46
B7_28ff:		jsr $4854		; 20 54 48
B7_2902:		eor $20			; 45 20
B7_2904:	.db $53
B7_2905:	.db $4b
B7_2906:		eor #$45		; 49 45
B7_2908:	.db $53
B7_2909:		jsr $5242		; 20 42 52
B7_290c:	.db $4f
B7_290d:		eor $47, x		; 55 47
B7_290f:		pha				; 48 
B7_2910:	.db $54
B7_2911:	.db $ff
B7_2912:	.db $27
B7_2913:	.db $44
B7_2914:		ora $4142, y	; 19 42 41
B7_2917:		lsr $4d, x		; 56 4d
B7_2919:	.db $4f
B7_291a:	.db $52
B7_291b:	.db $44
B7_291c:		eor ($20, x)	; 41 20
B7_291e:	.db $42
B7_291f:		eor ($43, x)	; 41 43
B7_2921:	.db $4b
B7_2922:		jsr $4f54		; 20 54 4f
B7_2925:		jsr $4854		; 20 54 48
B7_2928:		eor $20			; 45 20
B7_292a:	.db $53
B7_292b:	.db $4b
B7_292c:		eor $ff2e, y	; 59 2e ff
B7_292f:		rol $c2			; 26 c2
B7_2931:	.db $1c
B7_2932:	.db $54
B7_2933:		pha				; 48 
B7_2934:		eor $20			; 45 20
B7_2936:		bvc B7_297d ; 50 45

B7_2938:	.db $4f
B7_2939:		;removed
	.db $50 $4c

B7_293b:		eor $20			; 45 20
B7_293d:	.db $43
B7_293e:		pha				; 48 
B7_293f:	.db $4f
B7_2940:	.db $53
B7_2941:		eor $20			; 45 20
B7_2943:		eor $4c			; 45 4c
B7_2945:	.db $4f
B7_2946:	.db $52
B7_2947:		eor ($20, x)	; 41 20
B7_2949:	.db $44
B7_294a:		eor ($4e, x)	; 41 4e
B7_294c:		eor ($4e, x)	; 41 4e
B7_294e:	.db $27
B7_294f:	.db $04
B7_2950:		clc				; 18 
B7_2951:		eor ($53, x)	; 41 53
B7_2953:		jsr $4854		; 20 54 48
B7_2956:		eor $49			; 45 49
B7_2958:	.db $52
B7_2959:		jsr $5551		; 20 51 55
B7_295c:		eor $45			; 45 45
B7_295e:		lsr $4120		; 4e 20 41
B7_2961:		lsr $2044		; 4e 44 20
B7_2964:		jmp $5649		; 4c 49 56


B7_2967:		eor $44			; 45 44
B7_2969:	.db $ff
B7_296a:	.db $27
B7_296b:	.db $44
B7_296c:		clc				; 18 
B7_296d:		pha				; 48 
B7_296e:		eor ($50, x)	; 41 50
B7_2970:		;removed
	.db $50 $49

B7_2972:		jmp $2c59		; 4c 59 2c


B7_2975:		jsr $4957		; 20 57 49
B7_2978:	.db $53
B7_2979:		pha				; 48 
B7_297a:		eor #$4e		; 49 4e
B7_297c:	.db $47
B7_297d:		jsr $4f46		; 20 46 4f
B7_2980:	.db $52
B7_2981:		jsr $4548		; 20 48 45
B7_2984:	.db $52
B7_2985:	.db $27
B7_2986:		stx $15			; 86 15
B7_2988:	.db $57
B7_2989:		eor $41			; 45 41
B7_298b:		jmp $4854		; 4c 54 48


B7_298e:		jsr $4e41		; 20 41 4e
B7_2991:	.db $44
B7_2992:		jsr $4148		; 20 48 41
B7_2995:		bvc B7_29e7 ; 50 50

B7_2997:		eor #$4e		; 49 4e
B7_2999:		eor $53			; 45 53
B7_299b:	.db $53
B7_299c:		rol $ceff		; 2e ff ce
B7_299f:		sbc #$d8		; e9 d8
B7_29a1:		sbc #$eb		; e9 eb
B7_29a3:		sbc #$f7		; e9 f7
B7_29a5:		sbc #$0c		; e9 0c
B7_29a7:		nop				; ea 
B7_29a8:	.db $22
B7_29a9:		nop				; ea 
B7_29aa:	.db $37
B7_29ab:		nop				; ea 
B7_29ac:	.db $3f
B7_29ad:		nop				; ea 
B7_29ae:	.db $52
B7_29af:		nop				; ea 
B7_29b0:	.db $5a
B7_29b1:		nop				; ea 
B7_29b2:		ror $ea			; 66 ea
B7_29b4:	.db $6f
B7_29b5:		nop				; ea 
B7_29b6:	.db $7c
B7_29b7:		nop				; ea 
B7_29b8:		dey				; 88 
B7_29b9:		nop				; ea 
B7_29ba:		sta $ea, x		; 95 ea
B7_29bc:		ldx #$ea		; a2 ea
B7_29be:		lda $d4ea		; ad ea d4
B7_29c1:		nop				; ea 
B7_29c2:		sbc #$ea		; e9 ea
B7_29c4:	.db $c2
B7_29c5:		nop				; ea 
B7_29c6:	.db $f4
B7_29c7:		nop				; ea 
B7_29c8:		asl a			; 0a
B7_29c9:	.db $eb
B7_29ca:	.db $17
B7_29cb:	.db $eb
B7_29cc:		bit $eb			; 24 eb
B7_29ce:		ora $6c			; 05 6c
B7_29d0:		.db $00				; 00
B7_29d1:		jmp ($4746)		; 6c 46 47


B7_29d4:		rol a			; 2a
B7_29d5:		ora $15, x		; 15 15
B7_29d7:		.db $00				; 00
B7_29d8:	.db $04
B7_29d9:		cli				; 58 
B7_29da:		.db $00				; 00
B7_29db:		pha				; 48 
B7_29dc:		asl $2a, x		; 16 2a
B7_29de:	.db $1c
B7_29df:		rol $6006		; 2e 06 60
B7_29e2:		.db $00				; 00
B7_29e3:		cli				; 58 
B7_29e4:		and $462e		; 2d 2e 46
B7_29e7:		clc				; 18 
B7_29e8:		asl $1d, x		; 16 1d
B7_29ea:		.db $00				; 00
B7_29eb:	.db $07
B7_29ec:	.db $5c
B7_29ed:		.db $00				; 00
B7_29ee:		jmp $4543		; 4c 43 45


B7_29f1:		asl $4516, x	; 1e 16 45
B7_29f4:		rol a			; 2a
B7_29f5:	.db $1c
B7_29f6:		.db $00				; 00
B7_29f7:		asl $58			; 06 58
B7_29f9:		.db $00				; 00
B7_29fa:		pha				; 48 
B7_29fb:		rol $18			; 26 18
B7_29fd:		lsr $25			; 46 25
B7_29ff:		rol a			; 2a
B7_2a00:	.db $1b
B7_2a01:		asl $60			; 06 60
B7_2a03:		.db $00				; 00
B7_2a04:		cli				; 58 
B7_2a05:		and $462e		; 2d 2e 46
B7_2a08:		clc				; 18 
B7_2a09:		asl $1d, x		; 16 1d
B7_2a0b:		.db $00				; 00
B7_2a0c:	.db $07
B7_2a0d:		cli				; 58 
B7_2a0e:		.db $00				; 00
B7_2a0f:		pha				; 48 
B7_2a10:	.db $1c
B7_2a11:		asl $461d, x	; 1e 1d 46
B7_2a14:	.db $47
B7_2a15:		rol $0645		; 2e 45 06
B7_2a18:		rts				; 60 


B7_2a19:		.db $00				; 00
B7_2a1a:		cli				; 58 
B7_2a1b:		and $462e		; 2d 2e 46
B7_2a1e:		clc				; 18 
B7_2a1f:		asl $1d, x		; 16 1d
B7_2a21:		.db $00				; 00
B7_2a22:		ora $58			; 05 58
B7_2a24:		.db $00				; 00
B7_2a25:		pha				; 48 
B7_2a26:		lsr $1e			; 46 1e
B7_2a28:		and $1d			; 25 1d
B7_2a2a:		and $6007		; 2d 07 60
B7_2a2d:		.db $00				; 00
B7_2a2e:		bvc B7_2a73 ; 50 43

B7_2a30:		eor $1e			; 45 1e
B7_2a32:		asl $45, x		; 16 45
B7_2a34:		rol a			; 2a
B7_2a35:	.db $1c
B7_2a36:		.db $00				; 00
B7_2a37:	.db $03
B7_2a38:		sty $8c01		; 8c 01 8c
B7_2a3b:		rol a			; 2a
B7_2a3c:	.db $7c
B7_2a3d:	.db $1a
B7_2a3e:		.db $00				; 00
B7_2a3f:		ora $88			; 05 88
B7_2a41:		ora ($78, x)	; 01 78
B7_2a43:		and $262a		; 2d 2a 26
B7_2a46:		clc				; 18 
B7_2a47:		and $9005		; 2d 05 90
B7_2a4a:		ora ($90, x)	; 01 90
B7_2a4c:	.db $2b
B7_2a4d:		asl $2709, x	; 1e 09 27
B7_2a50:		and #$00		; 29 00
B7_2a52:	.db $03
B7_2a53:		sty $8c01		; 8c 01 8c
B7_2a56:	.db $1c
B7_2a57:	.db $1e $2e $00
B7_2a5a:	.db $07
B7_2a5b:		sty $7c01		; 8c 01 7c
B7_2a5e:	.db $1c
B7_2a5f:		rol a			; 2a
B7_2a60:		ora $462a, x	; 1d 2a 46
B7_2a63:	.db $17
B7_2a64:		clc				; 18 
B7_2a65:		.db $00				; 00
B7_2a66:	.db $04
B7_2a67:		sty $8801		; 8c 01 88
B7_2a6a:		and #$25		; 29 25
B7_2a6c:	.db $1a
B7_2a6d:		clc				; 18 
B7_2a6e:		.db $00				; 00
B7_2a6f:		php				; 08 
B7_2a70:		sty $7801		; 8c 01 78
B7_2a73:		ora $162a, x	; 1d 2a 16
B7_2a76:		clc				; 18 
B7_2a77:		ora $1a2e, x	; 1d 2e 1a
B7_2a7a:		asl $0700, x	; 1e 00 07
B7_2a7d:		sty $7c01		; 8c 01 7c
B7_2a80:	.db $47
B7_2a81:		asl $0f1c, x	; 1e 1c 0f
B7_2a84:	.db $43
B7_2a85:	.db $1e $1d $00
B7_2a88:		php				; 08 
B7_2a89:		sty $7801		; 8c 01 78
B7_2a8c:		ora $18, x		; 15 18
B7_2a8e:		lsr $17			; 46 17
B7_2a90:	.db $80
B7_2a91:	.db $1c
B7_2a92:		rol a			; 2a
B7_2a93:		ora $0800, x	; 1d 00 08
B7_2a96:		sty $7801		; 8c 01 78
B7_2a99:	.db $47
B7_2a9a:		rol a			; 2a
B7_2a9b:	.db $1b
B7_2a9c:	.db $1b
B7_2a9d:	.db $80
B7_2a9e:		ora $2b1e, x	; 1d 1e 2b
B7_2aa1:		.db $00				; 00
B7_2aa2:		asl $8c			; 06 8c
B7_2aa4:		ora ($80, x)	; 01 80
B7_2aa6:	.db $17
B7_2aa7:		rol a			; 2a
B7_2aa8:		eor $25			; 45 25
B7_2aaa:	.db $1c
B7_2aab:		clc				; 18 
B7_2aac:		.db $00				; 00
B7_2aad:		ora $58			; 05 58
B7_2aaf:		.db $00				; 00
B7_2ab0:		pha				; 48 
B7_2ab1:		lsr $25			; 46 25
B7_2ab3:	.db $43
B7_2ab4:		rol $0745		; 2e 45 07
B7_2ab7:		rts				; 60 


B7_2ab8:		.db $00				; 00
B7_2ab9:		bvc B7_2aca ; 50 0f

B7_2abb:		rol $18			; 26 18
B7_2abd:		lsr $18			; 46 18
B7_2abf:	.db $1e $1d $00
B7_2ac2:		ora $88			; 05 88
B7_2ac4:		ora ($78, x)	; 01 78
B7_2ac6:	.db $1b
B7_2ac7:		and $2c			; 25 2c
B7_2ac9:		rol a			; 2a
B7_2aca:		lsr $04			; 46 04
B7_2acc:		bcc B7_2acf ; 90 01

B7_2ace:		tya				; 98 
B7_2acf:		ora $18, x		; 15 18
B7_2ad1:	.db $1b
B7_2ad2:	.db $1c
B7_2ad3:		.db $00				; 00
B7_2ad4:		asl $88			; 06 88
B7_2ad6:		ora ($78, x)	; 01 78
B7_2ad8:		bit $432a		; 2c 2a 43
B7_2adb:		bit $1c1e		; 2c 1e 1c
B7_2ade:		asl $90			; 06 90
B7_2ae0:		ora ($90, x)	; 01 90
B7_2ae2:		and $7c			; 25 7c
B7_2ae4:		lsr $7c			; 46 7c
B7_2ae6:		rol a			; 2a
B7_2ae7:	.db $7c
B7_2ae8:		.db $00				; 00
B7_2ae9:		asl $8c			; 06 8c
B7_2aeb:		ora ($80, x)	; 01 80
B7_2aed:		bit $432a		; 2c 2a 43
B7_2af0:		bit $1c1e		; 2c 1e 1c
B7_2af3:		.db $00				; 00
B7_2af4:	.db $07
B7_2af5:		cli				; 58 
B7_2af6:		.db $00				; 00
B7_2af7:		pha				; 48 
B7_2af8:		lsr $43			; 46 43
B7_2afa:		rol $182c		; 2e 2c 18
B7_2afd:		rol a			; 2a
B7_2afe:	.db $1b
B7_2aff:		asl $60			; 06 60
B7_2b01:		.db $00				; 00
B7_2b02:		cli				; 58 
B7_2b03:	.db $47
B7_2b04:	.db $17
B7_2b05:		rol a			; 2a
B7_2b06:		ora $461a, x	; 1d 1a 46
B7_2b09:		.db $00				; 00
B7_2b0a:		php				; 08 
B7_2b0b:		sty $7801		; 8c 01 78
B7_2b0e:	.db $17
B7_2b0f:		rol $452a		; 2e 2a 45
B7_2b12:	.db $47
B7_2b13:		and #$7c		; 29 7c
B7_2b15:		ora $0800, y	; 19 00 08
B7_2b18:		sty $7801		; 8c 01 78
B7_2b1b:	.db $1c
B7_2b1c:		rol a			; 2a
B7_2b1d:	.db $1a
B7_2b1e:		clc				; 18 
B7_2b1f:		bit $2a17		; 2c 17 2a
B7_2b22:		ora $0200, x	; 1d 00 02
B7_2b25:		bvc B7_2b27 ; 50 00

B7_2b27:		.db $30 $61

B7_2b29:	.db $62
B7_2b2a:	.db $02
B7_2b2b:		cli				; 58 
B7_2b2c:		.db $00				; 00
B7_2b2d:		;removed
	.db $30 $63

B7_2b2f:	.db $64
B7_2b30:	.db $02
B7_2b31:		bvc B7_2b33 ; 50 00

B7_2b33:		;removed
	.db $50 $65

B7_2b35:		ror $02			; 66 02
B7_2b37:		cli				; 58 
B7_2b38:		.db $00				; 00
B7_2b39:		.db $50 $67

B7_2b3b:		pla				; 68 
B7_2b3c:	.db $02
B7_2b3d:		bvc B7_2b3f ; 50 00

B7_2b3f:		;removed
	.db $70 $69

B7_2b41:		ror a			; 6a
B7_2b42:	.db $02
B7_2b43:		cli				; 58 
B7_2b44:		.db $00				; 00
B7_2b45:		;removed
	.db $70 $6b

B7_2b47:		jmp ($5401)		; 6c 01 54


B7_2b4a:		.db $00				; 00
B7_2b4b:	.db $44
B7_2b4c:		rts				; 60 


B7_2b4d:		ora ($54, x)	; 01 54
B7_2b4f:		.db $00				; 00
B7_2b50:	.db $64
B7_2b51:		rts				; 60 


B7_2b52:		.db $00				; 00


warpInputLoop:
	lda #$1f
	jsr set_wChrBank0

	ldy #$00
	bit wJoy1ButtonsPressed
	bmi @aSelected

	bvc @noAction

; b held
	iny

@aSelected:
; A - y=0, B - y=1
	lda wJoy1ButtonsPressed
	and #PADF_UP|PADF_DOWN
	beq @noAction

; process change every 8f rames
	lda wWarpInputBuffer
	clc
	adc #$20
	sta wWarpInputBuffer
	beq +

	jmp @updateOam

; X = 01 if up pressed, ff if down pressed
+	ldx #$01
	lda wJoy1ButtonsPressed
	and #PADF_UP
	bne +

	ldx #$ff
+	stx wWarpSelectValAddition
; or roomY, keep between 0 to 1f
	lda wRoomX.w, y
	clc
	adc wWarpSelectValAddition
	and #$1f

; or roomY, set updated value
	sta wRoomX.w, y
	jmp @updateOam

@noAction:
; start buffer such that you can process straight away
	lda #$e0
	sta wWarpInputBuffer

; y means start drawing with roomY
; oam details from idx $f0
@updateOam:
	ldy #$01
	ldx #$f0

	lda #$90
	sta wWarpSelectOamX

; base tile value nums start at #$40
-	lda wRoomX.w, y
	clc
	adc #$40
	sta wOam.tile.w, x

; set other vars
	lda wWarpSelectOamX
	sta wOam.X.w, x
	lda #$40
	sta wOam.Y.w, x
	lda #$03
	sta wOam.attr.w, x

; inc for roomX
	lda wWarpSelectOamX
	clc
	adc #$10
	sta wWarpSelectOamX

; add room X sprite
	inx
	inx
	inx
	inx
	dey
	bpl -

	rts


B7_2bc0:		jsr hideAllOam		; 20 9f c3
B7_2bc3:		lda #$00		; a9 00
B7_2bc5:		sta $0c			; 85 0c
B7_2bc7:		sta $0e			; 85 0e
B7_2bc9:		lda #$10		; a9 10
B7_2bcb:		sta wPlayerY			; 85 cc
B7_2bcd:		sta wPlayerX			; 85 ce
B7_2bcf:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_2bd2:		lda #$03		; a9 03
B7_2bd4:		sta $07			; 85 07
B7_2bd6:		lda wJoy1NewButtonsPressed			; a5 29
B7_2bd8:		and #$20		; 29 20
B7_2bda:		beq B7_2be2 ; f0 06

B7_2bdc:		jsr hideAllOam		; 20 9f c3
B7_2bdf:		jmp safeRestoreDefaultPrgBank		; 4c 95 c1


B7_2be2:		lda wJoy1NewButtonsPressed			; a5 29
B7_2be4:		lsr a			; 4a
B7_2be5:		bcs B7_2bf2 ; b0 0b

B7_2be7:		lsr a			; 4a
B7_2be8:		bcs B7_2bff ; b0 15

B7_2bea:		lsr a			; 4a
B7_2beb:		bcs B7_2c0c ; b0 1f

B7_2bed:		lsr a			; 4a
B7_2bee:		bcs B7_2c19 ; b0 29

B7_2bf0:		bcc B7_2bcf ; 90 dd

B7_2bf2:		lda #$20		; a9 20
B7_2bf4:		jsr $ecbf		; 20 bf ec
B7_2bf7:		lda #$02		; a9 02
B7_2bf9:		jsr $ecc5		; 20 c5 ec
B7_2bfc:		jmp $ec23		; 4c 23 ec


B7_2bff:		lda #$e0		; a9 e0
B7_2c01:		jsr $ecbf		; 20 bf ec
B7_2c04:		lda #$fe		; a9 fe
B7_2c06:		jsr $ecc5		; 20 c5 ec
B7_2c09:		jmp $ec23		; 4c 23 ec


B7_2c0c:		lda #$20		; a9 20
B7_2c0e:		jsr $ecb9		; 20 b9 ec
B7_2c11:		lda #$02		; a9 02
B7_2c13:		jsr $eccd		; 20 cd ec
B7_2c16:		jmp $ec23		; 4c 23 ec


B7_2c19:		lda #$e0		; a9 e0
B7_2c1b:		jsr $ecb9		; 20 b9 ec
B7_2c1e:		lda #$fe		; a9 fe
B7_2c20:		jsr $eccd		; 20 cd ec
B7_2c23:		jsr getMetatileTilesAddr		; 20 b9 da
B7_2c26:		lda $05			; a5 05
B7_2c28:		clc				; 18 
B7_2c29:		adc #$04		; 69 04
B7_2c2b:		sta $05			; 85 05
B7_2c2d:		ldy #$00		; a0 00
B7_2c2f:		ldx #$00		; a2 00
B7_2c31:		lda ($04), y	; b1 04
B7_2c33:		pha				; 48 
B7_2c34:		lsr a			; 4a
B7_2c35:		lsr a			; 4a
B7_2c36:		lsr a			; 4a
B7_2c37:		lsr a			; 4a
B7_2c38:		sta wRoomLoadingRow1ToCopy.w, x	; 9d c0 06
B7_2c3b:		pla				; 68 
B7_2c3c:		and #$0f		; 29 0f
B7_2c3e:		sta $06c1, x	; 9d c1 06
B7_2c41:		inx				; e8 
B7_2c42:		inx				; e8 
B7_2c43:		iny				; c8 
B7_2c44:		cpy #$04		; c0 04
B7_2c46:		bne B7_2c31 ; d0 e9

B7_2c48:		lda $00			; a5 00
B7_2c4a:		pha				; 48 
B7_2c4b:		lsr a			; 4a
B7_2c4c:		lsr a			; 4a
B7_2c4d:		lsr a			; 4a
B7_2c4e:		lsr a			; 4a
B7_2c4f:		sta wRoomLoadingRow1ToCopy.w, x	; 9d c0 06
B7_2c52:		pla				; 68 
B7_2c53:		and #$0f		; 29 0f
B7_2c55:		sta $06c1, x	; 9d c1 06
B7_2c58:		ldx #$04		; a2 04
B7_2c5a:		ldy #$00		; a0 00
B7_2c5c:		lda $07			; a5 07
B7_2c5e:		sta wOam.attr.w, x	; 9d 02 02
B7_2c61:		lda $dd86, y	; b9 86 dd
B7_2c64:		clc				; 18 
B7_2c65:		adc wPlayerY			; 65 cc
B7_2c67:		cmp #$08		; c9 08
B7_2c69:		bne B7_2c70 ; d0 05

B7_2c6b:		clc				; 18 
B7_2c6c:		adc #$08		; 69 08
B7_2c6e:		bne B7_2c77 ; d0 07

B7_2c70:		cmp #$e8		; c9 e8
B7_2c72:		bne B7_2c77 ; d0 03

B7_2c74:		sec				; 38 
B7_2c75:		sbc #$08		; e9 08
B7_2c77:		sta wOam.Y.w, x	; 9d 00 02
B7_2c7a:		lda $dd90, y	; b9 90 dd
B7_2c7d:		clc				; 18 
B7_2c7e:		adc wPlayerX			; 65 ce
B7_2c80:		sta wOam.X.w, x	; 9d 03 02
B7_2c83:		lda wRoomLoadingRow1ToCopy.w, y	; b9 c0 06
B7_2c86:		ora #$80		; 09 80
B7_2c88:		sta wOam.tile.w, x	; 9d 01 02
B7_2c8b:		inx				; e8 
B7_2c8c:		inx				; e8 
B7_2c8d:		inx				; e8 
B7_2c8e:		inx				; e8 
B7_2c8f:		iny				; c8 
B7_2c90:		cpy #$08		; c0 08
B7_2c92:		bne B7_2c5c ; d0 c8

B7_2c94:		lda $07			; a5 07
B7_2c96:		sta wOam.attr.w, x	; 9d 02 02
B7_2c99:		lda $dd86, y	; b9 86 dd
B7_2c9c:		sta wOam.Y.w, x	; 9d 00 02
B7_2c9f:		lda $dd90, y	; b9 90 dd
B7_2ca2:		sta wOam.X.w, x	; 9d 03 02
B7_2ca5:		lda wRoomLoadingRow1ToCopy.w, y	; b9 c0 06
B7_2ca8:		ora #$80		; 09 80
B7_2caa:		sta wOam.tile.w, x	; 9d 01 02
B7_2cad:		inx				; e8 
B7_2cae:		inx				; e8 
B7_2caf:		inx				; e8 
B7_2cb0:		inx				; e8 
B7_2cb1:		iny				; c8 
B7_2cb2:		cpy #$0a		; c0 0a
B7_2cb4:		bne B7_2c94 ; d0 de

B7_2cb6:		jmp $ebcf		; 4c cf eb


B7_2cb9:		clc				; 18 
B7_2cba:		adc wPlayerY			; 65 cc
B7_2cbc:		sta wPlayerY			; 85 cc
B7_2cbe:		rts				; 60 


B7_2cbf:		clc				; 18 
B7_2cc0:		adc wPlayerX			; 65 ce
B7_2cc2:		sta wPlayerX			; 85 ce
B7_2cc4:		rts				; 60 


B7_2cc5:		clc				; 18 
B7_2cc6:		adc $0e			; 65 0e
B7_2cc8:		and #$0e		; 29 0e
B7_2cca:		sta $0e			; 85 0e
B7_2ccc:		rts				; 60 


B7_2ccd:		clc				; 18 
B7_2cce:		adc $0c			; 65 0c
B7_2cd0:		and #$0e		; 29 0e
B7_2cd2:		sta $0c			; 85 0c
B7_2cd4:		rts				; 60 


; unused
processSecretInput:
	ldx wSecretInputCounter.w
	cpx #$10
	beq @done

	lda wJoy1NewButtonsPressed
	beq @done

; jump if pressing the right button
	cmp @inputButtons.w, x
	beq +

; set all buttons filled, so can't warp
	lda #$10
	sta wSecretInputCounter.w
	bne @done

; inc counter
+	inc wSecretInputCounter.w
	lda wSecretInputCounter.w
	cmp #$10
	bne @done

	lda #GF_CAN_WARP
	jsr setGlobalFlag

@done:
	rts

@inputButtons:
	.db PADF_UP
	.db PADF_A
	.db PADF_UP
	.db PADF_A
	.db PADF_DOWN
	.db PADF_A
	.db PADF_DOWN
	.db PADF_A
	.db PADF_LEFT
	.db PADF_B
	.db PADF_LEFT
	.db PADF_B
	.db PADF_RIGHT
	.db PADF_B
	.db PADF_RIGHT
	.db PADF_B


getTextByte:
	lda #:scriptAddresses
	jsr safeSetPrgBankA

	lda (wNPCTextAddress), y
	pha
	jsr safeRestoreDefaultPrgBank
	pla
	rts


setNPCTextAddress:
	lda #:scriptAddresses
	jsr safeSetPrgBankA

	ldy #$00
	lda (wNPCTextAddressSrc), y
	pha
	iny
	lda (wNPCTextAddressSrc), y
	sta wNPCTextAddress+1
	pla
	sta wNPCTextAddress
	jmp safeRestoreDefaultPrgBank


data_7_2d2e:
	dwbe $237c
	.db $01 $38 $ff

data_7_2d33:
	dwbe $237c
	.db $01 $20 $ff

data_7_2d38:
	dwbe $277c
	.db $01 $38 $ff

data_7_2d3d
	dwbe $277c
	.db $01 $20 $ff


.org $2da0

b0_rleStructsAddresses:
	.dw rleStruct00
	.dw rleStruct01
	.dw rleStruct02
	.dw rleStruct03
	.dw rleStruct04
	.dw rleStruct05
	.dw rleStruct06
	.dw rleStruct07
	.dw rleStruct08
	.dw rleStruct09
	.dw rleStruct0a
	.dw rleStruct0b
	.dw rleStruct0c
	.dw rleStruct0d
	.dw rleStruct0e
	.dw rleStruct0f
	.dw rleStruct10
	.dw rleStruct11
	.dw rleStruct12
	.dw rleStruct13
	.dw rleStruct14
	.dw rleStruct15
	.dw rleStruct16
	.dw rleStruct17
	.dw rleStruct18
	.dw rleStruct19
	.dw rleStruct1a
	.dw rleStruct1b
	.dw rleStruct1c
	.dw rleStruct1d
	.dw rleStruct1e
	.dw rleStruct1f
	.dw rleStruct20
	.dw rleStruct21
	.dw rleStruct22


.org $2e00

textData_7_2e00:
	.dw scriptPreset_00
	.dw scriptPreset_01
	.dw scriptPreset_02
	.dw scriptPreset_03
	.dw scriptPreset_04
	.dw scriptPreset_05
	.dw scriptPreset_06
	.dw scriptPreset_07
	.dw scriptPreset_08
	.dw scriptPreset_09
	.dw scriptPreset_0a
	.dw scriptPreset_0b
	.dw scriptPreset_0c
	.dw scriptPreset_0d
	.dw scriptPreset_0e
	.dw scriptPreset_0f
	.dw scriptPreset_10
	.dw scriptPreset_11
	.dw scriptPreset_12
	.dw scriptPreset_13
	.dw scriptPreset_14
	.dw scriptPreset_15
	.dw scriptPreset_16
	.dw scriptPreset_17
	.dw scriptPreset_18
	.dw scriptPreset_19
	.dw scriptPreset_1a
	.dw scriptPreset_1b
	.dw scriptPreset_1c
	.dw scriptPreset_1d
	.dw scriptPreset_1e
	.dw scriptPreset_1f
	.dw scriptPreset_20
	.dw scriptPreset_21
	.dw scriptPreset_22
	.dw scriptPreset_23
	.dw scriptPreset_24
	.dw scriptPreset_25
	.dw scriptPreset_26
	.dw scriptPreset_27
	.dw scriptPreset_28
	.dw scriptPreset_29
	.dw scriptPreset_2a
	.dw scriptPreset_2b
	.dw scriptPreset_2c
	.dw scriptPreset_2d
	.dw scriptPreset_2e
	.dw scriptPreset_2f
	.dw scriptPreset_30
	.dw scriptPreset_31
	.dw scriptPreset_32
	.dw scriptPreset_33
	.dw scriptPreset_34
	.dw scriptPreset_35
	.dw scriptPreset_36
	.dw scriptPreset_37
	.dw scriptPreset_38
	.dw scriptPreset_39
	.dw scriptPreset_3a
	.dw scriptPreset_3b
	.dw scriptPreset_3c
	.dw scriptPreset_3d
	.dw scriptPreset_3e
	.dw scriptPreset_3f
	.dw scriptPreset_40
	.dw scriptPreset_41
	.dw scriptPreset_42
	.dw scriptPreset_43
	.dw scriptPreset_44
	.dw scriptPreset_45
	.dw scriptPreset_46
	.dw scriptPreset_47
	.dw scriptPreset_48
	.dw scriptPreset_49
	.dw scriptPreset_4a
	.dw scriptPreset_4b
	.dw scriptPreset_4c
	.dw scriptPreset_4d
	.dw scriptPreset_4e
	.dw scriptPreset_4f
	.dw scriptPreset_50
	.dw scriptPreset_51
	.dw scriptPreset_52
	.dw scriptPreset_53
	.dw scriptPreset_54
	.dw scriptPreset_55
	.dw scriptPreset_56
	.dw scriptPreset_57
	.dw scriptPreset_58
	.dw scriptPreset_59
	.dw scriptPreset_5a
	.dw scriptPreset_5b
	.dw scriptPreset_5c
	.dw scriptPreset_5d
	.dw scriptPreset_5e
	.dw scriptPreset_5f
	.dw scriptPreset_60
	.dw scriptPreset_61
	.dw scriptPreset_62
	.dw scriptPreset_63
	.dw scriptPreset_64
	.dw scriptPreset_65
	.dw scriptPreset_66
	.dw scriptPreset_67
	.dw scriptPreset_68
	.dw scriptPreset_69
	.dw scriptPreset_6a
	.dw scriptPreset_6b
	.dw scriptPreset_6c
	.dw scriptPreset_6d
	.dw scriptPreset_6e
	.dw scriptPreset_6f
	.dw scriptPreset_70
	.dw scriptPreset_71
	.dw scriptPreset_72
	.dw scriptPreset_73
	.dw scriptPreset_74
	.dw scriptPreset_75
	.dw scriptPreset_76
	.dw scriptPreset_77
	.dw scriptPreset_78
	.dw scriptPreset_79
	.dw scriptPreset_7a
	.dw scriptPreset_7b
	.dw scriptPreset_7c
	.dw scriptPreset_7d
	.dw scriptPreset_7e
	.dw scriptPreset_7f
	.dw scriptPreset_80
	.dw scriptPreset_81
	.dw scriptPreset_82
	.dw scriptPreset_83
	.dw scriptPreset_84
	.dw scriptPreset_85
	.dw scriptPreset_86
	.dw scriptPreset_87
	.dw scriptPreset_88
	.dw scriptPreset_89
	.dw scriptPreset_8a
	.dw scriptPreset_8b
	.dw scriptPreset_8c
	.dw scriptPreset_8d
	.dw scriptPreset_8e
	.dw scriptPreset_8f
	.dw scriptPreset_90
	.dw scriptPreset_91
	.dw scriptPreset_92
	.dw scriptPreset_93
	.dw scriptPreset_94
	.dw scriptPreset_95
	.dw scriptPreset_96
	.dw scriptPreset_97
	.dw scriptPreset_98
	.dw scriptPreset_99
	.dw scriptPreset_9a
	.dw scriptPreset_9b
	.dw scriptPreset_9c
	.dw scriptPreset_9d
	.dw scriptPreset_9e
	.dw scriptPreset_9f
	.dw scriptPreset_a0
	.dw scriptPreset_a1
	.dw scriptPreset_a2
	.dw scriptPreset_a3
	.dw scriptPreset_a4
	.dw scriptPreset_a5
	.dw scriptPreset_a6
	.dw scriptPreset_a7
	.dw scriptPreset_a8
	.dw scriptPreset_a9
	.dw scriptPreset_aa
	.dw scriptPreset_ab
	.dw scriptPreset_ac
	.dw scriptPreset_ad
	.dw scriptPreset_ae
	.dw scriptPreset_af
	.dw scriptPreset_b0
	.dw scriptPreset_b1
	.dw scriptPreset_b2
	.dw scriptPreset_b3
	.dw scriptPreset_b4
	.dw scriptPreset_b5
	.dw scriptPreset_b6


B7_2f6e:	.db $00
B7_2f6f:	.db $ff
B7_2f70:	.db $07
B7_2f71:	.db $ff
B7_2f72:	.db $0c
B7_2f73:	.db $ff
B7_2f74:		ora $ff, x		; 15 ff
B7_2f76:	.db $1b
B7_2f77:	.db $ff
B7_2f78:	.db $23
B7_2f79:	.db $ff
B7_2f7a:		and #$ff		; 29 ff
B7_2f7c:	.db $2f
B7_2f7d:	.db $ff
B7_2f7e:	.db $3a
B7_2f7f:	.db $ff
B7_2f80:	.db $43
B7_2f81:	.db $ff
B7_2f82:		eor $53ff		; 4d ff 53
B7_2f85:	.db $ff
B7_2f86:	.db $5b
B7_2f87:	.db $ff
B7_2f88:		adc ($ff, x)	; 61 ff
B7_2f8a:		ror a			; 6a
B7_2f8b:	.db $ff
B7_2f8c:	.db $73
B7_2f8d:	.db $ff
B7_2f8e:	.db $7b
B7_2f8f:	.db $ff
B7_2f90:		sta $ff			; 85 ff
B7_2f92:		sta $95ff		; 8d ff 95
B7_2f95:	.db $ff
B7_2f96:	.db $9c
B7_2f97:	.db $ff
B7_2f98:	.db $a3
B7_2f99:	.db $ff
B7_2f9a:		tay				; a8 
B7_2f9b:	.db $ff
B7_2f9c:		lda $b3ff		; ad ff b3
B7_2f9f:	.db $ff
B7_2fa0:	.db $bb
B7_2fa1:	.db $ff
B7_2fa2:		cpy #$ff		; c0 ff
B7_2fa4:		cmp $ff			; c5 ff
B7_2fa6:		dex				; ca 
B7_2fa7:	.db $ff
B7_2fa8:	.db $cf
B7_2fa9:	.db $ff
B7_2faa:		cmp $ff, x		; d5 ff


.org $3000

func_7_3000:
B7_3000:		lda $70			; a5 70
B7_3002:		beq B7_3007 ; f0 03

B7_3004:		jmp $f0f4		; 4c f4 f0

B7_3007:		jsr $f283		; 20 83 f2
B7_300a:		lda #$42		; a9 42
B7_300c:		sta $47			; 85 47
B7_300e:		lda #$06		; a9 06
B7_3010:		sta $07			; 85 07
B7_3012:		jsr $f232		; 20 32 f2
B7_3015:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B7_3017:		jsr $f08a		; 20 8a f0
B7_301a:		ldy #$00		; a0 00
B7_301c:		jsr $f28e		; 20 8e f2
B7_301f:		lda $f307, y	; b9 07 f3
B7_3022:		bmi B7_303e ; 30 1a

B7_3024:		sta wVramQueue.w, x	; 9d 00 05
B7_3027:		inx				; e8 
B7_3028:		iny				; c8 
B7_3029:		dec $0a			; c6 0a
B7_302b:		bne B7_301f ; d0 f2

B7_302d:		jsr $f2a3		; 20 a3 f2
B7_3030:		dec $07			; c6 07
B7_3032:		bne B7_301c ; d0 e8

B7_3034:		lda #$00		; a9 00
B7_3036:		sta wVramQueue.w, x	; 9d 00 05
B7_3039:		sta $70			; 85 70
B7_303b:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B7_303d:		rts				; 60 

B7_303e:		and #$40		; 29 40
B7_3040:		bne B7_305e ; d0 1c

B7_3042:		lda wCurrLevel			; a5 71
B7_3044:		clc				; 18 
B7_3045:		adc #$01		; 69 01
B7_3047:		jsr func_7_364d		; 20 4d f6
B7_304a:		lda $0d			; a5 0d
B7_304c:		bne B7_3050 ; d0 02

B7_304e:		lda #$20		; a9 20
B7_3050:		sta wVramQueue.w, x	; 9d 00 05
B7_3053:		inx				; e8 
B7_3054:		dec $0a			; c6 0a
B7_3056:		lda $0e			; a5 0e
B7_3058:		sta wVramQueue.w, x	; 9d 00 05
B7_305b:		jmp $f027		; 4c 27 f0

B7_305e:		tya				; 98 
B7_305f:		pha				; 48 
B7_3060:		lda #$03		; a9 03
B7_3062:		sta $08			; 85 08
B7_3064:		lda $f307, y	; b9 07 f3
B7_3067:		pha				; 48 
B7_3068:		and #$0f		; 29 0f
B7_306a:		tay				; a8 
B7_306b:		pla				; 68 
B7_306c:		and #$20		; 29 20
B7_306e:		beq B7_3074 ; f0 04

B7_3070:		lda #$05		; a9 05
B7_3072:		sta $08			; 85 08
B7_3074:		lda wRoomLoadingRow1ToCopy.w, y	; b9 c0 06
B7_3077:		sta wVramQueue.w, x	; 9d 00 05
B7_307a:		inx				; e8 
B7_307b:		iny				; c8 
B7_307c:		dec $0a			; c6 0a
B7_307e:		dec $08			; c6 08
B7_3080:		bne B7_3074 ; d0 f2

B7_3082:		dex				; ca 
B7_3083:		inc $0a			; e6 0a
B7_3085:		pla				; 68 
B7_3086:		tay				; a8 
B7_3087:		jmp $f027		; 4c 27 f0


B7_308a:		ldy #$23		; a0 23
B7_308c:		lda wPPUCtrl			; a5 20
B7_308e:		and #$01		; 29 01
B7_3090:		beq B7_3094 ; f0 02

B7_3092:		ldy #$27		; a0 27
B7_3094:		tya				; 98 
B7_3095:		pha				; 48 
B7_3096:		sta wVramQueue.w, x	; 9d 00 05
B7_3099:		inx				; e8 
B7_309a:		lda #$c0		; a9 c0
B7_309c:		sta wVramQueue.w, x	; 9d 00 05
B7_309f:		inx				; e8 
B7_30a0:		lda #$03		; a9 03
B7_30a2:		sta wVramQueue.w, x	; 9d 00 05
B7_30a5:		sta $0a			; 85 0a
B7_30a7:		inx				; e8 
B7_30a8:		tya				; 98 
B7_30a9:		asl a			; 0a
B7_30aa:		and #$08		; 29 08
B7_30ac:		tay				; a8 
B7_30ad:		pha				; 48 
B7_30ae:		lda $0700, y	; b9 00 07
B7_30b1:		and $f32e, y	; 39 2e f3
B7_30b4:		sta $0700, y	; 99 00 07
B7_30b7:		sta wVramQueue.w, x	; 9d 00 05
B7_30ba:		inx				; e8 
B7_30bb:		iny				; c8 
B7_30bc:		dec $0a			; c6 0a
B7_30be:		bne B7_30ae ; d0 ee

B7_30c0:		pla				; 68 
B7_30c1:		tay				; a8 
B7_30c2:		pla				; 68 
B7_30c3:		sta wVramQueue.w, x	; 9d 00 05
B7_30c6:		inx				; e8 
B7_30c7:		lda #$c8		; a9 c8
B7_30c9:		sta wVramQueue.w, x	; 9d 00 05
B7_30cc:		inx				; e8 
B7_30cd:		lda #$03		; a9 03
B7_30cf:		sta wVramQueue.w, x	; 9d 00 05
B7_30d2:		sta $0a			; 85 0a
B7_30d4:		inx				; e8 
B7_30d5:		lda $0710, y	; b9 10 07
B7_30d8:		and $f339, y	; 39 39 f3
B7_30db:		sta $0710, y	; 99 10 07
B7_30de:		sta wVramQueue.w, x	; 9d 00 05
B7_30e1:		inx				; e8 
B7_30e2:		iny				; c8 
B7_30e3:		dec $0a			; c6 0a
B7_30e5:		bne B7_30d5 ; d0 ee

B7_30e7:		lda #$00		; a9 00
B7_30e9:		sta wVramQueue.w, x	; 9d 00 05
B7_30ec:		sta $70			; 85 70
B7_30ee:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B7_30f0:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_30f3:		rts				; 60 

B7_30f4:		lda $70			; a5 70
B7_30f6:		bmi B7_310a ; 30 12

B7_30f8:		jsr $f283		; 20 83 f2
B7_30fb:		lda #$00		; a9 00
B7_30fd:		sta $47			; 85 47
B7_30ff:		sta wRoomLoadingRow1ToCopy.w		; 8d c0 06
B7_3102:		lda #$02		; a9 02
B7_3104:		sta $06c1		; 8d c1 06
B7_3107:		jsr $f1f5		; 20 f5 f1
B7_310a:		jsr $f1a0		; 20 a0 f1
B7_310d:		lda #$04		; a9 04
B7_310f:		sta $0b			; 85 0b
B7_3111:		ldy wRoomLoadingRow1ToCopy.w		; ac c0 06
B7_3114:		lda $f2b1, y	; b9 b1 f2
B7_3117:		and #$0f		; 29 0f
B7_3119:		asl a			; 0a
B7_311a:		asl a			; 0a
B7_311b:		asl a			; 0a
B7_311c:		tay				; a8 
B7_311d:		jsr $f28e		; 20 8e f2
B7_3120:		lda $f2cf, y	; b9 cf f2
B7_3123:		sta wVramQueue.w, x	; 9d 00 05
B7_3126:		inx				; e8 
B7_3127:		iny				; c8 
B7_3128:		dec $0a			; c6 0a
B7_312a:		bne B7_3120 ; d0 f4

B7_312c:		jsr $f159		; 20 59 f1
B7_312f:		jsr $f2a3		; 20 a3 f2
B7_3132:		lda wRoomLoadingRow1ToCopy.w		; ad c0 06
B7_3135:		inc wRoomLoadingRow1ToCopy.w		; ee c0 06
B7_3138:		cmp #$1d		; c9 1d
B7_313a:		beq B7_3146 ; f0 0a

B7_313c:		dec $0b			; c6 0b
B7_313e:		bne B7_3111 ; d0 d1

B7_3140:		jsr $f14e		; 20 4e f1
B7_3143:		jmp $f10a		; 4c 0a f1

B7_3146:		jsr $f14e		; 20 4e f1
B7_3149:		lda #$40		; a9 40
B7_314b:		sta $70			; 85 70
B7_314d:		rts				; 60 


B7_314e:		lda #$00		; a9 00
B7_3150:		sta wVramQueue.w, x	; 9d 00 05
B7_3153:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B7_3155:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_3158:		rts				; 60 


B7_3159:		tya				; 98 
B7_315a:		pha				; 48 
B7_315b:		ldy wRoomLoadingRow1ToCopy.w		; ac c0 06
B7_315e:		lda $f2b1, y	; b9 b1 f2
B7_3161:		and #$f0		; 29 f0
B7_3163:		lsr a			; 4a
B7_3164:		lsr a			; 4a
B7_3165:		lsr a			; 4a
B7_3166:		lsr a			; 4a
B7_3167:		sta $0c			; 85 0c
B7_3169:		beq B7_319d ; f0 32

B7_316b:		lda $48			; a5 48
B7_316d:		sta wVramQueue.w, x	; 9d 00 05
B7_3170:		inx				; e8 
B7_3171:		lda $47			; a5 47
B7_3173:		clc				; 18 
B7_3174:		adc $0c			; 65 0c
B7_3176:		sta wVramQueue.w, x	; 9d 00 05
B7_3179:		inx				; e8 
B7_317a:		ldy #$05		; a0 05
B7_317c:		lda $0c			; a5 0c
B7_317e:		cmp #$02		; c9 02
B7_3180:		beq B7_3184 ; f0 02

B7_3182:		ldy #$03		; a0 03
B7_3184:		tya				; 98 
B7_3185:		sta wVramQueue.w, x	; 9d 00 05
B7_3188:		sta $0c			; 85 0c
B7_318a:		inx				; e8 
B7_318b:		ldy $06c1		; ac c1 06
B7_318e:		lda wRoomLoadingRow1ToCopy.w, y	; b9 c0 06
B7_3191:		sta wVramQueue.w, x	; 9d 00 05
B7_3194:		iny				; c8 
B7_3195:		inx				; e8 
B7_3196:		dec $0c			; c6 0c
B7_3198:		bne B7_318e ; d0 f4

B7_319a:		sty $06c1		; 8c c1 06
B7_319d:		pla				; 68 
B7_319e:		tay				; a8 
B7_319f:		rts				; 60 


B7_31a0:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B7_31a2:		lda $47			; a5 47
B7_31a4:		pha				; 48 
B7_31a5:		ldy #$23		; a0 23
B7_31a7:		lda #$00		; a9 00
B7_31a9:		sta $0b			; 85 0b
B7_31ab:		lda $48			; a5 48
B7_31ad:		and #$04		; 29 04
B7_31af:		beq B7_31b7 ; f0 06

B7_31b1:		ldy #$27		; a0 27
B7_31b3:		lda #$08		; a9 08
B7_31b5:		sta $0b			; 85 0b
B7_31b7:		tya				; 98 
B7_31b8:		sta wVramQueue.w, x	; 9d 00 05
B7_31bb:		inx				; e8 
B7_31bc:		lda $48			; a5 48
B7_31be:		and #$fb		; 29 fb
B7_31c0:		asl $47			; 06 47
B7_31c2:		rol a			; 2a
B7_31c3:		asl $47			; 06 47
B7_31c5:		rol a			; 2a
B7_31c6:		asl $47			; 06 47
B7_31c8:		rol a			; 2a
B7_31c9:		asl $47			; 06 47
B7_31cb:		rol a			; 2a
B7_31cc:		pha				; 48 
B7_31cd:		ora #$c0		; 09 c0
B7_31cf:		sta wVramQueue.w, x	; 9d 00 05
B7_31d2:		inx				; e8 
B7_31d3:		lda #$02		; a9 02
B7_31d5:		sta wVramQueue.w, x	; 9d 00 05
B7_31d8:		inx				; e8 
B7_31d9:		lda #$00		; a9 00
B7_31db:		sta wVramQueue.w, x	; 9d 00 05
B7_31de:		inx				; e8 
B7_31df:		sta wVramQueue.w, x	; 9d 00 05
B7_31e2:		inx				; e8 
B7_31e3:		pla				; 68 
B7_31e4:		asl a			; 0a
B7_31e5:		clc				; 18 
B7_31e6:		adc $0b			; 65 0b
B7_31e8:		tay				; a8 
B7_31e9:		lda #$00		; a9 00
B7_31eb:		sta $0700, y	; 99 00 07
B7_31ee:		sta $0701, y	; 99 01 07
B7_31f1:		pla				; 68 
B7_31f2:		sta $47			; 85 47
B7_31f4:		rts				; 60 


B7_31f5:		jsr $f5da		; 20 da f5
B7_31f8:		jsr $f5f1		; 20 f1 f5
B7_31fb:		ldx #$04		; a2 04
B7_31fd:		ldy #$01		; a0 01
B7_31ff:		jsr $f610		; 20 10 f6
B7_3202:		jsr $f62b		; 20 2b f6
B7_3205:		sta wRoomLoadingRow1ToCopy.w, x	; 9d c0 06
B7_3208:		inx				; e8 
B7_3209:		inx				; e8 
B7_320a:		inx				; e8 
B7_320b:		dec $0b			; c6 0b
B7_320d:		bpl B7_3202 ; 10 f3

B7_320f:		ldx #$02		; a2 02
B7_3211:		dey				; 88 
B7_3212:		bpl B7_31ff ; 10 eb

B7_3214:		ldx #$03		; a2 03
B7_3216:		lda #$0e		; a9 0e
B7_3218:		sta $0b			; 85 0b
B7_321a:		lda #$20		; a9 20
B7_321c:		sta wRoomLoadingRow1ToCopy.w, x	; 9d c0 06
B7_321f:		inx				; e8 
B7_3220:		inx				; e8 
B7_3221:		inx				; e8 
B7_3222:		dec $0b			; c6 0b
B7_3224:		bpl B7_321c ; 10 f6

B7_3226:		ldy #$2f		; a0 2f
B7_3228:		ldx #$04		; a2 04
B7_322a:		jsr $f236		; 20 36 f2
B7_322d:		lda #$80		; a9 80
B7_322f:		sta $70			; 85 70
B7_3231:		rts				; 60 


B7_3232:		ldy #$00		; a0 00
B7_3234:		ldx #$04		; a2 04
B7_3236:		lda wCurrExpDigits, x		; b5 7c
B7_3238:		sta $0b, x		; 95 0b
B7_323a:		dex				; ca 
B7_323b:		bpl B7_3236 ; 10 f9

B7_323d:		lda #$04		; a9 04
B7_323f:		sta $09			; 85 09
B7_3241:		ldx #$00		; a2 00
B7_3243:		jsr $f260		; 20 60 f2
B7_3246:		lda wCurrMP			; a5 7a
B7_3248:		jsr func_7_364d		; 20 4d f6
B7_324b:		jsr $f25a		; 20 5a f2
B7_324e:		lda $70			; a5 70
B7_3250:		and #$40		; 29 40
B7_3252:		beq B7_3255 ; f0 01

B7_3254:		rts				; 60 


B7_3255:		lda wCurrHealth			; a5 7b
B7_3257:		jsr func_7_364d		; 20 4d f6
B7_325a:		lda #$03		; a9 03
B7_325c:		sta $09			; 85 09
B7_325e:		ldx #$01		; a2 01
B7_3260:		lda $0b, x		; b5 0b
B7_3262:		bne B7_3271 ; d0 0d

B7_3264:		lda #$20		; a9 20
B7_3266:		sta wRoomLoadingRow1ToCopy.w, y	; 99 c0 06
B7_3269:		inx				; e8 
B7_326a:		iny				; c8 
B7_326b:		cpx $09			; e4 09
B7_326d:		bne B7_3260 ; d0 f1

B7_326f:		beq B7_327c ; f0 0b

B7_3271:		lda $0b, x		; b5 0b
B7_3273:		sta wRoomLoadingRow1ToCopy.w, y	; 99 c0 06
B7_3276:		inx				; e8 
B7_3277:		iny				; c8 
B7_3278:		cpx $09			; e4 09
B7_327a:		bne B7_3271 ; d0 f5

B7_327c:		lda $0b, x		; b5 0b
B7_327e:		sta wRoomLoadingRow1ToCopy.w, y	; 99 c0 06
B7_3281:		iny				; c8 
B7_3282:		rts				; 60 


B7_3283:		lda wPPUCtrl			; a5 20
B7_3285:		and #$01		; 29 01
B7_3287:		asl a			; 0a
B7_3288:		asl a			; 0a
B7_3289:		ora #$20		; 09 20
B7_328b:		sta $48			; 85 48
B7_328d:		rts				; 60 


B7_328e:		lda $48			; a5 48
B7_3290:		sta wVramQueue.w, x	; 9d 00 05
B7_3293:		inx				; e8 
B7_3294:		lda $47			; a5 47
B7_3296:		sta wVramQueue.w, x	; 9d 00 05
B7_3299:		inx				; e8 
B7_329a:		lda #$08		; a9 08
B7_329c:		sta wVramQueue.w, x	; 9d 00 05
B7_329f:		sta $0a			; 85 0a
B7_32a1:		inx				; e8 
B7_32a2:		rts				; 60 


B7_32a3:		lda $47			; a5 47
B7_32a5:		clc				; 18 
B7_32a6:		adc #$20		; 69 20
B7_32a8:		sta $47			; 85 47
B7_32aa:		lda $48			; a5 48
B7_32ac:		adc #$00		; 69 00
B7_32ae:		sta $48			; 85 48
B7_32b0:		rts				; 60 


B7_32b1:		.db $00				; 00
B7_32b2:		.db $00				; 00
B7_32b3:		ora ($02, x)	; 01 02
B7_32b5:	.db $32
B7_32b6:	.db $32
B7_32b7:	.db $32
B7_32b8:	.db $32
B7_32b9:	.db $32
B7_32ba:	.db $32
B7_32bb:	.db $32
B7_32bc:	.db $32
B7_32bd:	.db $32
B7_32be:	.db $32
B7_32bf:	.db $32
B7_32c0:	.db $32
B7_32c1:	.db $32
B7_32c2:	.db $32
B7_32c3:	.db $32
B7_32c4:	.db $02
B7_32c5:	.db $03
B7_32c6:	.db $02
B7_32c7:	.db $04
B7_32c8:	.db $22
B7_32c9:		ora $42			; 05 42
B7_32cb:	.db $02
B7_32cc:		asl $00			; 06 00
B7_32ce:		.db $00				; 00
B7_32cf:		jsr $2020		; 20 20 20
B7_32d2:		jsr $2020		; 20 20 20
B7_32d5:		jsr $2020		; 20 20 20
B7_32d8:		asl a			; 0a
B7_32d9:	.db $0c
B7_32da:	.db $0c
B7_32db:	.db $0c
B7_32dc:	.db $0c
B7_32dd:	.db $0c
B7_32de:		asl a			; 0a
B7_32df:		jsr $200d		; 20 0d 20
B7_32e2:		jsr $2020		; 20 20 20
B7_32e5:		jsr $200e		; 20 0e 20
B7_32e8:		ora $1220		; 0d 20 12
B7_32eb:		jsr $200f		; 20 0f 20
B7_32ee:		asl $0d20		; 0e 20 0d
B7_32f1:	.db $0f
B7_32f2:	.db $1f
B7_32f3:	.db $12
B7_32f4:		jsr $0e20		; 20 20 0e
B7_32f7:		jsr $100d		; 20 0d 10
B7_32fa:	.db $12
B7_32fb:		jsr $2020		; 20 20 20
B7_32fe:		asl $0a20		; 0e 20 0a
B7_3301:	.db $0b
B7_3302:	.db $0b
B7_3303:	.db $0b
B7_3304:	.db $0b
B7_3305:	.db $0b
B7_3306:		asl a			; 0a
B7_3307:		asl a			; 0a
B7_3308:	.db $0c
B7_3309:	.db $0c
B7_330a:	.db $0c
B7_330b:	.db $0c
B7_330c:	.db $0c
B7_330d:	.db $0c
B7_330e:		asl a			; 0a
B7_330f:		ora $1313		; 0d 13 13
B7_3312:	.db $80
B7_3313:	.db $13
B7_3314:	.db $13
B7_3315:		asl $0f0d		; 0e 0d 0f
B7_3318:		cpx #$0e		; e0 0e
B7_331a:		ora $1210		; 0d 10 12
B7_331d:		jsr $0ec5		; 20 c5 0e
B7_3320:		ora $1211		; 0d 11 12
B7_3323:		jsr $0ec8		; 20 c8 0e
B7_3326:		asl a			; 0a
B7_3327:	.db $0b
B7_3328:	.db $0b
B7_3329:	.db $0b
B7_332a:	.db $0b
B7_332b:	.db $0b
B7_332c:	.db $0b
B7_332d:		asl a			; 0a
B7_332e:	.db $3f
B7_332f:	.db $0f
B7_3330:	.db $cf
B7_3331:		.db $00				; 00
B7_3332:		.db $00				; 00
B7_3333:		.db $00				; 00
B7_3334:		.db $00				; 00
B7_3335:		.db $00				; 00
B7_3336:	.db $3f
B7_3337:	.db $0f
B7_3338:	.db $cf
B7_3339:	.db $33
B7_333a:		.db $00				; 00
B7_333b:	.db $cc $00 $00
B7_333e:		.db $00				; 00
B7_333f:		.db $00				; 00
B7_3340:		.db $00				; 00
B7_3341:	.db $33
B7_3342:		.db $00				; 00
B7_3343:		.db $cc


processExp_etc_todo:
	jsr processDebugFlagPressingBOn2ndCtrler

	lda $74
B7_3349:		bne B7_3352 ; d0 07

B7_334b:		lda $75			; a5 75
B7_334d:		bne B7_3352 ; d0 03

B7_334f:		jmp B7_33ee		; 4c ee f3

B7_3352:		sec				; 38 
B7_3353:		lda $74			; a5 74
B7_3355:		sbc #$01		; e9 01
B7_3357:		sta $74			; 85 74
B7_3359:		lda $75			; a5 75
B7_335b:		sbc #$00		; e9 00
B7_335d:		sta $75			; 85 75
B7_335f:		lda wMajorNMIUpdatesCounter			; a5 23
B7_3361:		and #$03		; 29 03
B7_3363:		bne B7_336a ; d0 05

B7_3365:		lda #$3a		; a9 3a
B7_3367:		jsr queueSoundAtoPlay		; 20 ad c4
B7_336a:		lda #$00		; a9 00
B7_336c:		sta $0b			; 85 0b
B7_336e:		sta $0c			; 85 0c
B7_3370:		sta $0d			; 85 0d
B7_3372:		sta $0f			; 85 0f
B7_3374:		lda #$01		; a9 01
B7_3376:		sta $0e			; 85 0e
B7_3378:		ldx #$04		; a2 04
B7_337a:		clc				; 18 
B7_337b:		lda wCurrExpDigits, x		; b5 7c
B7_337d:		adc $0b, x		; 75 0b
B7_337f:		cmp #$0a		; c9 0a
B7_3381:		bcc B7_3385 ; 90 02

B7_3383:		sbc #$0a		; e9 0a
B7_3385:		sta wCurrExpDigits, x		; 95 7c
B7_3387:		dex				; ca 
B7_3388:		bpl B7_337b ; 10 f1

B7_338a:		bcc B7_339d ; 90 11

B7_338c:		ldx #$03		; a2 03
B7_338e:		lda #$09		; a9 09
B7_3390:		sta wCurrExpDigits, x		; 95 7c
B7_3392:		dex				; ca 
B7_3393:		bpl B7_3390 ; 10 fb

B7_3395:		lda #$00		; a9 00
B7_3397:		lda $80			; a5 80
B7_3399:		sta $74			; 85 74
B7_339b:		sta $75			; 85 75
B7_339d:		lda wCurrLevel			; a5 71
B7_339f:		cmp #$0f		; c9 0f
B7_33a1:		beq B7_33eb ; f0 48

; a is curr level, *= 5
B7_33a3:		ldx #$00		; a2 00
B7_33a5:		asl a			; 0a
B7_33a6:		asl a			; 0a
B7_33a7:		clc				; 18 
B7_33a8:		adc wCurrLevel			; 65 71
B7_33aa:		tay				; a8 

B7_33ab:		lda levelExpReqs.w, y	; b9 1b d2
B7_33ae:		cmp wCurrExpDigits, x		; d5 7c
B7_33b0:		bcc B7_33ba ; 90 08

B7_33b2:		bne B7_33eb ; d0 37

B7_33b4:		iny				; c8 
B7_33b5:		inx				; e8 
B7_33b6:		cpx #$05		; e0 05
B7_33b8:		bne B7_33ab ; d0 f1

B7_33ba:		inc wCurrLevel			; e6 71
B7_33bc:		jsr $f554		; 20 54 f5
B7_33bf:		lda #$3b		; a9 3b
B7_33c1:		jsr queueSoundAtoPlay		; 20 ad c4
B7_33c4:		ldy wCurrLevel			; a4 71
B7_33c6:		lda $b3			; a5 b3
B7_33c8:		beq B7_33d6 ; f0 0c

B7_33ca:		dey				; 88 
B7_33cb:		sec				; 38 
B7_33cc:		sbc $d1cb, y	; f9 cb d1
B7_33cf:		iny				; c8 
B7_33d0:		clc				; 18 
B7_33d1:		adc $d1cb, y	; 79 cb d1
B7_33d4:		sta $b3			; 85 b3
B7_33d6:		lda $b4			; a5 b4
B7_33d8:		beq B7_33e6 ; f0 0c

B7_33da:		dey				; 88 
B7_33db:		sec				; 38 
B7_33dc:		sbc $d1cb, y	; f9 cb d1
B7_33df:		iny				; c8 
B7_33e0:		clc				; 18 
B7_33e1:		adc $d1db, y	; 79 db d1
B7_33e4:		sta $b4			; 85 b4
B7_33e6:		lda levelAgility.w, y	; b9 eb d1
B7_33e9:		sta wCurrAgility			; 85 b5
B7_33eb:		jsr func_7_34fd		; 20 fd f4

B7_33ee:		ldy #$01		; a0 01
; also wHealthGiven
B7_33f0:		lda wMPGiven.w, y
B7_33f3:		beq B7_343a ; f0 45

; also wHealthGiven
B7_33f5:		lda wMPGiven.w, y
B7_33f8:		sec				; 38 
B7_33f9:		sbc #$01		; e9 01
; also wHealthGiven
B7_33fb:		sta wMPGiven.w, y
B7_33fe:		lda wMajorNMIUpdatesCounter			; a5 23
B7_3400:		and #$03		; 29 03
B7_3402:		bne B7_340d ; d0 09

B7_3404:		tya				; 98 
B7_3405:		pha				; 48 
B7_3406:		lda #$3a		; a9 3a
B7_3408:		jsr queueSoundAtoPlay		; 20 ad c4
B7_340b:		pla				; 68 
B7_340c:		tay				; a8 
B7_340d:		tya				; 98 
B7_340e:		eor #$01		; 49 01
B7_3410:		asl a			; 0a
B7_3411:		asl a			; 0a
B7_3412:		asl a			; 0a
B7_3413:		asl a			; 0a
B7_3414:		clc				; 18 
B7_3415:		adc wCurrLevel			; 65 71
B7_3417:		tax				; aa 
; or wCurrHealth
B7_3418:		lda wCurrMP.w, y
B7_341b:		clc				; 18 
B7_341c:		adc #$01		; 69 01
B7_341e:		bcs B7_3429 ; b0 09

; or wCurrHealth
B7_3420:		sta wCurrMP.w, y
B7_3423:		sec				; 38 
B7_3424:		sbc levelMaxHealth.w, x	; fd fb d1
B7_3427:		bcc B7_3434 ; 90 0b

B7_3429:		lda levelMaxHealth.w, x	; bd fb d1
; or wCurrHealth
B7_342c:		sta wCurrMP.w, y
B7_342f:		lda #$00		; a9 00
; also wHealthGiven
B7_3431:		sta wMPGiven.w, y
B7_3434:		jsr $f51c		; 20 1c f5
B7_3437:		jmp B7_343d		; 4c 3d f4

B7_343a:		jsr func_7_344d		; 20 4d f4

B7_343d:		dey				; 88 
B7_343e:		bpl B7_33f0 ; 10 b0

B7_3440:		jsr func_7_3594		; 20 94 f5
B7_3443:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B7_3445:		lda #$00		; a9 00
B7_3447:		sta wVramQueue.w, x	; 9d 00 05
B7_344a:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B7_344c:		rts				; 60 


func_7_344d:
; or wHealthTaken
B7_344d:		lda wMPUsed.w, y
B7_3450:		beq B7_3477 ; @done

; or wCurrHealth
B7_3452:		lda wCurrMP.w, y
.ifdef INVINCIBLE
	clc
	.db $ea $ea $ea
	jmp B7_346f
.else
B7_3455:		sec				; 38 
; or wHealthTaken
B7_3456:		sbc wMPUsed.w, y
; or wCurrHealth
B7_3459:		sta wCurrMP.w, y ; 99 7a 00 - 1f469
.endif
B7_345c:		beq B7_3460 ; f0 02

B7_345e:		bcs B7_346f ; b0 0f

B7_3460:		lda #$00		; a9 00
; or wCurrHealth
B7_3462:		sta wCurrMP.w, y
B7_3465:		cpy #$01		; c0 01
B7_3467:		bne B7_346f ; d0 06

B7_3469:		lda $c0			; a5 c0
B7_346b:		ora #$04		; 09 04
B7_346d:		sta $c0			; 85 c0

B7_346f:		lda #$00		; a9 00
; or wHealthTaken
B7_3471:		sta wMPUsed.w, y
B7_3474:		jsr $f51c		; 20 1c f5
B7_3477:		rts				; 60 


func_7_3478:
B7_3478:		sty $07			; 84 07
B7_347a:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B7_347c:		lda $0a			; a5 0a
B7_347e:		and #$7f		; 29 7f
B7_3480:		tay				; a8 
B7_3481:		lda wPPUCtrl			; a5 20
B7_3483:		and #$01		; 29 01
B7_3485:		asl a			; 0a
B7_3486:		asl a			; 0a
B7_3487:		ora $f548, y	; 19 48 f5
B7_348a:		sta wVramQueue.w, x	; 9d 00 05
B7_348d:		inx				; e8 
B7_348e:		lda $f54e, y	; b9 4e f5
B7_3491:		sta wVramQueue.w, x	; 9d 00 05
B7_3494:		inx				; e8 
B7_3495:		cpy #$02		; c0 02
B7_3497:		bcs B7_34a7 ; b0 0e

B7_3499:		lda #$05		; a9 05
B7_349b:		sta wVramQueue.w, x	; 9d 00 05
B7_349e:		inx				; e8 
B7_349f:		lda #$04		; a9 04
B7_34a1:		sta $09			; 85 09
B7_34a3:		ldy #$00		; a0 00
B7_34a5:		beq B7_34b3 ; f0 0c

B7_34a7:		lda #$03		; a9 03
B7_34a9:		sta wVramQueue.w, x	; 9d 00 05
B7_34ac:		lda #$02		; a9 02
B7_34ae:		sta $09			; 85 09
B7_34b0:		inx				; e8 
B7_34b1:		ldy #$01		; a0 01
B7_34b3:		lda $0b.w, y
B7_34b6:		bne B7_34c5 ; d0 0d

B7_34b8:		lda $08			; a5 08
B7_34ba:		sta wVramQueue.w, x	; 9d 00 05
B7_34bd:		inx				; e8 
B7_34be:		iny				; c8 
B7_34bf:		dec $09			; c6 09
B7_34c1:		bne B7_34b3 ; d0 f0

B7_34c3:		beq B7_34dd ; f0 18

B7_34c5:		lda $0a			; a5 0a
B7_34c7:		bmi B7_34cf ; 30 06

B7_34c9:		jsr func_7_34f3		; 20 f3 f4
B7_34cc:		jmp B7_34d5		; 4c d5 f4

B7_34cf:		lda $0b.w, y
B7_34d2:		sta wVramQueue.w, x	; 9d 00 05

B7_34d5:		inx				; e8 
B7_34d6:		iny				; c8 
B7_34d7:		dec $09			; c6 09
B7_34d9:		bne B7_34c5 ; d0 ea

B7_34db:		beq B7_34dd ; f0 00

B7_34dd:		lda $0a			; a5 0a
B7_34df:		bmi B7_34e7 ; 30 06

B7_34e1:		jsr func_7_34f3		; 20 f3 f4
B7_34e4:		jmp B7_34ed		; 4c ed f4

B7_34e7:		lda $0b.w, y
B7_34ea:		sta wVramQueue.w, x	; 9d 00 05

B7_34ed:		inx				; e8 
B7_34ee:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B7_34f0:		ldy $07			; a4 07
B7_34f2:		rts				; 60 


func_7_34f3:
B7_34f3:		lda $0b.w, y
B7_34f6:		clc				; 18 
B7_34f7:		adc #$f0		; 69 f0
B7_34f9:		sta wVramQueue.w, x	; 9d 00 05
B7_34fc:		rts				; 60 


func_7_34fd:
B7_34fd:		lda #$20		; a9 20
B7_34ff:		sta $08			; 85 08
B7_3501:		ldy #$00		; a0 00
B7_3503:		lda $70			; a5 70
B7_3505:		and #$40		; 29 40
	beq +

B7_3509:		ldy #$01		; a0 01
+	tya				; 98 
B7_350c:		ora #$80		; 09 80
B7_350e:		sta $0a			; 85 0a
B7_3510:		ldx #$04		; a2 04
-	lda wCurrExpDigits, x		; b5 7c
B7_3514:		sta $0b, x		; 95 0b
B7_3516:		dex				; ca 
	bpl -

B7_3519:		jmp func_7_3478		; 4c 78 f4


B7_351c:		lda $70			; a5 70
B7_351e:		and #$40		; 29 40
B7_3520:		beq B7_3526 ; f0 04

B7_3522:		tya				; 98 
B7_3523:		beq B7_3526 ; f0 01

B7_3525:		rts				; 60 


B7_3526:	.db $b9 $7a $00
B7_3529:		jsr func_7_364d		; 20 4d f6
B7_352c:		lda #$20		; a9 20
B7_352e:		sta $08			; 85 08
B7_3530:		tya				; 98 
B7_3531:		clc				; 18 
B7_3532:		adc #$02		; 69 02
B7_3534:		ora #$80		; 09 80
B7_3536:		sta $0a			; 85 0a
B7_3538:		lda $70			; a5 70
B7_353a:		and #$40		; 29 40
B7_353c:		beq B7_3545 ; f0 07

B7_353e:		lda $0a			; a5 0a
B7_3540:		clc				; 18 
B7_3541:		adc #$02		; 69 02
B7_3543:		sta $0a			; 85 0a
B7_3545:		jmp func_7_3478		; 4c 78 f4


B7_3548:		jsr $2022		; 20 22 20
B7_354b:	.db $20 $23 $00
B7_354e:		sty $e2			; 84 e2
B7_3550:		ldx $c6			; a6 c6
B7_3552:		bit $00			; 24 00
B7_3554:		lda $70			; a5 70
B7_3556:		and #$40		; 29 40
B7_3558:		bne B7_3593 ; d0 39

B7_355a:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B7_355c:		lda wPPUCtrl			; a5 20
B7_355e:		and #$01		; 29 01
B7_3560:		asl a			; 0a
B7_3561:		asl a			; 0a
B7_3562:		ora #$20		; 09 20
B7_3564:		sta wVramQueue.w, x	; 9d 00 05
B7_3567:		inx				; e8 
B7_3568:		lda #$65		; a9 65
B7_356a:		sta wVramQueue.w, x	; 9d 00 05
B7_356d:		inx				; e8 
B7_356e:		lda #$02		; a9 02
B7_3570:		sta wVramQueue.w, x	; 9d 00 05
B7_3573:		inx				; e8 
B7_3574:		lda wCurrLevel			; a5 71
B7_3576:		clc				; 18 
B7_3577:		adc #$01		; 69 01
B7_3579:		jsr func_7_364d		; 20 4d f6
B7_357c:		lda $0d			; a5 0d
B7_357e:		bne B7_3582 ; d0 02

B7_3580:		lda #$20		; a9 20
B7_3582:		sta wVramQueue.w, x	; 9d 00 05
B7_3585:		inx				; e8 
B7_3586:		lda $0e			; a5 0e
B7_3588:		sta wVramQueue.w, x	; 9d 00 05
B7_358b:		inx				; e8 
B7_358c:		lda #$00		; a9 00
B7_358e:		sta wVramQueue.w, x	; 9d 00 05
B7_3591:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B7_3593:		rts				; 60 


func_7_3594:
B7_3594:		lda $70			; a5 70
B7_3596:		and #$40		; 29 40
B7_3598:		bne B7_359b ; d0 01

B7_359a:		rts				; 60 

B7_359b:		jsr $f5da		; 20 da f5
B7_359e:		jsr $f5f1		; 20 f1 f5
B7_35a1:		ldy #$01		; a0 01
B7_35a3:		lda $0a			; a5 0a
B7_35a5:		pha				; 48 
B7_35a6:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B7_35a8:		lda wPPUCtrl			; a5 20
B7_35aa:		and #$01		; 29 01
B7_35ac:		asl a			; 0a
B7_35ad:		asl a			; 0a
B7_35ae:		ora #$20		; 09 20
B7_35b0:		sta wVramQueue.w, x	; 9d 00 05
B7_35b3:		inx				; e8 
B7_35b4:		tya				; 98 
B7_35b5:		asl a			; 0a
B7_35b6:		clc				; 18 
B7_35b7:		adc #$83		; 69 83
B7_35b9:		sta wVramQueue.w, x	; 9d 00 05
B7_35bc:		inx				; e8 
B7_35bd:		lda #$8f		; a9 8f
B7_35bf:		sta wVramQueue.w, x	; 9d 00 05
B7_35c2:		inx				; e8 
B7_35c3:		jsr $f610		; 20 10 f6
B7_35c6:		jsr $f62b		; 20 2b f6
B7_35c9:		sta wVramQueue.w, x	; 9d 00 05
B7_35cc:		inx				; e8 
B7_35cd:		dec $0b			; c6 0b
B7_35cf:		bpl B7_35c6 ; 10 f5

B7_35d1:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B7_35d3:		dey				; 88 
B7_35d4:		bpl B7_35a6 ; 10 d0

B7_35d6:		pla				; 68 
B7_35d7:		sta $0a			; 85 0a
B7_35d9:		rts				; 60 


B7_35da:		lda $72			; a5 72
B7_35dc:		sta $00			; 85 00
B7_35de:		lda wCurrHealth			; a5 7b
B7_35e0:		lsr a			; 4a
B7_35e1:		sta $72			; 85 72
B7_35e3:		cmp $00			; c5 00
B7_35e5:		bcc B7_35e8 ; 90 01

B7_35e7:		rts				; 60 


B7_35e8:		lda wCurrHealth			; a5 7b
B7_35ea:		and #$01		; 29 01
B7_35ec:		beq B7_35e7 ; f0 f9

B7_35ee:		inc $72			; e6 72
B7_35f0:		rts				; 60 


B7_35f1:		lda $d4			; a5 d4
B7_35f3:		sta $0b			; 85 0b
B7_35f5:		lda $035f		; ad 5f 03
B7_35f8:		lsr $0b			; 46 0b
B7_35fa:		ror a			; 6a
B7_35fb:		lsr $0b			; 46 0b
B7_35fd:		ror a			; 6a
B7_35fe:		lsr $0b			; 46 0b
B7_3600:		ror a			; 6a
B7_3601:		lsr $0b			; 46 0b
B7_3603:		ror a			; 6a
B7_3604:		sta $73			; 85 73
B7_3606:		lda $035f		; ad 5f 03
B7_3609:		and #$0f		; 29 0f
B7_360b:		beq B7_360f ; f0 02

B7_360d:		inc $73			; e6 73
B7_360f:		rts				; 60 


B7_3610:		lda #$00		; a9 00
B7_3612:		sta $0a			; 85 0a
B7_3614:	.db $b9 $72 $00
B7_3617:		asl a			; 0a
B7_3618:		rol $0a			; 26 0a
B7_361a:		asl a			; 0a
B7_361b:		rol $0a			; 26 0a
B7_361d:		asl a			; 0a
B7_361e:		rol $0a			; 26 0a
B7_3620:		asl a			; 0a
B7_3621:		rol $0a			; 26 0a
B7_3623:		asl a			; 0a
B7_3624:		rol $0a			; 26 0a
B7_3626:		lda #$0e		; a9 0e
B7_3628:		sta $0b			; 85 0b
B7_362a:		rts				; 60 


B7_362b:	.db $b9 $72 $00
B7_362e:		beq B7_364a ; f0 1a

B7_3630:		lda $0a			; a5 0a
B7_3632:		cmp #$0f		; c9 0f
B7_3634:		beq B7_3647 ; f0 11

B7_3636:		cmp $0b			; c5 0b
B7_3638:		bcc B7_364a ; 90 10

B7_363a:		bne B7_3647 ; d0 0b

B7_363c:	.db $b9 $72 $00
B7_363f:		and #$07		; 29 07
B7_3641:		eor #$07		; 49 07
B7_3643:		clc				; 18 
B7_3644:		adc #$15		; 69 15
B7_3646:		rts				; 60 


B7_3647:		lda #$14		; a9 14
B7_3649:		rts				; 60 


B7_364a:		lda #$1c		; a9 1c
B7_364c:		rts				; 60 


func_7_364d:
B7_364d:		pha				; 48 
B7_364e:		txa				; 8a 
B7_364f:		pha				; 48 
B7_3650:		ldx #$00		; a2 00
B7_3652:		stx $0c			; 86 0c
B7_3654:		stx $0d			; 86 0d
B7_3656:		stx $0e			; 86 0e
B7_3658:		stx $0f			; 86 0f
B7_365a:		pla				; 68 
B7_365b:		tax				; aa 
B7_365c:		pla				; 68 
B7_365d:		sec				; 38 

B7_365e:		sbc #100		; e9 64
B7_3660:		bcc B7_3667 ; 90 05

B7_3662:		inc $0c			; e6 0c
B7_3664:		jmp B7_365e		; 4c 5e f6

B7_3667:		adc #100		; 69 64

B7_3669:		sbc #10		; e9 0a
B7_366b:		bcc B7_3672 ; 90 05

B7_366d:		inc $0d			; e6 0d
B7_366f:		jmp B7_3669		; 4c 69 f6

B7_3672:		adc #10		; 69 0a
B7_3674:		sta $0e			; 85 0e
B7_3676:		rts				; 60 


roomEvent_bogarda:
B7_3677:		lda #GF_FIREFLOR_MAGIC		; a9 2c
B7_3679:		jsr checkGlobalFlag		; 20 6c c4
B7_367c:		bne B7_3684 ; d0 06

B7_367e:		lda wPlayerY			; a5 cc
B7_3680:		cmp #$c0		; c9 c0
B7_3682:		bcc B7_3685 ; 90 01

B7_3684:		rts				; 60 

B7_3685:		lda #$24		; a9 24
B7_3687:		jsr queueSoundAtoPlay		; 20 ad c4
B7_368a:		lda #$5b		; a9 5b
B7_368c:		sta wRLEStructAddressToCopy			; 85 33
B7_368e:		lda #$fa		; a9 fa
B7_3690:		sta wRLEStructAddressToCopy+1			; 85 34
B7_3692:		jsr func_6_22bf		; 20 bf a2
B7_3695:		jsr func_6_02a7		; 20 a7 82
B7_3698:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_369b:		inc $a3			; e6 a3
B7_369d:		inc $f8			; e6 f8
B7_369f:		jsr func_7_3986		; 20 86 f9
B7_36a2:		lda #$7e		; a9 7e
B7_36a4:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_36a7:		lda #$09		; a9 09
B7_36a9:		sta $59			; 85 59
B7_36ab:		lda #$0a		; a9 0a
B7_36ad:		sta $d5			; 85 d5
B7_36af:		sta $d7			; 85 d7
B7_36b1:		jsr func_7_2045		; 20 45 e0
B7_36b4:		inc $0407		; ee 07 04
B7_36b7:		bit $f8			; 24 f8
B7_36b9:		bmi B7_36c1 ; 30 06

B7_36bb:		jsr mainGameplayLoop		; 20 27 df
B7_36be:		jmp $f6b7		; 4c b7 f6


B7_36c1:		jsr func_6_22bf		; 20 bf a2
B7_36c4:		jsr func_6_02a7		; 20 a7 82
B7_36c7:		jsr $f9a9		; 20 a9 f9
B7_36ca:		jsr $fa0d		; 20 0d fa
B7_36cd:		jsr $fa1d		; 20 1d fa
B7_36d0:		lda #$1f		; a9 1f
B7_36d2:		sta wRoomY			; 85 43
B7_36d4:		lda #$1c		; a9 1c
B7_36d6:		sta wRoomX			; 85 42
B7_36d8:		lda #$00		; a9 00
B7_36da:		sta $59			; 85 59
B7_36dc:		sta $70			; 85 70
B7_36de:		sta $f8			; 85 f8
B7_36e0:		jsr clearAllEntities		; 20 94 c3
B7_36e3:		lda #$01		; a9 01
B7_36e5:		sta $d5			; 85 d5
B7_36e7:		sta $d7			; 85 d7
B7_36e9:		jsr func_7_2045		; 20 45 e0
B7_36ec:		lda #$00		; a9 00
B7_36ee:		sta $a3			; 85 a3
B7_36f0:		ldx #$ff		; a2 ff
B7_36f2:		txs				; 9a 
B7_36f3:		jmp mainLoop		; 4c a9 de


roomEvent_muzh:
B7_36f6:		lda #GF_BOMBARD_MAGIC		; a9 29
B7_36f8:		jsr checkGlobalFlag		; 20 6c c4
B7_36fb:		bne B7_3703 ; d0 06

B7_36fd:		lda wPlayerY			; a5 cc
B7_36ff:		cmp #$c0		; c9 c0
B7_3701:		bcc B7_3704 ; 90 01

B7_3703:		rts				; 60 


B7_3704:		lda #$24		; a9 24
B7_3706:		jsr queueSoundAtoPlay		; 20 ad c4
B7_3709:		lda #$7a		; a9 7a
B7_370b:		sta wRLEStructAddressToCopy			; 85 33
B7_370d:		lda #$fa		; a9 fa
B7_370f:		sta wRLEStructAddressToCopy+1			; 85 34
B7_3711:		jsr func_6_22bf		; 20 bf a2
B7_3714:		jsr func_6_02a7		; 20 a7 82
B7_3717:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_371a:		inc $a3			; e6 a3
B7_371c:		inc $f8			; e6 f8
B7_371e:		inc $f8			; e6 f8
B7_3720:		jsr func_7_3986		; 20 86 f9
B7_3723:		lda #$0a		; a9 0a
B7_3725:		sta $59			; 85 59
B7_3727:		lda #$0a		; a9 0a
B7_3729:		sta $d5			; 85 d5
B7_372b:		jsr $f964		; 20 64 f9
B7_372e:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_3731:		jsr func_7_1b5a		; 20 5a db
B7_3734:		lda #$01		; a9 01
B7_3736:		sta $70			; 85 70
B7_3738:		jsr func_7_3000		; 20 00 f0
B7_373b:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_373e:		lda $d6			; a5 d6
B7_3740:		bne B7_373b ; d0 f9

B7_3742:		inc $0407		; ee 07 04
B7_3745:		bit $f8			; 24 f8
B7_3747:		bmi B7_374f ; 30 06

B7_3749:		jsr mainGameplayLoop		; 20 27 df
B7_374c:		jmp $f745		; 4c 45 f7


B7_374f:		jsr func_6_22bf		; 20 bf a2
B7_3752:		jsr func_6_02a7		; 20 a7 82
B7_3755:		jsr $f9a9		; 20 a9 f9
B7_3758:		jsr $fa0d		; 20 0d fa
B7_375b:		jsr $fa1d		; 20 1d fa
B7_375e:		jmp $f6d8		; 4c d8 f6


roomEvent_eborsisk:
B7_3761:		lda #GF_BEAT_EBORSISK		; a9 0d
B7_3763:		jsr checkGlobalFlag		; 20 6c c4
B7_3766:		bne B7_376e ; d0 06

B7_3768:		lda wPlayerY			; a5 cc
B7_376a:		cmp #$c0		; c9 c0
B7_376c:		bcc B7_376f ; 90 01

B7_376e:		rts				; 60 

B7_376f:		lda #$24		; a9 24
B7_3771:		jsr queueSoundAtoPlay		; 20 ad c4
B7_3774:		lda #$a7		; a9 a7
B7_3776:		sta wRLEStructAddressToCopy			; 85 33
B7_3778:		lda #$fa		; a9 fa
B7_377a:		sta wRLEStructAddressToCopy+1			; 85 34
B7_377c:		jsr func_6_22bf		; 20 bf a2
B7_377f:		jsr func_6_02a7		; 20 a7 82
B7_3782:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_3785:		inc $a3			; e6 a3
B7_3787:		lda #$03		; a9 03
B7_3789:		sta $f8			; 85 f8
B7_378b:		jsr func_7_3986		; 20 86 f9
B7_378e:		lda #$0b		; a9 0b
B7_3790:		sta $59			; 85 59
B7_3792:		lda #$0a		; a9 0a
B7_3794:		sta $d5			; 85 d5
B7_3796:		jsr $f964		; 20 64 f9
B7_3799:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_379c:		jsr func_7_1b5a		; 20 5a db
B7_379f:		lda #$01		; a9 01
B7_37a1:		sta $70			; 85 70
B7_37a3:		jsr func_7_3000		; 20 00 f0
B7_37a6:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_37a9:		lda $d6			; a5 d6
B7_37ab:		bne B7_37a6 ; d0 f9

B7_37ad:		inc $0407		; ee 07 04
B7_37b0:		bit $f8			; 24 f8
B7_37b2:		bmi B7_37ba ; 30 06

B7_37b4:		jsr mainGameplayLoop		; 20 27 df
B7_37b7:		jmp $f7b0		; 4c b0 f7

B7_37ba:		jsr $f7ee		; 20 ee f7
B7_37bd:		jsr func_6_22bf		; 20 bf a2
B7_37c0:		jsr func_6_02a7		; 20 a7 82
B7_37c3:		jsr func_7_39d3		; 20 d3 f9
B7_37c6:		jsr $fa34		; 20 34 fa
B7_37c9:		jsr $fa44		; 20 44 fa
B7_37cc:		lda #$00		; a9 00
B7_37ce:		sta $59			; 85 59
B7_37d0:		sta $70			; 85 70
B7_37d2:		sta $f8			; 85 f8
B7_37d4:		sta $a3			; 85 a3
B7_37d6:		jsr clearAllEntities		; 20 94 c3
B7_37d9:		lda #$14		; a9 14
B7_37db:		sta $d5			; 85 d5
B7_37dd:		jsr $f964		; 20 64 f9
B7_37e0:		jsr $803e		; 20 3e 80
B7_37e3:		lda #GF_BEAT_EBORSISK		; a9 0d
B7_37e5:		jsr setGlobalFlag		; 20 60 c4
B7_37e8:		ldx #$ff		; a2 ff
B7_37ea:		txs				; 9a 
B7_37eb:		jmp mainLoop		; 4c a9 de


B7_37ee:		ldx #$0e		; a2 0e
B7_37f0:		lda wEntities_360.w, x	; bd 60 03
B7_37f3:		jsr initNpcSpecAIdxX		; 20 ec c3
B7_37f6:		inx				; e8 
B7_37f7:		cpx #$17		; e0 17
B7_37f9:		bne B7_37f0 ; d0 f5

B7_37fb:		rts				; 60 


roomEvent_kaelFight:
B7_37fc:		lda #GF_BEAT_KAEL		; a9 0c
B7_37fe:		jsr checkGlobalFlag		; 20 6c c4
B7_3801:		bne B7_3809 ; d0 06

B7_3803:		lda wPlayerY			; a5 cc
B7_3805:		cmp #$c0		; c9 c0
B7_3807:		bcc B7_380a ; 90 01

B7_3809:		rts				; 60 

B7_380a:		lda #$24		; a9 24
B7_380c:		jsr queueSoundAtoPlay		; 20 ad c4
B7_380f:		lda #$a7		; a9 a7
B7_3811:		sta wRLEStructAddressToCopy			; 85 33
B7_3813:		lda #$fa		; a9 fa
B7_3815:		sta wRLEStructAddressToCopy+1			; 85 34
B7_3817:		jsr func_6_22bf		; 20 bf a2
B7_381a:		jsr func_6_02a7		; 20 a7 82
B7_381d:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_3820:		inc $a3			; e6 a3
B7_3822:		lda #$04		; a9 04
B7_3824:		sta $f8			; 85 f8
B7_3826:		jsr func_7_3986		; 20 86 f9
B7_3829:		lda #$7e		; a9 7e
B7_382b:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_382e:		lda #$0b		; a9 0b
B7_3830:		sta $59			; 85 59
B7_3832:		lda #$0a		; a9 0a
B7_3834:		sta $d5			; 85 d5
B7_3836:		sta $d7			; 85 d7
B7_3838:		jsr func_7_2045		; 20 45 e0
B7_383b:		inc $0407		; ee 07 04
B7_383e:		bit $f8			; 24 f8
B7_3840:		bmi B7_3848 ; 30 06

B7_3842:		jsr mainGameplayLoop		; 20 27 df
B7_3845:		jmp $f83e		; 4c 3e f8

B7_3848:		jsr func_6_22bf		; 20 bf a2
B7_384b:		jsr func_6_02a7		; 20 a7 82
B7_384e:		jsr func_7_39d3		; 20 d3 f9
B7_3851:		jsr $fa34		; 20 34 fa
B7_3854:		jsr $fa44		; 20 44 fa
B7_3857:		lda #$00		; a9 00
B7_3859:		sta $59			; 85 59
B7_385b:		sta $70			; 85 70
B7_385d:		sta $f8			; 85 f8
B7_385f:		sta $a3			; 85 a3
B7_3861:		jsr clearAllEntities		; 20 94 c3
B7_3864:		lda #$02		; a9 02
B7_3866:		sta $d5			; 85 d5
B7_3868:		jsr $f964		; 20 64 f9
B7_386b:		jsr $803e		; 20 3e 80
B7_386e:		lda #GF_BEAT_KAEL		; a9 0c
B7_3870:		jsr setGlobalFlag		; 20 60 c4
B7_3873:		ldx #$ff		; a2 ff
B7_3875:		txs				; 9a 
B7_3876:		jmp mainLoop		; 4c a9 de


roomEvent_bavmorda:
B7_3879:		lda #$7e		; a9 7e
B7_387b:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_387e:		jsr func_6_22bf		; 20 bf a2
B7_3881:		jsr func_6_02a7		; 20 a7 82
B7_3884:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_3887:		lda #$05		; a9 05
B7_3889:		sta $f8			; 85 f8
B7_388b:		jsr func_7_3986		; 20 86 f9
B7_388e:		lda #$7e		; a9 7e
B7_3890:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_3893:		lda #$0a		; a9 0a
B7_3895:		sta $d5			; 85 d5
B7_3897:		sta $d7			; 85 d7
B7_3899:		jsr func_7_2045		; 20 45 e0
B7_389c:		lda $0317		; ad 17 03
B7_389f:		and #$fe		; 29 fe
B7_38a1:		sta $0317		; 8d 17 03
B7_38a4:		lda $0347		; ad 47 03
B7_38a7:		and #$df		; 29 df
B7_38a9:		sta $0347		; 8d 47 03
B7_38ac:		inc $0407		; ee 07 04
B7_38af:		bit $f8			; 24 f8
B7_38b1:		bmi B7_38b9 ; 30 06

B7_38b3:		jsr mainGameplayLoop		; 20 27 df
B7_38b6:		jmp $f8af		; 4c af f8

B7_38b9:		jsr func_6_22bf		; 20 bf a2
B7_38bc:		jsr func_6_02a7		; 20 a7 82
B7_38bf:		jsr $f9a9		; 20 a9 f9
B7_38c2:		lda #$1f		; a9 1f
B7_38c4:		sta wRoomY			; 85 43
B7_38c6:		lda #$1b		; a9 1b
B7_38c8:		sta wRoomX			; 85 42
B7_38ca:		lda #$7e		; a9 7e
B7_38cc:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_38cf:		lda #$00		; a9 00
B7_38d1:		sta $70			; 85 70
B7_38d3:		lda #$05		; a9 05
B7_38d5:		sta $f8			; 85 f8
B7_38d7:		jsr clearAllEntities		; 20 94 c3
B7_38da:		lda #$95		; a9 95
B7_38dc:		sta wSavedInternalPalettesSpecIdx			; 85 2f
B7_38de:		lda #$0a		; a9 0a
B7_38e0:		sta $d5			; 85 d5
B7_38e2:		sta $d7			; 85 d7
B7_38e4:		jsr func_7_2045		; 20 45 e0
B7_38e7:		jsr func_7_3986		; 20 86 f9
B7_38ea:		lda #$3f		; a9 3f
B7_38ec:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_38ef:		lda $0347		; ad 47 03
B7_38f2:		and #$df		; 29 df
B7_38f4:		sta $0347		; 8d 47 03
B7_38f7:		inc $0407		; ee 07 04
B7_38fa:		bit $f8			; 24 f8
B7_38fc:		bmi B7_3907 ; 30 09

B7_38fe:		jsr $f96e		; 20 6e f9
B7_3901:		jsr mainGameplayLoop		; 20 27 df
B7_3904:		jmp $f8fa		; 4c fa f8

B7_3907:		jsr func_6_22bf		; 20 bf a2
B7_390a:		jsr func_6_02a7		; 20 a7 82
B7_390d:		lda #$bd		; a9 bd
B7_390f:		sta wGenericCounter			; 85 2d
B7_3911:		jsr updateCurrScreensSprPalettes		; 20 40 dd
B7_3914:		lda wMajorNMIUpdatesCounter			; a5 23
B7_3916:		and #$04		; 29 04
B7_3918:		bne B7_3924 ; d0 0a

B7_391a:		lda #$29		; a9 29
B7_391c:		jsr queueSoundAtoPlay		; 20 ad c4
B7_391f:		lda #$94		; a9 94
B7_3921:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_3924:		ldx #$20		; a2 20
B7_3926:		lda wMajorNMIUpdatesCounter			; a5 23
B7_3928:		and #$04		; 29 04
B7_392a:		bne B7_392e ; d0 02

B7_392c:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B7_392e:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B7_392e:	.db $ea $ea $ea
.endif
B7_3931:		stx $30			; 86 30
B7_3933:		jsr drawEntities		; 20 03 c4
B7_3936:		jsr drawPlayer		; 20 dd c3
B7_3939:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_393c:		dec wGenericCounter			; c6 2d
B7_393e:		bne B7_3911 ; d0 d1

B7_3940:		jsr updateCurrScreensSprPalettes		; 20 40 dd
B7_3943:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B7_3945:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B7_3945:	.db $ea $ea $ea
.endif
B7_3948:		stx $30			; 86 30
B7_394a:		lda #$00		; a9 00
B7_394c:		sta $70			; 85 70
B7_394e:		sta $f8			; 85 f8
B7_3950:		sta $a3			; 85 a3
B7_3952:		jsr clearAllEntities		; 20 94 c3
B7_3955:		lda #$ff		; a9 ff
B7_3957:		sta $d5			; 85 d5
B7_3959:		jsr $f964		; 20 64 f9
B7_395c:		lda #$7e		; a9 7e
B7_395e:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_3961:		jmp $e14b		; 4c 4b e1


B7_3964:		lda #$80		; a9 80
B7_3966:		sta $d6			; 85 d6
B7_3968:		lda #$fd		; a9 fd
B7_396a:		jsr queueSoundAtoPlay		; 20 ad c4
B7_396d:		rts				; 60 


B7_396e:		lda wMajorNMIUpdatesCounter			; a5 23
B7_3970:		and #$07		; 29 07
B7_3972:		bne B7_3985 ; d0 11

B7_3974:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B7_3976:		jsr updateSavedInternalPalettesFromSpecA		; 20 b0 c6
B7_3979:		inc $2f			; e6 2f
B7_397b:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B7_397d:		cmp #$98		; c9 98
B7_397f:		bcc B7_3985 ; 90 04

B7_3981:		lda #$95		; a9 95
B7_3983:		sta wSavedInternalPalettesSpecIdx			; 85 2f
B7_3985:		rts				; 60 


; called during boss fights
func_7_3986:
B7_3986:		ldy $f8			; a4 f8
B7_3988:		dey				; 88 
B7_3989:		tya				; 98 
B7_398a:		asl a			; 0a
B7_398b:		tay				; a8 
B7_398c:		lda $faca, y	; b9 ca fa
B7_398f:		sta wSprPaletteSpecAndChrBank			; 85 50
B7_3991:		lda $facb, y	; b9 cb fa
B7_3994:		sta wEntityDataByte2			; 85 52
B7_3996:		jsr setSprPalAndChr_updateCurrScreensSprPalettes		; 20 3d dd
B7_3999:		jsr loadScreenEntities		; 20 3c e1
B7_399c:		jsr updateScreenEntities		; 20 23 c4
B7_399f:		jsr drawEntities		; 20 03 c4
B7_39a2:		jsr drawPlayer		; 20 dd c3
B7_39a5:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_39a8:		rts				; 60 


B7_39a9:		lda #$bd		; a9 bd
B7_39ab:		sta wGenericCounter			; 85 2d
B7_39ad:		jsr updateCurrScreensSprPalettes		; 20 40 dd
B7_39b0:		lda wMajorNMIUpdatesCounter			; a5 23
B7_39b2:		and #$04		; 29 04
B7_39b4:		bne B7_39c0 ; d0 0a

B7_39b6:		lda #$29		; a9 29
B7_39b8:		jsr queueSoundAtoPlay		; 20 ad c4
B7_39bb:		lda #$94		; a9 94
B7_39bd:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B7_39c0:		jsr drawEntities		; 20 03 c4
B7_39c3:		jsr drawPlayer		; 20 dd c3
B7_39c6:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_39c9:		dec wGenericCounter			; c6 2d
B7_39cb:		bne B7_39ad ; d0 e0

B7_39cd:		jsr updateCurrScreensSprPalettes		; 20 40 dd
B7_39d0:		jmp func_7_39ff		; 4c ff f9


func_7_39d3:
B7_39d3:		lda #$bd		; a9 bd
B7_39d5:		sta wGenericCounter			; 85 2d
B7_39d7:		ldx #$20		; a2 20
B7_39d9:		lda wMajorNMIUpdatesCounter			; a5 23
B7_39db:		and #$04		; 29 04
B7_39dd:		bne B7_39e6 ; d0 07

B7_39df:		lda #$29		; a9 29
B7_39e1:		jsr queueSoundAtoPlay		; 20 ad c4
B7_39e4:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B7_39e6:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B7_39e6:	.db $ea $ea $ea
.endif
B7_39e9:		stx $30			; 86 30
B7_39eb:		jsr drawEntities		; 20 03 c4
B7_39ee:		jsr drawPlayer		; 20 dd c3
B7_39f1:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_39f4:		dec wGenericCounter			; c6 2d
B7_39f6:		bne B7_39d7 ; d0 df

B7_39f8:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B7_39fa:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B7_39fa:	.db $ea $ea $ea
.endif
B7_39fd:		stx $30			; 86 30

func_7_39ff:
B7_39ff:		lda #$ff		; a9 ff
B7_3a01:		sta $d5			; 85 d5
B7_3a03:		lda #$80		; a9 80
B7_3a05:		sta $d6			; 85 d6
B7_3a07:		lda #$fd		; a9 fd
B7_3a09:		jsr queueSoundAtoPlay		; 20 ad c4
B7_3a0c:		rts				; 60 


B7_3a0d:		lda $74			; a5 74
B7_3a0f:		ora $75			; 05 75
B7_3a11:		beq B7_3a1c ; f0 09

B7_3a13:		jsr processExp_etc_todo		; 20 44 f3
B7_3a16:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_3a19:		jmp $fa0d		; 4c 0d fa


B7_3a1c:		rts				; 60 


B7_3a1d:		lda #$ff		; a9 ff
B7_3a1f:		sta wHealthGiven			; 85 77
B7_3a21:		lda wHealthGiven			; a5 77
B7_3a23:		beq B7_3a2e ; f0 09

B7_3a25:		jsr processExp_etc_todo		; 20 44 f3
B7_3a28:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_3a2b:		jmp $fa21		; 4c 21 fa


B7_3a2e:		lda #$3f		; a9 3f
B7_3a30:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_3a33:		rts				; 60 


B7_3a34:		lda $74			; a5 74
B7_3a36:		ora $75			; 05 75
B7_3a38:		beq B7_3a43 ; f0 09

B7_3a3a:		jsr processExp_etc_todo		; 20 44 f3
B7_3a3d:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_3a40:		jmp $fa34		; 4c 34 fa


B7_3a43:		rts				; 60 


B7_3a44:		lda #$ff		; a9 ff
B7_3a46:		sta wHealthGiven			; 85 77
B7_3a48:		lda wHealthGiven			; a5 77
B7_3a4a:		beq B7_3a55 ; f0 09

B7_3a4c:		jsr processExp_etc_todo		; 20 44 f3
B7_3a4f:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B7_3a52:		jmp $fa48		; 4c 48 fa


B7_3a55:		lda #$3f		; a9 3f
B7_3a57:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B7_3a5a:		rts				; 60 


B7_3a5b:	.db $23
B7_3a5c:		jmp $7408		; 4c 08 74


B7_3a5f:		ror $74, x		; 76 74
B7_3a61:		ror $74, x		; 76 74
B7_3a63:		ror $74, x		; 76 74
B7_3a65:		ror $23, x		; 76 23
B7_3a67:		jmp ($7508)		; 6c 08 75


B7_3a6a:	.db $77
B7_3a6b:		adc wHealthGiven, x		; 75 77
B7_3a6d:		adc wHealthGiven, x		; 75 77
B7_3a6f:		adc wHealthGiven, x		; 75 77
B7_3a71:	.db $23
B7_3a72:		sty $7548		; 8c 48 75
B7_3a75:	.db $23
B7_3a76:		ldy $7548		; ac 48 75
B7_3a79:	.db $ff
B7_3a7a:	.db $27
B7_3a7b:		jmp $7408		; 4c 08 74


B7_3a7e:		ror $74, x		; 76 74
B7_3a80:		ror $74, x		; 76 74
B7_3a82:		ror $74, x		; 76 74
B7_3a84:		ror $27, x		; 76 27
B7_3a86:		jmp ($7508)		; 6c 08 75


B7_3a89:	.db $77
B7_3a8a:		adc wHealthGiven, x		; 75 77
B7_3a8c:		adc wHealthGiven, x		; 75 77
B7_3a8e:		adc wHealthGiven, x		; 75 77
B7_3a90:	.db $27
B7_3a91:		sty $9408		; 8c 08 94
B7_3a94:		stx $94, y		; 96 94
B7_3a96:		stx $94, y		; 96 94
B7_3a98:		stx $94, y		; 96 94
B7_3a9a:		stx $27, y		; 96 27
B7_3a9c:		ldy $9508		; ac 08 95
B7_3a9f:	.db $97
B7_3aa0:		sta $97, x		; 95 97
B7_3aa2:		sta $97, x		; 95 97
B7_3aa4:		sta $97, x		; 95 97
B7_3aa6:	.db $ff
B7_3aa7:	.db $27
B7_3aa8:		jmp $a40a		; 4c 0a a4


B7_3aab:		ldx $a4			; a6 a4
B7_3aad:		ldx $a4			; a6 a4
B7_3aaf:		ldx $a4			; a6 a4
B7_3ab1:		ldx $a4			; a6 a4
B7_3ab3:		ldx $27			; a6 27
B7_3ab5:		jmp ($a50a)		; 6c 0a a5


B7_3ab8:	.db $a7
B7_3ab9:		lda $a7			; a5 a7
B7_3abb:		lda $a7			; a5 a7
B7_3abd:		lda $a7			; a5 a7
B7_3abf:		lda $a7			; a5 a7
B7_3ac1:	.db $27
B7_3ac2:		sty $204a		; 8c 4a 20
B7_3ac5:	.db $27
B7_3ac6:		ldy $204a		; ac 4a 20
B7_3ac9:	.db $ff
B7_3aca:	.db $a7
B7_3acb:	.db $1a
B7_3acc:		adc ($1d, x)	; 61 1d
B7_3ace:	.db $37
B7_3acf:		ora $1c27, y	; 19 27 1c
B7_3ad2:		adc $1b, x		; 75 1b
B7_3ad4:	.db $ff
B7_3ad5:	.db $ff
B7_3ad6:	.db $ff
B7_3ad7:	.db $ff
B7_3ad8:	.db $ff
B7_3ad9:	.db $ff
B7_3ada:	.db $ff
B7_3adb:	.db $ff
B7_3adc:	.db $ff
B7_3add:	.db $ff
B7_3ade:	.db $ff
B7_3adf:	.db $ff
B7_3ae0:		.db $00				; 00
B7_3ae1:		.db $00				; 00
B7_3ae2:		.db $00				; 00
B7_3ae3:		.db $00				; 00
B7_3ae4:		.db $00				; 00
B7_3ae5:		.db $00				; 00
B7_3ae6:		.db $00				; 00
B7_3ae7:		.db $00				; 00
B7_3ae8:		.db $00				; 00
B7_3ae9:		.db $00				; 00
B7_3aea:		.db $00				; 00
B7_3aeb:		.db $00				; 00
B7_3aec:		.db $00				; 00
B7_3aed:		.db $00				; 00
B7_3aee:		.db $00				; 00
B7_3aef:		.db $00				; 00
B7_3af0:		.db $00				; 00
B7_3af1:		.db $00				; 00
B7_3af2:		.db $00				; 00
B7_3af3:		.db $00				; 00
B7_3af4:		.db $00				; 00
B7_3af5:		.db $00				; 00
B7_3af6:		.db $00				; 00
B7_3af7:		.db $00				; 00
B7_3af8:		.db $00				; 00
B7_3af9:		.db $00				; 00
B7_3afa:		.db $00				; 00
B7_3afb:		.db $00				; 00
B7_3afc:		.db $00				; 00
B7_3afd:		.db $00				; 00
B7_3afe:		.db $00				; 00
B7_3aff:		.db $00				; 00


data_7_3b00:
	.db $00 $15 $4a $ae $2d $c8 $79 $39 $00 $c7 $87 $38 $d3 $52 $b6 $eb
	.db $00 $eb $b6 $52 $d3 $38 $87 $c7 $00 $39 $79 $c8 $2d $ae $4a $15
	.db $00 $0b $25 $57 $97 $e4 $3d $9d $00 $63 $c3 $1c $69 $a9 $db $f5
	.db $00 $f5 $db $a9 $69 $1c $c3 $63 $00 $9d $3d $e4 $97 $57 $25 $0b
	.db $76 $7e $93 $b9 $ea $26 $6a $b4 $00 $4c $96 $da $16 $47 $6d $82
	.db $8a $82 $6d $47 $16 $da $96 $4c $00 $b4 $6a $26 $ea $b9 $93 $7e
	.db $b4 $bb $cc $ed $16 $48 $82 $c0 $00 $40 $7e $b8 $ea $13 $34 $45
	.db $4c $45 $34 $13 $ea $b8 $7e $40 $00 $c0 $82 $48 $16 $ed $cc $bb
	.db $00 $06 $13 $2c $4c $72 $9f $cf $00 $31 $61 $8e $b4 $d4 $ed $fa
	.db $00 $fa $ed $d4 $b4 $8e $61 $31 $00 $cf $9f $72 $4c $2c $13 $06
	.db $3b $3f $4a $5d $75 $93 $b5 $da $00 $26 $4b $6d $8b $a3 $b6 $c1
	.db $c5 $c1 $b6 $a3 $8b $6d $4b $26 $00 $da $b5 $93 $75 $5d $4a $3f
	.db $7b $7e $85 $92 $a2 $b7 $ce $e7 $00 $19 $32 $49 $5e $6e $7b $82
	.db $85 $82 $7b $6e $5e $49 $32 $19 $00 $e7 $ce $b7 $a2 $92 $85 $7e
	.db $be $c0 $c3 $ca $d2 $dc $e7 $f4 $00 $0c $19 $24 $2e $36 $3d $40
	.db $42 $40 $3d $36 $2e $24 $19 $0c $00 $f4 $e7 $dc $d2 $ca $c3 $c0


data_7_3c00:
	.db $fc $fc $fc $fc $fd $fd $fe $ff $00 $00 $01 $02 $02 $03 $03 $03
	.db $04 $03 $03 $03 $02 $02 $01 $00 $00 $ff $fe $fd $fd $fc $fc $fc
	.db $fe $fe $fe $fe $fe $fe $ff $ff $00 $00 $00 $01 $01 $01 $01 $01
	.db $02 $01 $01 $01 $01 $01 $00 $00 $00 $ff $ff $fe $fe $fe $fe $fe
	.db $fe $fe $fe $fe $fe $ff $ff $ff $00 $00 $00 $00 $01 $01 $01 $01
	.db $01 $01 $01 $01 $01 $00 $00 $00 $00 $ff $ff $ff $fe $fe $fe $fe
	.db $fe $fe $fe $fe $ff $ff $ff $ff $00 $00 $00 $00 $00 $01 $01 $01
	.db $01 $01 $01 $01 $00 $00 $00 $00 $00 $ff $ff $ff $ff $fe $fe $fe
	.db $ff $ff $ff $ff $ff $ff $ff $ff $00 $00 $00 $00 $00 $00 $00 $00
	.db $01 $00 $00 $00 $00 $00 $00 $00 $00 $ff $ff $ff $ff $ff $ff $ff
	.db $ff $ff $ff $ff $ff $ff $ff $ff $00 $00 $00 $00 $00 $00 $00 $00
	.db $00 $00 $00 $00 $00 $00 $00 $00 $00 $ff $ff $ff $ff $ff $ff $ff
	.db $ff $ff $ff $ff $ff $ff $ff $ff $00 $00 $00 $00 $00 $00 $00 $00
	.db $00 $00 $00 $00 $00 $00 $00 $00 $00 $ff $ff $ff $ff $ff $ff $ff
	.db $ff $ff $ff $ff $ff $ff $ff $ff $00 $00 $00 $00 $00 $00 $00 $00
	.db $00 $00 $00 $00 $00 $00 $00 $00 $00 $ff $ff $ff $ff $ff $ff $ff


data_7_3d00:
	.db $00 $c7 $87 $38 $d3 $52 $b6 $eb $00 $eb $b6 $52 $d3 $38 $87 $c7
	.db $00 $39 $79 $c8 $2d $ae $4a $15 $00 $15 $4a $ae $2d $c8 $79 $39
	.db $00 $63 $c3 $1c $69 $a9 $db $f5 $00 $f5 $db $a9 $69 $1c $c3 $63
	.db $00 $9d $3d $e4 $97 $57 $25 $0b $00 $0b $25 $57 $97 $e4 $3d $9d
	.db $00 $4c $96 $da $16 $47 $6d $82 $8a $82 $6d $47 $16 $da $96 $4c
	.db $00 $b4 $6a $26 $ea $b9 $93 $7e $76 $7e $93 $b9 $ea $26 $6a $b4
	.db $00 $40 $7e $b8 $ea $13 $34 $45 $4c $45 $34 $13 $ea $b8 $7e $40
	.db $00 $c0 $82 $48 $16 $ed $cc $bb $b4 $bb $cc $ed $16 $48 $82 $c0
	.db $00 $31 $61 $8e $b4 $d4 $ed $fa $00 $fa $ed $d4 $b4 $8e $61 $31
	.db $00 $cf $9f $72 $4c $2c $13 $06 $00 $06 $13 $2c $4c $72 $9f $cf
	.db $00 $26 $4b $6d $8b $a3 $b6 $c1 $c5 $c1 $b6 $a3 $8b $6d $4b $26
	.db $00 $da $b5 $93 $75 $5d $4a $3f $3b $3f $4a $5d $75 $93 $b5 $da
	.db $00 $19 $32 $49 $5e $6e $7b $82 $85 $82 $7b $6e $5e $49 $32 $19
	.db $00 $e7 $ce $b7 $a2 $92 $85 $7e $7b $7e $85 $92 $a2 $b7 $ce $e7
	.db $00 $0c $19 $24 $2e $36 $3d $40 $42 $40 $3d $36 $2e $24 $19 $0c
	.db $00 $f4 $e7 $dc $d2 $ca $c3 $c0 $be $c0 $c3 $ca $d2 $dc $e7 $f4


data_7_3e00:
	.db $00 $00 $01 $02 $02 $03 $03 $03 $04 $03 $03 $03 $02 $02 $01 $00
	.db $00 $ff $fe $fd $fd $fc $fc $fc $fc $fc $fc $fc $fd $fd $fe $ff
	.db $00 $00 $00 $01 $01 $01 $01 $01 $02 $01 $01 $01 $01 $01 $00 $00
	.db $00 $ff $ff $fe $fe $fe $fe $fe $fe $fe $fe $fe $fe $fe $ff $ff
	.db $00 $00 $00 $00 $01 $01 $01 $01 $01 $01 $01 $01 $01 $00 $00 $00
	.db $00 $ff $ff $ff $fe $fe $fe $fe $fe $fe $fe $fe $fe $ff $ff $ff
	.db $00 $00 $00 $00 $00 $01 $01 $01 $01 $01 $01 $01 $00 $00 $00 $00
	.db $00 $ff $ff $ff $ff $fe $fe $fe $fe $fe $fe $fe $ff $ff $ff $ff
	.db $00 $00 $00 $00 $00 $00 $00 $00 $01 $00 $00 $00 $00 $00 $00 $00
	.db $00 $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff
	.db $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
	.db $00 $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff
	.db $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
	.db $00 $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff
	.db $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
	.db $00 $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff $ff


B7_3f00:		jsr $4957		; 20 57 49
B7_3f03:		jmp $204c		; 4c 4c 20


B7_3f06:	.db $ff
B7_3f07:	.db $57
B7_3f08:		eor #$4c		; 49 4c
B7_3f0a:		jmp $47ff		; 4c ff 47


B7_3f0d:	.db $52
B7_3f0e:		eor $41			; 45 41
B7_3f10:	.db $54
B7_3f11:		eor $53			; 45 53
B7_3f13:	.db $54
B7_3f14:	.db $ff
B7_3f15:	.db $47
B7_3f16:	.db $52
B7_3f17:		eor $41			; 45 41
B7_3f19:	.db $54
B7_3f1a:	.db $ff
B7_3f1b:	.db $42
B7_3f1c:		eor ($43, x)	; 41 43
B7_3f1e:	.db $4b
B7_3f1f:		jsr $4f54		; 20 54 4f
B7_3f22:	.db $ff
B7_3f23:	.db $42
B7_3f24:		eor ($43, x)	; 41 43
B7_3f26:	.db $4b
B7_3f27:		jsr $42ff		; 20 ff 42
B7_3f2a:		eor ($43, x)	; 41 43
B7_3f2c:	.db $4b
B7_3f2d:		rol $45ff		; 2e ff 45
B7_3f30:		eor ($47, x)	; 41 47
B7_3f32:		jmp $2045		; 4c 45 20


B7_3f35:	.db $43
B7_3f36:		jmp $4e41		; 4c 41 4e


B7_3f39:	.db $ff
B7_3f3a:		jsr $4f4e		; 20 4e 4f
B7_3f3d:	.db $54
B7_3f3e:		pha				; 48 
B7_3f3f:		eor #$4e		; 49 4e
B7_3f41:	.db $47
B7_3f42:	.db $ff
B7_3f43:		eor ($46, x)	; 41 46
B7_3f45:	.db $52
B7_3f46:		eor ($49, x)	; 41 49
B7_3f48:	.db $44
B7_3f49:		jsr $464f		; 20 4f 46
B7_3f4c:	.db $ff
B7_3f4d:		eor $41			; 45 41
B7_3f4f:	.db $52
B7_3f50:	.db $54
B7_3f51:		pha				; 48 
B7_3f52:	.db $ff
B7_3f53:		lsr $45			; 46 45
B7_3f55:		eor ($54, x)	; 41 54
B7_3f57:		pha				; 48 
B7_3f58:		eor $52			; 45 52
B7_3f5a:	.db $ff
B7_3f5b:	.db $4f
B7_3f5c:	.db $54
B7_3f5d:		pha				; 48 
B7_3f5e:		eor $52			; 45 52
B7_3f60:	.db $ff
B7_3f61:		jsr $4146		; 20 46 41
B7_3f64:	.db $54
B7_3f65:		pha				; 48 
B7_3f66:		eor $52			; 45 52
B7_3f68:		jsr $46ff		; 20 ff 46
B7_3f6b:		eor $52, x		; 55 52
B7_3f6d:	.db $54
B7_3f6e:		pha				; 48 
B7_3f6f:		eor $52			; 45 52
B7_3f71:		jsr $57ff		; 20 ff 57
B7_3f74:		eor #$54		; 49 54
B7_3f76:		pha				; 48 
B7_3f77:	.db $4f
B7_3f78:		eor $54, x		; 55 54
B7_3f7a:	.db $ff
B7_3f7b:		jsr $4148		; 20 48 41
B7_3f7e:	.db $53
B7_3f7f:		jsr $4542		; 20 42 45
B7_3f82:		eor $4e			; 45 4e
B7_3f84:	.db $ff
B7_3f85:		jsr $4f44		; 20 44 4f
B7_3f88:		lsr $5427		; 4e 27 54
B7_3f8b:		jsr $20ff		; 20 ff 20
B7_3f8e:	.db $42
B7_3f8f:	.db $52
B7_3f90:		eor #$4e		; 49 4e
B7_3f92:	.db $47
B7_3f93:		jsr $43ff		; 20 ff 43
B7_3f96:	.db $4f
B7_3f97:		eor $4e49		; 4d 49 4e
B7_3f9a:	.db $47
B7_3f9b:	.db $ff
B7_3f9c:		jsr $4854		; 20 54 48
B7_3f9f:		eor #$4e		; 49 4e
B7_3fa1:	.db $47
B7_3fa2:	.db $ff
B7_3fa3:		jmp $4b49		; 4c 49 4b


B7_3fa6:		eor $ff			; 45 ff
B7_3fa8:		jmp $4b41		; 4c 41 4b


B7_3fab:		eor $ff			; 45 ff
B7_3fad:	.db $57
B7_3fae:		eor ($4b, x)	; 41 4b
B7_3fb0:	.db $4b
B7_3fb1:		eor ($ff, x)	; 41 ff
B7_3fb3:	.db $42
B7_3fb4:	.db $52
B7_3fb5:	.db $4f
B7_3fb6:		eor $47, x		; 55 47
B7_3fb8:		pha				; 48 
B7_3fb9:	.db $54
B7_3fba:	.db $ff
B7_3fbb:	.db $53
B7_3fbc:		eor $4c			; 45 4c
B7_3fbe:		lsr $ff			; 46 ff
B7_3fc0:	.db $4b
B7_3fc1:		lsr $574f		; 4e 4f 57
B7_3fc4:	.db $ff
B7_3fc5:	.db $57
B7_3fc6:		eor #$4e		; 49 4e
B7_3fc8:	.db $47
B7_3fc9:	.db $ff
B7_3fca:		eor #$4e		; 49 4e
B7_3fcc:	.db $54
B7_3fcd:	.db $4f
B7_3fce:	.db $ff
B7_3fcf:	.db $53
B7_3fd0:	.db $43
B7_3fd1:		eor ($4c, x)	; 41 4c
B7_3fd3:		eor $ff			; 45 ff
B7_3fd5:	.db $43
B7_3fd6:		eor ($4c, x)	; 41 4c
B7_3fd8:		jmp $4445		; 4c 45 44


.org $3fe8

resetVector:
irqVector:
; reset MMC1 control register
	inc RESET_MMC1_CTRL_REG_ADDR.w ; CADDR.w
	sei
	cld
	jmp begin


B7_3ff0:		sbc ($6b), y	; f1 6b
B7_3ff2:	.db $5c
B7_3ff3:		and ($33, x)	; 21 33
B7_3ff5:	.db $04
B7_3ff6:		.db $00				; 00
B7_3ff7:		.db $00				; 00
B7_3ff8:		php				; 08 
B7_3ff9:	.db $44


.org $3ffa

	.dw nmiVector
	.dw resetVector
	.dw irqVector
