
processPlayerInputInGame:
	lda wPlayerY
	sta wTempPlayerY
	lda wPlayerX
	sta wTempPlayerX

	lda wJoy1NewButtonsPressed
	and #PADF_START
	beq @notPressedStart

; start pressed
	lda #SND_OPENING_INV
	jsr queueSoundAtoPlay

	lda #$1e
	jsr waitForAnumberOfMajorityOfNMIFuncsDone
	jsr handleInventory
	rts

@notPressedStart:
	lda wJoy1NewButtonsPressed
	and #PADF_SELECT
B6_0020:		beq B6_004b ; @pastWarpInputCheck

; try to process warp if flag checked
	lda #GF_CAN_WARP
	jsr checkGlobalFlag
	bne +

B6_0029:		jmp B6_004b		; @pastWarpInputCheck

+
; warp input loop, select to exit and warp
	jsr hideAllOam
-	jsr waitForMajorityOfNMIFuncsDone
	jsr warpInputLoop
	lda wJoy1NewButtonsPressed
	and #PADF_SELECT
	bne @selectedWarp
	jmp -

@selectedWarp:
	jsr roomTransitionUpdateChrPalMus2EntityBytes		; 20 c9 9d
B6_0041:		jsr setNametable1IfOddRoomX		; 20 d7 dc
B6_0044:		jsr func_7_1cb3		; 20 b3 dc
B6_0047:		jsr func_7_3000		; 20 00 f0
B6_004a:		rts				; 60 

@pastWarpInputCheck:
B6_004b:		lda $c0			; a5 c0
B6_004d:		and #$04		; 29 04
B6_004f:		beq B6_0054 ; f0 03

B6_0051:		jmp $ba29		; 4c 29 ba

B6_0054:		lda wPlayerKnockbackCounter			; a5 c7
B6_0056:		beq B6_0077 ; f0 1f

B6_0058:		cmp #$1e		; c9 1e
B6_005a:		bcc B6_0077 ; 90 1b

B6_005c:		lda $bf			; a5 bf
B6_005e:		cmp #$04		; c9 04
B6_0060:		bcc B6_0069 ; 90 07

B6_0062:		cmp #$08		; c9 08
B6_0064:		bcs B6_0069 ; b0 03

B6_0066:		jsr func_6_02a1		; 20 a1 82
B6_0069:		ldx wPlayerDirection			; a6 c3
B6_006b:		stx $07			; 86 07
B6_006d:		jsr updatePlayerX_orthoDirectionX_4px		; 20 94 86
B6_0070:		jsr updatePlayerY_orthoDirectionX_4px		; 20 b9 86
B6_0073:		jsr $8212		; 20 12 82

-	rts				; 60 

B6_0077:		lda wEquippedMagic			; a5 b8
B6_0079:		bpl B6_00cf ; 10 54

B6_007b:		and #$7f		; 29 7f
B6_007d:		jsr jumpTable		; 20 3d c2
	.dw -
	.dw func_6_00cf
	.dw -
	.dw -
	.dw -
	.dw func_6_00a0
	.dw func_6_00cf
	.dw -
	.dw -
	.dw -
	.dw -
	.dw func_6_00b7
	.dw -
	.dw -
	.dw -
	.dw func_6_00b7

func_6_00a0:
B6_00a0:		dec $b0			; c6 b0
B6_00a2:		bne B6_00cc ; d0 28

B6_00a4:		dec $b1			; c6 b1
B6_00a6:		bpl B6_00cc ; 10 24

B6_00a8:		ldx #$07		; a2 07
B6_00aa:		lda #$00		; a9 00
B6_00ac:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_00af:		dex				; ca 
B6_00b0:		bpl B6_00aa ; 10 f8

B6_00b2:		jsr markMagicNotInUse		; 20 94 88
B6_00b5:		rts				; 60 


B6_00b6:		rts				; 60 

func_6_00b7:
B6_00b7:		dec $b0			; c6 b0
B6_00b9:		bne B6_00cc ; d0 11

B6_00bb:		dec $b1			; c6 b1
B6_00bd:		bpl B6_00cc ; 10 0d

B6_00bf:		jsr func_6_02a7		; 20 a7 82
B6_00c2:		lda $58			; a5 58
B6_00c4:		and #$7f		; 29 7f
B6_00c6:		sta $58			; 85 58
B6_00c8:		jsr markMagicNotInUse		; 20 94 88
B6_00cb:		rts				; 60 

B6_00cc:		jmp B6_00cf		; 4c cf 80


func_6_00cf:
B6_00cf:		lda $bf			; a5 bf
B6_00d1:		cmp #$04		; c9 04
B6_00d3:		bcc B6_00f9 ; 90 24

B6_00d5:		cmp #$06		; c9 06
B6_00d7:		bcc B6_00f6 ; 90 1d

B6_00d9:		cmp #$08		; c9 08
B6_00db:		bcc B6_00f3 ; 90 16

B6_00dd:		bne B6_00ea ; d0 0b

B6_00df:		dec $a4			; c6 a4
B6_00e1:		bne B6_00ea ; d0 07

B6_00e3:		dec $a5			; c6 a5
B6_00e5:		bpl B6_00ea ; 10 03

B6_00e7:		jsr func_6_02a7		; 20 a7 82
B6_00ea:		lda wJoy1ButtonsPressed			; a5 27
B6_00ec:		and #PADF_UP|PADF_DOWN|PADF_LEFT|PADF_RIGHT		; 29 0f
B6_00ee:		beq B6_0113 ; f0 23

B6_00f0:		jmp $8128		; 4c 28 81

B6_00f3:		jmp $8198		; 4c 98 81

B6_00f6:		jmp func_6_01b4		; 4c b4 81


func_6_00f9:
B6_00f9:		lda wJoy1ButtonsPressed			; a5 27
B6_00fb:		and #PADF_UP|PADF_DOWN|PADF_LEFT|PADF_RIGHT		; 29 0f
B6_00fd:		bne B6_011a ; d0 1b

B6_00ff:		bit wJoy1NewButtonsPressed			; 24 29
B6_0101:		bvs B6_0114 ; 70 11

B6_0103:		bmi B6_0140 ; 30 3b

B6_0105:		lda $c0			; a5 c0
B6_0107:		ora #$08		; 09 08
B6_0109:		sta $c0			; 85 c0
B6_010b:		lda #$01		; a9 01
B6_010d:		sta wPlayerAnimationDataOffset			; 85 c5
B6_010f:		lda #$00		; a9 00
B6_0111:		sta wPlayerAnimationFramesCounter			; 85 c6
B6_0113:		rts				; 60 

B6_0114:		ldx #$04		; a2 04
B6_0116:		jsr $8292		; 20 92 82
B6_0119:		rts				; 60 

B6_011a:		bit wJoy1NewButtonsPressed			; 24 29
B6_011c:		bvc B6_0124 ; 50 06

B6_011e:		ldx #$06		; a2 06
B6_0120:		jsr $8292		; 20 92 82
B6_0123:		rts				; 60 

B6_0124:		bit wJoy1NewButtonsPressed			; 24 29
B6_0126:		bmi B6_0140 ; 30 18

B6_0128:		jsr processMovementInputForPlayer		; 20 ec 81

stub_7_012b:
B6_012b:		rts				; 60 

B6_012c:		cmp #$05		; c9 05
B6_012e:		bne B6_0128 ; d0 f8

B6_0130:		lda wEquippedMagic			; a5 b8
B6_0132:		cmp #$06		; c9 06
B6_0134:		beq B6_0148 ; f0 12

B6_0136:		bne B6_0128 ; d0 f0

@cantUseMagic:
B6_0138:		lda #$2b		; a9 2b
B6_013a:		jsr queueSoundAtoPlay		; 20 ad c4
B6_013d:		jmp B6_0128		; 4c 28 81

B6_0140:		lda $5e			; a5 5e
B6_0142:		bne B6_0128 ; d0 e4

B6_0144:		lda $f8			; a5 f8
B6_0146:		bne B6_012c ; d0 e4

B6_0148:		lda wEquippedMagic			; a5 b8
B6_014a:		beq B6_0128 ; f0 dc

B6_014c:		bmi B6_0128 ; 30 da

B6_014e:		cmp #$0d		; c9 0d
B6_0150:		bcs B6_0128 ; b0 d6

B6_0152:		tay				; a8 
B6_0153:		dey				; 88 
B6_0154:		lda magicMPReqs.w, y	; b9 89 81
B6_0157:		cmp wCurrMP			; c5 7a
	beq +

B6_015b:		bcs B6_0138 ; @cantUseMagic

+	sta wMPUsed			; 85 78
B6_015f:		lda wEquippedMagic			; a5 b8
B6_0161:		tay				; a8 
B6_0162:		ora #$80		; 09 80
B6_0164:		sta wEquippedMagic			; 85 b8
B6_0166:		dey				; 88 
B6_0167:		tya				; 98 
B6_0168:		jsr jumpTable		; 20 3d c2
	.dw useMagic_acorn
	.dw useMagic_bombard
	.dw useMagic_renew
	.dw useMagic_thunder
	.dw useMagic_fireflor
	.dw useMagic_cane
	.dw useMagic_terstorm
	.dw useMagic_healmace
	.dw useMagic_ocarina
	.dw useMagic_fleet
	.dw useMagic_specter
	.dw useMagic_healball
	.dw stub_7_012b
	.dw stub_7_012b
	.dw stub_7_012b


magicMPReqs:
	.db $05 $0a $03
	.db $14 $05 $0c
	.db $05 $14 $14
	.db $14 $32 $1e
	.db $00 $00 $00


B6_0198:		lda $be			; a5 be
B6_019a:		bne B6_01ad ; d0 11

B6_019c:		lda wPlayerAnimationDataOffset			; a5 c5
B6_019e:		cmp #$03		; c9 03
B6_01a0:		bne B6_01ac ; d0 0a

B6_01a2:		lda #$06		; a9 06
B6_01a4:		sta $be			; 85 be
B6_01a6:		lda $c0			; a5 c0
B6_01a8:		ora #$08		; 09 08
B6_01aa:		sta $c0			; 85 c0
B6_01ac:		rts				; 60 


B6_01ad:		dec $be			; c6 be
B6_01af:		bne B6_01ac ; d0 fb

B6_01b1:		jmp $81dd		; 4c dd 81


func_6_01b4:
B6_01b4:		lda $be			; a5 be
B6_01b6:		bne B6_01c9 ; d0 11

B6_01b8:		lda wPlayerAnimationDataOffset			; a5 c5
B6_01ba:		cmp #$08		; c9 08
B6_01bc:		bne B6_01c8 ; d0 0a

B6_01be:		lda #$1e		; a9 1e
B6_01c0:		sta $be			; 85 be
B6_01c2:		lda $c0			; a5 c0
B6_01c4:		ora #$08		; 09 08
B6_01c6:		sta $c0			; 85 c0
B6_01c8:		rts				; 60 

B6_01c9:		dec $be			; c6 be
B6_01cb:		beq B6_01dd ; f0 10

B6_01cd:		lda wJoy1NewButtonsPressed			; a5 29
B6_01cf:		and #$c0		; 29 c0
B6_01d1:		bne B6_01d9 ; d0 06

B6_01d3:		lda wJoy1ButtonsPressed			; a5 27
B6_01d5:		and #$0f		; 29 0f
B6_01d7:		beq B6_01c8 ; f0 ef

B6_01d9:		lda #$00		; a9 00
B6_01db:		sta $be			; 85 be
B6_01dd:		jsr func_6_02a1		; 20 a1 82
B6_01e0:		jsr setPlayerMovementAnimationDetails		; 20 c4 82
B6_01e3:		lda #$00		; a9 00
B6_01e5:		sta wPlayerAnimationDataOffset			; 85 c5
B6_01e7:		sta wPlayerAnimationFramesCounter			; 85 c6
B6_01e9:		jmp func_6_00f9		; 4c f9 80


processMovementInputForPlayer:
	ldx #$00
	lda wJoy1ButtonsPressed
	and #PADF_UP|PADF_DOWN|PADF_LEFT|PADF_RIGHT
; direction idx is 0 for up, to 7 for top-left
-	cmp playerInputToDirIdx.w, x
	beq @storeAndProcessDirection

	inx
	cpx #$08
	bne -

	rts

@storeAndProcessDirection:
	stx wPlayerDirection
	jsr updatePlayerX_diagDirectionX
	jsr updatePlayerY_diagDirectionX

; set current orthogonal direction
	lda wPlayerDirection
	lsr a
	sta wPlayerDirectionOrthogonal
	tax
	bcs @movingDiagonally

; animate
	stx wPlayerDirectionFacing
	jsr setPlayerMovementAnimationDetails

; skip collision checking if debug mode, holding a
	lda wMiscGlobalFlags.w
	and #GFB_CAN_WARP
	beq +

	bit wJoy2ButtonsPressed
	bmi @done

+	jsr storePlayerCoordsIn_0c_0e
	jsr processCollision_secIfWall
	bcc @playerNotHitWall

@restorePlayerCoords:
	lda wTempPlayerX
	sta wPlayerX
	lda wTempPlayerY
	sta wPlayerY

@done:
	rts

@playerNotHitWall:
	jsr setPlayerDirectionOrthogonalNextClockwise
	jsr storePlayerCoordsIn_0c_0e
	jsr processCollision_secIfWall
	bcc @done
	bcs @restorePlayerCoords

@movingDiagonally:
B6_023b:		lda $c0			; a5 c0
B6_023d:		and #$f7		; 29 f7
B6_023f:		sta $c0			; 85 c0
B6_0241:		lda #$00		; a9 00
B6_0243:		sta $08			; 85 08

; skip collision check if debug mode, holding A
B6_0245:		lda wMiscGlobalFlags.w		; ad 09 06
B6_0248:		and #GFB_CAN_WARP		; 29 20
	beq B6_0250

B6_024c:		bit wJoy2ButtonsPressed			; 24 28
B6_024e:		bmi processMovementInputForPlayer@done ; 30 dd

+
B6_0250:		lda wTempPlayerY			; a5 ca
B6_0252:		sta wPlayerCollisionY			; 85 0c
B6_0254:		lda wPlayerX			; a5 ce
B6_0256:		sta wPlayerCollisionX			; 85 0e
B6_0258:		jsr processCollision_secIfWall		; 20 2d 83
B6_025b:		bcs B6_026a ; b0 0d

B6_025d:		jsr setPlayerDirectionOrthogonalNextClockwise		; 20 ba 82
B6_0260:		inc $08			; e6 08
B6_0262:		lda $08			; a5 08
B6_0264:		cmp #$03		; c9 03
B6_0266:		beq B6_026e ; f0 06

B6_0268:		bne B6_0250 ; d0 e6

B6_026a:		lda wTempPlayerX			; a5 cb
B6_026c:		sta wPlayerX			; 85 ce
B6_026e:		lda #$00		; a9 00
B6_0270:		sta $08			; 85 08
B6_0272:		lda wPlayerDirection			; a5 c3
B6_0274:		lsr a			; 4a
B6_0275:		tax				; aa 
B6_0276:		sta wPlayerDirectionOrthogonal			; 85 07
B6_0278:		jsr storePlayerCoordsIn_0c_0e		; 20 b1 82
B6_027b:		jsr processCollision_secIfWall		; 20 2d 83
B6_027e:		bcs B6_028d ; b0 0d

B6_0280:		jsr setPlayerDirectionOrthogonalNextClockwise		; 20 ba 82
B6_0283:		inc $08			; e6 08
B6_0285:		lda $08			; a5 08
B6_0287:		cmp #$03		; c9 03
B6_0289:		beq B6_0291 ; f0 06

B6_028b:		bne B6_0278 ; d0 eb

B6_028d:		lda wTempPlayerY			; a5 ca
B6_028f:		sta wPlayerY			; 85 cc
B6_0291:		rts				; 60 


B6_0292:		lda $c0			; a5 c0
B6_0294:		lsr a			; 4a
B6_0295:		bcc B6_02a0 ; 90 09

B6_0297:		lsr a			; 4a
B6_0298:		bcc B6_029b ; 90 01

B6_029a:		inx				; e8 
B6_029b:		stx $bf			; 86 bf
B6_029d:		jsr setPlayerMovementAnimationDetails		; 20 c4 82
B6_02a0:		rts				; 60 


func_6_02a1:
B6_02a1:		lda $bf			; a5 bf
B6_02a3:		cmp #$08		; c9 08
B6_02a5:		bcs B6_02b0 ; b0 09

func_6_02a7:
B6_02a7:		lda $c0			; a5 c0
B6_02a9:		and #$03		; 29 03
B6_02ab:		sta $bf			; 85 bf
B6_02ad:		jsr setPlayerMovementAnimationDetails		; 20 c4 82
B6_02b0:		rts				; 60 


storePlayerCoordsIn_0c_0e:
	lda wPlayerY
	sta wPlayerCollisionY
	lda wPlayerX
	sta wPlayerCollisionX
	rts


setPlayerDirectionOrthogonalNextClockwise:
	ldx wPlayerDirectionOrthogonal
	inx
	txa
	and #$03
	tax
	sta wPlayerDirectionOrthogonal
	rts


; rets in X the direction faced
setPlayerMovementAnimationDetails:
B6_02c4:		ldx wPlayerDirectionFacing			; a6 c9
B6_02c6:		lda $bf			; a5 bf
B6_02c8:		cmp #$09		; c9 09
B6_02ca:		beq B6_02ff ; @animateSlime

B6_02cc:		asl a			; 0a
B6_02cd:		pha				; 48 
B6_02ce:		clc				; 18 
B6_02cf:		adc $bf			; 65 bf
B6_02d1:		clc				; 18 
B6_02d2:		adc data_6_070e.w, x	; 7d 0e 87
B6_02d5:		sta wNewPlayerAnimationIdx			; 85 c1
B6_02d7:		cmp wCurrPlayerAnimationIdx			; c5 c4
B6_02d9:		beq B6_02e3 ; f0 08

B6_02db:		ldy #$00		; a0 00
B6_02dd:		sty wPlayerAnimationDataOffset			; 84 c5
B6_02df:		sty wPlayerAnimationFramesCounter			; 84 c6
B6_02e1:		sty $be			; 84 be

B6_02e3:		pla				; 68 
B6_02e4:		asl a			; 0a
B6_02e5:		clc				; 18 
B6_02e6:		adc wPlayerDirectionFacing			; 65 c9
B6_02e8:		tax				; aa 
B6_02e9:		lda $c0			; a5 c0
B6_02eb:		and data_6_0712.w, x	; 3d 12 87
B6_02ee:		ldy data_6_0712.w, x	; bc 12 87
B6_02f1:		cpy #$f7		; c0 f7
B6_02f3:		bne B6_02f7 ; d0 02

B6_02f5:		ora #$40		; 09 40
B6_02f7:		sta $c0			; 85 c0

@done:
B6_02f9:		jsr getSwordSwingSpeed		; 20 ad c3
	ldx wPlayerDirectionFacing
	rts

@animateSlime:
; start animating as slime if not already the case
B6_02ff:		lda #ANIM_PLAYER_SLIME		; a9 1b
	cmp wCurrPlayerAnimationIdx
	beq +

	sta wNewPlayerAnimationIdx
	ldy #$00
	sty wPlayerAnimationDataOffset
	sty wPlayerAnimationFramesCounter

+	jmp B6_02f9		; @done

.include "code/collisions.s"


updatePlayerX_orthoDirectionX_4px:
	lda playerOrthoXOffsets_4px.w, x
	clc
	jmp +


updatePlayerX_diagDirectionX:
; add sub x
	lda subXMovementData.w, x
	clc
	adc wPlayerSubX
	sta wPlayerSubX

; add x, no lower than $10
	lda xMovementData.w, x

+
	adc wPlayerX
	cmp #$10
	bcs +

	lda #$10
	bne @done

; no higher than $f0
+	cmp #$f1
	bcc @done

	lda #$f0

@done:
	sta wPlayerX
	rts


updatePlayerY_orthoDirectionX_4px:
	lda playerOrthoYOffsets_4px.w, x
	clc
	jmp +


updatePlayerY_diagDirectionX:
; add sub y
	lda subYMovementData.w, x
	clc
	adc wPlayerSubY
	sta wPlayerSubY

; add y, no lower than $18
	lda yMovementData.w, x

+
	adc wPlayerY
	cmp #$18
	bcs +

	lda #$18
	bne @done

; no higher than $d8
+	cmp #$d9
	bcc @done

	lda #$d8

@done:
	sta wPlayerY
	rts


; from up clockwise to top-left
playerInputToDirIdx:
	.db PADF_UP
	.db PADF_UP|PADF_RIGHT
	.db PADF_RIGHT
	.db PADF_DOWN|PADF_RIGHT
	.db PADF_DOWN
	.db PADF_DOWN|PADF_LEFT
	.db PADF_LEFT
	.db PADF_UP|PADF_LEFT


.ifdef FAST_MOVEMENT
.define POS_SMALL_ADJUST $1fa
.define POS_MEDIUM_ADJUST $2cc
.define POS_LARGE_ADJUST $311
.define NEG_SMALL_ADJUST $fe06
.define NEG_MEDIUM_ADJUST $fd34
.define NEG_LARGE_ADJUST $fcef
.else
.define POS_SMALL_ADJUST $fd
.define POS_MEDIUM_ADJUST $166
.define POS_LARGE_ADJUST $311
.define NEG_SMALL_ADJUST $ff03
.define NEG_MEDIUM_ADJUST $fe9a
.define NEG_LARGE_ADJUST $fcef
.endif

subYMovementData:
	.db <NEG_MEDIUM_ADJUST
	.db <NEG_SMALL_ADJUST
	.db <$0000
	.db <POS_SMALL_ADJUST
	.db <POS_MEDIUM_ADJUST
	.db <POS_SMALL_ADJUST
	.db <$0000
	.db <NEG_SMALL_ADJUST
	.db <$0311
	.db <$fcef

yMovementData:
	.db >NEG_MEDIUM_ADJUST
	.db >NEG_SMALL_ADJUST
	.db >$0000
	.db >POS_SMALL_ADJUST
	.db >POS_MEDIUM_ADJUST
	.db >POS_SMALL_ADJUST
	.db >$0000
	.db >NEG_SMALL_ADJUST
	.db >$0311
	.db >$fcef

subXMovementData:
	.db <$0000
	.db <POS_SMALL_ADJUST
	.db <POS_MEDIUM_ADJUST
	.db <POS_SMALL_ADJUST
	.db <$0000
	.db <NEG_SMALL_ADJUST
	.db <NEG_MEDIUM_ADJUST
	.db <NEG_SMALL_ADJUST
	.db <$0360
	.db <$fca0

xMovementData:
	.db >$0000
	.db >POS_SMALL_ADJUST
	.db >POS_MEDIUM_ADJUST
	.db >POS_SMALL_ADJUST
	.db >$0000
	.db >NEG_SMALL_ADJUST
	.db >NEG_MEDIUM_ADJUST
	.db >NEG_SMALL_ADJUST
	.db >$0360
	.db >$fca0


data_6_070e:
	.db $00 $01 $02 $01


data_6_0712:
B6_0712:		.db $b7
B6_0713:	.db $b7
B6_0714:	.db $b7
B6_0715:	.db $f7
B6_0716:	.db $f7
B6_0717:	.db $b7
B6_0718:	.db $b7
B6_0719:	.db $f7
B6_071a:	.db $b7
B6_071b:	.db $f7
B6_071c:	.db $b7
B6_071d:	.db $b7
B6_071e:	.db $f7
B6_071f:	.db $b7
B6_0720:	.db $b7
B6_0721:	.db $f7
B6_0722:	.db $b7
B6_0723:	.db $b7
B6_0724:	.db $b7
B6_0725:	.db $f7
B6_0726:	.db $b7
B6_0727:	.db $b7
B6_0728:	.db $b7
B6_0729:	.db $f7
B6_072a:	.db $b7
B6_072b:	.db $b7
B6_072c:	.db $b7
B6_072d:	.db $f7
B6_072e:	.db $b7
B6_072f:	.db $b7
B6_0730:	.db $b7
B6_0731:	.db $f7
B6_0732:	.db $b7
B6_0733:	.db $f7
B6_0734:	.db $b7
B6_0735:	.db $b7
B6_0736:		ora ($03, x)	; 01 03
B6_0738:		ora ($03, x)	; 01 03


collisionCheckOffsetsY:
	.db $02 $02 $0d $0d

collisionCheckOffsetsX:
	.db $f8 $08 $08 $f8


B6_0742:		ora ($02, x)	; 01 02
B6_0744:	.db $02
B6_0745:		ora ($03, x)	; 01 03
B6_0747:		.db $00				; 00
B6_0748:		.db $00				; 00
B6_0749:	.db $03
B6_074a:		ora ($00, x)	; 01 00
B6_074c:	.db $02
B6_074d:	.db $03
B6_074e:	.db $03
B6_074f:	.db $02
B6_0750:		.db $00				; 00
B6_0751:		.db $01


playerOrthoXOffsets_4px:
	.db $00 $04 $00 $fc


playerOrthoYOffsets_4px:
	.db $fc $00 $04 $00


caveInnerRoomEntrances:
; room y - x
	.db $00 $14
	.db $05 $0c
	.db $02 $1e
	.db $12 $11
	.db $ff

caveInnerRoomDests:
	.db $1c $1e
	.db $1b $1f
	.db $13 $1c
	.db $12 $1d
	.db $ff


B6_076c:		.db $25
B6_076d:		bpl B6_07b3 ; 10 44

B6_076f:		jsr $3025		; 20 25 30
B6_0772:	.db $44
B6_0773:		jsr $5025		; 20 25 50
B6_0776:	.db $04
B6_0777:	.db $f4
B6_0778:		inc $f4, x		; f6 f4
B6_077a:		inc $25, x		; f6 25
B6_077c:		bvs B6_0782 ; 70 04

B6_077e:		sbc $f7, x		; f5 f7
B6_0780:		sbc $f7, x		; f5 f7
B6_0782:	.db $ff
B6_0783:		and ($10, x)	; 21 10
B6_0785:	.db $44
B6_0786:		jsr $3021		; 20 21 30
B6_0789:	.db $44
B6_078a:		jsr $5021		; 20 21 50
B6_078d:	.db $04
B6_078e:		sed				; f8 
B6_078f:	.db $fa
B6_0790:		sed				; f8 
B6_0791:	.db $fa
B6_0792:		and ($70, x)	; 21 70
B6_0794:	.db $04
B6_0795:		sbc $f9fb, y	; f9 fb f9
B6_0798:	.db $fb
B6_0799:	.db $ff
B6_079a:		and ($0c, x)	; 21 0c
B6_079c:	.db $44
B6_079d:		jsr $2c21		; 20 21 2c
B6_07a0:	.db $44
B6_07a1:		jsr $4c21		; 20 21 4c
B6_07a4:	.db $04
B6_07a5:	.db $f4
B6_07a6:		inc $f4, x		; f6 f4
B6_07a8:		inc $21, x		; f6 21
B6_07aa:		jmp ($f504)		; 6c 04 f5


B6_07ad:	.db $f7
B6_07ae:		sbc $f7, x		; f5 f7
B6_07b0:	.db $ff
B6_07b1:		and ($16, x)	; 21 16
B6_07b3:	.db $04
B6_07b4:	.db $74
B6_07b5:		ror $78, x		; 76 78
B6_07b7:	.db $7a
B6_07b8:		and ($36, x)	; 21 36
B6_07ba:	.db $04
B6_07bb:		adc wHealthGiven, x		; 75 77
B6_07bd:		adc $217b, y	; 79 7b 21
B6_07c0:		lsr $04, x		; 56 04
B6_07c2:	.db $7c
B6_07c3:		ror $8280, x	; 7e 80 82
B6_07c6:		and ($76, x)	; 21 76
B6_07c8:	.db $04
B6_07c9:		adc $817f, x	; 7d 7f 81
B6_07cc:	.db $83
B6_07cd:	.db $ff
B6_07ce:		and $16			; 25 16
B6_07d0:	.db $04
B6_07d1:	.db $74
B6_07d2:		ror $78, x		; 76 78
B6_07d4:	.db $7a
B6_07d5:		and $36			; 25 36
B6_07d7:	.db $04
B6_07d8:		adc wHealthGiven, x		; 75 77
B6_07da:		adc $257b, y	; 79 7b 25
B6_07dd:		lsr $04, x		; 56 04
B6_07df:	.db $7c
B6_07e0:		ror $8280, x	; 7e 80 82
B6_07e3:		and $76			; 25 76
B6_07e5:	.db $04
B6_07e6:		adc $817f, x	; 7d 7f 81
B6_07e9:	.db $83
B6_07ea:	.db $ff
B6_07eb:		bit $58			; 24 58
B6_07ed:	.db $04
B6_07ee:	.db $74
B6_07ef:		ror $78, x		; 76 78
B6_07f1:	.db $7a
B6_07f2:		bit $78			; 24 78
B6_07f4:	.db $04
B6_07f5:		adc wHealthGiven, x		; 75 77
B6_07f7:		adc $247b, y	; 79 7b 24
B6_07fa:		tya				; 98 
B6_07fb:	.db $04
B6_07fc:	.db $7c
B6_07fd:		ror $8280, x	; 7e 80 82
B6_0800:		bit $b8			; 24 b8
B6_0802:	.db $04
B6_0803:		adc $817f, x	; 7d 7f 81
B6_0806:	.db $83
B6_0807:	.db $ff
B6_0808:		jsr $04d8		; 20 d8 04
B6_080b:		ldy $c0be, x	; bc be c0
B6_080e:	.db $c2
B6_080f:		jsr $04f8		; 20 f8 04
B6_0812:		lda $c1bf, x	; bd bf c1
B6_0815:	.db $c3
B6_0816:		and ($18, x)	; 21 18
B6_0818:	.db $04
B6_0819:		cpy $c6			; c4 c6
B6_081b:		iny				; c8 
B6_081c:		dex				; ca 
B6_081d:		and ($38, x)	; 21 38
B6_081f:	.db $04
B6_0820:		cmp $c7			; c5 c7
B6_0822:		cmp #$cb		; c9 cb
B6_0824:	.db $ff
B6_0825:		and ($90, x)	; 21 90
B6_0827:	.db $04
B6_0828:		jsr $2022		; 20 22 20
B6_082b:	.db $22
B6_082c:		and ($b0, x)	; 21 b0
B6_082e:	.db $04
B6_082f:		and ($23, x)	; 21 23
B6_0831:		and ($23, x)	; 21 23
B6_0833:		and ($d0, x)	; 21 d0
B6_0835:	.db $04
B6_0836:		;removed
	.db $90 $92

B6_0838:		bcc B6_07cc ; 90 92

B6_083a:		and ($f0, x)	; 21 f0
B6_083c:	.db $04
B6_083d:		sta ($93), y	; 91 93
B6_083f:		sta ($93), y	; 91 93
B6_0841:	.db $ff

.include "code/magicUse.s"

B6_0ea9:		pha				; 48 
B6_0eaa:		stx $b0			; 86 b0
B6_0eac:		pla				; 68 
B6_0ead:		pha				; 48 
B6_0eae:		and wMajorNMIUpdatesCounter			; 25 23
B6_0eb0:		bne B6_0ebd ; d0 0b

B6_0eb2:		inc $c9			; e6 c9
B6_0eb4:		lda $c9			; a5 c9
B6_0eb6:		and #$03		; 29 03
B6_0eb8:		sta wPlayerDirectionFacing			; 85 c9
B6_0eba:		jsr setPlayerMovementAnimationDetails		; 20 c4 82
B6_0ebd:		jsr drawEntities		; 20 03 c4
B6_0ec0:		jsr drawPlayer		; 20 dd c3
B6_0ec3:		jsr processExp_etc_todo		; 20 44 f3
B6_0ec6:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0ec9:		dec $b0			; c6 b0
B6_0ecb:		bne B6_0eac ; d0 df

B6_0ecd:		pla				; 68 
B6_0ece:		rts				; 60 


B6_0ecf:		ldx #$07		; a2 07
B6_0ed1:		lda #$1a		; a9 1a
B6_0ed3:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_0ed6:		dex				; ca 
B6_0ed7:		bpl B6_0ed1 ; 10 f8

B6_0ed9:		inc $b0			; e6 b0
B6_0edb:		lda $b0			; a5 b0
B6_0edd:		cmp #$03		; c9 03
B6_0edf:		bcc B6_0ee5 ; 90 04

B6_0ee1:		lda #$00		; a9 00
B6_0ee3:		sta $b0			; 85 b0
B6_0ee5:		lda $b0			; a5 b0
B6_0ee7:		asl a			; 0a
B6_0ee8:		asl a			; 0a
B6_0ee9:		asl a			; 0a
B6_0eea:		tax				; aa 
B6_0eeb:		ldy #$00		; a0 00
B6_0eed:		lda $8f19, x	; bd 19 8f
B6_0ef0:		sta wEntitiesY.w, y	; 99 80 04
B6_0ef3:		lda $8f31, x	; bd 31 8f
B6_0ef6:		sta wEntitiesX.w, y	; 99 b0 04
B6_0ef9:		inx				; e8 
B6_0efa:		iny				; c8 
B6_0efb:		cpy #$08		; c0 08
B6_0efd:		bcc B6_0eed ; 90 ee

B6_0eff:		rts				; 60 


B6_0f00:		ora $03			; 05 03
B6_0f02:		asl $3202		; 0e 02 32
B6_0f05:		.db $00				; 00
B6_0f06:	.db $33
B6_0f07:		ora ($21, x)	; 01 21
B6_0f09:		.db $00				; 00
B6_0f0a:	.db $22
B6_0f0b:		.db $00				; 00
B6_0f0c:	.db $23
B6_0f0d:		.db $00				; 00
B6_0f0e:		and $03			; 25 03
B6_0f10:	.db $ff
B6_0f11:		ora #$0a		; 09 0a
B6_0f13:		ora #$0b		; 09 0b
B6_0f15:	.db $0f
B6_0f16:		ora #$0a		; 09 0a
B6_0f18:	.db $0b
B6_0f19:	.db $14
B6_0f1a:	.db $14
B6_0f1b:	.db $34
B6_0f1c:		jmp ($9c7c)		; 6c 7c 9c


B6_0f1f:		cpy $14e4		; cc e4 14
B6_0f22:	.db $34
B6_0f23:	.db $44
B6_0f24:	.db $64
B6_0f25:		sty $d4b4		; 8c b4 d4
B6_0f28:		cpx $1c			; e4 1c
B6_0f2a:		jmp $7454		; 4c 54 74


B6_0f2d:		sty $b4ac		; 8c ac b4
B6_0f30:		cpy $f434		; cc 34 f4
B6_0f33:		ldy $dc			; a4 dc
B6_0f35:		jmp $246c		; 4c 6c 24


B6_0f38:		cpy $e4c4		; cc c4 e4
B6_0f3b:	.db $5c
B6_0f3c:		sty $14			; 84 14
B6_0f3e:		ldy $44, x		; b4 44
B6_0f40:	.db $9c
B6_0f41:	.db $74
B6_0f42:		ldy $2c, x		; b4 2c
B6_0f44:	.db $74
B6_0f45:	.db $9c
B6_0f46:	.db $d4
B6_0f47:	.db $54
B6_0f48:	.db $ec


handleInventory:
	lda #$00
	sta wInventoryPageSelected

	jsr setPPUMask_noSprites

; use left nametables
B6_0f50:		lda wPPUCtrl			; a5 20
B6_0f52:		and #$fe		; 29 fe
B6_0f54:		sta wPPUCtrl			; 85 20

B6_0f56:		jsr hideAllOam		; 20 9f c3

; load room y-$1f, x-$00
	lda #$00
	jsr loadAllScreenRowsForRoomY1fhRoomXA
	jsr waitForMajorityOfNMIFuncsDone

B6_0f61:		jsr func_6_1058		; 20 58 90
B6_0f64:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1

B6_0f67:		jsr func_6_110a		; 20 0a 91
B6_0f6a:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1

B6_0f6d:		jsr func_6_17a2		; 20 a2 97
B6_0f70:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1

; set chr banks
	lda #$13
	jsr set_wChrBank1
	lda #$1f
	jsr set_wChrBank0

;
B6_0f7d:		lda #$05		; a9 05
B6_0f7f:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_0f82:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1

B6_0f85:		lda #$00		; a9 00
B6_0f87:		sta wInvCursorDelay			; 85 01
B6_0f89:		sta $00			; 85 00

; start displaying and processing
	jsr setPPUMask_addShowAll

@invMainMenuLoop:
B6_0f8e:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
	lda wJoy1NewButtonsPressed
	and #PADF_START
B6_0f95:		beq B6_0fcd ; @notPressedStart

; pressed Start
	jsr setPPUMask_noSprites		; 20 53 c1
	jsr waitForMajorityOfNMIFuncsDone

; load screen and set chr banks
	jsr b6_loadAllScreenRowsForCurrRoom
	jsr waitForMajorityOfNMIFuncsDone

	lda wBGChrBank
	jsr set_wChrBank1
	jsr setInGameSprChrBank

; reload overworld palettes
	jsr update_wInternalPalettesFromSavedPaletteIdx

; reload spr palettes
	lda wSprPaletteSpecAndChrBank
	lsr a
	lsr a
	lsr a
	lsr a
	clc
	adc #$10
	jsr update_wInternalPalettesFromSpecA

	jsr setNametable1IfOddRoomX
B6_0fbd:		jsr func_6_02a1		; 20 a1 82
B6_0fc0:		jsr func_6_11db		; 20 db 91
	jsr waitForMajorityOfNMIFuncsDone
B6_0fc6:		jsr func_7_3000		; 20 00 f0
	jsr setPPUMask_addShowAll
	rts

@notPressedStart:
B6_0fcd:		bit wJoy1NewButtonsPressed			; 24 29
	bpl +

; pressed A
	jmp @selectedInvPage

+	lda wJoy1ButtonsPressed
	and #PADF_UP|PADF_DOWN|PADF_LEFT|PADF_RIGHT
	beq @resetDelay

; pressed directions - process every 16 frames
	lda wInvCursorDelay
	clc
	adc #$10
	sta wInvCursorDelay
	bne @sendCursorTo_wOam

	lda wJoy1ButtonsPressed
	and #PADF_UP|PADF_DOWN
	beq @checkPressedHoriz

; pressed up or down
	lda #SND_MOVING_IN_INV
	jsr queueSoundAtoPlay

; 0 becomes 2, 1 becomes 3, etc
	lda wInventoryPageSelected
	eor #$02
	sta wInventoryPageSelected
	jmp @sendCursorTo_wOam

@checkPressedHoriz:
	lda wJoy1ButtonsPressed
	and #PADF_LEFT|PADF_RIGHT
	beq @sendCursorTo_wOam

; pressed left or right
	lda #SND_MOVING_IN_INV
	jsr queueSoundAtoPlay

; 0 becomes 1, 2 becomes 3, etc
	lda wInventoryPageSelected
	eor #$01
	sta wInventoryPageSelected
	jmp @sendCursorTo_wOam

@resetDelay:
	lda #$e0
	sta wInvCursorDelay

@sendCursorTo_wOam:
; oam offset X
	ldx #$04
	ldy wInventoryPageSelected

; blink cursor every 8 frames
	lda wMajorNMIUpdatesCounter
	and #$08
	beq +

; rest of cursor oam
	lda inventoryMainMenuCursorYs.w, y
	sta wOam.Y.w, x
	lda inventoryMainMenuCursorXs.w, y
	sta wOam.X.w, x
	lda #$83
	sta wOam.tile.w, x
	lda #$01
	sta wOam.attr.w, x
	jmp B6_0f8e ; @invMainMenuLoop

+	lda #$f8
	sta wOam.Y.w, x
	jmp B6_0f8e ; @invMainMenuLoop

@selectedInvPage:
	jsr setPPUMask_noSprites
	jsr hideAllOam
	jsr waitForMajorityOfNMIFuncsDone

	lda wInventoryPageSelected
	jsr jumpTable

	.dw handleSwordInvScreen
	.dw handleShieldInvScreen
	.dw handleMagicInvScreen
	.dw handleItemInvScreen

inventoryMainMenuCursorYs:
	.db $b0 $b0 $c0 $c0

inventoryMainMenuCursorXs:
	.db $78 $b0 $78 $b0


func_6_1058:
B6_1058:		lda #$00
B6_105a:		jsr func_6_11cb		; 20 cb 91
B6_105d:		lda #$01		; a9 01
B6_105f:		jsr func_6_11cb		; 20 cb 91
B6_1062:		jsr func_6_1066		; 20 66 90
B6_1065:		rts				; 60 


func_6_1066:
B6_1066:		ldx #$00		; a2 00
B6_1068:		lda wEquippedSword, x		; b5 b6
B6_106a:		asl a			; 0a
B6_106b:		asl a			; 0a
B6_106c:		asl a			; 0a
B6_106d:		sta $00, x		; 95 00
B6_106f:		inx				; e8 
B6_1070:		cpx #$03		; e0 03
B6_1072:		bne B6_1068 ; d0 f4

B6_1074:		jsr $9084		; 20 84 90
B6_1077:		jsr $9094		; 20 94 90
B6_107a:		jsr $90a4		; 20 a4 90
B6_107d:		jsr $90c4		; 20 c4 90
B6_1080:		jsr updateFromVramQueue		; 20 f2 c2
B6_1083:		rts				; 60 


B6_1084:		lda #$f2		; a9 f2
B6_1086:		sta $04			; 85 04
B6_1088:		lda #$92		; a9 92
B6_108a:		sta $05			; 85 05
B6_108c:		ldx #$00		; a2 00
B6_108e:		ldy $00			; a4 00
B6_1090:		jsr $90b4		; 20 b4 90
B6_1093:		rts				; 60 


B6_1094:		lda #$3a		; a9 3a
B6_1096:		sta $04			; 85 04
B6_1098:		lda #$93		; a9 93
B6_109a:		sta $05			; 85 05
B6_109c:		ldx #$08		; a2 08
B6_109e:		ldy $01			; a4 01
B6_10a0:		jsr $90b4		; 20 b4 90
B6_10a3:		rts				; 60 


B6_10a4:		lda #$82		; a9 82
B6_10a6:		sta $04			; 85 04
B6_10a8:		lda #$93		; a9 93
B6_10aa:		sta $05			; 85 05
B6_10ac:		ldx #$10		; a2 10
B6_10ae:		ldy $02			; a4 02
B6_10b0:		jsr $90b4		; 20 b4 90
B6_10b3:		rts				; 60 


B6_10b4:		lda #$08		; a9 08
B6_10b6:		sta $06			; 85 06
B6_10b8:		lda ($04), y	; b1 04
B6_10ba:		sta wRoomLoadingRow1ToCopy.w, x	; 9d c0 06
B6_10bd:		inx				; e8 
B6_10be:		iny				; c8 
B6_10bf:		dec $06			; c6 06
B6_10c1:		bne B6_10b8 ; d0 f5

B6_10c3:		rts				; 60 


B6_10c4:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B6_10c6:		ldy #$00		; a0 00
B6_10c8:		sty $04			; 84 04
B6_10ca:		sty $06			; 84 06
B6_10cc:		lda $9104, y	; b9 04 91
B6_10cf:		sta wVramQueue.w, x	; 9d 00 05
B6_10d2:		inx				; e8 
B6_10d3:		lda $9105, y	; b9 05 91
B6_10d6:		sta wVramQueue.w, x	; 9d 00 05
B6_10d9:		inx				; e8 
B6_10da:		lda #$08		; a9 08
B6_10dc:		sta wVramQueue.w, x	; 9d 00 05
B6_10df:		sta $05			; 85 05
B6_10e1:		ldy $06			; a4 06
B6_10e3:		inx				; e8 
B6_10e4:		lda wRoomLoadingRow1ToCopy.w, y	; b9 c0 06
B6_10e7:		sta wVramQueue.w, x	; 9d 00 05
B6_10ea:		inx				; e8 
B6_10eb:		iny				; c8 
B6_10ec:		dec $05			; c6 05
B6_10ee:		bne B6_10e4 ; d0 f4

B6_10f0:		sty $06			; 84 06
B6_10f2:		inc $04			; e6 04
B6_10f4:		inc $04			; e6 04
B6_10f6:		ldy $04			; a4 04
B6_10f8:		cpy #$06		; c0 06
B6_10fa:		bcc B6_10cc ; 90 d0

B6_10fc:		lda #$00		; a9 00
B6_10fe:		sta wVramQueue.w, x	; 9d 00 05
B6_1101:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B6_1103:		rts				; 60 


B6_1104:		jsr $21f4		; 20 f4 21
B6_1107:		sty $22, x		; 94 22
B6_1109:	.db $34


func_6_110a:
B6_110a:		lda #$08		; a9 08
B6_110c:		sta $d0			; 85 d0
B6_110e:		jsr $911b		; 20 1b 91
B6_1111:		jsr $9132		; 20 32 91
B6_1114:		jsr $9149		; 20 49 91
B6_1117:		jsr $91a7		; 20 a7 91
B6_111a:		rts				; 60 


B6_111b:		lda wEquippedSword			; a5 b6
B6_111d:		bne B6_1120 ; d0 01

B6_111f:		rts				; 60 


B6_1120:		lda #$82		; a9 82
B6_1122:		sta $06			; 85 06
B6_1124:		lda #$94		; a9 94
B6_1126:		sta $07			; 85 07
B6_1128:		lda #$2c		; a9 2c
B6_112a:		ldx #$7c		; a2 7c
B6_112c:		ldy $00			; a4 00
B6_112e:		jsr func_6_1160		; 20 60 91
B6_1131:		rts				; 60 


B6_1132:		lda $b7			; a5 b7
B6_1134:		bne B6_1137 ; d0 01

B6_1136:		rts				; 60 


B6_1137:		lda #$ca		; a9 ca
B6_1139:		sta $06			; 85 06
B6_113b:		lda #$94		; a9 94
B6_113d:		sta $07			; 85 07
B6_113f:		lda #$54		; a9 54
B6_1141:		ldx #$7c		; a2 7c
B6_1143:		ldy $01			; a4 01
B6_1145:		jsr func_6_1160		; 20 60 91
B6_1148:		rts				; 60 


B6_1149:		lda wEquippedMagic			; a5 b8
B6_114b:		bne B6_114e ; d0 01

B6_114d:		rts				; 60 


B6_114e:		lda #$12		; a9 12
B6_1150:		sta $06			; 85 06
B6_1152:		lda #$95		; a9 95
B6_1154:		sta $07			; 85 07
B6_1156:		lda #$7c		; a9 7c
B6_1158:		ldx #$7c		; a2 7c
B6_115a:		ldy $02			; a4 02
B6_115c:		jsr func_6_1160		; 20 60 91
B6_115f:		rts				; 60 


func_6_1160:
B6_1160:		sta $04			; 85 04 eg 28 for 1st sword (y)
B6_1162:		stx $05			; 86 05 eg 8c (x)
B6_1164:		sty $08			; 84 08 eg 08

B6_1166:		ldx $d0			; a6 d0
B6_1168:		ldy #$00		; a0 00
B6_116a:		sty $09			; 84 09

B6_116c:		lda $04			; a5 04
B6_116e:		clc				; 18 
B6_116f:		adc data_6_119f.w, y	; 79 9f 91
B6_1172:		sta wOam.Y.w, x	; 9d 00 02
B6_1175:		iny				; c8 
B6_1176:		lda $05			; a5 05
B6_1178:		clc				; 18 
B6_1179:		adc data_6_119f.w, y	; 79 9f 91
B6_117c:		sta wOam.X.w, x	; 9d 03 02
B6_117f:		iny				; c8 
B6_1180:		sty $09			; 84 09
B6_1182:		ldy $08			; a4 08
B6_1184:		lda ($06), y	; b1 06 eg 9482
B6_1186:		sta wOam.tile.w, x	; 9d 01 02
B6_1189:		iny				; c8 
B6_118a:		lda ($06), y	; b1 06
B6_118c:		sta wOam.attr.w, x	; 9d 02 02
B6_118f:		iny				; c8 
B6_1190:		sty $08			; 84 08
B6_1192:		inx				; e8 
B6_1193:		inx				; e8 
B6_1194:		inx				; e8 
B6_1195:		inx				; e8 
B6_1196:		ldy $09			; a4 09
B6_1198:		cpy #$08		; c0 08
B6_119a:		bcc B6_116c ; 90 d0

B6_119c:		stx $d0			; 86 d0
B6_119e:		rts				; 60 

data_6_119f:
	.db $00 $00
	.db $08 $00
	.db $00 $08
	.db $08 $08


B6_11a7:		ldx $d0			; a6 d0
B6_11a9:		ldy #$00		; a0 00
B6_11ab:		lda $9050, y	; b9 50 90
B6_11ae:		sta wOam.Y.w, x	; 9d 00 02
B6_11b1:		lda $9054, y	; b9 54 90
B6_11b4:		sta wOam.X.w, x	; 9d 03 02
B6_11b7:		lda #$82		; a9 82
B6_11b9:		sta wOam.tile.w, x	; 9d 01 02
B6_11bc:		lda #$01		; a9 01
B6_11be:		sta wOam.attr.w, x	; 9d 02 02
B6_11c1:		inx				; e8 
B6_11c2:		inx				; e8 
B6_11c3:		inx				; e8 
B6_11c4:		inx				; e8 
B6_11c5:		iny				; c8 
B6_11c6:		cpy #$04		; c0 04
B6_11c8:		bne B6_11ab ; d0 e1

B6_11ca:		rts				; 60 


func_6_11cb:
B6_11cb:		asl a			; 0a
B6_11cc:		tay				; a8 
B6_11cd:		lda $9211, y	; b9 11 92
B6_11d0:		sta wRLEStructAddressToCopy			; 85 33
B6_11d2:		lda $9212, y	; b9 12 92
B6_11d5:		sta wRLEStructAddressToCopy+1			; 85 34
B6_11d7:		jsr updateFromRLEStruct		; 20 2f c3
B6_11da:		rts				; 60 


func_6_11db:
B6_11db:		ldy $59			; a4 59
B6_11dd:		beq B6_11da ; f0 fb

B6_11df:		dey				; 88 
B6_11e0:		tya				; 98 
B6_11e1:		asl a			; 0a
B6_11e2:		tay				; a8 
B6_11e3:		lda $91f1, y	; b9 f1 91
B6_11e6:		sta wRLEStructAddressToCopy			; 85 33
B6_11e8:		lda $91f2, y	; b9 f2 91
B6_11eb:		sta wRLEStructAddressToCopy+1			; 85 34
B6_11ed:		jsr updateFromRLEStruct		; 20 2f c3
B6_11f0:		rts				; 60 


B6_11f1:		lda ($87), y	; b1 87
B6_11f3:	.db $83
B6_11f4:	.db $87
B6_11f5:		jmp ($9a87)		; 6c 87 9a


B6_11f8:	.db $87
B6_11f9:		dec $eb87		; ce 87 eb
B6_11fc:	.db $87
B6_11fd:		php				; 08 
B6_11fe:		dey				; 88 
B6_11ff:		and $88			; 25 88
B6_1201:	.db $5b
B6_1202:	.db $fa
B6_1203:	.db $7a
B6_1204:	.db $fa
B6_1205:	.db $a7
B6_1206:	.db $fa


loadAllScreenRowsForRoomY1fhRoomXA:
	sta wTempRoomX
	lda #$1f
	sta wTempRoomY
	jsr loadAllScreenRowsForSpecifiedRoom		; 20 fb de
	rts


B6_1211:		and ($92, x)	; 21 92
B6_1213:	.db $5f
B6_1214:	.db $92
B6_1215:	.db $a7
B6_1216:	.db $92
B6_1217:	.db $b2
B6_1218:	.db $92
B6_1219:		lda $c892, x	; bd 92 c8
B6_121c:	.db $92
B6_121d:	.db $d2
B6_121e:	.db $92
B6_121f:	.db $e2
B6_1220:	.db $92
B6_1221:		and ($43, x)	; 21 43
B6_1223:		asl $1b			; 06 1b
B6_1225:		rol $2e26		; 2e 26 2e
B6_1228:	.db $1b
B6_1229:	.db $6f
B6_122a:		and ($83, x)	; 21 83
B6_122c:	.db $03
B6_122d:		rol $4328		; 2e 28 43
B6_1230:		and ($a8, x)	; 21 a8
B6_1232:		ora ($6f, x)	; 01 6f
B6_1234:		and ($e3, x)	; 21 e3
B6_1236:	.db $02
B6_1237:	.db $1c
B6_1238:	.db $43
B6_1239:	.db $22
B6_123a:	.db $07
B6_123b:		ora ($6f, x)	; 01 6f
B6_123d:	.db $22
B6_123e:	.db $43
B6_123f:	.db $02
B6_1240:	.db $17
B6_1241:	.db $43
B6_1242:	.db $22
B6_1243:	.db $67
B6_1244:		ora ($6f, x)	; 01 6f
B6_1246:	.db $22
B6_1247:	.db $a3
B6_1248:		ora $46			; 05 46
B6_124a:	.db $47
B6_124b:		eor $80			; 45 80
B6_124d:	.db $6f
B6_124e:	.db $22
B6_124f:	.db $e3
B6_1250:		ora $2d			; 05 2d
B6_1252:		rol $8015		; 2e 15 80
B6_1255:	.db $6f
B6_1256:	.db $23
B6_1257:	.db $23
B6_1258:		ora $2a			; 05 2a
B6_125a:		asl $18, x		; 16 18
B6_125c:	.db $80
B6_125d:	.db $6f
B6_125e:	.db $ff
B6_125f:		jsr $05a3		; 20 a3 05
B6_1262:	.db $43
B6_1263:		eor $2e			; 45 2e
B6_1265:		lsr $46			; 46 46
B6_1267:		jsr $05c7		; 20 c7 05
B6_126a:		lsr $47			; 46 47
B6_126c:		rol a			; 2a
B6_126d:		eor $47			; 45 47
B6_126f:		jsr $05b3		; 20 b3 05
B6_1272:		lsr $27			; 46 27
B6_1274:		asl $2d45, x	; 1e 45 2d
B6_1277:		and ($53, x)	; 21 53
B6_1279:		asl $46			; 06 46
B6_127b:	.db $17
B6_127c:		clc				; 18 
B6_127d:		rol $2d1b		; 2e 1b 2d
B6_1280:		and ($f3, x)	; 21 f3
B6_1282:		ora $1c			; 05 1c
B6_1284:		rol a			; 2a
B6_1285:		asl $18, x		; 16 18
B6_1287:		bit $d022		; 2c 22 d0
B6_128a:		ora $2746		; 0d 46 27
B6_128d:		asl $2d45, x	; 1e 45 2d
B6_1290:	.db $80
B6_1291:	.db $80
B6_1292:		lsr $17			; 46 17
B6_1294:		clc				; 18 
B6_1295:		rol $2d1b		; 2e 1b 2d
B6_1298:	.db $23
B6_1299:		;removed
	.db $10 $0b

B6_129b:	.db $1c
B6_129c:		rol a			; 2a
B6_129d:		asl $18, x		; 16 18
B6_129f:		bit $8080		; 2c 80 80
B6_12a2:		clc				; 18 
B6_12a3:	.db $47
B6_12a4:		rol $ff1c		; 2e 1c ff
B6_12a7:		jsr $0763		; 20 63 07
B6_12aa:		lsr $27			; 46 27
B6_12ac:		asl $2d45, x	; 1e 45 2d
B6_12af:	.db $80
B6_12b0:		stx $20ff		; 8e ff 20
B6_12b3:	.db $63
B6_12b4:	.db $07
B6_12b5:	.db $1c
B6_12b6:		rol a			; 2a
B6_12b7:		asl $18, x		; 16 18
B6_12b9:		bit $8e80		; 2c 80 8e
B6_12bc:	.db $ff
B6_12bd:		jsr $0763		; 20 63 07
B6_12c0:		clc				; 18 
B6_12c1:	.db $47
B6_12c2:		rol $801c		; 2e 1c 80
B6_12c5:		sty $ff8e		; 8c 8e ff
B6_12c8:		jsr $0663		; 20 63 06
B6_12cb:		lsr $17			; 46 17
B6_12cd:		clc				; 18 
B6_12ce:		rol $2d1b		; 2e 1b 2d
B6_12d1:	.db $ff
B6_12d2:	.db $23
B6_12d3:		bpl B6_12e1 ; 10 0c

B6_12d5:	.db $43
B6_12d6:		eor $2e			; 45 2e
B6_12d8:		lsr $46			; 46 46
B6_12da:	.db $80
B6_12db:		rol a			; 2a
B6_12dc:	.db $80
B6_12dd:		asl $8045, x	; 1e 45 80
B6_12e0:	.db $2b
B6_12e1:	.db $ff
B6_12e2:	.db $23
B6_12e3:		bvc B6_12f1 ; 50 0c

B6_12e5:	.db $43
B6_12e6:		eor $2e			; 45 2e
B6_12e8:		lsr $46			; 46 46
B6_12ea:	.db $80
B6_12eb:		rol a			; 2a
B6_12ec:	.db $80
B6_12ed:		asl $8045, x	; 1e 45 80
B6_12f0:	.db $2b
B6_12f1:	.db $ff
B6_12f2:		ora $471e, x	; 1d 1e 47
B6_12f5:	.db $17
B6_12f6:		clc				; 18 
B6_12f7:		ora $8016, x	; 1d 16 80
B6_12fa:	.db $1b
B6_12fb:		asl $161d, x	; 1e 1d 16
B6_12fe:	.db $80
B6_12ff:	.db $80
B6_1300:	.db $80
B6_1301:	.db $80
B6_1302:	.db $2b
B6_1303:		rol a			; 2a
B6_1304:	.db $47
B6_1305:	.db $47
B6_1306:	.db $1b
B6_1307:		rol $8080		; 2e 80 80
B6_130a:		ora $1b, x		; 15 1b
B6_130c:		rol a			; 2a
B6_130d:	.db $1c
B6_130e:		rol $8080		; 2e 80 80
B6_1311:	.db $80
B6_1312:		and $2a45		; 2d 45 2a
B6_1315:		asl $1e, x		; 16 1e
B6_1317:		ora $8080, x	; 1d 80 80
B6_131a:	.db $27
B6_131b:		clc				; 18 
B6_131c:		ora $8016, x	; 1d 16 80
B6_131f:	.db $80
B6_1320:	.db $80
B6_1321:	.db $80
B6_1322:		and $262e		; 2d 2e 26
B6_1325:		clc				; 18 
B6_1326:	.db $1b
B6_1327:		rol $2e29		; 2e 29 2e
B6_132a:	.db $1a
B6_132b:		rol a			; 2a
B6_132c:		clc				; 18 
B6_132d:		lsr $2e			; 46 2e
B6_132f:		eor $80			; 45 80
B6_1331:	.db $80
B6_1332:	.db $27
B6_1333:		asl $2d1d, x	; 1e 1d 2d
B6_1336:		rol $8045		; 2e 45 80
B6_1339:	.db $80
B6_133a:		ora $471e, x	; 1d 1e 47
B6_133d:	.db $17
B6_133e:		clc				; 18 
B6_133f:		ora $8016, x	; 1d 16 80
B6_1342:	.db $27
B6_1343:		asl $2d1e, x	; 1e 1e 2d
B6_1346:	.db $80
B6_1347:	.db $80
B6_1348:	.db $80
B6_1349:	.db $80
B6_134a:		lsr $1c			; 46 1c
B6_134c:		rol a			; 2a
B6_134d:	.db $1b
B6_134e:	.db $1b
B6_134f:	.db $80
B6_1350:	.db $80
B6_1351:	.db $80
B6_1352:		asl $1e, x		; 16 1e
B6_1354:	.db $1b
B6_1355:		and $8080		; 2d 80 80
B6_1358:	.db $80
B6_1359:	.db $80
B6_135a:		and $2a45		; 2d 45 2a
B6_135d:		asl $1e, x		; 16 1e
B6_135f:		ora $8080, x	; 1d 80 80
B6_1362:	.db $1c
B6_1363:		rol $2a47		; 2e 47 2a
B6_1366:	.db $1b
B6_1367:	.db $80
B6_1368:	.db $80
B6_1369:	.db $80
B6_136a:	.db $47
B6_136b:		rol a			; 2a
B6_136c:		clc				; 18 
B6_136d:	.db $1b
B6_136e:	.db $80
B6_136f:	.db $80
B6_1370:	.db $80
B6_1371:	.db $80
B6_1372:	.db $2b
B6_1373:		rol a			; 2a
B6_1374:	.db $47
B6_1375:	.db $47
B6_1376:	.db $1b
B6_1377:		rol $8080		; 2e 80 80
B6_137a:		ora $25, x		; 15 25
B6_137c:		eor $29			; 45 29
B6_137e:	.db $80
B6_137f:	.db $80
B6_1380:	.db $80
B6_1381:	.db $80
B6_1382:		ora $471e, x	; 1d 1e 47
B6_1385:	.db $17
B6_1386:		clc				; 18 
B6_1387:		ora $8016, x	; 1d 16 80
B6_138a:		rol a			; 2a
B6_138b:		bit $451e		; 2c 1e 45
B6_138e:		ora $8080, x	; 1d 80 80
B6_1391:	.db $80
B6_1392:	.db $2b
B6_1393:		asl $2b1c, x	; 1e 1c 2b
B6_1396:		rol a			; 2a
B6_1397:		eor $2d			; 45 2d
B6_1399:	.db $80
B6_139a:		eor $2e			; 45 2e
B6_139c:		ora $272e, x	; 1d 2e 27
B6_139f:	.db $80
B6_13a0:	.db $80
B6_13a1:	.db $80
B6_13a2:	.db $47
B6_13a3:	.db $17
B6_13a4:		and $1d			; 25 1d
B6_13a6:		and $452e		; 2d 2e 45
B6_13a9:	.db $80
B6_13aa:		ora $18, x		; 15 18
B6_13ac:		eor $2e			; 45 2e
B6_13ae:		ora $1b, x		; 15 1b
B6_13b0:		asl $2c45, x	; 1e 45 2c
B6_13b3:		rol a			; 2a
B6_13b4:		ora $802e, x	; 1d 2e 80
B6_13b7:	.db $80
B6_13b8:	.db $80
B6_13b9:	.db $80
B6_13ba:	.db $47
B6_13bb:		rol $4645		; 2e 45 46
B6_13be:	.db $47
B6_13bf:		asl $1c45, x	; 1e 45 1c
B6_13c2:	.db $17
B6_13c3:		rol $1b2a		; 2e 2a 1b
B6_13c6:	.db $1c
B6_13c7:		rol a			; 2a
B6_13c8:		bit $1e2e		; 2c 2e 1e
B6_13cb:		bit $452a		; 2c 2a 45
B6_13ce:		clc				; 18 
B6_13cf:		ora $802a, x	; 1d 2a 80
B6_13d2:		ora $1b, x		; 15 1b
B6_13d4:		rol $472e		; 2e 2e 47
B6_13d7:	.db $80
B6_13d8:	.db $80
B6_13d9:	.db $80
B6_13da:		lsr $43			; 46 43
B6_13dc:		rol $472c		; 2e 2c 47
B6_13df:		rol $8045		; 2e 45 80
B6_13e2:	.db $17
B6_13e3:		rol $1b2a		; 2e 2a 1b
B6_13e6:	.db $2b
B6_13e7:		rol a			; 2a
B6_13e8:	.db $1b
B6_13e9:	.db $1b
B6_13ea:	.db $80
B6_13eb:	.db $80
B6_13ec:	.db $80
B6_13ed:	.db $80
B6_13ee:	.db $80
B6_13ef:	.db $80
B6_13f0:	.db $80
B6_13f1:	.db $80
B6_13f2:	.db $80
B6_13f3:	.db $80
B6_13f4:	.db $80
B6_13f5:	.db $80
B6_13f6:	.db $80
B6_13f7:	.db $80
B6_13f8:	.db $80
B6_13f9:	.db $80
B6_13fa:	.db $80
B6_13fb:	.db $80
B6_13fc:	.db $80
B6_13fd:	.db $80
B6_13fe:	.db $80
B6_13ff:	.db $80
B6_1400:	.db $80
B6_1401:	.db $80
B6_1402:		ora $471e, x	; 1d 1e 47
B6_1405:	.db $17
B6_1406:		clc				; 18 
B6_1407:		ora $8016, x	; 1d 16 80
B6_140a:		lsr $47			; 46 47
B6_140c:		rol a			; 2a
B6_140d:	.db $47
B6_140e:		and $2e			; 25 2e
B6_1410:	.db $80
B6_1411:	.db $80
B6_1412:		eor $18			; 45 18
B6_1414:		ora $8016, x	; 1d 16 80
B6_1417:	.db $80
B6_1418:	.db $80
B6_1419:	.db $80
B6_141a:	.db $17
B6_141b:		rol $2b45		; 2e 45 2b
B6_141e:		lsr $80			; 46 80
B6_1420:	.db $80
B6_1421:	.db $80
B6_1422:		lsr $2c			; 46 2c
B6_1424:		rol a			; 2a
B6_1425:	.db $1b
B6_1426:		rol $8080		; 2e 80 80
B6_1429:	.db $80
B6_142a:	.db $2b
B6_142b:		eor $2a			; 45 2a
B6_142d:		bit $1b2e		; 2c 2e 1b
B6_1430:		rol $1a47		; 2e 47 1a
B6_1433:		rol $8029		; 2e 29 80
B6_1436:	.db $80
B6_1437:	.db $80
B6_1438:	.db $80
B6_1439:	.db $80
B6_143a:		ora $1b, x		; 15 1b
B6_143c:		and $47			; 25 47
B6_143e:		rol $8080		; 2e 80 80
B6_1441:	.db $80
B6_1442:		bit $2945		; 2c 45 29
B6_1445:		lsr $47			; 46 47
B6_1447:		rol a			; 2a
B6_1448:	.db $1b
B6_1449:	.db $80
B6_144a:		bit $2945		; 2c 45 29
B6_144d:		lsr $47			; 46 47
B6_144f:		rol a			; 2a
B6_1450:	.db $1b
B6_1451:	.db $80
B6_1452:		bit $2e45		; 2c 45 2e
B6_1455:		lsr $47			; 46 47
B6_1457:	.db $80
B6_1458:	.db $80
B6_1459:	.db $80
B6_145a:	.db $27
B6_145b:		rol a			; 2a
B6_145c:	.db $1a
B6_145d:	.db $1a
B6_145e:		rol a			; 2a
B6_145f:	.db $80
B6_1460:	.db $80
B6_1461:	.db $80
B6_1462:		ora $2c1e, x	; 1d 1e 2c
B6_1465:	.db $1a
B6_1466:	.db $1c
B6_1467:		rol a			; 2a
B6_1468:		rol a			; 2a
B6_1469:		eor $1d			; 45 1d
B6_146b:		rol $1a2c		; 2e 2c 1a
B6_146e:	.db $1b
B6_146f:		rol a			; 2a
B6_1470:		bit $432e		; 2c 2e 43
B6_1473:		asl $2d27, x	; 1e 27 2d
B6_1476:		rol $8045		; 2e 45 80
B6_1479:	.db $80
B6_147a:		lsr $17			; 46 17
B6_147c:		asl $462e, x	; 1e 2e 46
B6_147f:	.db $80
B6_1480:	.db $80
B6_1481:	.db $80

; long sword tile/attr at index 8/9
data_6_1482:
B6_1482:		.db $00				; 00
B6_1483:		.db $00				; 00
B6_1484:		.db $00				; 00
B6_1485:		.db $00				; 00
B6_1486:		.db $00				; 00
B6_1487:		.db $00				; 00
B6_1488:		.db $00				; 00
B6_1489:		.db $00				; 00
B6_148a:	.db $80
B6_148b:		.db $00				; 00
B6_148c:		sta $00			; 85 00
B6_148e:		sty $00			; 84 00
B6_1490:		stx $00			; 86 00
B6_1492:		cmp $cf02		; cd 02 cf
B6_1495:	.db $02
B6_1496:		dec $d002		; ce 02 d0
B6_1499:	.db $02
B6_149a:	.db $8b
B6_149b:	.db $02
B6_149c:		sta $8c02		; 8d 02 8c
B6_149f:	.db $03
B6_14a0:	.db $80
B6_14a1:		.db $00				; 00
B6_14a2:		cmp $03, x		; d5 03
B6_14a4:	.db $d7
B6_14a5:	.db $03
B6_14a6:		dec $03, x		; d6 03
B6_14a8:		cld				; d8 
B6_14a9:	.db $03
B6_14aa:	.db $87
B6_14ab:		ora ($89, x)	; 01 89
B6_14ad:		ora ($88, x)	; 01 88
B6_14af:		ora ($8a, x)	; 01 8a
B6_14b1:		ora ($d9, x)	; 01 d9
B6_14b3:		.db $00				; 00
B6_14b4:	.db $db
B6_14b5:		.db $00				; 00
B6_14b6:	.db $da
B6_14b7:		.db $00				; 00
B6_14b8:	.db $dc
B6_14b9:		.db $00				; 00
B6_14ba:		cmp ($02), y	; d1 02
B6_14bc:	.db $d3
B6_14bd:	.db $02
B6_14be:	.db $d2
B6_14bf:	.db $02
B6_14c0:	.db $d4
B6_14c1:	.db $02
B6_14c2:		cmp $df00, x	; dd 00 df
B6_14c5:		.db $00				; 00
B6_14c6:		dec $e000, x	; de 00 e0
B6_14c9:		.db $00				; 00
B6_14ca:		.db $00				; 00
B6_14cb:		.db $00				; 00
B6_14cc:		.db $00				; 00
B6_14cd:		.db $00				; 00
B6_14ce:		.db $00				; 00
B6_14cf:		.db $00				; 00
B6_14d0:		.db $00				; 00
B6_14d1:		.db $00				; 00
B6_14d2:		stx $9001		; 8e 01 90
B6_14d5:		ora ($8f, x)	; 01 8f
B6_14d7:		ora ($91, x)	; 01 91
B6_14d9:		ora ($e7, x)	; 01 e7
B6_14db:	.db $03
B6_14dc:		sbc #$03		; e9 03
B6_14de:		inx				; e8 
B6_14df:	.db $03
B6_14e0:		nop				; ea 
B6_14e1:	.db $03
B6_14e2:	.db $92
B6_14e3:	.db $02
B6_14e4:	.db $93
B6_14e5:	.db $02
B6_14e6:		sbc ($02, x)	; e1 02
B6_14e8:	.db $e2
B6_14e9:	.db $02
B6_14ea:		sty $00, x		; 94 00
B6_14ec:		sta $00, x		; 95 00
B6_14ee:		sty $40, x		; 94 40
B6_14f0:		sta $40, x		; 95 40
B6_14f2:	.db $eb
B6_14f3:		.db $00				; 00
B6_14f4:		sbc $ec00		; ed00 ec
B6_14f7:		.db $00				; 00
B6_14f8:		inc $f300		; ee 00 f3
B6_14fb:	.db $03
B6_14fc:	.db $f4
B6_14fd:	.db $03
B6_14fe:	.db $f3
B6_14ff:	.db $43
B6_1500:	.db $f4
B6_1501:	.db $43
B6_1502:	.db $ef
B6_1503:	.db $02
B6_1504:		sbc ($02), y	; f1 02
B6_1506:		beq B6_150a ; f0 02

B6_1508:	.db $f2
B6_1509:	.db $02
B6_150a:		sbc $02, x		; f5 02
B6_150c:	.db $f7
B6_150d:	.db $02
B6_150e:		inc $02, x		; f6 02
B6_1510:		sed				; f8 
B6_1511:	.db $02
B6_1512:		.db $00				; 00
B6_1513:		.db $00				; 00
B6_1514:		.db $00				; 00
B6_1515:		.db $00				; 00
B6_1516:		.db $00				; 00
B6_1517:		.db $00				; 00
B6_1518:		.db $00				; 00
B6_1519:		.db $00				; 00
B6_151a:		stx $01, y		; 96 01
B6_151c:		tya				; 98 
B6_151d:		ora ($97, x)	; 01 97
B6_151f:		ora ($99, x)	; 01 99
B6_1521:		ora ($b9, x)	; 01 b9
B6_1523:		ora ($bb, x)	; 01 bb
B6_1525:		ora ($ba, x)	; 01 ba
B6_1527:		ora ($bc, x)	; 01 bc
B6_1529:		ora ($bd, x)	; 01 bd
B6_152b:		ora ($bf, x)	; 01 bf
B6_152d:		ora ($be, x)	; 01 be
B6_152f:		ora ($c0, x)	; 01 c0
B6_1531:		ora ($c1, x)	; 01 c1
B6_1533:	.db $02
B6_1534:	.db $c3
B6_1535:	.db $02
B6_1536:	.db $c2
B6_1537:	.db $02
B6_1538:		cpy $02			; c4 02
B6_153a:		cmp $02			; c5 02
B6_153c:	.db $c7
B6_153d:	.db $02
B6_153e:		dec $02			; c6 02
B6_1540:		iny				; c8 
B6_1541:	.db $02
B6_1542:	.db $80
B6_1543:		.db $00				; 00
B6_1544:	.db $9f
B6_1545:		ora ($9e, x)	; 01 9e
B6_1547:		ora ($80, x)	; 01 80
B6_1549:		.db $00				; 00
B6_154a:		cmp #$00		; c9 00
B6_154c:	.db $cb
B6_154d:		.db $00				; 00
B6_154e:		dex				; ca 
B6_154f:		.db $00				; 00
B6_1550:		cpy $8000		; cc 00 80
B6_1553:		.db $00				; 00
B6_1554:	.db $ab
B6_1555:		ora ($aa, x)	; 01 aa
B6_1557:		ora ($ac, x)	; 01 ac
B6_1559:		ora ($e3, x)	; 01 e3
B6_155b:		ora ($e5, x)	; 01 e5
B6_155d:		ora ($e4, x)	; 01 e4
B6_155f:		ora ($e6, x)	; 01 e6
B6_1561:		ora ($b5, x)	; 01 b5
B6_1563:		.db $00				; 00
B6_1564:	.db $b7
B6_1565:		.db $00				; 00
B6_1566:		ldx $00, y		; b6 00
B6_1568:		clv				; b8 
B6_1569:		.db $00				; 00
B6_156a:		lda $af00		; ad 00 af
B6_156d:		.db $00				; 00
B6_156e:		ldx $b000		; ae 00 b0
B6_1571:		.db $00				; 00
B6_1572:		ldy #$03		; a0 03
B6_1574:		ldx #$03		; a2 03
B6_1576:		lda ($03, x)	; a1 03
B6_1578:	.db $a3
B6_1579:	.db $03
B6_157a:		txs				; 9a 
B6_157b:		ora ($9c, x)	; 01 9c
B6_157d:		ora ($9b, x)	; 01 9b
B6_157f:		ora ($9d, x)	; 01 9d
B6_1581:		ora ($b1, x)	; 01 b1
B6_1583:	.db $02
B6_1584:	.db $b3
B6_1585:		ora ($b2, x)	; 01 b2
B6_1587:	.db $02
B6_1588:		ldy $01, x		; b4 01
B6_158a:	.db $80
B6_158b:		.db $00				; 00
B6_158c:	.db $80
B6_158d:		.db $00				; 00
B6_158e:	.db $80
B6_158f:		.db $00				; 00
B6_1590:	.db $80
B6_1591:		.db $00				; 00
B6_1592:		.db $00				; 00
B6_1593:		.db $00				; 00
B6_1594:		.db $00				; 00
B6_1595:		.db $00				; 00
B6_1596:		.db $00				; 00
B6_1597:		.db $00				; 00
B6_1598:		.db $00				; 00
B6_1599:		.db $00				; 00
B6_159a:		sbc $fb02, y	; f9 02 fb
B6_159d:	.db $02
B6_159e:	.db $fa
B6_159f:	.db $02
B6_15a0:	.db $fc
B6_15a1:	.db $02
B6_15a2:		sbc $ff02, x	; fd 02 ff
B6_15a5:	.db $02
B6_15a6:	.db $fe $02 $00
B6_15a9:	.db $02
B6_15aa:		ora ($03, x)	; 01 03
B6_15ac:	.db $03
B6_15ad:	.db $03
B6_15ae:	.db $02
B6_15af:	.db $03
B6_15b0:	.db $04
B6_15b1:	.db $03
B6_15b2:		ora $03			; 05 03
B6_15b4:	.db $07
B6_15b5:	.db $03
B6_15b6:		asl $03			; 06 03
B6_15b8:		php				; 08 
B6_15b9:	.db $03
B6_15ba:		ora #$02		; 09 02
B6_15bc:	.db $0b
B6_15bd:	.db $02
B6_15be:		asl a			; 0a
B6_15bf:	.db $02
B6_15c0:	.db $0c
B6_15c1:	.db $02
B6_15c2:	.db $80
B6_15c3:		.db $00				; 00
B6_15c4:		asl $0d02		; 0e 02 0d
B6_15c7:	.db $02
B6_15c8:	.db $0f
B6_15c9:	.db $02
B6_15ca:		bpl B6_15cc ; 10 00

B6_15cc:	.db $12
B6_15cd:	.db $02
B6_15ce:		ora ($00), y	; 11 00
B6_15d0:	.db $80
B6_15d1:		.db $00				; 00
B6_15d2:	.db $13
B6_15d3:		.db $00				; 00
B6_15d4:		ora $01, x		; 15 01
B6_15d6:	.db $14
B6_15d7:		.db $00				; 00
B6_15d8:		asl $01, x		; 16 01
B6_15da:	.db $17
B6_15db:		.db $00				; 00
B6_15dc:		ora $01, x		; 15 01
B6_15de:		clc				; 18 
B6_15df:		.db $00				; 00
B6_15e0:		asl $01, x		; 16 01
B6_15e2:		ora $1b02, y	; 19 02 1b
B6_15e5:	.db $02
B6_15e6:	.db $1a
B6_15e7:	.db $02
B6_15e8:	.db $1c
B6_15e9:	.db $02
B6_15ea:		ora $1f03, x	; 1d 03 1f
B6_15ed:	.db $03
B6_15ee:		asl $2003, x	; 1e 03 20
B6_15f1:	.db $03
B6_15f2:		and ($02, x)	; 21 02
B6_15f4:	.db $23
B6_15f5:	.db $02
B6_15f6:	.db $22
B6_15f7:	.db $02
B6_15f8:		bit $02			; 24 02
B6_15fa:		and $02			; 25 02
B6_15fc:	.db $27
B6_15fd:		.db $00				; 00
B6_15fe:		rol $02			; 26 02
B6_1600:		plp				; 28 
B6_1601:	.db $02
B6_1602:		and #$01		; 29 01
B6_1604:	.db $2b
B6_1605:		ora ($2a, x)	; 01 2a
B6_1607:		ora ($2c, x)	; 01 2c
B6_1609:		ora ($2d, x)	; 01 2d
B6_160b:		ora ($2f, x)	; 01 2f
B6_160d:		ora ($2e, x)	; 01 2e
B6_160f:		ora ($30, x)	; 01 30
B6_1611:		ora ($80, x)	; 01 80
B6_1613:	.db $80
B6_1614:	.db $80
B6_1615:	.db $80
B6_1616:	.db $80
B6_1617:	.db $80
B6_1618:	.db $80
B6_1619:	.db $80
B6_161a:		adc $4a70		; 6d 70 4a
B6_161d:	.db $07
B6_161e:	.db $80
B6_161f:	.db $80
B6_1620:	.db $80
B6_1621:	.db $80
B6_1622:	.db $5b
B6_1623:	.db $07
B6_1624:		lsr $6b, x		; 56 6b
B6_1626:	.db $80
B6_1627:	.db $80
B6_1628:	.db $80
B6_1629:	.db $80
B6_162a:		eor $216c, x	; 5d 6c 21
B6_162d:	.db $63
B6_162e:	.db $80
B6_162f:	.db $80
B6_1630:	.db $80
B6_1631:	.db $80
B6_1632:		lsr $07, x		; 56 07
B6_1634:		adc #$4c		; 69 4c
B6_1636:	.db $07
B6_1637:		bvs B6_15b9 ; 70 80

B6_1639:	.db $80
B6_163a:	.db $22
B6_163b:		and ($70, x)	; 21 70
B6_163d:		lsr a			; 4a
B6_163e:	.db $07
B6_163f:	.db $80
B6_1640:	.db $80
B6_1641:	.db $80
B6_1642:		eor $07, x		; 55 07
B6_1644:	.db $5c
B6_1645:	.db $07
B6_1646:	.db $6b
B6_1647:	.db $1f
B6_1648:		and ($80, x)	; 21 80
B6_164a:		pha				; 48 
B6_164b:		and ($4d, x)	; 21 4d
B6_164d:	.db $07
B6_164e:	.db $0f
B6_164f:	.db $80
B6_1650:	.db $80
B6_1651:	.db $80
B6_1652:	.db $6f
B6_1653:		bvs B6_16a7 ; 70 52

B6_1655:	.db $07
B6_1656:	.db $0f
B6_1657:	.db $80
B6_1658:	.db $80
B6_1659:	.db $80
B6_165a:	.db $80
B6_165b:	.db $80
B6_165c:	.db $80
B6_165d:	.db $80
B6_165e:	.db $80
B6_165f:	.db $80
B6_1660:	.db $80
B6_1661:	.db $80
B6_1662:	.db $22
B6_1663:		adc ($56), y	; 71 56
B6_1665:	.db $07
B6_1666:	.db $80
B6_1667:	.db $80
B6_1668:	.db $80
B6_1669:	.db $80
B6_166a:	.db $4f
B6_166b:		adc $0f			; 65 0f
B6_166d:	.db $6b
B6_166e:	.db $80
B6_166f:	.db $80
B6_1670:	.db $80
B6_1671:	.db $80
B6_1672:		jmp $0f07		; 4c 07 0f


B6_1675:	.db $6b
B6_1676:		lsr $07, x		; 56 07
B6_1678:	.db $80
B6_1679:	.db $80
B6_167a:		lsr $07, x		; 56 07
B6_167c:		adc #$4c		; 69 4c
B6_167e:	.db $07
B6_167f:		bvs B6_1601 ; 70 80

B6_1681:	.db $80
B6_1682:	.db $64
B6_1683:	.db $52
B6_1684:	.db $6b
B6_1685:	.db $80
B6_1686:	.db $80
B6_1687:	.db $80
B6_1688:	.db $80
B6_1689:	.db $80
B6_168a:		eor $21, x		; 55 21
B6_168c:	.db $6b
B6_168d:	.db $80
B6_168e:	.db $80
B6_168f:	.db $80
B6_1690:	.db $80
B6_1691:	.db $80
B6_1692:	.db $5b
B6_1693:	.db $07
B6_1694:		lsr $6b, x		; 56 6b
B6_1696:	.db $80
B6_1697:	.db $80
B6_1698:	.db $80
B6_1699:	.db $80
B6_169a:		eor $1f73, x	; 5d 73 1f
B6_169d:		ror a			; 6a
B6_169e:	.db $0f
B6_169f:	.db $80
B6_16a0:	.db $80
B6_16a1:	.db $80
B6_16a2:	.db $80
B6_16a3:	.db $80
B6_16a4:	.db $80
B6_16a5:	.db $80
B6_16a6:	.db $80
B6_16a7:	.db $80
B6_16a8:	.db $80
B6_16a9:	.db $80
B6_16aa:	.db $47
B6_16ab:	.db $07
B6_16ac:		rol $0717, x	; 3e 17 07
B6_16af:		ror a			; 6a
B6_16b0:	.db $80
B6_16b1:	.db $80
B6_16b2:	.db $5f
B6_16b3:	.db $07
B6_16b4:		bvs B6_1711 ; 70 5b

B6_16b6:	.db $07
B6_16b7:	.db $0f
B6_16b8:		lsr $07, x		; 56 07
B6_16ba:		ror a			; 6a
B6_16bb:		cli				; 58 
B6_16bc:	.db $73
B6_16bd:	.db $0f
B6_16be:	.db $80
B6_16bf:	.db $80
B6_16c0:	.db $80
B6_16c1:	.db $80
B6_16c2:		eor $5270		; 4d 70 52
B6_16c5:	.db $07
B6_16c6:	.db $0f
B6_16c7:	.db $80
B6_16c8:	.db $80
B6_16c9:	.db $80
B6_16ca:		eor $2106, x	; 5d 06 21
B6_16cd:		ror $0f			; 66 0f
B6_16cf:	.db $80
B6_16d0:	.db $80
B6_16d1:	.db $80
B6_16d2:	.db $2f
B6_16d3:	.db $14
B6_16d4:		bit $4529		; 2c 29 45
B6_16d7:		and $8080		; 2d 80 80
B6_16da:		eor $0f, x		; 55 0f
B6_16dc:	.db $6b
B6_16dd:	.db $4f
B6_16de:		lsr $0f, x		; 56 0f
B6_16e0:	.db $63
B6_16e1:	.db $80
B6_16e2:	.db $5c
B6_16e3:	.db $0f
B6_16e4:	.db $6b
B6_16e5:	.db $64
B6_16e6:		and ($4f, x)	; 21 4f
B6_16e8:	.db $80
B6_16e9:	.db $80
B6_16ea:		bit $48			; 24 48
B6_16ec:		ror a			; 6a
B6_16ed:	.db $57
B6_16ee:	.db $80
B6_16ef:	.db $80
B6_16f0:	.db $80
B6_16f1:	.db $80
B6_16f2:		eor $0f6a, x	; 5d 6a 0f
B6_16f5:		lsr $80, x		; 56 80
B6_16f7:	.db $80
B6_16f8:	.db $80
B6_16f9:	.db $80
B6_16fa:	.db $4f
B6_16fb:		lsr $4a08, x	; 5e 08 4a
B6_16fe:	.db $52
B6_16ff:	.db $0f
B6_1700:	.db $80
B6_1701:	.db $80
B6_1702:	.db $5c
B6_1703:	.db $0f
B6_1704:	.db $6b
B6_1705:	.db $5f
B6_1706:	.db $07
B6_1707:	.db $0f
B6_1708:	.db $6b
B6_1709:	.db $80
B6_170a:	.db $80
B6_170b:	.db $80
B6_170c:	.db $80
B6_170d:	.db $80
B6_170e:	.db $80
B6_170f:	.db $80
B6_1710:	.db $80
B6_1711:	.db $80
B6_1712:	.db $80
B6_1713:	.db $80
B6_1714:	.db $80
B6_1715:	.db $80
B6_1716:	.db $80
B6_1717:	.db $80
B6_1718:	.db $80
B6_1719:	.db $80
B6_171a:	.db $80
B6_171b:	.db $80
B6_171c:	.db $80
B6_171d:	.db $80
B6_171e:	.db $80
B6_171f:	.db $80
B6_1720:	.db $80
B6_1721:	.db $80
B6_1722:	.db $80
B6_1723:	.db $80
B6_1724:	.db $80
B6_1725:	.db $80
B6_1726:	.db $80
B6_1727:	.db $80
B6_1728:	.db $80
B6_1729:	.db $80
B6_172a:		rol $192c		; 2e 2c 19
B6_172d:	.db $07
B6_172e:		rol $071e, x	; 3e 1e 07
B6_1731:		bit $706a		; 2c 6a 70
B6_1734:		lsr a			; 4a
B6_1735:	.db $07
B6_1736:	.db $80
B6_1737:	.db $80
B6_1738:	.db $80
B6_1739:	.db $80
B6_173a:	.db $34
B6_173b:	.db $17
B6_173c:		asl $802c, x	; 1e 2c 80
B6_173f:	.db $80
B6_1740:	.db $80
B6_1741:	.db $80
B6_1742:		bit $193b		; 2c 3b 19
B6_1745:	.db $80
B6_1746:	.db $80
B6_1747:	.db $80
B6_1748:	.db $80
B6_1749:	.db $80
B6_174a:		eor $6c07, x	; 5d 07 6c
B6_174d:	.db $4f
B6_174e:		jmp ($5671)		; 6c 71 56


B6_1751:	.db $80
B6_1752:		ora $16, x		; 15 16
B6_1754:	.db $07
B6_1755:	.db $80
B6_1756:	.db $80
B6_1757:	.db $80
B6_1758:	.db $80
B6_1759:	.db $80
B6_175a:		lsr $7707		; 4e 07 77
B6_175d:	.db $57
B6_175e:	.db $0f
B6_175f:		and #$12		; 29 12
B6_1761:		and $152a		; 2d 2a 15
B6_1764:	.db $2b
B6_1765:	.db $1c
B6_1766:	.db $2b
B6_1767:	.db $1b
B6_1768:	.db $42
B6_1769:		bit $2e2a		; 2c 2a 2e
B6_176c:	.db $2b
B6_176d:	.db $1c
B6_176e:	.db $2b
B6_176f:	.db $1b
B6_1770:	.db $42
B6_1771:		bit $3015		; 2c 15 30
B6_1774:		and #$33		; 29 33
B6_1776:		rol $421b, x	; 3e 1b 42
B6_1779:		bit $716f		; 2c 6f 71
B6_177c:		pha				; 48 
B6_177d:		and #$30		; 29 30
B6_177f:	.db $80
B6_1780:	.db $80
B6_1781:	.db $80
B6_1782:	.db $1b
B6_1783:	.db $3b
B6_1784:		and #$15		; 29 15
B6_1786:		asl $07, x		; 16 07
B6_1788:	.db $80
B6_1789:	.db $80
B6_178a:	.db $5a
B6_178b:		adc ($4a), y	; 71 4a
B6_178d:		jmp ($804f)		; 6c 4f 80


B6_1790:	.db $80
B6_1791:	.db $80
B6_1792:	.db $1b
B6_1793:		eor $3a			; 45 3a
B6_1795:		rol $1929, x	; 3e 29 19
B6_1798:		and $80			; 25 80
B6_179a:	.db $2f
B6_179b:	.db $47
B6_179c:	.db $07
B6_179d:		bit $291b		; 2c 1b 29
B6_17a0:	.db $17
B6_17a1:		.db $45


func_6_17a2:
	ldx wNextVramQueueIdxToFillInFrom
B6_17a4:		lda #$21		; a9 21
B6_17a6:		sta wVramQueue.w, x	; 9d 00 05
B6_17a9:		inx				; e8 
B6_17aa:		lda #$4a		; a9 4a
B6_17ac:		sta wVramQueue.w, x	; 9d 00 05
B6_17af:		inx				; e8 
B6_17b0:		lda #$02		; a9 02
B6_17b2:		sta wVramQueue.w, x	; 9d 00 05
B6_17b5:		inx				; e8 
B6_17b6:		lda wCurrLevel			; a5 71
B6_17b8:		clc				; 18 
B6_17b9:		adc #$01		; 69 01
B6_17bb:		jsr func_7_364d		; 20 4d f6
B6_17be:		lda $0d			; a5 0d
B6_17c0:		php				; 08 
B6_17c1:		clc				; 18 
B6_17c2:		adc #$f0		; 69 f0
B6_17c4:		plp				; 28 
B6_17c5:		bne B6_17c9 ; d0 02

B6_17c7:		lda #$80		; a9 80
B6_17c9:		sta wVramQueue.w, x	; 9d 00 05
B6_17cc:		inx				; e8 
B6_17cd:		lda $0e			; a5 0e
B6_17cf:		clc				; 18 
B6_17d0:		adc #$f0		; 69 f0
B6_17d2:		sta wVramQueue.w, x	; 9d 00 05
B6_17d5:		inx				; e8 
B6_17d6:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B6_17d8:		lda #$00		; a9 00
B6_17da:		sta $0a			; 85 0a
B6_17dc:		lda #$80		; a9 80
B6_17de:		sta $08			; 85 08
B6_17e0:		ldx #$04		; a2 04
B6_17e2:		lda wCurrExpDigits, x		; b5 7c
B6_17e4:		sta $0b, x		; 95 0b
B6_17e6:		dex				; ca 
B6_17e7:		bpl B6_17e2 ; 10 f9

B6_17e9:		jsr func_6_1846		; 20 46 98
B6_17ec:		inc $0a			; e6 0a
B6_17ee:		ldx #$00		; a2 00
B6_17f0:		lda wCurrLevel			; a5 71
B6_17f2:		asl a			; 0a
B6_17f3:		asl a			; 0a
B6_17f4:		clc				; 18 
B6_17f5:		adc wCurrLevel			; 65 71
B6_17f7:		tay				; a8 
B6_17f8:		lda levelExpReqs.w, y	; b9 1b d2
B6_17fb:		sta $0b, x		; 95 0b
B6_17fd:		iny				; c8 
B6_17fe:		inx				; e8 
B6_17ff:		cpx #$05		; e0 05
B6_1801:		bne B6_17f8 ; d0 f5

B6_1803:		jsr func_6_1846		; 20 46 98
B6_1806:		ldy wCurrLevel			; a4 71
B6_1808:		inc $0a			; e6 0a
B6_180a:		lda levelMaxMP.w, y	; b9 0b d2
B6_180d:		jsr func_7_364d		; 20 4d f6
B6_1810:		jsr func_6_1846		; 20 46 98
B6_1813:		inc $0a			; e6 0a
B6_1815:		lda levelMaxHealth.w, y	; b9 fb d1
B6_1818:		jsr func_7_364d		; 20 4d f6
B6_181b:		jsr func_6_1846		; 20 46 98
B6_181e:		ldy #$01		; a0 01
B6_1820:		inc $0a			; e6 0a
B6_1822:	.db $b9 $7a $00
B6_1825:		jsr func_7_364d		; 20 4d f6
B6_1828:		jsr func_6_1846		; 20 46 98
B6_182b:		dey				; 88 
B6_182c:		bpl B6_1820 ; 10 f2

B6_182e:		ldy #$02		; a0 02
B6_1830:		inc $0a			; e6 0a
B6_1832:	.db $b9 $b3 $00
B6_1835:		jsr func_7_364d		; 20 4d f6
B6_1838:		jsr func_6_1846		; 20 46 98
B6_183b:		dey				; 88 
B6_183c:		bpl B6_1830 ; 10 f2

B6_183e:		lda #$00		; a9 00
B6_1840:		sta wVramQueue.w, x	; 9d 00 05
B6_1843:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B6_1845:		rts				; 60 


func_6_1846:
B6_1846:		sty $07			; 84 07
B6_1848:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B6_184a:		ldy $0a			; a4 0a
B6_184c:		lda $985e, y	; b9 5e 98
B6_184f:		sta wVramQueue.w, x	; 9d 00 05
B6_1852:		inx				; e8 
B6_1853:		lda $9867, y	; b9 67 98
B6_1856:		sta wVramQueue.w, x	; 9d 00 05
B6_1859:		inx				; e8 
B6_185a:		jmp $f495		; 4c 95 f4


B6_185d:		rts				; 60 


B6_185e:		and ($21, x)	; 21 21
B6_1860:	.db $22
B6_1861:	.db $22
B6_1862:	.db $22
B6_1863:	.db $22
B6_1864:	.db $23
B6_1865:	.db $22
B6_1866:	.db $22
B6_1867:	.db $a3
B6_1868:	.db $c7
B6_1869:		ora #$69		; 09 69
B6_186b:	.db $64
B6_186c:	.db $04
B6_186d:		and #$e9		; 29 e9
B6_186f:		.db $a9


handleSwordInvScreen:
	jsr $9b4f
B6_1873:		lda #$02		; a9 02
B6_1875:		jsr func_6_11cb		; 20 cb 91
B6_1878:		jsr $9bc0		; 20 c0 9b
B6_187b:		jsr updateFromVramQueue		; 20 f2 c2
B6_187e:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1881:		lda wSwordGlobalFlags.w		; ad 03 06
B6_1884:		bne B6_1889 ; d0 03

B6_1886:		jmp $9b37		; 4c 37 9b

B6_1889:		jsr $9bff		; 20 ff 9b

B6_188c:		lda wSwordGlobalFlags.w		; ad 03 06
B6_188f:		ldx #$00		; a2 00
B6_1891:		ldy #$04		; a0 04
B6_1893:		jsr func_6_1b69		; 20 69 9b
B6_1896:		lda #$00		; a9 00
B6_1898:		sta $f2			; 85 f2
B6_189a:		ldy $b6			; a4 b6
B6_189c:		beq B6_18a1 ; f0 03

B6_189e:		dey				; 88 
B6_189f:		sty $f3			; 84 f3
B6_18a1:		jsr $9b73		; 20 73 9b
B6_18a4:		lda wJoy1NewButtonsPressed			; a5 29
B6_18a6:		and #$80		; 29 80
B6_18a8:		beq B6_18ad ; f0 03

B6_18aa:		jmp $9929		; 4c 29 99


B6_18ad:		ldy #$00		; a0 00
B6_18af:		jsr $9c99		; 20 99 9c
B6_18b2:		lda wJoy1NewButtonsPressed			; a5 29
B6_18b4:		and #$40		; 29 40
B6_18b6:		beq B6_18bb ; f0 03

B6_18b8:		jmp $9920		; 4c 20 99


B6_18bb:		ldx $f3			; a6 f3
B6_18bd:		inx				; e8 
B6_18be:		lda wSwordGlobalFlags.w		; ad 03 06
B6_18c1:		lsr a			; 4a
B6_18c2:		dex				; ca 
B6_18c3:		bne B6_18c1 ; d0 fc

B6_18c5:		bcs B6_18cd ; b0 06

B6_18c7:		jsr $992c		; 20 2c 99
B6_18ca:		jmp $9917		; 4c 17 99


B6_18cd:		lda $f3			; a5 f3
B6_18cf:		clc				; 18 
B6_18d0:		adc #$01		; 69 01
B6_18d2:		sta $b6			; 85 b6
B6_18d4:		jsr $9bc0		; 20 c0 9b
B6_18d7:		ldy #$00		; a0 00
B6_18d9:		sty $00			; 84 00
B6_18db:		sty $01			; 84 01
B6_18dd:		lda wStoryGlobalFlags0.w		; ad 00 06
B6_18e0:		and #$08		; 29 08
B6_18e2:		beq B6_18f0 ; f0 0c

B6_18e4:		lda wEquippedSword			; a5 b6
B6_18e6:		cmp #$05		; c9 05
B6_18e8:		bne B6_18f0 ; d0 06

B6_18ea:		lda #$54		; a9 54
B6_18ec:		sta $01			; 85 01
B6_18ee:		bne B6_18f0 ; d0 00

B6_18f0:		lda wItemGlobalFlags0.w		; ad 07 06
B6_18f3:		and #GFB_RING_ITEM		; 29 02
B6_18f5:		beq B6_18fb ; f0 04

B6_18f7:		lda #$0a		; a9 0a
B6_18f9:		sta $00			; 85 00

B6_18fb:		ldy wCurrLevel			; a4 71
B6_18fd:		ldx $b6			; a6 b6
B6_18ff:		clc				; 18 
B6_1900:		lda weaponStrength.w, x	; bd 6b d2
B6_1903:		adc $d1cb, y	; 79 cb d1
B6_1906:		adc $01			; 65 01
B6_1908:		adc $00			; 65 00
B6_190a:		sta $b3			; 85 b3
B6_190c:		ldx #$08		; a2 08
B6_190e:		jsr $9b8e		; 20 8e 9b
B6_1911:		lda $c0			; a5 c0
B6_1913:		ora #$01		; 09 01
B6_1915:		sta $c0			; 85 c0
B6_1917:		jsr $9d34		; 20 34 9d
B6_191a:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_191d:		jmp $98a4		; 4c a4 98


B6_1920:		jsr $992c		; 20 2c 99
B6_1923:		jsr $9d34		; 20 34 9d
B6_1926:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1929:		jmp $8f4d		; 4c 4d 8f


B6_192c:		lda #$00		; a9 00
B6_192e:		sta $b6			; 85 b6
B6_1930:		jsr $9bc0		; 20 c0 9b
B6_1933:		lda #$00		; a9 00
B6_1935:		sta $b3			; 85 b3
B6_1937:		ldx #$08		; a2 08
B6_1939:		jsr $9b8e		; 20 8e 9b
B6_193c:		lda $c0			; a5 c0
B6_193e:		and #$fe		; 29 fe
B6_1940:		sta $c0			; 85 c0
B6_1942:		rts				; 60 


handleShieldInvScreen:
B6_1943:		jsr $9b4f		; 20 4f 9b
B6_1946:		lda #$05		; a9 05
B6_1948:		jsr func_6_11cb		; 20 cb 91
B6_194b:		jsr $9bd1		; 20 d1 9b
B6_194e:		jsr updateFromVramQueue		; 20 f2 c2
B6_1951:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1954:		lda wShieldGlobalFlags.w		; ad 04 06
B6_1957:		bne B6_195c ; d0 03

B6_1959:		jmp $9b37		; 4c 37 9b


B6_195c:		jsr $9c08		; 20 08 9c
B6_195f:		lda wShieldGlobalFlags.w		; ad 04 06
B6_1962:		ldx #$00		; a2 00
B6_1964:		ldy #$04		; a0 04
B6_1966:		jsr func_6_1b69		; 20 69 9b
B6_1969:		lda #$00		; a9 00
B6_196b:		sta $f2			; 85 f2
B6_196d:		ldy $b7			; a4 b7
B6_196f:		beq B6_1974 ; f0 03

B6_1971:		dey				; 88 
B6_1972:		sty $f3			; 84 f3
B6_1974:		jsr $9b73		; 20 73 9b
B6_1977:		lda wJoy1NewButtonsPressed			; a5 29
B6_1979:		and #$80		; 29 80
B6_197b:		bne B6_19e5 ; d0 68

B6_197d:		ldy #$00		; a0 00
B6_197f:		jsr $9c99		; 20 99 9c
B6_1982:		lda wJoy1NewButtonsPressed			; a5 29
B6_1984:		and #$40		; 29 40
B6_1986:		bne B6_19dc ; d0 54

B6_1988:		ldx $f3			; a6 f3
B6_198a:		inx				; e8 
B6_198b:		lda wShieldGlobalFlags.w		; ad 04 06
B6_198e:		lsr a			; 4a
B6_198f:		dex				; ca 
B6_1990:		bne B6_198e ; d0 fc

B6_1992:		bcs B6_199a ; b0 06

B6_1994:		jsr $99c5		; 20 c5 99
B6_1997:		jmp $99bc		; 4c bc 99


B6_199a:		lda $f3			; a5 f3
B6_199c:		clc				; 18 
B6_199d:		adc #$01		; 69 01
B6_199f:		sta $b7			; 85 b7
B6_19a1:		jsr $9bd1		; 20 d1 9b
B6_19a4:		ldy wCurrLevel			; a4 71
B6_19a6:		ldx $b7			; a6 b7
B6_19a8:		clc				; 18 
B6_19a9:		lda $d274, x	; bd 74 d2
B6_19ac:		adc $d1db, y	; 79 db d1
B6_19af:		sta $b4			; 85 b4
B6_19b1:		ldx #$07		; a2 07
B6_19b3:		jsr $9b8e		; 20 8e 9b
B6_19b6:		lda $c0			; a5 c0
B6_19b8:		ora #$02		; 09 02
B6_19ba:		sta $c0			; 85 c0
B6_19bc:		jsr $9d34		; 20 34 9d
B6_19bf:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_19c2:		jmp $9977		; 4c 77 99


B6_19c5:		lda #$00		; a9 00
B6_19c7:		sta $b7			; 85 b7
B6_19c9:		jsr $9bd1		; 20 d1 9b
B6_19cc:		lda #$00		; a9 00
B6_19ce:		sta $b4			; 85 b4
B6_19d0:		ldx #$07		; a2 07
B6_19d2:		jsr $9b8e		; 20 8e 9b
B6_19d5:		lda $c0			; a5 c0
B6_19d7:		and #$fd		; 29 fd
B6_19d9:		sta $c0			; 85 c0
B6_19db:		rts				; 60 


B6_19dc:		jsr $99c5		; 20 c5 99
B6_19df:		jsr $9d34		; 20 34 9d
B6_19e2:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_19e5:		jmp $8f4d		; 4c 4d 8f


handleMagicInvScreen:
B6_19e8:		jsr $9ba2		; 20 a2 9b
B6_19eb:		lda #$03		; a9 03
B6_19ed:		jsr func_6_11cb		; 20 cb 91
B6_19f0:		jsr $9be2		; 20 e2 9b
B6_19f3:		jsr updateFromVramQueue		; 20 f2 c2
B6_19f6:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_19f9:		lda #$00		; a9 00
B6_19fb:		sta $b0			; 85 b0
B6_19fd:		sta $b1			; 85 b1
B6_19ff:		sta $b2			; 85 b2
B6_1a01:		lda $bf			; a5 bf
B6_1a03:		cmp #$09		; c9 09
B6_1a05:		bne B6_1a0a ; d0 03

B6_1a07:		jsr func_6_02a7		; 20 a7 82
B6_1a0a:		ldx #$07		; a2 07
B6_1a0c:		lda #$00		; a9 00
B6_1a0e:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_1a11:		dex				; ca 
B6_1a12:		bpl B6_1a0c ; 10 f8

B6_1a14:		jsr markMagicNotInUse		; 20 94 88
B6_1a17:		lda wMagicGlobalFlags0.w		; ad 05 06
B6_1a1a:		bne B6_1a24 ; d0 08

B6_1a1c:		lda wMagicGlobalFlags1.w		; ad 06 06
B6_1a1f:		bne B6_1a24 ; d0 03

B6_1a21:		jmp $9b37		; 4c 37 9b


B6_1a24:		jsr $9c11		; 20 11 9c
B6_1a27:		lda wMagicGlobalFlags0.w		; ad 05 06
B6_1a2a:		ldx #$00		; a2 00
B6_1a2c:		ldy #$00		; a0 00
B6_1a2e:		jsr func_6_1b69		; 20 69 9b
B6_1a31:		lda wMagicGlobalFlags1.w		; ad 06 06
B6_1a34:		ldx #$07		; a2 07
B6_1a36:		ldy #$00		; a0 00
B6_1a38:		jsr func_6_1b69		; 20 69 9b
B6_1a3b:		lda #$00		; a9 00
B6_1a3d:		sta $f2			; 85 f2
B6_1a3f:		ldy $b8			; a4 b8
B6_1a41:		beq B6_1a46 ; f0 03

B6_1a43:		dey				; 88 
B6_1a44:		sty $f3			; 84 f3
B6_1a46:		jsr $9b73		; 20 73 9b
B6_1a49:		lda wJoy1NewButtonsPressed			; a5 29
B6_1a4b:		and #$80		; 29 80
B6_1a4d:		bne B6_1ab3 ; d0 64

B6_1a4f:		ldy #$01		; a0 01
B6_1a51:		jsr $9c99		; 20 99 9c
B6_1a54:		lda wJoy1NewButtonsPressed			; a5 29
B6_1a56:		and #$40		; 29 40
B6_1a58:		bne B6_1aaa ; d0 50

B6_1a5a:		ldy #$00		; a0 00
B6_1a5c:		sty $b9			; 84 b9
B6_1a5e:		ldx $f3			; a6 f3
B6_1a60:		inx				; e8 
B6_1a61:		cpx #$08		; e0 08
B6_1a63:		bcc B6_1a6e ; 90 09

B6_1a65:		ldy #$01		; a0 01
B6_1a67:		inx				; e8 
B6_1a68:		txa				; 8a 
B6_1a69:		and #$0f		; 29 0f
B6_1a6b:		eor #$08		; 49 08
B6_1a6d:		tax				; aa 
B6_1a6e:		lda wMagicGlobalFlags0.w, y	; b9 05 06
B6_1a71:		lsr a			; 4a
B6_1a72:		dex				; ca 
B6_1a73:		bne B6_1a71 ; d0 fc

B6_1a75:		bcs B6_1a7d ; b0 06

B6_1a77:		jsr $9aa0		; 20 a0 9a
B6_1a7a:		jmp $9a97		; 4c 97 9a


B6_1a7d:		lda $f3			; a5 f3
B6_1a7f:		clc				; 18 
B6_1a80:		adc #$01		; 69 01
B6_1a82:		sta wEquippedMagic			; 85 b8
B6_1a84:		jsr $9be2		; 20 e2 9b
B6_1a87:		lda wEquippedMagic			; a5 b8
B6_1a89:		beq B6_1a97 ; f0 0c

B6_1a8b:		cmp #$08		; c9 08
B6_1a8d:		bcs B6_1a97 ; b0 08

B6_1a8f:		tax				; aa 
B6_1a90:		sec				; 38 
B6_1a91:		rol $b9			; 26 b9
B6_1a93:		clc				; 18 
B6_1a94:		dex				; ca 
B6_1a95:		bne B6_1a91 ; d0 fa

B6_1a97:		jsr $9d34		; 20 34 9d
B6_1a9a:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1a9d:		jmp $9a49		; 4c 49 9a


B6_1aa0:		lda #$00		; a9 00
B6_1aa2:		sta wEquippedMagic			; 85 b8
B6_1aa4:		sta $b9			; 85 b9
B6_1aa6:		jsr $9be2		; 20 e2 9b
B6_1aa9:		rts				; 60 


B6_1aaa:		jsr $9aa0		; 20 a0 9a
B6_1aad:		jsr $9d34		; 20 34 9d
B6_1ab0:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1ab3:		jmp $8f4d		; 4c 4d 8f


handleItemInvScreen:
B6_1ab6:		jsr $9ba2		; 20 a2 9b
B6_1ab9:		lda #$04		; a9 04
B6_1abb:		jsr func_6_11cb		; 20 cb 91
B6_1abe:		lda wItemGlobalFlags0.w		; ad 07 06
B6_1ac1:		bne B6_1ad3 ; d0 10

B6_1ac3:		lda wItemGlobalFlags1.w		; ad 08 06
B6_1ac6:		bne B6_1ad3 ; d0 0b

B6_1ac8:		ldy #$00		; a0 00
B6_1aca:		jsr $9bf3		; 20 f3 9b
B6_1acd:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1ad0:		jmp $9b37		; 4c 37 9b


B6_1ad3:		jsr $9c1a		; 20 1a 9c
B6_1ad6:		lda wItemGlobalFlags0.w		; ad 07 06
B6_1ad9:		ldx #$00		; a2 00
B6_1adb:		ldy #$00		; a0 00
B6_1add:		jsr func_6_1b69		; 20 69 9b
B6_1ae0:		lda wItemGlobalFlags1.w		; ad 08 06
B6_1ae3:		ldx #$08		; a2 08
B6_1ae5:		ldy #$00		; a0 00
B6_1ae7:		jsr func_6_1b69		; 20 69 9b
B6_1aea:		lda #$00		; a9 00
B6_1aec:		sta $f3			; 85 f3
B6_1aee:		sta $f2			; 85 f2
B6_1af0:		jsr $9b73		; 20 73 9b
B6_1af3:		lda wJoy1NewButtonsPressed			; a5 29
B6_1af5:		and #$80		; 29 80
B6_1af7:		bne B6_1b34 ; d0 3b

B6_1af9:		ldy #$01		; a0 01
B6_1afb:		jsr $9c99		; 20 99 9c
B6_1afe:		ldy #$00		; a0 00
B6_1b00:		lda $f3			; a5 f3
B6_1b02:		and #$08		; 29 08
B6_1b04:		beq B6_1b08 ; f0 02

B6_1b06:		ldy #$01		; a0 01
B6_1b08:		lda $f3			; a5 f3
B6_1b0a:		and #$b7		; 29 b7
B6_1b0c:		tax				; aa 
B6_1b0d:		inx				; e8 
B6_1b0e:		lda wItemGlobalFlags0.w, y	; b9 07 06
B6_1b11:		lsr a			; 4a
B6_1b12:		dex				; ca 
B6_1b13:		bne B6_1b11 ; d0 fc

B6_1b15:		bcc B6_1b26 ; 90 0f

B6_1b17:		lda $f3			; a5 f3
B6_1b19:		clc				; 18 
B6_1b1a:		adc #$01		; 69 01
B6_1b1c:		asl a			; 0a
B6_1b1d:		asl a			; 0a
B6_1b1e:		asl a			; 0a
B6_1b1f:		tay				; a8 
B6_1b20:		jsr $9bf3		; 20 f3 9b
B6_1b23:		jmp $9b2b		; 4c 2b 9b


B6_1b26:		ldy #$00		; a0 00
B6_1b28:		jsr $9bf3		; 20 f3 9b
B6_1b2b:		jsr $9d34		; 20 34 9d
B6_1b2e:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1b31:		jmp $9af3		; 4c f3 9a


B6_1b34:		jmp $8f4d		; 4c 4d 8f


B6_1b37:		jsr setPPUCtrl_addNMI_bgAt1000h		; 20 6e c1
B6_1b3a:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1b3d:		jsr setPPUMask_addShowAll		; 20 5d c1
B6_1b40:		lda wJoy1NewButtonsPressed			; a5 29
B6_1b42:		and #$c0		; 29 c0
B6_1b44:		bne B6_1b4c ; d0 06

B6_1b46:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1b49:		jmp $9b40		; 4c 40 9b


B6_1b4c:		jmp $8f4d		; 4c 4d 8f


B6_1b4f:		lda #$00		; a9 00
B6_1b51:		sta $d0			; 85 d0
B6_1b53:		lda #$02		; a9 02
B6_1b55:		jsr loadAllScreenRowsForRoomY1fhRoomXA		; 20 07 92
B6_1b58:		lda #$00		; a9 00
B6_1b5a:		jsr func_6_11cb		; 20 cb 91
B6_1b5d:		lda #$06		; a9 06
B6_1b5f:		jsr func_6_11cb		; 20 cb 91
B6_1b62:		jsr func_6_17a2		; 20 a2 97
B6_1b65:		jsr updateFromVramQueue		; 20 f2 c2
B6_1b68:		rts				; 60 


func_6_1b69:
B6_1b69:		sta $01			; 85 01 - global flags for swords
B6_1b6b:		stx $00			; 86 00 - offsets for sprite tiles
B6_1b6d:		sty $03			; 84 03 - to add to y offsets
B6_1b6f:		jsr func_6_1c54		; 20 54 9c
B6_1b72:		rts				; 60 


B6_1b73:		ldy #$00		; a0 00
B6_1b75:		lda $9d1c, y	; b9 1c 9d
B6_1b78:		cmp $f3			; c5 f3
B6_1b7a:		beq B6_1b7f ; f0 03

B6_1b7c:		iny				; c8 
B6_1b7d:		bne B6_1b75 ; d0 f6

B6_1b7f:		sty $f2			; 84 f2
B6_1b81:		jsr $9d34		; 20 34 9d
B6_1b84:		jsr setPPUCtrl_addNMI_bgAt1000h		; 20 6e c1
B6_1b87:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1b8a:		jsr setPPUMask_addShowAll		; 20 5d c1
B6_1b8d:		rts				; 60 


B6_1b8e:		stx $0a			; 86 0a
B6_1b90:		jsr func_7_364d		; 20 4d f6
B6_1b93:		lda #$80		; a9 80
B6_1b95:		sta $08			; 85 08
B6_1b97:		jsr func_6_1846		; 20 46 98
B6_1b9a:		lda #$00		; a9 00
B6_1b9c:		sta wVramQueue.w, x	; 9d 00 05
B6_1b9f:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B6_1ba1:		rts				; 60 


B6_1ba2:		lda #$00		; a9 00
B6_1ba4:		sta $d0			; 85 d0
B6_1ba6:		lda #$04		; a9 04
B6_1ba8:		jsr loadAllScreenRowsForRoomY1fhRoomXA		; 20 07 92
B6_1bab:		lda #$00		; a9 00
B6_1bad:		jsr func_6_11cb		; 20 cb 91
B6_1bb0:		lda #$07		; a9 07
B6_1bb2:		jsr func_6_11cb		; 20 cb 91
B6_1bb5:		jsr func_6_17a2		; 20 a2 97
B6_1bb8:		jsr updateFromVramQueue		; 20 f2 c2
B6_1bbb:		lda #$80		; a9 80
B6_1bbd:		sta $08			; 85 08
B6_1bbf:		rts				; 60 


B6_1bc0:		ldy #$00		; a0 00
B6_1bc2:		jsr $9c23		; 20 23 9c
B6_1bc5:		lda #$f2		; a9 f2
B6_1bc7:		sta $04			; 85 04
B6_1bc9:		lda #$92		; a9 92
B6_1bcb:		sta $05			; 85 05
B6_1bcd:		jsr $9c2b		; 20 2b 9c
B6_1bd0:		rts				; 60 


B6_1bd1:		ldy #$01		; a0 01
B6_1bd3:		jsr $9c23		; 20 23 9c
B6_1bd6:		lda #$3a		; a9 3a
B6_1bd8:		sta $04			; 85 04
B6_1bda:		lda #$93		; a9 93
B6_1bdc:		sta $05			; 85 05
B6_1bde:		jsr $9c2b		; 20 2b 9c
B6_1be1:		rts				; 60 


B6_1be2:		ldy #$02		; a0 02
B6_1be4:		jsr $9c23		; 20 23 9c
B6_1be7:		lda #$82		; a9 82
B6_1be9:		sta $04			; 85 04
B6_1beb:		lda #$93		; a9 93
B6_1bed:		sta $05			; 85 05
B6_1bef:		jsr $9c2b		; 20 2b 9c
B6_1bf2:		rts				; 60 


B6_1bf3:		lda #$02		; a9 02
B6_1bf5:		sta $04			; 85 04
B6_1bf7:		lda #$94		; a9 94
B6_1bf9:		sta $05			; 85 05
B6_1bfb:		jsr $9c2b		; 20 2b 9c
B6_1bfe:		rts				; 60 


B6_1bff:		lda #$82		; a9 82
B6_1c01:		sta $06			; 85 06
B6_1c03:		lda #$94		; a9 94
B6_1c05:		sta $07			; 85 07
B6_1c07:		rts				; 60 


B6_1c08:		lda #$ca		; a9 ca
B6_1c0a:		sta $06			; 85 06
B6_1c0c:		lda #$94		; a9 94
B6_1c0e:		sta $07			; 85 07
B6_1c10:		rts				; 60 


B6_1c11:		lda #$12		; a9 12
B6_1c13:		sta $06			; 85 06
B6_1c15:		lda #$95		; a9 95
B6_1c17:		sta $07			; 85 07
B6_1c19:		rts				; 60 


B6_1c1a:		lda #$92		; a9 92
B6_1c1c:		sta $06			; 85 06
B6_1c1e:		lda #$95		; a9 95
B6_1c20:		sta $07			; 85 07
B6_1c22:		rts				; 60 


B6_1c23:	.db $b9 $b6 $00
B6_1c26:		asl a			; 0a
B6_1c27:		asl a			; 0a
B6_1c28:		asl a			; 0a
B6_1c29:		tay				; a8 
B6_1c2a:		rts				; 60 


B6_1c2b:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B6_1c2d:		lda #$20		; a9 20
B6_1c2f:		sta wVramQueue.w, x	; 9d 00 05
B6_1c32:		inx				; e8 
B6_1c33:		lda #$c4		; a9 c4
B6_1c35:		sta wVramQueue.w, x	; 9d 00 05
B6_1c38:		inx				; e8 
B6_1c39:		lda #$08		; a9 08
B6_1c3b:		sta wVramQueue.w, x	; 9d 00 05
B6_1c3e:		sta $02			; 85 02
B6_1c40:		inx				; e8 
B6_1c41:		lda ($04), y	; b1 04
B6_1c43:		sta wVramQueue.w, x	; 9d 00 05
B6_1c46:		inx				; e8 
B6_1c47:		iny				; c8 
B6_1c48:		dec $02			; c6 02
B6_1c4a:		bne B6_1c41 ; d0 f5

B6_1c4c:		lda #$00		; a9 00
B6_1c4e:		sta wVramQueue.w, x	; 9d 00 05
B6_1c51:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B6_1c53:		rts				; 60 


func_6_1c54:
; 8 swords
B6_1c54:		lda #$08		; a9 08
B6_1c56:		sta $02			; 85 02

B6_1c58:		inc $00			; e6 00
; skip if a bit on $01 is not set (global flag not set)
B6_1c5a:		lsr $01			; 46 01
B6_1c5c:		bcc B6_1c74 ; 90 16
; 8 bytes per sword (4 tiles and attrs)
B6_1c5e:		lda $00			; a5 00
B6_1c60:		tax				; aa 
B6_1c61:		asl a			; 0a
B6_1c62:		asl a			; 0a
B6_1c63:		asl a			; 0a
B6_1c64:		tay				; a8 
; y offset
B6_1c65:		lda $9c79, x	; bd 79 9c
B6_1c68:		pha				; 48
; x offset 
B6_1c69:		lda $9c89, x	; bd 89 9c
B6_1c6c:		tax				; aa 
B6_1c6d:		pla				; 68 
B6_1c6e:		clc				; 18 
B6_1c6f:		adc $03			; 65 03
; A - y, X - x, Y - sprite tiles offset
B6_1c71:		jsr func_6_1160		; 20 60 91
B6_1c74:		dec $02			; c6 02
B6_1c76:		bne B6_1c58 ; d0 e0

B6_1c78:		rts				; 60 


B6_1c79:		.db $00				; 00
B6_1c7a:		bit $24			; 24 24
B6_1c7c:		bit $44			; 24 44
B6_1c7e:	.db $44
B6_1c7f:	.db $44
B6_1c80:	.db $64
B6_1c81:	.db $64
B6_1c82:	.db $64
B6_1c83:		sty $84			; 84 84
B6_1c85:		sty $a4			; 84 a4
B6_1c87:		ldy $a4			; a4 a4

B6_1c89:		.db $00				; 00
B6_1c8a:		sty $ccac		; 8c ac cc
B6_1c8d:		sty $ccac		; 8c ac cc
B6_1c90:		sty $ccac		; 8c ac cc
B6_1c93:		sty $ccac		; 8c ac cc
B6_1c96:		sty $ccac		; 8c ac cc
B6_1c99:		lda wJoy1ButtonsPressed			; a5 27
B6_1c9b:		and #$0f		; 29 0f
B6_1c9d:		bne B6_1ca4 ; d0 05

B6_1c9f:		lda #$e0		; a9 e0
B6_1ca1:		sta $f1			; 85 f1
B6_1ca3:		rts				; 60 


B6_1ca4:		lda $f1			; a5 f1
B6_1ca6:		clc				; 18 
B6_1ca7:		adc #$10		; 69 10
B6_1ca9:		sta $f1			; 85 f1
B6_1cab:		beq B6_1cae ; f0 01

B6_1cad:		rts				; 60 


B6_1cae:		lda wJoy1ButtonsPressed			; a5 27
B6_1cb0:		and #$0c		; 29 0c
B6_1cb2:		beq B6_1cdc ; f0 28

B6_1cb4:		eor #$0c		; 49 0c
B6_1cb6:		asl a			; 0a
B6_1cb7:		sec				; 38 
B6_1cb8:		sbc #$0c		; e9 0c
B6_1cba:		clc				; 18 
B6_1cbb:		adc $f2			; 65 f2
B6_1cbd:		bpl B6_1cc7 ; 10 08

B6_1cbf:		and #$0f		; 29 0f
B6_1cc1:		clc				; 18 
B6_1cc2:		adc $9d18, y	; 79 18 9d
B6_1cc5:		bne B6_1cce ; d0 07

B6_1cc7:		cmp $9d1a, y	; d9 1a 9d
B6_1cca:		bcc B6_1cce ; 90 02

B6_1ccc:		and #$03		; 29 03
B6_1cce:		sta $f2			; 85 f2
B6_1cd0:		tay				; a8 
B6_1cd1:		lda $9d1c, y	; b9 1c 9d
B6_1cd4:		sta $f3			; 85 f3
B6_1cd6:		lda #$27		; a9 27
B6_1cd8:		jsr queueSoundAtoPlay		; 20 ad c4
B6_1cdb:		rts				; 60 


B6_1cdc:		lda wJoy1ButtonsPressed			; a5 27
B6_1cde:		and #$03		; 29 03
B6_1ce0:		beq B6_1d11 ; f0 2f

B6_1ce2:		eor #$03		; 49 03
B6_1ce4:		asl a			; 0a
B6_1ce5:		sec				; 38 
B6_1ce6:		sbc #$03		; e9 03
B6_1ce8:		php				; 08 
B6_1ce9:		clc				; 18 
B6_1cea:		adc $f2			; 65 f2
B6_1cec:		sta $f2			; 85 f2
B6_1cee:		and #$03		; 29 03
B6_1cf0:		cmp #$03		; c9 03
B6_1cf2:		bne B6_1d12 ; d0 1e

B6_1cf4:		plp				; 28 
B6_1cf5:		bmi B6_1cff ; 30 08

B6_1cf7:		lda $f2			; a5 f2
B6_1cf9:		sec				; 38 
B6_1cfa:		sbc #$03		; e9 03
B6_1cfc:		jmp $9d04		; 4c 04 9d


B6_1cff:		lda $f2			; a5 f2
B6_1d01:		clc				; 18 
B6_1d02:		adc #$03		; 69 03
B6_1d04:		sta $f2			; 85 f2
B6_1d06:		tay				; a8 
B6_1d07:		lda $9d1c, y	; b9 1c 9d
B6_1d0a:		sta $f3			; 85 f3
B6_1d0c:		lda #$27		; a9 27
B6_1d0e:		jsr queueSoundAtoPlay		; 20 ad c4
B6_1d11:		rts				; 60 


B6_1d12:		plp				; 28 
B6_1d13:		lda $f2			; a5 f2
B6_1d15:		jmp $9d04		; 4c 04 9d


B6_1d18:		.db $00				; 00
B6_1d19:	.db $04
B6_1d1a:	.db $0f
B6_1d1b:	.db $13
B6_1d1c:		.db $00				; 00
B6_1d1d:		ora ($02, x)	; 01 02
B6_1d1f:	.db $ff
B6_1d20:	.db $03
B6_1d21:	.db $04
B6_1d22:		ora $ff			; 05 ff
B6_1d24:		asl $07			; 06 07
B6_1d26:		php				; 08 
B6_1d27:	.db $ff
B6_1d28:		ora #$0a		; 09 0a
B6_1d2a:	.db $0b
B6_1d2b:	.db $ff
B6_1d2c:	.db $0c
B6_1d2d:		ora $ff0e		; 0d 0e ff
B6_1d30:		;removed
	.db $10 $11

B6_1d32:	.db $12
B6_1d33:	.db $ff
B6_1d34:		ldx #$f0		; a2 f0
B6_1d36:		ldy $f3			; a4 f3
B6_1d38:		lda wMajorNMIUpdatesCounter			; a5 23
B6_1d3a:		and #$08		; 29 08
B6_1d3c:		beq B6_1d79 ; f0 3b

B6_1d3e:		lda $9c7a, y	; b9 7a 9c
B6_1d41:		sec				; 38 
B6_1d42:		sbc #$04		; e9 04
B6_1d44:		sta $01			; 85 01
B6_1d46:		lda $9c8a, y	; b9 8a 9c
B6_1d49:		sec				; 38 
B6_1d4a:		sbc #$04		; e9 04
B6_1d4c:		sta $02			; 85 02
B6_1d4e:		ldy #$00		; a0 00
B6_1d50:		lda $01			; a5 01
B6_1d52:		clc				; 18 
B6_1d53:		adc $9d88, y	; 79 88 9d
B6_1d56:		adc $03			; 65 03
B6_1d58:		sta wOam.Y.w, x	; 9d 00 02
B6_1d5b:		lda $02			; a5 02
B6_1d5d:		clc				; 18 
B6_1d5e:		adc $9d8c, y	; 79 8c 9d
B6_1d61:		sta wOam.X.w, x	; 9d 03 02
B6_1d64:		lda $9d90, y	; b9 90 9d
B6_1d67:		sta wOam.attr.w, x	; 9d 02 02
B6_1d6a:		lda #$81		; a9 81
B6_1d6c:		sta wOam.tile.w, x	; 9d 01 02
B6_1d6f:		inx				; e8 
B6_1d70:		inx				; e8 
B6_1d71:		inx				; e8 
B6_1d72:		inx				; e8 
B6_1d73:		iny				; c8 
B6_1d74:		cpy #$04		; c0 04
B6_1d76:		bne B6_1d50 ; d0 d8

B6_1d78:		rts				; 60 


B6_1d79:		lda #$f8		; a9 f8
B6_1d7b:		sta wOam.Y.w, x	; 9d 00 02
B6_1d7e:		sta $0204, x	; 9d 04 02
B6_1d81:		sta $0208, x	; 9d 08 02
B6_1d84:		sta $020c, x	; 9d 0c 02
B6_1d87:		rts				; 60 


B6_1d88:		.db $00				; 00
B6_1d89:		.db $00				; 00
B6_1d8a:		;removed
	.db $10 $10

B6_1d8c:		.db $00				; 00
B6_1d8d:		bpl B6_1d8f ; 10 00

B6_1d8f:		;removed
	.db $10 $01

B6_1d91:		eor ($81, x)	; 41 81
B6_1d93:		.db $c1


processDebugFlagPressingBOn2ndCtrler:
	lda #GF_CAN_WARP
	jsr checkGlobalFlag
	beq @done

; jump if pressing B on 2nd joypad while being able to warp
	lda wJoy2ButtonsPressed
	and #PADF_B
	bne +

	rts

+
; give all items
	lda #$ff
	sta wSwordGlobalFlags.w
	sta wShieldGlobalFlags.w
	sta wItemGlobalFlags0.w

	lda #$7f
	sta wMagicGlobalFlags0.w
	sta wItemGlobalFlags1.w

	lda #$1f
	sta wMagicGlobalFlags1.w

; 90000 exp
	lda #$09
	sta wCurrExpDigits

; all warp locs
	lda #$e0
	sta wStoryGlobalFlags0.w
	lda #$07
	sta wStoryGlobalFlags1.w

@done:
	rts


roomTransitionUpdateChrPalMus2EntityBytes:
	jsr loadBGChrBankPalettesAndMusicForRoom
	jsr updatePalettesFromRoomTransitions
B6_1dcf:		jsr func_6_1e27		; 20 27 9e
	jsr loadRoom2EntityBytes
	jsr setSprPalAndChr_updateCurrScreensSprPalettes
	rts


loadBGChrBankPalettesAndMusicForRoom:
B6_1dd9:		ldx #$00		; a2 00
B6_1ddb:		ldy #$00		; a0 00

B6_1ddd:		lda roomAreaTransitionYXs.w, x	; bd 66 9e
B6_1de0:		bmi B6_1df2 ; @done

B6_1de2:		cmp wRoomY			; c5 43
B6_1de4:		bne B6_1ded ; d0 07

B6_1de6:		lda roomAreaTransitionYXs.w+1, x	; bd 67 9e
B6_1de9:		cmp wRoomX			; c5 42
B6_1deb:		beq B6_1df3 ; f0 06

B6_1ded:		iny				; c8 
B6_1dee:		inx				; e8 
B6_1def:		inx				; e8 
B6_1df0:		bne B6_1ddd ; d0 eb

B6_1df2:		rts				; 60 

; y is now non-double-idx
; y idx into here * 3 into x
B6_1df3:		lda roomAreaTransition_chrPalMusIdxes.w, y	; b9 bd 9e
B6_1df6:		asl a			; 0a
B6_1df7:		clc				; 18 
B6_1df8:		adc roomAreaTransition_chrPalMusIdxes.w, y	; 79 bd 9e
B6_1dfb:		tax				; aa 

; into $53 later into chr bank 1 (bg tiles)
B6_1dfc:		lda chrPalMusData.w, x	; bd e9 9e
B6_1dff:		sta wBGChrBank			; 85 53

; related to sound to play
B6_1e01:		lda chrPalMusData.w+2, x	; bd eb 9e
B6_1e04:		bmi B6_1e1b ; 30 15

B6_1e06:		cmp $d7			; c5 d7
B6_1e08:		beq B6_1e1b ; f0 11

B6_1e0a:		sta $d5			; 85 d5
B6_1e0c:		lda $d7			; a5 d7
B6_1e0e:		cmp #$09		; c9 09
B6_1e10:		beq B6_1e1b ; f0 09

B6_1e12:		lda #$fd		; a9 fd
B6_1e14:		jsr queueSoundAtoPlay		; 20 ad c4
B6_1e17:		lda #$80		; a9 80
B6_1e19:		sta $d6			; 85 d6

; related to internal palette spec
B6_1e1b:		lda chrPalMusData.w+1, x	; bd ea 9e
B6_1e1e:		jsr updateSavedInternalPalettesFromSpecA		; 20 b0 c6

B6_1e21:		lda wBGChrBank			; a5 53
B6_1e23:		jsr set_wChrBank1		; 20 db c1
B6_1e26:		rts				; 60 


func_6_1e27:
; 1st byte is $ff, so always jump
B6_1e27:		ldx #$00		; a2 00
B6_1e29:		lda data_6_1f73.w, x	; bd 73 9f
B6_1e2c:		bmi B6_1e3d ; 30 0f

B6_1e2e:		cmp wRoomY			; c5 43
B6_1e30:		bne B6_1e39 ; d0 07

B6_1e32:		lda $9f74, x	; bd 74 9f
B6_1e35:		cmp wRoomX			; c5 42
B6_1e37:		beq B6_1e40 ; f0 07

B6_1e39:		inx				; e8 
B6_1e3a:		inx				; e8 
B6_1e3b:		bne B6_1e29 ; d0 ec

; store $ff here
B6_1e3d:		sta $54			; 85 54
B6_1e3f:		rts				; 60 

B6_1e40:		txa				; 8a 
B6_1e41:		lsr a			; 4a
B6_1e42:		sta $54			; 85 54
B6_1e44:		rts				; 60 


updatePalettesFromRoomTransitions:
B6_1e45:		ldy #$00		; a0 00
B6_1e47:		ldx #$00		; a2 00
-	lda roomTransitionBGChangeRooms.w, x	; bd 74 9f
B6_1e4c:		bmi B6_1e5e ; 30 10

B6_1e4e:		cmp wRoomY			; c5 43
B6_1e50:		bne B6_1e59 ; d0 07

B6_1e52:		lda roomTransitionBGChangeRooms.w+1, x	; bd 75 9f
B6_1e55:		cmp wRoomX			; c5 42
B6_1e57:		beq B6_1e5f ; f0 06

B6_1e59:		iny				; c8 
B6_1e5a:		inx				; e8 
B6_1e5b:		inx				; e8 
	bne -

B6_1e5e:		rts				; 60 

B6_1e5f:		lda roomTransitionBGPalettes.w, y	; b9 85 9f
B6_1e62:		jsr updateSavedInternalPalettesFromSpecA		; 20 b0 c6
B6_1e65:		rts				; 60 


; room y - room x to compare
roomAreaTransitionYXs:
	.db $08 $03
	.db $0a $03
	.db $00 $18
	.db $02 $18 ; 03
	.db $09 $17
	.db $09 $19
	.db $09 $1b
	.db $0a $1a
	.db $0a $1c
	.db $1a $0e ; 09
	.db $18 $0e
	.db $13 $0c
	.db $13 $0f ; 0c
	.db $14 $0f
	.db $15 $0b
	.db $15 $10
	.db $11 $0c
	.db $11 $0f
	.db $12 $0b
	.db $12 $0d
	.db $12 $0e
	.db $14 $11
	.db $15 $09
	.db $16 $0a
	.db $0a $18
	.db $0b $19
	.db $0f $19 ; 1a
	.db $10 $18
	.db $0a $09 ; 1c
	.db $0a $07
	.db $09 $0a
	.db $0c $10
	.db $0c $0e
	.db $0c $12
	.db $0a $10
	.db $0a $0f
	.db $13 $03 ; 24
	.db $14 $02
	.db $14 $04
	.db $13 $05
	.db $11 $03
	.db $12 $04
	.db $1e $1c
	.db $ff


roomAreaTransition_chrPalMusIdxes:
	.db $01
	.db $00
	.db $02
	.db $06 ; 03
	.db $03
	.db $03
	.db $03
	.db $07
	.db $07
	.db $04 ; 09
	.db $00
	.db $1a
	.db $1a ; 0c
	.db $1a
	.db $1a
	.db $1a
	.db $00
	.db $00
	.db $00
	.db $00
	.db $00
	.db $00
	.db $00
	.db $00
	.db $05
	.db $05
	.db $05 ; 1a
	.db $07
	.db $2c ; 1c
	.db $08
	.db $08
	.db $2a
	.db $00
	.db $00
	.db $00
	.db $00
	.db $2b ; 24
	.db $1b
	.db $1b
	.db $1b
	.db $1b
	.db $1b
	.db $2d
	.db $ff


chrPalMusData:
	.db $00 $00 $00
	.db $03 $01 $03
	.db $03 $02 $02
	.db $03 $03 $14
	.db $04 $04 $04 ; 04
	.db $05 $0d $04 ; 05
	.db $00 $07 $00 ; 06
	.db $00 $0c $00
	.db $00 $0b $00
	.db $10 $0f $01
	.db $06 $20 $03
	.db $06 $21 $03
	.db $06 $22 $03
	.db $06 $23 $03
	.db $06 $24 $03
	.db $06 $25 $03
	.db $06 $26 $03
	.db $06 $27 $03
	.db $06 $28 $03
	.db $06 $29 $03
	.db $10 $0e $01
	.db $10 $2a $01
	.db $10 $2b $01
	.db $10 $2c $01
	.db $10 $2d $01
	.db $10 $2e $01
	.db $04 $2f $04 ; 1a
	.db $00 $06 $00
	.db $07 $02 $02
	.db $07 $03 $14
	.db $03 $68 $14
	.db $06 $64 $13
	.db $0f $65 $02
	.db $07 $66 $14
	.db $10 $0f $02
	.db $0f $62 $13
	.db $0f $62 $0f
	.db $0f $61 $02
	.db $07 $70 $14
	.db $07 $71 $14
	.db $0f $62 $02
	.db $00 $5d $00
	.db $05 $72 $00
	.db $04 $5e $00 ; 2b
	.db $04 $5f $00 ; 2c
	.db $0f $95 $0f


data_6_1f73:
	.db $ff

roomTransitionBGChangeRooms:
	.db $17 $04
	.db $17 $06
	.db $07 $10
	.db $08 $10
	.db $06 $1b
	.db $07 $1b
	.db $07 $1c
	.db $08 $1c
	.db $ff

roomTransitionBGPalettes:
	.db $06
	.db $00
	.db $07
	.db $00
	.db $0a
	.db $09
	.db $08
	.db $0c


func_6_1f8d:
B6_1f8d:		lda #$25		; a9 25
B6_1f8f:		jsr queueSoundAtoPlay		; 20 ad c4
B6_1f92:		ldy #$10		; a0 10
B6_1f94:		jsr palettesSprFadeOut		; 20 1b c6
B6_1f97:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B6_1f99:		sta $2e			; 85 2e
B6_1f9b:		ldy #$04		; a0 04
B6_1f9d:		jsr palettesBGFadeOut		; 20 0e c6

func_6_1fa0:
B6_1fa0:		jsr func_6_2020		; 20 20 a0
B6_1fa3:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_1fa6:		bit $6c			; 24 6c
B6_1fa8:		bmi B6_1fbc ; 30 12

B6_1faa:		jsr updateMagicEntities		; 20 2e c4
B6_1fad:		jsr updateScreenEntities		; 20 23 c4
B6_1fb0:		jsr drawEntities		; 20 03 c4
B6_1fb3:		jsr drawPlayer		; 20 dd c3
B6_1fb6:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_1fb9:		jmp $9fa6		; 4c a6 9f

B6_1fbc:		bit $68			; 24 68
B6_1fbe:		bpl B6_1fc6 ; 10 06

B6_1fc0:		lda wJoy1NewButtonsPressed			; a5 29
B6_1fc2:		and #PADF_A|PADF_B		; 29 c0
B6_1fc4:		bne B6_1fd8 ; d0 12

B6_1fc6:		jsr func_6_27b5		; 20 b5 a7
B6_1fc9:		jsr updateScreenEntities		; 20 23 c4
B6_1fcc:		jsr drawEntities		; 20 03 c4
B6_1fcf:		jsr drawPlayer		; 20 dd c3
B6_1fd2:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_1fd5:		jmp $9fbc		; 4c bc 9f

B6_1fd8:		lda $6c			; a5 6c
B6_1fda:		ora #$40		; 09 40
B6_1fdc:		sta $6c			; 85 6c
B6_1fde:		lda $6c			; a5 6c
B6_1fe0:		and #$20		; 29 20
B6_1fe2:		bne B6_1ff6 ; d0 12

B6_1fe4:		jsr updateMagicEntities		; 20 2e c4
B6_1fe7:		jsr updateScreenEntities		; 20 23 c4
B6_1fea:		jsr drawEntities		; 20 03 c4
B6_1fed:		jsr drawPlayer		; 20 dd c3
B6_1ff0:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_1ff3:		jmp $9fde		; 4c de 9f


B6_1ff6:		lda #$1e		; a9 1e
B6_1ff8:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B6_1ffb:		sec				; 38 
B6_1ffc:		ror $5d			; 66 5d
B6_1ffe:		ldy #$04		; a0 04
B6_2000:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B6_2003:		lda $d7			; a5 d7
B6_2005:		jsr queueSoundAtoPlay		; 20 ad c4
B6_2008:		jsr $8f97		; 20 97 8f
B6_200b:		lda #$00		; a9 00
B6_200d:		sta $6c			; 85 6c
B6_200f:		sta $56			; 85 56
B6_2011:		lda #$f8		; a9 f8
B6_2013:		sta $0200		; 8d 00 02
B6_2016:		lda $c0			; a5 c0
B6_2018:		and #$ef		; 29 ef
B6_201a:		sta $c0			; 85 c0
B6_201c:		jsr $a1be		; 20 be a1
B6_201f:		rts				; 60 


func_6_2020:
B6_2020:		lda $c0			; a5 c0
B6_2022:		ora #$10		; 09 10
B6_2024:		sta $c0			; 85 c0
B6_2026:		lda #$ff		; a9 ff
B6_2028:		jsr queueSoundAtoPlay		; 20 ad c4
B6_202b:		jsr setPPUMask_noSprites		; 20 53 c1
B6_202e:		jsr func_6_22bf		; 20 bf a2
B6_2031:		jsr $a1ae		; 20 ae a1
B6_2034:		jsr drawEntities		; 20 03 c4
B6_2037:		jsr drawPlayer		; 20 dd c3
B6_203a:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_203d:		jsr setPPUCtrl_noNMI		; 20 64 c1
B6_2040:		jsr func_6_211c		; 20 1c a1
B6_2043:		jsr func_6_20e5		; 20 e5 a0
B6_2046:		lda $f0			; a5 f0
B6_2048:		and #$0f		; 29 0f
B6_204a:		clc				; 18 
B6_204b:		adc #$08		; 69 08
B6_204d:		jsr set_wChrBank1		; 20 db c1
B6_2050:		lda $f0			; a5 f0
B6_2052:		and #$30		; 29 30
B6_2054:		lsr a			; 4a
B6_2055:		lsr a			; 4a
B6_2056:		lsr a			; 4a
B6_2057:		lsr a			; 4a
B6_2058:		clc				; 18 
B6_2059:		adc #$1c		; 69 1c
B6_205b:		jsr set_wChrBank0		; 20 c2 c1
B6_205e:		jsr $a202		; 20 02 a2
B6_2061:		jsr func_7_11b6		; 20 b6 d1
B6_2064:		jsr setPPUCtrl_addNMI_bgAt1000h		; 20 6e c1
B6_2067:		jsr $a187		; 20 87 a1
B6_206a:		jsr $a0b7		; 20 b7 a0
B6_206d:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_2070:		jsr func_7_3000		; 20 00 f0
B6_2073:		jsr setPPUMask_addShowAll		; 20 5d c1
B6_2076:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_2079:		ldy #$04		; a0 04
B6_207b:		lda wInternalPalettesSpecIdx			; a5 2e
B6_207d:		jsr paletteSpecAFadeIn		; 20 2e c6
B6_2080:		lda $6e			; a5 6e
B6_2082:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_2085:		lda #$1e		; a9 1e
B6_2087:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B6_208a:		ldx #$00		; a2 00
B6_208c:		lda $bf			; a5 bf
B6_208e:		cmp #$08		; c9 08
B6_2090:		bcc B6_2098 ; 90 06

B6_2092:		clc				; 18 
B6_2093:		adc #$1a		; 69 1a
B6_2095:		jmp $a09e		; 4c 9e a0


B6_2098:		lda $c0			; a5 c0
B6_209a:		and #$03		; 29 03
B6_209c:		ora #$04		; 09 04
B6_209e:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_20a1:		lda #$78		; a9 78
B6_20a3:		sta wEntitiesY.w		; 8d 80 04
B6_20a6:		lda #$d8		; a9 d8
B6_20a8:		sta wEntitiesX.w		; 8d b0 04
B6_20ab:		lda #$b8		; a9 b8
B6_20ad:		sta wEntities_408.w		; 8d 08 04
B6_20b0:		lda #$00		; a9 00
B6_20b2:		sta $68			; 85 68
B6_20b4:		sta $6c			; 85 6c
B6_20b6:		rts				; 60 


B6_20b7:		ldx #$00		; a2 00
B6_20b9:		lda $a0d2, x	; bd d2 a0
B6_20bc:		cmp #$ff		; c9 ff
B6_20be:		beq B6_20c7 ; f0 07

B6_20c0:		cmp $60			; c5 60
B6_20c2:		beq B6_20cb ; f0 07

B6_20c4:		inx				; e8 
B6_20c5:		bne B6_20b9 ; d0 f2

B6_20c7:		lda #$05		; a9 05
B6_20c9:		bne B6_20ce ; d0 03

B6_20cb:		lda $a0dc, x	; bd dc a0
B6_20ce:		jsr queueSoundAtoPlay		; 20 ad c4
B6_20d1:		rts				; 60 


B6_20d2:		and ($22, x)	; 21 22
B6_20d4:	.db $23
B6_20d5:		bit $36			; 24 36
B6_20d7:		and $4c4b, x	; 3d 4b 4c
B6_20da:	.db $54
B6_20db:	.db $ff
B6_20dc:		asl $0e0e		; 0e 0e 0e
B6_20df:		asl $0612		; 0e 12 06
B6_20e2:	.db $ff
B6_20e3:	.db $ff
B6_20e4:		.db $0e


func_6_20e5:
	lda #$1d
B6_20e7:		sta $0d			; 85 0d
B6_20e9:		ldx $60			; a6 60
B6_20eb:		lda $a42d, x	; bd 2d a4
B6_20ee:		tax				; aa 
B6_20ef:		and #$20		; 29 20
B6_20f1:		beq B6_20f5 ; f0 02

B6_20f3:		inc $0d			; e6 0d
B6_20f5:		txa				; 8a 
B6_20f6:		and #$1f		; 29 1f
B6_20f8:		sta $0f			; 85 0f
B6_20fa:		jsr $a1a2		; 20 a2 a1
B6_20fd:		jsr loadAllScreenRowsForSpecifiedRoom		; 20 fb de
B6_2100:		jsr $a1dc		; 20 dc a1
B6_2103:		lda #<$a6f3		; a9 f3
B6_2105:		sta wRLEStructAddressToCopy			; 85 33
B6_2107:		lda #>$a6f3		; a9 a6
B6_2109:		sta wRLEStructAddressToCopy+1			; 85 34
B6_210b:		lda $0f			; a5 0f
B6_210d:		lsr a			; 4a
B6_210e:		bcc B6_2118 ; 90 08

B6_2110:		lda #$54		; a9 54
B6_2112:		sta wRLEStructAddressToCopy			; 85 33
B6_2114:		lda #$a7		; a9 a7
B6_2116:		sta wRLEStructAddressToCopy+1			; 85 34
B6_2118:		jsr updateFromRLEStruct		; 20 2f c3
B6_211b:		rts				; 60 


; deals with loading inner rooms
func_6_211c:
B6_211c:		bit $56			; 24 56
B6_211e:		bpl B6_2126 ; 10 06

; 6:2315
B6_2120:		ldy #$21		; a0 21
B6_2122:		ldx #$42		; a2 42
B6_2124:		bne B6_212a ; d0 04

B6_2126:		ldy #$00		; a0 00
B6_2128:		ldx #$00		; a2 00
B6_212a:		lda npcLocationsData.w, x	; bd d3 a2
B6_212d:		bmi B6_213f ; 30 10

B6_212f:		cmp wRoomY			; c5 43
B6_2131:		bne B6_213a ; d0 07

B6_2133:		lda npcLocationsData.w+1, x	; bd d4 a2
B6_2136:		cmp wRoomX			; c5 42
B6_2138:		beq B6_2140 ; f0 06

B6_213a:		iny				; c8 
B6_213b:		inx				; e8 
B6_213c:		inx				; e8 
B6_213d:		bne B6_212a ; d0 eb

B6_213f:		rts				; 60 

B6_2140:		sty $60			; 84 60
B6_2142:		lda data_6_2380.w, y	; b9 80 a3
B6_2145:		sta $f0			; 85 f0
B6_2147:		lda data_6_23d7.w, y	; b9 d7 a3
B6_214a:		sta $2e			; 85 2e
B6_214c:		lda $bf			; a5 bf
B6_214e:		cmp #$09		; c9 09
B6_2150:		bne B6_2157 ; d0 05

B6_2152:		lda #$5d		; a9 5d
B6_2154:		sta $6b			; 85 6b
B6_2156:		rts				; 60 

; script address?
B6_2157:		lda npcScriptsData.w, x	; bd 83 a4
B6_215a:		sta $00			; 85 00
B6_215c:		lda npcScriptsData.w+1, x	; bd 84 a4
B6_215f:		sta $01			; 85 01
B6_2161:		lda #$00		; a9 00
; 2 is counter into script bytes
B6_2163:		sta $02			; 85 02
B6_2165:		ldy $02			; a4 02
B6_2167:		lda ($00), y	; b1 00
B6_2169:		beq B6_217e ; f0 13
; 1st byte in 03 (num global flags to check), get next byte
; 1st global flag to be set determines 6b
; otherwise last value is 6b
B6_216b:		sta $03			; 85 03
B6_216d:		inc $02			; e6 02
B6_216f:		ldy $02			; a4 02
B6_2171:		lda ($00), y	; b1 00
B6_2173:		jsr checkGlobalFlag		; 20 6c c4
B6_2176:		bne B6_217e ; d0 06

B6_2178:		inc $02			; e6 02
B6_217a:		dec $03			; c6 03
B6_217c:		bne B6_216d ; d0 ef
; $6b is next byte read
B6_217e:		inc $02			; e6 02
B6_2180:		ldy $02			; a4 02
B6_2182:		lda ($00), y	; b1 00
B6_2184:		sta $6b			; 85 6b
B6_2186:		rts				; 60 


B6_2187:		ldx #$00		; a2 00
B6_2189:		lda data_6_219f.w, x	; bd 9f a1
B6_218c:		cmp #$ff		; c9 ff
B6_218e:		beq B6_2186 ; f0 f6

B6_2190:		cmp $60			; c5 60
B6_2192:		beq B6_2197 ; f0 03

B6_2194:		inx				; e8 
B6_2195:		bne B6_2189 ; d0 f2

B6_2197:		txa				; 8a 
B6_2198:		jsr jumpTable		; 20 3d c2
	.dw $b11e
	.dw $b185
	
data_6_219f:
	.db $1c $4f $ff
	

B6_21a2:		lda wPPUCtrl			; a5 20
B6_21a4:		lsr a			; 4a
B6_21a5:		pha				; 48 
B6_21a6:		lda $0f			; a5 0f
B6_21a8:		lsr a			; 4a
B6_21a9:		pla				; 68 
B6_21aa:		rol a			; 2a
B6_21ab:		sta wPPUCtrl			; 85 20
B6_21ad:		rts				; 60 


B6_21ae:		ldx #$17		; a2 17
B6_21b0:		lda wEntitiesControlByte.w, x	; bd 00 03
B6_21b3:		bpl B6_21ba ; 10 05

B6_21b5:		ora #$10		; 09 10
B6_21b7:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_21ba:		dex				; ca 
B6_21bb:		bpl B6_21b0 ; 10 f3

B6_21bd:		rts				; 60 


B6_21be:		ldx #$17		; a2 17
B6_21c0:		lda wEntitiesControlByte.w, x	; bd 00 03
B6_21c3:		bpl B6_21d0 ; 10 0b

B6_21c5:		pha				; 48 
B6_21c6:		and #$10		; 29 10
B6_21c8:		beq B6_21d4 ; f0 0a

B6_21ca:		pla				; 68 
B6_21cb:		and #$ef		; 29 ef
B6_21cd:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_21d0:		dex				; ca 
B6_21d1:		bpl B6_21c0 ; 10 ed

B6_21d3:		rts				; 60 


B6_21d4:		pla				; 68 
B6_21d5:		lda #$00		; a9 00
B6_21d7:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_21da:		beq B6_21d0 ; f0 f4

B6_21dc:		lda PPUSTATUS.w		; ad 02 20
B6_21df:		ldx #$22		; a2 22
B6_21e1:		lda wPPUCtrl			; a5 20
B6_21e3:		lsr a			; 4a
B6_21e4:		bcc B6_21e8 ; 90 02

B6_21e6:		ldx #$26		; a2 26
B6_21e8:		stx PPUADDR.w		; 8e 06 20
B6_21eb:		lda #$80		; a9 80
B6_21ed:		sta PPUADDR.w		; 8d 06 20
B6_21f0:		ldx #$00		; a2 00
B6_21f2:		ldy #$02		; a0 02
B6_21f4:		lda #$20		; a9 20
B6_21f6:		sta PPUDATA.w		; 8d 07 20
B6_21f9:		inx				; e8 
B6_21fa:		cpx #$40		; e0 40
B6_21fc:		bne B6_21f4 ; d0 f6

B6_21fe:		dey				; 88 
B6_21ff:		bne B6_21f4 ; d0 f3

B6_2201:		rts				; 60 


B6_2202:		ldx #$08		; a2 08
B6_2204:		lda $60			; a5 60
B6_2206:		asl a			; 0a
B6_2207:		tay				; a8 
B6_2208:		lda $a648, y	; b9 48 a6
B6_220b:		sta $6e			; 85 6e
B6_220d:		lda $a647, y	; b9 47 a6
B6_2210:		beq B6_2219 ; f0 07

B6_2212:		cmp #$fc		; c9 fc
B6_2214:		bcs B6_221a ; b0 04

B6_2216:		jsr $a228		; 20 28 a2
B6_2219:		rts				; 60 


B6_221a:		sec				; 38 
B6_221b:		sbc #$fc		; e9 fc
B6_221d:		jsr jumpTable		; 20 3d c2
	.dw $a238
	.dw $a25a
	.dw $a282
	.dw $a290


B6_2228:	jsr initNpcSpecAIdxX
	lda wEntities_330.w, x
B6_222e:		sta wEntitiesY.w, x	; 9d 80 04
B6_2231:		lda wEntities_348.w, x	; bd 48 03
B6_2234:		sta wEntitiesX.w, x	; 9d b0 04
B6_2237:		rts				; 60 


B6_2238:		lda #$31		; a9 31
B6_223a:		ldx #$08		; a2 08
B6_223c:		jsr $a228		; 20 28 a2
B6_223f:		lda #$68		; a9 68
B6_2241:		sta wEntitiesY.w, x	; 9d 80 04
B6_2244:		lda #$90		; a9 90
B6_2246:		sta wEntitiesX.w, x	; 9d b0 04
B6_2249:		inx				; e8 
B6_224a:		lda #$28		; a9 28
B6_224c:		jsr $a228		; 20 28 a2
B6_224f:		lda #$70		; a9 70
B6_2251:		sta wEntitiesY.w, x	; 9d 80 04
B6_2254:		lda #$a0		; a9 a0
B6_2256:		sta wEntitiesX.w, x	; 9d b0 04
B6_2259:		rts				; 60 


B6_225a:		lda #$31		; a9 31
B6_225c:		ldx #$08		; a2 08
B6_225e:		jsr $a228		; 20 28 a2
B6_2261:		inx				; e8 
B6_2262:		lda #$2b		; a9 2b
B6_2264:		jsr $a228		; 20 28 a2
B6_2267:		lda #$60		; a9 60
B6_2269:		sta wEntitiesY.w, x	; 9d 80 04
B6_226c:		lda #$88		; a9 88
B6_226e:		sta wEntitiesX.w, x	; 9d b0 04
B6_2271:		inx				; e8 
B6_2272:		lda #$2b		; a9 2b
B6_2274:		jsr $a228		; 20 28 a2
B6_2277:		lda #$60		; a9 60
B6_2279:		sta wEntitiesY.w, x	; 9d 80 04
B6_227c:		lda #$a8		; a9 a8
B6_227e:		sta wEntitiesX.w, x	; 9d b0 04
B6_2281:		rts				; 60 


B6_2282:		lda #$25		; a9 25
B6_2284:		ldx #$08		; a2 08
B6_2286:		jsr $a228		; 20 28 a2
B6_2289:		inx				; e8 
B6_228a:		lda #$24		; a9 24
B6_228c:		jsr $a228		; 20 28 a2
B6_228f:		rts				; 60 


B6_2290:		lda #$58		; a9 58
B6_2292:		ldx #$08		; a2 08
B6_2294:		jsr $a228		; 20 28 a2
B6_2297:		inx				; e8 
B6_2298:		lda #$59		; a9 59
B6_229a:		jsr $a228		; 20 28 a2
B6_229d:		inx				; e8 
B6_229e:		lda #$5a		; a9 5a
B6_22a0:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_22a3:		lda wEntities_330.w, x	; bd 30 03
B6_22a6:		sta wEntities_408.w, x	; 9d 08 04
B6_22a9:		inx				; e8 
B6_22aa:		cpx #$0e		; e0 0e
B6_22ac:		bne B6_229e ; d0 f0

B6_22ae:		lda #$5b		; a9 5b
B6_22b0:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_22b3:		lda wEntities_330.w, x	; bd 30 03
B6_22b6:		sta wEntities_408.w, x	; 9d 08 04
B6_22b9:		inx				; e8 
B6_22ba:		cpx #$12		; e0 12
B6_22bc:		bne B6_22ae ; d0 f0

B6_22be:		rts				; 60 


func_6_22bf:
B6_22bf:		ldx #$07		; a2 07
B6_22c1:		lda #$00		; a9 00
B6_22c3:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_22c6:		dex				; ca 
B6_22c7:		bpl B6_22c1 ; 10 f8

B6_22c9:		lda $bf			; a5 bf
B6_22cb:		cmp #$08		; c9 08
B6_22cd:		bcs B6_22d2 ; b0 03

B6_22cf:		jsr markMagicNotInUse		; 20 94 88
B6_22d2:		rts				; 60 


; decides index of 'inner room', by cmp'ing room y then x
npcLocationsData:
	.db $1a $0c
	.db $1a $0d
	.db $1a $10
	.db $1a $11
	.db $1b $0d
	.db $1b $0f
	.db $1c $0d
	.db $1c $0f
	.db $1c $10 ; 08
	.db $13 $0d
	.db $13 $0e
	.db $14 $0e
	.db $15 $0d
	.db $15 $10 ; 0d
	.db $16 $0b
	.db $16 $0d
	.db $0a $18 ; 10
	.db $0b $17
	.db $0b $1a
	.db $0d $18
	.db $0e $1a
	.db $0f $15
	.db $08 $03
	.db $13 $03 ; 17
	.db $05 $0c
	.db $12 $11
	.db $02 $1e
	.db $00 $14
	.db $0c $06
	.db $0a $09
	.db $0c $10 ; 1e
	.db $1f $1f
	.db $ff $ff

	.db $02 $02 ; 21
	.db $04 $15
	.db $00 $13
	.db $11 $1b
	.db $1b $0e
	.db $09 $06
	.db $1a $0e
	.db $13 $0c
	.db $15 $0b
	.db $0a $0a
	.db $0f $0e
	.db $04 $07 ; 2c
	.db $05 $04 ; 2d
	.db $0f $0b ; 2e
	.db $00 $02 ; 2f
	.db $17 $06
	.db $16 $02
	.db $05 $0d ; 32
	.db $00 $0d
	.db $04 $0a ; 34
	.db $02 $0a ; 35
	.db $14 $0a
	.db $0d $07
	.db $0f $02 ; 38
	.db $07 $17 ; 39
	.db $00 $1f
	.db $08 $17 ; 3b
	.db $06 $1a ; 3c
	.db $0b $03
	.db $11 $0a
	.db $00 $12 ; 3f
	.db $19 $10
	.db $12 $02
	.db $05 $0f ; 42
	.db $0b $10
	.db $07 $1e
	.db $05 $14 ; 45
	.db $1c $17
	.db $1c $1c
	.db $0e $07 ; 48
	.db $00 $1b
	.db $19 $11 ; 4a
	.db $1f $1e
	.db $1c $02
	.db $1f $1d
	.db $0a $1a
	.db $00 $18
	.db $18 $1b
	.db $11 $1d ; 51
	.db $16 $19
	.db $1f $1c
	.db $1f $1b
	.db $0b $1e ; 55
	.db $ff


data_6_2380:
.db $12
B6_2381:	.db $02
B6_2382:	.db $02
B6_2383:	.db $12
B6_2384:	.db $12
B6_2385:	.db $12
B6_2386:	.db $12
B6_2387:	.db $12
B6_2388:	.db $12
B6_2389:	.db $02
B6_238a:	.db $02
B6_238b:	.db $02
B6_238c:	.db $02
B6_238d:	.db $12
B6_238e:	.db $02
B6_238f:	.db $02
B6_2390:		bpl B6_2394 ; 10 02

B6_2392:	.db $02
B6_2393:	.db $02
B6_2394:	.db $02
B6_2395:	.db $02
B6_2396:	.db $23
B6_2397:	.db $12
B6_2398:		.db $00				; 00
B6_2399:		ora $12, x		; 15 12
B6_239b:	.db $02
B6_239c:		ora ($02), y	; 11 02
B6_239e:	.db $12
B6_239f:		bit $ff			; 24 ff
B6_23a1:		ora ($24, x)	; 01 24
B6_23a3:	.db $03
B6_23a4:		rol $14			; 26 14
B6_23a6:	.db $03
B6_23a7:	.db $14
B6_23a8:	.db $04
B6_23a9:	.db $04
B6_23aa:	.db $12
B6_23ab:		and $24			; 25 24
B6_23ad:		bit $25			; 24 25
B6_23af:		bit $25			; 24 25
B6_23b1:		ora $24			; 05 24
B6_23b3:		bit $24			; 24 24
B6_23b5:		bit $26			; 24 26
B6_23b7:		ora $25			; 05 25
B6_23b9:		bit $03			; 24 03
B6_23bb:		bit $24			; 24 24
B6_23bd:		bit $25			; 24 25
B6_23bf:		bit $25			; 24 25
B6_23c1:		and $24			; 25 24
B6_23c3:		bit $24			; 24 24
B6_23c5:		bit $24			; 24 24
B6_23c7:		bit $25			; 24 25
B6_23c9:		bpl B6_23ce ; 10 03

B6_23cb:	.db $03
B6_23cc:	.db $03
B6_23cd:	.db $03
B6_23ce:		ora $03			; 05 03
B6_23d0:	.db $03
B6_23d1:	.db $03
B6_23d2:		bit $01			; 24 01
B6_23d4:		rol $24			; 26 24
B6_23d6:	.db $ff


data_6_23d7:
B6_23d7:	.db $44
B6_23d8:	.db $43
B6_23d9:	.db $43
B6_23da:	.db $43
B6_23db:	.db $44
B6_23dc:	.db $44
B6_23dd:	.db $44
B6_23de:	.db $43
B6_23df:	.db $43
B6_23e0:	.db $44
B6_23e1:	.db $43
B6_23e2:	.db $44
B6_23e3:	.db $43
B6_23e4:	.db $43
B6_23e5:	.db $44
B6_23e6:	.db $43
B6_23e7:	.db $7f
B6_23e8:	.db $44
B6_23e9:	.db $43
B6_23ea:	.db $43
B6_23eb:	.db $43
B6_23ec:	.db $44
B6_23ed:	.db $4f
B6_23ee:	.db $43
B6_23ef:	.db $80
B6_23f0:		sta ($84, x)	; 81 84
B6_23f2:	.db $43
B6_23f3:		lsr $44			; 46 44
B6_23f5:	.db $43
B6_23f6:		eor $00			; 45 00
B6_23f8:	.db $47
B6_23f9:	.db $93
B6_23fa:	.db $77
B6_23fb:		adc $4640, x	; 7d 40 46
B6_23fe:		rti				; 40 


B6_23ff:		rti				; 40 


B6_2400:		rti				; 40 


B6_2401:		sty $4c			; 84 4c
B6_2403:	.db $82
B6_2404:	.db $82
B6_2405:	.db $42
B6_2406:		eor ($4b, x)	; 41 4b
B6_2408:		lsr a			; 4a
B6_2409:	.db $83
B6_240a:		pha				; 48 
B6_240b:	.db $83
B6_240c:	.db $83
B6_240d:	.db $7c
B6_240e:		lsr a			; 4a
B6_240f:	.db $42
B6_2410:	.db $82
B6_2411:		eor #$82		; 49 82
B6_2413:	.db $82
B6_2414:		sta ($4b), y	; 91 4b
B6_2416:	.db $82
B6_2417:		eor $7e4e		; 4d 4e 7e
B6_241a:		ror $7e41, x	; 7e 41 7e
B6_241d:	.db $92
B6_241e:	.db $92
B6_241f:	.db $42
B6_2420:	.db $7b
B6_2421:	.db $74
B6_2422:		adc $74, x		; 75 74
B6_2424:	.db $74
B6_2425:		lsr a			; 4a
B6_2426:		adc $7a78, y	; 79 78 7a
B6_2429:		eor ($46, x)	; 41 46
B6_242b:		adc $0d41, x	; 7d 41 0d
B6_242e:	.db $2f
B6_242f:	.db $2f
B6_2430:		ora $08			; 05 08
B6_2432:	.db $07
B6_2433:	.db $07
B6_2434:	.db $0c
B6_2435:	.db $0b
B6_2436:	.db $07
B6_2437:		asl $08			; 06 08
B6_2439:	.db $2f
B6_243a:	.db $04
B6_243b:	.db $07
B6_243c:	.db $2f
B6_243d:		and $2f07, y	; 39 07 2f
B6_2440:	.db $2f
B6_2441:	.db $2f
B6_2442:		php				; 08 
B6_2443:		asl $0305, x	; 1e 05 03
B6_2446:	.db $0f
B6_2447:		rol $2f			; 26 2f
B6_2449:		clc				; 18 
B6_244a:		ora #$05		; 09 05
B6_244c:		asl $1500		; 0e 00 15
B6_244f:	.db $13
B6_2450:	.db $23
B6_2451:	.db $2b
B6_2452:		.db $10 $3e

B6_2454:		ora ($10), y	; 11 10
B6_2456:		ora ($26), y	; 11 26
B6_2458:	.db $1c
B6_2459:		bit $2d2c		; 2c 2c 2d
B6_245c:		bit $1a1b		; 2c 1b 1a
B6_245f:		bit $2c16		; 2c 16 2c
B6_2462:		bit $192a		; 2c 2a 19
B6_2465:		and $172c		; 2d 2c 17
B6_2468:		bit $122c		; 2c 2c 12
B6_246b:	.db $1b
B6_246c:		bit $1d1d		; 2c 1d 1d
B6_246f:		rol $2c2e		; 2e 2e 2c
B6_2472:		rol $2e2e		; 2e 2e 2e
B6_2475:		and $2729		; 2d 29 27
B6_2478:		and ($1f, x)	; 21 1f
B6_247a:		jsr $251a		; 20 1a 25
B6_247d:		bit $28			; 24 28
B6_247f:		bit $2b3d		; 2c 3d 2b
B6_2482:		.db $2c


.include "data/npcScripts.s"


B6_2647:		.db $41
B6_2648:		bvc B6_264a ; 50 00

B6_264a:		bvc B6_264c ; 50 00

B6_264c:		bvc B6_268d ; 50 3f

B6_264e:		bvc B6_26a1 ; 50 51

B6_2650:		bvc B6_2694 ; 50 42

B6_2652:		;removed
	.db $50 $42

B6_2654:		;removed
	.db $50 $40

B6_2656:		;removed
	.db $50 $3e

B6_2658:		bvc B6_2688 ; 50 2e

B6_265a:		;removed
	.db $50 $30

B6_265c:		;removed
	.db $50 $32

B6_265e:		bvc B6_2660 ; 50 00

B6_2660:		;removed
	.db $50 $3d

B6_2662:		stx $502e		; 8e 2e 50
B6_2665:		.db $00				; 00
B6_2666:		;removed
	.db $50 $43

B6_2668:	.db $8f
B6_2669:	.db $2e $50 $00
B6_266c:		bvc B6_266e ; 50 00

B6_266e:		bvc B6_2670 ; 50 00

B6_2670:		bvc B6_26a4 ; 50 32

B6_2672:		;removed
	.db $50 $22

B6_2674:	.db $57
B6_2675:	.db $3f
B6_2676:		bvc B6_2686 ; 50 0e

B6_2678:		dey				; 88 
B6_2679:		and $3f8e, x	; 3d 8e 3f
B6_267c:		bvc B6_267e ; 50 00

B6_267e:		bvc B6_26b6 ; 50 36

B6_2680:	.db $52
B6_2681:	.db $32
B6_2682:		;removed
	.db $50 $3f

B6_2684:		bvc B6_2697 ; 50 11

B6_2686:	.db $89
B6_2687:		.db $00				; 00
B6_2688:		;removed
	.db $50 $35

B6_268a:		cli				; 58 
B6_268b:		and $8c			; 25 8c
B6_268d:	.db $9f
B6_268e:		sta $8a57		; 8d 57 8a
B6_2691:	.db $42
B6_2692:		bvc B6_2691 ; 50 fd

B6_2694:	.db $57
B6_2695:		eor ($50), y	; 51 50
B6_2697:	.db $2f
B6_2698:		bvc B6_26cd ; 50 33

B6_269a:		bvc B6_26db ; 50 3f

B6_269c:		bvc B6_26be ; 50 20

B6_269e:		sta $5552		; 8d 52 55
B6_26a1:	.db $52
B6_26a2:		eor $52, x		; 55 52
B6_26a4:		eor $52, x		; 55 52
B6_26a6:		eor $21, x		; 55 21
B6_26a8:		eor ($29), y	; 51 29
B6_26aa:		;removed
	.db $50 $52

B6_26ac:		eor $11, x		; 55 11
B6_26ae:	.db $89
B6_26af:	.db $52
B6_26b0:		eor $52, x		; 55 52
B6_26b2:		eor $ff, x		; 55 ff
B6_26b4:	.db $8b
B6_26b5:		plp				; 28 
B6_26b6:		;removed
	.db $50 $52

B6_26b8:		eor $52, x		; 55 52
B6_26ba:		eor $53, x		; 55 53
B6_26bc:		lsr $52, x		; 56 52
B6_26be:		eor $52, x		; 55 52
B6_26c0:		eor $5c, x		; 55 5c
B6_26c2:		sty $5121		; 8c 21 51
B6_26c5:	.db $52
B6_26c6:		eor $50, x		; 55 50
B6_26c8:		bcc B6_26f0 ; 90 26

B6_26ca:		stx $5552		; 8e 52 55
B6_26cd:	.db $52
B6_26ce:		eor $52, x		; 55 52
B6_26d0:		eor $52, x		; 55 52
B6_26d2:		eor $52, x		; 55 52
B6_26d4:		eor $52, x		; 55 52
B6_26d6:		eor $52, x		; 55 52
B6_26d8:		eor $43, x		; 55 43
B6_26da:	.db $8f
B6_26db:	.db $2b
B6_26dc:	.db $54
B6_26dd:		rol a			; 2a
B6_26de:		sta $5028		; 8d 28 50
B6_26e1:		and #$50		; 29 50
B6_26e3:		and #$50		; 29 50
B6_26e5:		bit $2d54		; 2c 54 2d
B6_26e8:		eor $fc, x		; 55 fc
B6_26ea:	.db $57
B6_26eb:	.db $52
B6_26ec:		eor $34, x		; 55 34
B6_26ee:		bvc B6_2747 ; 50 57

B6_26f0:		txa				; 8a 
B6_26f1:	.db $52
B6_26f2:		eor $21, x		; 55 21
B6_26f4:	.db $42
B6_26f5:		ora ($0a, x)	; 01 0a
B6_26f7:		and ($49, x)	; 21 49
B6_26f9:		ora ($0a, x)	; 01 0a
B6_26fb:	.db $22
B6_26fc:	.db $62
B6_26fd:		ora ($0a, x)	; 01 0a
B6_26ff:	.db $22
B6_2700:		adc #$01		; 69 01
B6_2702:		asl a			; 0a
B6_2703:		and ($43, x)	; 21 43
B6_2705:		lsr $0b			; 46 0b
B6_2707:	.db $22
B6_2708:	.db $63
B6_2709:		lsr $0c			; 46 0c
B6_270b:		and ($62, x)	; 21 62
B6_270d:		iny				; c8 
B6_270e:		ora $6921		; 0d 21 69
B6_2711:		iny				; c8 
B6_2712:		asl $4c20		; 0e 20 4c
B6_2715:		ora ($0a, x)	; 01 0a
B6_2717:		jsr $015d		; 20 5d 01
B6_271a:		asl a			; 0a
B6_271b:	.db $22
B6_271c:		jmp ($0a01)		; 6c 01 0a


B6_271f:	.db $22
B6_2720:		adc $0a01, x	; 7d 01 0a
B6_2723:		jsr $504d		; 20 4d 50
B6_2726:	.db $0b
B6_2727:	.db $22
B6_2728:		adc $0c50		; 6d 50 0c
B6_272b:		jsr $d06c		; 20 6c d0
B6_272e:		ora $7d20		; 0d 20 7d
B6_2731:		;removed
	.db $d0 $0e

B6_2733:	.db $22
B6_2734:		ldx #$01		; a2 01
B6_2736:		asl a			; 0a
B6_2737:	.db $22
B6_2738:		lda $0a01, x	; bd 01 0a
B6_273b:	.db $23
B6_273c:	.db $82
B6_273d:		ora ($0a, x)	; 01 0a
B6_273f:	.db $23
B6_2740:		sta $0a01, x	; 9d 01 0a
B6_2743:	.db $22
B6_2744:	.db $a3
B6_2745:	.db $5a
B6_2746:	.db $0b
B6_2747:	.db $23
B6_2748:	.db $83
B6_2749:	.db $5a
B6_274a:	.db $0c
B6_274b:	.db $22
B6_274c:	.db $c2
B6_274d:		dec $0d			; c6 0d
B6_274f:	.db $22
B6_2750:		cmp $0ec6, x	; dd c6 0e
B6_2753:	.db $ff
B6_2754:		and $42			; 25 42
B6_2756:		ora ($0a, x)	; 01 0a
B6_2758:		and $49			; 25 49
B6_275a:		ora ($0a, x)	; 01 0a
B6_275c:		rol $62			; 26 62
B6_275e:		ora ($0a, x)	; 01 0a
B6_2760:		rol $69			; 26 69
B6_2762:		ora ($0a, x)	; 01 0a
B6_2764:		and $43			; 25 43
B6_2766:		lsr $0b			; 46 0b
B6_2768:		rol $63			; 26 63
B6_276a:		lsr $0c			; 46 0c
B6_276c:		and $62			; 25 62
B6_276e:		iny				; c8 
B6_276f:		ora $6925		; 0d 25 69
B6_2772:		iny				; c8 
B6_2773:		asl $4c24		; 0e 24 4c
B6_2776:		ora ($0a, x)	; 01 0a
B6_2778:		bit $5d			; 24 5d
B6_277a:		ora ($0a, x)	; 01 0a
B6_277c:		rol $6c			; 26 6c
B6_277e:		ora ($0a, x)	; 01 0a
B6_2780:		rol $7d			; 26 7d
B6_2782:		ora ($0a, x)	; 01 0a
B6_2784:		bit $4d			; 24 4d
B6_2786:		;removed
	.db $50 $0b

B6_2788:		rol $6d			; 26 6d
B6_278a:		bvc B6_2798 ; 50 0c

B6_278c:		bit $6c			; 24 6c
B6_278e:		bne B6_279d ; d0 0d

B6_2790:		bit $7d			; 24 7d
B6_2792:		;removed
	.db $d0 $0e

B6_2794:		rol $a2			; 26 a2
B6_2796:		ora ($0a, x)	; 01 0a
B6_2798:		rol $bd			; 26 bd
B6_279a:		ora ($0a, x)	; 01 0a
B6_279c:	.db $27
B6_279d:	.db $82
B6_279e:		ora ($0a, x)	; 01 0a
B6_27a0:	.db $27
B6_27a1:		sta $0a01, x	; 9d 01 0a
B6_27a4:		rol $a3			; 26 a3
B6_27a6:	.db $5a
B6_27a7:	.db $0b
B6_27a8:	.db $27
B6_27a9:	.db $83
B6_27aa:	.db $5a
B6_27ab:	.db $0c
B6_27ac:		rol $c2			; 26 c2
B6_27ae:		dec $0d			; c6 0d
B6_27b0:		rol $dd			; 26 dd
B6_27b2:		dec $0e			; c6 0e
B6_27b4:	.db $ff


func_6_27b5:
B6_27b5:		jsr $aab3		; 20 b3 aa
B6_27b8:		lda $68			; a5 68
B6_27ba:		bmi B6_27cd ; 30 11

B6_27bc:		jsr jumpTable		; 20 3d c2
	.dw func_6_27ce
	.dw $a85c
	.dw $a973
	.dw $a7ee
	.dw $a9b9
	.dw $a897
	.dw $a8b5

B6_27cd:		rts				; 60 

func_6_27ce:
B6_27ce:		lda #$00		; a9 00
B6_27d0:		sta $69			; 85 69
B6_27d2:		sta wNPCTextByteOffset			; 85 62
B6_27d4:		sta $61			; 85 61
B6_27d6:		jsr $aa9e		; 20 9e aa
B6_27d9:		lda #$03		; a9 03
B6_27db:		sta wTimeUntilDisplayingNextTextByte			; 85 63
B6_27dd:		jsr $aaaa		; 20 aa aa
B6_27e0:		lda #>(scriptAddresses/2)		; a9 40
B6_27e2:		sta wNPCTextAddressSrc+1			; 85 65
B6_27e4:		lda wScriptIdx			; a5 6b
B6_27e6:		asl a			; 0a
B6_27e7:		rol wNPCTextAddressSrc+1			; 26 65
B6_27e9:		sta wNPCTextAddressSrc			; 85 64
B6_27eb:		jsr setNPCTextAddress		; 20 19 ed

B6_27ee:		ldy wNPCTextByteOffset			; a4 62
B6_27f0:		ldx $61			; a6 61
B6_27f2:		jsr getTextByte		; 20 0c ed
B6_27f5:		sec				; 38 
B6_27f6:		sbc #$f2		; e9 f2
B6_27f8:		bcc B6_2819 ; 90 1f

B6_27fa:		jsr jumpTable		; 20 3d c2
	.dw textByteF2_todo
	.dw textByteF3_todo
	.dw textByteF4_unsetGlobalFlag
	.dw textByteF5_setRoomYX
	.dw textByteF6_todo
	.dw textByteF7_displayPreset
	.dw textByteF8_playParamSoundWaitParamSeconds
	.dw textByteF9_todo
	.dw textByteFA_setGlobalFlag
	.dw textByteFB_todo
	.dw textByteFC_customCode
	.dw textByteFD_todo
	.dw textByteFE_todo
	.dw textByteFF_todo

B6_2819:		jsr getTextByte		; 20 0c ed
B6_281c:		bmi B6_2829 ; 30 0b

func_6_281e:
B6_281e:		sta $06d8, x	; 9d d8 06
B6_2821:		lda #$20		; a9 20
B6_2823:		sta wRoomLoadingRow1ToCopy.w, x	; 9d c0 06
B6_2826:		jmp func_6_2848		; 4c 48 a8


B6_2829:		and #$7f		; 29 7f
B6_282b:		pha				; 48 
B6_282c:		and #$20		; 29 20
B6_282e:		bne B6_283c ; d0 0c

B6_2830:		pla				; 68 
B6_2831:		sta $06d8, x	; 9d d8 06
B6_2834:		lda #$79		; a9 79
B6_2836:		sta wRoomLoadingRow1ToCopy.w, x	; 9d c0 06
B6_2839:		jmp func_6_2848		; 4c 48 a8


B6_283c:		pla				; 68 
B6_283d:		sec				; 38 
B6_283e:		sbc #$10		; e9 10
B6_2840:		sta $06d8, x	; 9d d8 06
B6_2843:		lda #$78		; a9 78
B6_2845:		sta wRoomLoadingRow1ToCopy.w, x	; 9d c0 06

func_6_2848:
B6_2848:		jsr $aa24		; 20 24 aa
B6_284b:		lda #$01		; a9 01
B6_284d:		sta $68			; 85 68
B6_284f:		inc $61			; e6 61
B6_2851:		lda #$01		; a9 01
B6_2853:		jsr $aa92		; 20 92 aa

incTextByteOffset_setDelay:
; inc offset
	inc wNPCTextByteOffset
	bne +
	inc wNPCTextAddress+1
+
.ifdef FAST_TEXT
	nop
	nop
	lda #$01
.else
	lda wJoy1ButtonsPressed
	and #PADF_UP
.endif
	bne +

; up not pressed, dec timer until reading next byte
	dec wTimeUntilDisplayingNextTextByte
	bpl @done

+
	lda #$03		; a9 03
	sta $68			; 85 68
	sta wTimeUntilDisplayingNextTextByte

@done:
	rts


; loads a preset word, or jump-type
textByteF7_displayPreset:
B6_286d:		jsr getTextByteIncPointer		; 20 b9 aa
B6_2870:		pha				; 48 
B6_2871:		lda wScriptIdx			; a5 6b
B6_2873:		sta $5f			; 85 5f
B6_2875:		ldy wNPCTextByteOffset			; a4 62
B6_2877:		iny				; c8 
B6_2878:		bne B6_287c ; d0 02

B6_287a:		inc $65			; e6 65
B6_287c:		sty $6f			; 84 6f
B6_287e:		lda $64			; a5 64
B6_2880:		sta $3e			; 85 3e
B6_2882:		lda $65			; a5 65
B6_2884:		sta $3f			; 85 3f
B6_2886:		pla				; 68 
B6_2887:		asl a			; 0a
B6_2888:		sta $64			; 85 64
B6_288a:		lda #>textData_7_2e00		; a9 ee
B6_288c:		adc #$00		; 69 00
B6_288e:		sta $65			; 85 65
B6_2890:		jsr setNPCTextAddress		; 20 19 ed
B6_2893:		lda #$00		; a9 00
B6_2895:		sta wNPCTextByteOffset			; 85 62
B6_2897:		ldy wNPCTextByteOffset			; a4 62
B6_2899:		ldx $61			; a6 61
B6_289b:		jsr getTextByte		; 20 0c ed
B6_289e:		cmp #$ff		; c9 ff
B6_28a0:		beq B6_28bb ; f0 19

B6_28a2:		jsr $a819		; 20 19 a8
B6_28a5:		lda $68			; a5 68
B6_28a7:		cmp #$03		; c9 03
B6_28a9:		bne B6_28b0 ; d0 05

B6_28ab:		lda #$05		; a9 05
B6_28ad:		sta $68			; 85 68
B6_28af:		rts				; 60 


B6_28b0:		lda #$06		; a9 06
B6_28b2:		sta $68			; 85 68
B6_28b4:		rts				; 60 


B6_28b5:		jsr $a85c		; 20 5c a8
B6_28b8:		jmp $a8a5		; 4c a5 a8


B6_28bb:		lda $5f			; a5 5f
B6_28bd:		sta $6b			; 85 6b
B6_28bf:		lda $6f			; a5 6f
B6_28c1:		sta wNPCTextByteOffset			; 85 62
B6_28c3:		lda $3e			; a5 3e
B6_28c5:		sta $64			; 85 64
B6_28c7:		lda $3f			; a5 3f
B6_28c9:		sta $65			; 85 65
B6_28cb:		lda #$03		; a9 03
B6_28cd:		sta $68			; 85 68
B6_28cf:		jmp $a7ee		; 4c ee a7


textByteFB_todo:
B6_28d2:		lda #$33		; a9 33
B6_28d4:		jsr queueSoundAtoPlay		; 20 ad c4
B6_28d7:		lda #$ba		; a9 ba
B6_28d9:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B6_28dc:		lda #$3e		; a9 3e
B6_28de:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B6_28e1:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteFA_setGlobalFlag:
	jsr getTextByteIncPointer
	jsr setGlobalFlag
	jmp incTextByteOffset_setDelay


textByteF3_todo:
B6_28ed:		lda #$0a		; a9 0a
B6_28ef:		clc				; 18 
B6_28f0:		adc $b3			; 65 b3
B6_28f2:		sta $b3			; 85 b3
B6_28f4:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteF2_todo:
B6_28f7:		lda #$01		; a9 01
B6_28f9:		sta $70			; 85 70
B6_28fb:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteF4_unsetGlobalFlag:
	jsr getTextByteIncPointer
	jsr unsetGlobalFlag
	jmp incTextByteOffset_setDelay


textByteFC_customCode:
	jsr getTextByteIncPointer
	jsr jumpTable

	.dw textByteFC_0_fillMP
	.dw textByteFC_1_ocarinaMenu
	.dw textByteFC_2_fillHP
	.dw textByteFC_3_attemptHealFin
	.dw textByteFC_4_healMuzh
	.dw textByteFC_5_scareGuardWithSlime
	.dw textByteFC_6_todo ; plays 2 sounds 4 times


textByteF9_todo:
B6_291b:		jsr getTextByteIncPointer		; 20 b9 aa
-	pha				; 48 
B6_291f:		ldy wNPCTextByteOffset			; a4 62
B6_2921:		tya				; 98 
B6_2922:		pha				; 48 
B6_2923:		ldx $61			; a6 61
B6_2925:		lda #$20		; a9 20
B6_2927:		jsr func_6_281e		; 20 1e a8
B6_292a:		pla				; 68 
B6_292b:		sta wNPCTextByteOffset			; 85 62
B6_292d:		pla				; 68 
B6_292e:		sec				; 38 
B6_292f:		sbc #$01		; e9 01
	bne -

B6_2933:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteF8_playParamSoundWaitParamSeconds:
; next byte is sound to play
	jsr getTextByteIncPointer
	pha

; next byte is number of $3f frames to wait for
	jsr getTextByteIncPointer
	tax
	pla
	jsr queueSoundAtoPlay
	txa
-	pha
	lda #$3f
	jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen
	pla
	sec
	sbc #$01
	bne -

	jmp incTextByteOffset_setDelay


textByteFD_todo:
B6_2952:		lda #$02		; a9 02
B6_2954:		sta $68			; 85 68
B6_2956:		ldx #$00		; a2 00
B6_2958:		bit $6d			; 24 6d
	bpl +

B6_295c:		ldx #$02		; a2 02
+	lda wMajorNMIUpdatesCounter			; a5 23
B6_2960:		and #$10		; 29 10
	beq +

B6_2964:		inx				; e8 
+	txa				; 8a 
B6_2966:		asl a			; 0a
B6_2967:		tax				; aa 
B6_2968:		lda data_6_29de.w, x	; bd de a9
B6_296b:		sta wRLEStructAddressToCopy			; 85 33
B6_296d:		lda data_6_29de.w+1, x	; bd df a9
B6_2970:		sta wRLEStructAddressToCopy+1			; 85 34
B6_2972:		rts				; 60 


B6_2973:		bit wJoy1NewButtonsPressed			; 24 29
B6_2975:		bmi B6_2979 ; 30 02

B6_2977:		bvc B6_2956 ; 50 dd

B6_2979:		lda #$1e		; a9 1e
B6_297b:		sta $a6			; 85 a6
B6_297d:		ldx #$01		; a2 01
B6_297f:		bit $6d			; 24 6d
B6_2981:		bpl B6_2985 ; 10 02

B6_2983:		ldx #$03		; a2 03
B6_2985:		jsr $a965		; 20 65 a9

textByteFE_todo:
B6_2988:		ldx $69			; a6 69
B6_298a:		cpx #$02		; e0 02
B6_298c:		bcs B6_29a7 ; b0 19

B6_298e:		lda $a9d8, x	; bd d8 a9
B6_2991:		sta $61			; 85 61
B6_2993:		lda $a9da, x	; bd da a9
B6_2996:		sta $67			; 85 67
B6_2998:		lda $a9dc, x	; bd dc a9
B6_299b:		sta $66			; 85 66
B6_299d:		inx				; e8 
B6_299e:		stx $69			; 86 69
B6_29a0:		lda #$03		; a9 03
B6_29a2:		sta $68			; 85 68
B6_29a4:		jmp incTextByteOffset_setDelay		; 4c 56 a8


B6_29a7:		jsr $aa09		; 20 09 aa
B6_29aa:		jsr $aaaa		; 20 aa aa
B6_29ad:		lda #$00		; a9 00
B6_29af:		sta $61			; 85 61
B6_29b1:		lda #$04		; a9 04
B6_29b3:		sta $68			; 85 68
B6_29b5:		jsr $aa5d		; 20 5d aa
B6_29b8:		rts				; 60 


B6_29b9:		lda #$20		; a9 20
B6_29bb:		jsr $aa92		; 20 92 aa
B6_29be:		lda $61			; a5 61
B6_29c0:		cmp #$90		; c9 90
B6_29c2:		bne B6_29b5 ; d0 f1

B6_29c4:		ldx $69			; a6 69
B6_29c6:		lda $a9d7, x	; bd d7 a9
B6_29c9:		sta $61			; 85 61
B6_29cb:		lda $a9d9, x	; bd d9 a9
B6_29ce:		sta $67			; 85 67
B6_29d0:		lda $a9db, x	; bd db a9
B6_29d3:		sta $66			; 85 66
B6_29d5:		jmp $a9a0		; 4c a0 a9


B6_29d8:		bmi B6_2a3a ; 30 60

B6_29da:	.db $23
B6_29db:	.db $23
B6_29dc:	.db $04
B6_29dd:	.db $44


data_6_29de:
	.dw data_7_2d2e
	.dw data_7_2d33
	.dw data_7_2d38
	.dw data_7_2d3d

B6_29e6:		jsr $aaaa
B6_29e9:		lda #$00		; a9 00
B6_29eb:		sta $61			; 85 61
B6_29ed:		lda #$00		; a9 00
B6_29ef:		jsr $aa9e		; 20 9e aa
B6_29f2:		jsr $aa5d		; 20 5d aa
B6_29f5:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_29f8:		lda #$20		; a9 20
B6_29fa:		jsr $aa92		; 20 92 aa
B6_29fd:		lda $61			; a5 61
B6_29ff:		cmp #$90		; c9 90
B6_2a01:		bne B6_29f2 ; d0 ef

B6_2a03:		rts				; 60 


textByteFF_todo:
B6_2a04:		lda #$ff		; a9 ff
B6_2a06:		sta $68			; 85 68
B6_2a08:		rts				; 60 


B6_2a09:		ldx #$30		; a2 30
B6_2a0b:		ldy #$00		; a0 00
B6_2a0d:		lda wRoomLoadingRow1ToCopy.w, x	; bd c0 06
B6_2a10:		sta wRoomLoadingRow1ToCopy.w, y	; 99 c0 06
B6_2a13:		inx				; e8 
B6_2a14:		iny				; c8 
B6_2a15:		cpx #$90		; e0 90
B6_2a17:		bne B6_2a0d ; d0 f4

B6_2a19:		lda #$20		; a9 20
B6_2a1b:		sta wRoomLoadingRow1ToCopy.w, y	; 99 c0 06
B6_2a1e:		iny				; c8 
B6_2a1f:		cpy #$90		; c0 90
B6_2a21:		bne B6_2a19 ; d0 f6

B6_2a23:		rts				; 60 


B6_2a24:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B6_2a26:		ldy $61			; a4 61
B6_2a28:		lda $67			; a5 67
B6_2a2a:		bit $6d			; 24 6d
B6_2a2c:		bpl B6_2a31 ; 10 03

B6_2a2e:		clc				; 18 
B6_2a2f:		adc #$04		; 69 04
B6_2a31:		sta wVramQueue.w, x	; 9d 00 05
B6_2a34:		inx				; e8 
B6_2a35:		lda $66			; a5 66
B6_2a37:		sta wVramQueue.w, x	; 9d 00 05
B6_2a3a:		inx				; e8 
B6_2a3b:		lda #$82		; a9 82
B6_2a3d:		sta wVramQueue.w, x	; 9d 00 05
B6_2a40:		and #$7f		; 29 7f
B6_2a42:		sta $f0			; 85 f0
B6_2a44:		inx				; e8 
B6_2a45:		lda wRoomLoadingRow1ToCopy.w, y	; b9 c0 06
B6_2a48:		sta wVramQueue.w, x	; 9d 00 05
B6_2a4b:		inx				; e8 
B6_2a4c:		tya				; 98 
B6_2a4d:		clc				; 18 
B6_2a4e:		adc #$18		; 69 18
B6_2a50:		tay				; a8 
B6_2a51:		dec $f0			; c6 f0
B6_2a53:		bne B6_2a45 ; d0 f0

B6_2a55:		lda #$00		; a9 00
B6_2a57:		sta wVramQueue.w, x	; 9d 00 05
B6_2a5a:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B6_2a5c:		rts				; 60 


B6_2a5d:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B6_2a5f:		ldy $61			; a4 61
B6_2a61:		lda $67			; a5 67
B6_2a63:		bit $6d			; 24 6d
B6_2a65:		bpl B6_2a6a ; 10 03

B6_2a67:		clc				; 18 
B6_2a68:		adc #$04		; 69 04
B6_2a6a:		sta wVramQueue.w, x	; 9d 00 05
B6_2a6d:		inx				; e8 
B6_2a6e:		lda $66			; a5 66
B6_2a70:		sta wVramQueue.w, x	; 9d 00 05
B6_2a73:		inx				; e8 
B6_2a74:		lda #$18		; a9 18
B6_2a76:		sta wVramQueue.w, x	; 9d 00 05
B6_2a79:		sta $f0			; 85 f0
B6_2a7b:		inx				; e8 
B6_2a7c:		lda wRoomLoadingRow1ToCopy.w, y	; b9 c0 06
B6_2a7f:		sta wVramQueue.w, x	; 9d 00 05
B6_2a82:		inx				; e8 
B6_2a83:		iny				; c8 
B6_2a84:		dec $f0			; c6 f0
B6_2a86:		bne B6_2a7c ; d0 f4

B6_2a88:		lda #$00		; a9 00
B6_2a8a:		sta wVramQueue.w, x	; 9d 00 05
B6_2a8d:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B6_2a8f:		sty $61			; 84 61
B6_2a91:		rts				; 60 


B6_2a92:		clc				; 18 
B6_2a93:		adc $66			; 65 66
B6_2a95:		sta $66			; 85 66
B6_2a97:		lda $67			; a5 67
B6_2a99:		adc #$00		; 69 00
B6_2a9b:		sta $67			; 85 67
B6_2a9d:		rts				; 60 


B6_2a9e:		tax				; aa 
B6_2a9f:		lda #$20		; a9 20
B6_2aa1:		sta wRoomLoadingRow1ToCopy.w, x	; 9d c0 06
B6_2aa4:		inx				; e8 
B6_2aa5:		cpx #$90		; e0 90
B6_2aa7:		bne B6_2a9f ; d0 f6

B6_2aa9:		rts				; 60 


B6_2aaa:		lda #$22		; a9 22
B6_2aac:		sta $67			; 85 67
B6_2aae:		lda #$c4		; a9 c4
B6_2ab0:		sta $66			; 85 66
B6_2ab2:		rts				; 60 


B6_2ab3:		lda wPPUCtrl			; a5 20
B6_2ab5:		lsr a			; 4a
B6_2ab6:		ror $6d			; 66 6d
B6_2ab8:		rts				; 60 


getTextByteIncPointer:
	ldy wNPCTextByteOffset
	iny
	bne +
	inc wNPCTextAddress+1
+	sty wNPCTextByteOffset
	jsr getTextByte
	rts


func_6_2ac6:
B6_2ac6:		lda #$25		; a9 25
B6_2ac8:		jsr queueSoundAtoPlay		; 20 ad c4
B6_2acb:		ldy #$10		; a0 10
B6_2acd:		jsr palettesSprFadeOut		; 20 1b c6
B6_2ad0:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B6_2ad2:		sta $2e			; 85 2e
B6_2ad4:		ldy #$04		; a0 04
B6_2ad6:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B6_2ad9:		jsr func_6_22bf		; 20 bf a2
B6_2adc:		jsr clearAllEntities		; 20 94 c3
B6_2adf:		jsr drawEntities		; 20 03 c4
B6_2ae2:		jsr drawPlayer		; 20 dd c3
B6_2ae5:		jsr setPPUMask_noSprites		; 20 53 c1
B6_2ae8:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_2aeb:		jsr func_6_2b24		; 20 24 ab
B6_2aee:		bpl B6_2af6 ; 10 06

B6_2af0:		jsr $ab8f		; 20 8f ab
B6_2af3:		bpl B6_2af6 ; 10 01

B6_2af5:		rts				; 60 

B6_2af6:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_2af9:		jsr b6_loadAllScreenRowsForCurrRoom		; 20 f3 de
B6_2afc:		jsr setNametable1IfOddRoomX		; 20 d7 dc
B6_2aff:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_2b02:		jsr loadRoom2EntityBytes		; 20 4d dd
B6_2b05:		jsr setInGameSprChrBank		; 20 bb c1
B6_2b08:		lda wSprPaletteSpecAndChrBank			; a5 50
B6_2b0a:		lsr a			; 4a
B6_2b0b:		lsr a			; 4a
B6_2b0c:		lsr a			; 4a
B6_2b0d:		lsr a			; 4a
B6_2b0e:		clc				; 18 
B6_2b0f:		adc #$10		; 69 10
B6_2b11:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_2b14:		lda #$00		; a9 00
B6_2b16:		sta wEntityDataByte2			; 85 52
B6_2b18:		sta $55			; 85 55
B6_2b1a:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_2b1d:		jsr func_7_3000		; 20 00 f0
B6_2b20:		jsr setPPUMask_addShowAll		; 20 5d c1
B6_2b23:		rts				; 60 


func_6_2b24:
	ldy #$00
	ldx #$00
-	lda entranceAData.w, x
	bmi @noneFound

	cmp wRoomY
	bne +

	lda entranceAData.w+1, x
	cmp wRoomX
	beq @entranceAfound

+	iny
	inx
	inx
	bne -

@noneFound:
	rts

@entranceAfound:
; indoor entrances?
B6_2b3e:		cpy #$1a		; c0 1a
B6_2b40:		bcs B6_2b68 ; @next

; save last outdoor entrance used
B6_2b42:		lda wRoomY			; a5 43
B6_2b44:		sta wLastOutdoorEntranceUsedY			; 85 5a
B6_2b46:		lda wRoomX			; a5 42
B6_2b48:		sta wLastOutdoorEntranceUsedX			; 85 5b

; jump entrance to underwater area
B6_2b4a:		cpy #$18		; c0 18
B6_2b4c:		beq B6_2b68 ; @next

B6_2b4e:		cpy #$19		; c0 19
B6_2b50:		beq B6_2b68 ; @next

; from outdoor to indoor caves
B6_2b52:		lda $58			; a5 58
B6_2b54:		ora #$40		; 09 40
B6_2b56:		sta $58			; 85 58
B6_2b58:		pha				; 48 
B6_2b59:		txa				; 8a 
B6_2b5a:		pha				; 48 
B6_2b5b:		tya				; 98 
B6_2b5c:		pha				; 48 
B6_2b5d:		jsr func_6_3626		; 20 26 b6
B6_2b60:		jsr func_6_3865		; 20 65 b8
B6_2b63:		pla				; 68 
B6_2b64:		tay				; a8 
B6_2b65:		pla				; 68 
B6_2b66:		tax				; aa 
B6_2b67:		pla				; 68 

@next:
B6_2b68:		cpy #$02		; c0 02
	bne @afterBraceletCheck

; use 2nd address if we unblocked the cave
	lda wStoryGlobalFlags0.w
	and #GFB_BRACELET_UNBLOCKED_CAVE
	beq @afterBraceletCheck

	inx
	inx

@afterBraceletCheck:
	lda entranceBData.w, x
	sta wRoomY
	lda entranceBData.w+1, x
	sta wRoomX

; 1st val here *= 3
B6_2b7f:		lda entrancesB_chrPalMus_positionIdxes.w, x	; bd 69 ad
B6_2b82:		asl a			; 0a
B6_2b83:		clc				; 18 
B6_2b84:		adc entrancesB_chrPalMus_positionIdxes.w, x	; 7d 69 ad
B6_2b87:		sta $00			; 85 00

B6_2b89:		lda entrancesB_chrPalMus_positionIdxes.w+1, x	; bd 6a ad
B6_2b8c:		jmp func_6_2bd7		; 4c d7 ab


;
B6_2b8f:		ldy #$00		; a0 00
B6_2b91:		ldx #$00		; a2 00
B6_2b93:		lda entranceBData.w, x	; bd b8 ac
B6_2b96:		bmi B6_2ba8 ; 30 10

B6_2b98:		cmp wRoomY			; c5 43
B6_2b9a:		bne B6_2ba3 ; d0 07

B6_2b9c:		lda entranceBData.w+1, x	; bd b9 ac
B6_2b9f:		cmp wRoomX			; c5 42
B6_2ba1:		beq B6_2ba9 ; f0 06

B6_2ba3:		iny				; c8 
B6_2ba4:		inx				; e8 
B6_2ba5:		inx				; e8 
B6_2ba6:		bne B6_2b93 ; d0 eb

B6_2ba8:		rts				; 60 

B6_2ba9:		cpy #$1a		; c0 1a
B6_2bab:		bcs B6_2bb3 ; b0 06

B6_2bad:		lda $58			; a5 58
B6_2baf:		and #$bf		; 29 bf
B6_2bb1:		sta $58			; 85 58

B6_2bb3:		cpy #$1f		; c0 1f
B6_2bb5:		bne B6_2bc0 ; d0 09

B6_2bb7:		lda wStoryGlobalFlags0.w		; ad 00 06
B6_2bba:		and #GFB_BRACELET_UNBLOCKED_CAVE		; 29 04
B6_2bbc:		beq B6_2bc0 ; f0 02

B6_2bbe:		inx				; e8 
B6_2bbf:		inx				; e8 

B6_2bc0:		lda entranceAData.w, x	; bd 07 ac
B6_2bc3:		sta wRoomY			; 85 43
B6_2bc5:		lda entranceAData.w+1, x	; bd 08 ac
B6_2bc8:		sta wRoomX			; 85 42
B6_2bca:		lda entrancesA_chrPalMus_positionIdxes.w, x	; bd 19 ae
B6_2bcd:		asl a			; 0a
B6_2bce:		clc				; 18 
B6_2bcf:		adc entrancesA_chrPalMus_positionIdxes.w, x	; 7d 19 ae
B6_2bd2:		sta $00			; 85 00
B6_2bd4:		lda entrancesA_chrPalMus_positionIdxes.w+1, x	; bd 1a ae

func_6_2bd7:
; 2nd val is indexed here to get new player coords
B6_2bd7:		asl a			; 0a
B6_2bd8:		tax				; aa 
B6_2bd9:		lda entrances_positionData.w, x	; bd c9 ae
B6_2bdc:		sec				; 38 
B6_2bdd:		sbc #$10		; e9 10
B6_2bdf:		sta wPlayerY			; 85 cc
B6_2be1:		lda entrances_positionData.w+1, x	; bd ca ae
B6_2be4:		sta wPlayerX			; 85 ce

B6_2be6:		ldx $00			; a6 00
B6_2be8:		lda chrPalMusData.w, x	; bd e9 9e
B6_2beb:		sta wBGChrBank			; 85 53
B6_2bed:		lda chrPalMusData.w+2, x	; bd eb 9e
B6_2bf0:		cmp $d7			; c5 d7
B6_2bf2:		beq B6_2bf9 ; f0 05

B6_2bf4:		sta $d5			; 85 d5
B6_2bf6:		jsr func_7_04ab		; 20 ab c4

B6_2bf9:		lda chrPalMusData.w+1, x	; bd ea 9e
B6_2bfc:		jsr updateSavedInternalPalettesFromSpecA		; 20 b0 c6

B6_2bff:		lda wBGChrBank			; a5 53
B6_2c01:		jsr set_wChrBank1		; 20 db c1
B6_2c04:		lda #$00		; a9 00
B6_2c06:		rts				; 60 


entranceAData:
	.db $0f $0e
	.db $16 $05
	.db $0d $00 ; 02
	.db $0d $00
	.db $14 $0a
	.db $0a $06
	.db $0b $05
	.db $09 $04
	.db $0c $00
	.db $09 $05
	.db $08 $05
	.db $0b $03
	.db $0b $02
	.db $0b $00
	.db $0d $0b
	.db $0d $0e
	.db $10 $12
	.db $10 $17
	.db $0a $1a
	.db $0b $10
	.db $08 $04
	.db $08 $02
	.db $09 $19
	.db $00 $18
	.db $07 $09 ; 18
	.db $0c $06 ; 19

	.db $10 $1d ; 1a
	.db $04 $03
	.db $09 $02
	.db $08 $06
	.db $06 $05
	.db $01 $06
	.db $00 $06
	.db $03 $04
	.db $04 $09
	.db $01 $0d
	.db $03 $15
	.db $12 $11
	.db $10 $1b
	.db $14 $16
	.db $06 $17
	.db $0c $1e
	.db $1a $09
	.db $0e $1e
	.db $1b $04
	.db $10 $1e
	.db $1b $06
	.db $12 $1e
	.db $1b $05
	.db $1a $0a
	.db $17 $01
	.db $11 $00
	.db $19 $01
	.db $13 $00
	.db $1b $01
	.db $13 $01
	.db $18 $03
	.db $15 $00
	.db $1a $03
	.db $15 $01
	.db $18 $05
	.db $17 $13
	.db $1b $12
	.db $17 $17
	.db $1b $13
	.db $18 $11
	.db $1c $0b
	.db $17 $1d
	.db $1b $1d
	.db $1c $1e
	.db $1b $1f
	.db $19 $1f
	.db $0c $1d
	.db $13 $1c
	.db $12 $1d
	.db $11 $1d
	.db $00 $13
	.db $14 $1a
	.db $15 $19
	.db $18 $19
	.db $17 $19
	.db $18 $1a
	.db $17 $1a
	.db $16 $1b
	.db $18 $1b
	.db $16 $1e
	.db $0e $1d
	.db $1c $02
	.db $ff


entranceBData:
	.db $00 $00
	.db $03 $03
	.db $01 $04
	.db $00 $04
	.db $00 $03
	.db $03 $13
	.db $01 $11
	.db $07 $16
	.db $01 $14
	.db $06 $16
	.db $05 $17
	.db $02 $1a
	.db $08 $1b
	.db $04 $15
	.db $11 $10
	.db $12 $16
	.db $00 $1d
	.db $06 $1e
	.db $08 $1e
	.db $09 $1f
	.db $0c $1f
	.db $17 $00
	.db $15 $15
	.db $14 $1d
	.db $08 $0a
	.db $06 $0a
	.db $07 $1e
	.db $03 $01
	.db $05 $08
	.db $0c $04
	.db $03 $02
	.db $02 $04
	.db $02 $04
	.db $05 $0e
	.db $04 $0d
	.db $04 $0e
	.db $01 $17
	.db $02 $1a
	.db $0a $1f
	.db $0b $1f
	.db $04 $1b
	.db $1b $09
	.db $0e $1f
	.db $1c $04
	.db $10 $1f
	.db $1c $06
	.db $12 $1f
	.db $1c $05
	.db $1a $0b
	.db $19 $0f
	.db $12 $00
	.db $19 $00
	.db $14 $00
	.db $1b $00
	.db $14 $01
	.db $18 $02
	.db $16 $00
	.db $1a $02
	.db $16 $01
	.db $18 $04
	.db $12 $01
	.db $1c $12
	.db $1b $16
	.db $1c $13
	.db $1b $1a
	.db $1c $02
	.db $19 $15
	.db $1c $1d
	.db $1b $1e
	.db $17 $1e
	.db $16 $1f
	.db $0d $1d
	.db $12 $1c
	.db $1a $1e
	.db $1a $1f
	.db $01 $13
	.db $19 $1d
	.db $19 $19
	.db $13 $19
	.db $13 $1b
	.db $12 $1b
	.db $12 $19
	.db $11 $1b
	.db $1a $1d
	.db $1a $13
	.db $16 $1a
	.db $14 $14
	.db $1a $07
	.db $ff


; idx to chrPalMus, then position
entrancesB_chrPalMus_positionIdxes:
	.db $14 $09
	.db $09 $13
	.db $15 $04
	.db $15 $04
	.db $15 $14
	.db $16 $09
	.db $16 $09
	.db $16 $09
	.db $16 $14
	.db $16 $04
	.db $16 $13
	.db $16 $09
	.db $16 $09
	.db $16 $12
	.db $17 $09
	.db $17 $04
	.db $18 $14
	.db $18 $04
	.db $09 $04
	.db $09 $09
	.db $0a $0d
	.db $0f $11
	.db $21 $1b
	.db $20 $1b
	.db $29 $1f
	.db $29 $1e
	.db $09 $04
	.db $14 $13
	.db $14 $13
	.db $14 $11
	.db $14 $13
	.db $15 $14
	.db $15 $14
	.db $15 $09
	.db $15 $11
	.db $15 $13
	.db $16 $09
	.db $17 $09
	.db $09 $09
	.db $09 $09
	.db $16 $13
	.db $0d $0f
	.db $0b $0d
	.db $0d $0f
	.db $0c $0d
	.db $0d $0f
	.db $0c $0d
	.db $0d $0f
	.db $0c $0d
	.db $0e $10
	.db $12 $0f
	.db $10 $11
	.db $12 $0f
	.db $11 $11
	.db $12 $0f
	.db $11 $11
	.db $12 $0f
	.db $11 $11
	.db $12 $0f
	.db $11 $11
	.db $13 $10
	.db $21 $1c
	.db $26 $1a
	.db $21 $1c
	.db $26 $1a
	.db $27 $00
	.db $21 $1a
	.db $20 $1c
	.db $25 $1a
	.db $20 $10
	.db $20 $10
	.db $25 $1c
	.db $28 $1a
	.db $25 $10
	.db $25 $10
	.db $28 $1c
	.db $1f $16
	.db $1f $15
	.db $1f $15
	.db $1f $16
	.db $1f $16
	.db $1f $15
	.db $24 $10
	.db $22 $11
	.db $22 $09
	.db $22 $09
	.db $09 $14
	.db $27 $10


; idx to chrPalMus, then position
entrancesA_chrPalMus_positionIdxes:
	.db $00 $04
	.db $00 $05
	.db $1b $03
	.db $1b $03
	.db $08 $01
	.db $00 $01
	.db $00 $0b
	.db $00 $08
	.db $00 $02
	.db $00 $0a
	.db $00 $09
	.db $00 $0c
	.db $00 $0d
	.db $00 $01
	.db $00 $01
	.db $07 $07
	.db $07 $01
	.db $07 $08
	.db $07 $05
	.db $00 $06
	.db $01 $00
	.db $01 $01
	.db $03 $00
	.db $02 $00
	.db $08 $14
	.db $00 $1d
	.db $09 $13
	.db $14 $09
	.db $14 $09
	.db $14 $14
	.db $14 $04
	.db $15 $09
	.db $15 $09
	.db $15 $14
	.db $15 $13
	.db $15 $09
	.db $16 $14
	.db $17 $04
	.db $09 $04
	.db $09 $04
	.db $16 $09
	.db $0a $11
	.db $0d $0e
	.db $0b $11
	.db $0d $0e
	.db $0c $11
	.db $0d $0e
	.db $0c $11
	.db $0d $0e
	.db $0c $11
	.db $0f $0d
	.db $12 $0e
	.db $10 $0d
	.db $12 $0e
	.db $11 $0d
	.db $12 $0e
	.db $11 $0d
	.db $12 $0e
	.db $11 $0d
	.db $12 $0e
	.db $11 $0d
	.db $21 $1a
	.db $21 $18
	.db $21 $1a
	.db $21 $18
	.db $21 $19
	.db $27 $1d
	.db $20 $1a
	.db $20 $18
	.db $25 $17
	.db $25 $17
	.db $25 $17
	.db $25 $18
	.db $28 $17
	.db $28 $1a
	.db $28 $17
	.db $28 $19
	.db $23 $17
	.db $23 $17
	.db $23 $1c
	.db $23 $18
	.db $23 $1c
	.db $23 $18
	.db $20 $1a
	.db $20 $17
	.db $20 $17
	.db $09 $09
	.db $1a $07


entrances_positionData:
	.db $70 $90
	.db $70 $70
	.db $90 $90
	.db $90 $50
	.db $50 $b0
	.db $90 $70
	.db $90 $30
	.db $d0 $90
	.db $b0 $90
	.db $70 $b0
	.db $b0 $70
	.db $70 $30
	.db $90 $d0
	.db $70 $50
	.db $50 $70
	.db $b0 $50
	.db $90 $a0
	.db $50 $d0
	.db $b0 $30
	.db $b0 $b0
	.db $90 $50
	.db $70 $80
	.db $70 $a0
	.db $70 $c0
	.db $80 $c0
	.db $40 $d0
	.db $60 $c0
	.db $60 $70
	.db $90 $40
	.db $90 $b0
	.db $30 $90
	.db $30 $d0


textByteFC_6_todo:
B6_2f09:		lda #$04		; a9 04
B6_2f0b:		pha				; 48 
B6_2f0c:		lda #$23		; a9 23
B6_2f0e:		jsr queueSoundAtoPlay		; 20 ad c4
B6_2f11:		lda #$1e		; a9 1e
B6_2f13:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B6_2f16:		lda #$22		; a9 22
B6_2f18:		jsr queueSoundAtoPlay		; 20 ad c4
B6_2f1b:		lda #$30		; a9 30
B6_2f1d:		jsr waitForAnumberOfMajorityOfNMIFuncsDone_spr0HitScreen		; 20 49 c1
B6_2f20:		pla				; 68 
B6_2f21:		sec				; 38 
B6_2f22:		sbc #$01		; e9 01
B6_2f24:		bne B6_2f0b ; d0 e5

B6_2f26:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteFC_0_fillMP:
B6_2f29:		lda #$ff		; a9 ff
B6_2f2b:		sta wMPGiven			; 85 76
B6_2f2d:		lda #$18		; a9 18
B6_2f2f:		sta $00			; 85 00
B6_2f31:		ldx #$15		; a2 15
B6_2f33:		lda wMajorNMIUpdatesCounter			; a5 23
B6_2f35:		and #$04		; 29 04
B6_2f37:		bne B6_2f3b ; d0 02

B6_2f39:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_2f3b:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_2f3b:	.db $ea $ea $ea
.endif
B6_2f3e:		stx $30			; 86 30
B6_2f40:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_2f43:		dec $00			; c6 00
B6_2f45:		bne B6_2f31 ; d0 ea

B6_2f47:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_2f49:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_2f49:	.db $ea $ea $ea
.endif
B6_2f4c:		stx $30			; 86 30
B6_2f4e:		lda wMPGiven			; a5 76
B6_2f50:		beq B6_2f5b ; f0 09

B6_2f52:		jsr processExp_etc_todo		; 20 44 f3
B6_2f55:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_2f58:		jmp $af4e		; 4c 4e af


B6_2f5b:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteFC_2_fillHP:
B6_2f5e:		lda #$ff		; a9 ff
B6_2f60:		sta wHealthGiven			; 85 77
B6_2f62:		lda #$18		; a9 18
B6_2f64:		sta $00			; 85 00
B6_2f66:		ldx #$15		; a2 15
B6_2f68:		lda wMajorNMIUpdatesCounter			; a5 23
B6_2f6a:		and #$04		; 29 04
B6_2f6c:		bne B6_2f70 ; d0 02

B6_2f6e:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_2f70:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_2f70:	.db $ea $ea $ea
.endif
B6_2f73:		stx $30			; 86 30
B6_2f75:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_2f78:		dec $00			; c6 00
B6_2f7a:		bne B6_2f66 ; d0 ea

B6_2f7c:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_2f7e:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_2f7e:	.db $ea $ea $ea
.endif
B6_2f81:		stx $30			; 86 30
B6_2f83:		lda wHealthGiven			; a5 77
B6_2f85:		beq B6_2f90 ; f0 09

B6_2f87:		jsr processExp_etc_todo		; 20 44 f3
B6_2f8a:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_2f8d:		jmp $af83		; 4c 83 af


B6_2f90:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteFC_1_ocarinaMenu:
B6_2f93:		jsr $a9e6		; 20 e6 a9
; GF_VISITED_NELWYN, etc for ocarina
B6_2f96:		lda #$05		; a9 05
B6_2f98:		sta $00			; 85 00

B6_2f9a:		lda $00			; a5 00
B6_2f9c:		jsr checkGlobalFlag		; 20 6c c4
B6_2f9f:		bne B6_2fa4 ; d0 03

.ifdef FULL_OCARINA_OPTIONS
	jmp B6_2fb8
.else
B6_2fa1:		jmp B6_2fc0		; 4c c0 af
.endif

B6_2fa4:		lda $00			; a5 00
B6_2fa6:		sec				; 38 
B6_2fa7:		sbc #$05		; e9 05
B6_2fa9:		asl a			; 0a
B6_2faa:		tax				; aa 
B6_2fab:		lda data_6_319f.w, x	; bd 9f b1
B6_2fae:		sta wRLEStructAddressToCopy			; 85 33
B6_2fb0:		lda data_6_319f.w+1, x	; bd a0 b1
B6_2fb3:		sta wRLEStructAddressToCopy+1			; 85 34
B6_2fb5:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1

B6_2fb8:		inc $00			; e6 00
B6_2fba:		lda $00			; a5 00
B6_2fbc:		cmp #$0b		; c9 0b
B6_2fbe:		bcc B6_2f9a ; 90 da

B6_2fc0:		lda $00			; a5 00
B6_2fc2:		sec				; 38 
B6_2fc3:		sbc #$06		; e9 06
B6_2fc5:		sta $00			; 85 00
B6_2fc7:		lda #$00		; a9 00
B6_2fc9:		sta $f0			; 85 f0
B6_2fcb:		sta $01			; 85 01
B6_2fcd:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_2fd0:		lda $f0			; a5 f0
B6_2fd2:		sta $f2			; 85 f2
B6_2fd4:		bit wJoy1NewButtonsPressed			; 24 29
B6_2fd6:		bmi B6_2fda ; 30 02

B6_2fd8:		bvc B6_2fdd ; 50 03

B6_2fda:		jmp B6_3073		; 4c 73 b0

B6_2fdd:		lda wJoy1ButtonsPressed			; a5 27
B6_2fdf:		and #PADF_UP|PADF_DOWN|PADF_LEFT|PADF_RIGHT		; 29 0f
B6_2fe1:		beq B6_303a ; f0 57

; pressed directions
B6_2fe3:		lda $01			; a5 01
B6_2fe5:		clc				; 18 
B6_2fe6:		adc #$10		; 69 10
B6_2fe8:		sta $01			; 85 01
B6_2fea:		bne B6_303e ; d0 52

B6_2fec:		lda wJoy1ButtonsPressed			; a5 27
B6_2fee:		and #PADF_UP|PADF_DOWN		; 29 0c
B6_2ff0:		beq B6_3026 ; f0 34

B6_2ff2:		pha				; 48 
B6_2ff3:		lda #$27		; a9 27
B6_2ff5:		jsr queueSoundAtoPlay		; 20 ad c4
B6_2ff8:		pla				; 68 
B6_2ff9:		eor #$0c		; 49 0c
B6_2ffb:		sec				; 38 
B6_2ffc:		sbc #$06		; e9 06
B6_2ffe:		clc				; 18 
B6_2fff:		adc $f0			; 65 f0
B6_3001:		bmi B6_3019 ; 30 16

B6_3003:		cmp #$06		; c9 06
B6_3005:		bcs B6_300c ; b0 05

B6_3007:		sta $f0			; 85 f0
B6_3009:		jmp B6_303e		; 4c 3e b0

B6_300c:		ldx #$01		; a2 01
B6_300e:		cmp #$06		; c9 06
B6_3010:		bne B6_3014 ; d0 02

B6_3012:		ldx #$00		; a2 00
B6_3014:		stx $f0			; 86 f0
B6_3016:		jmp B6_303e		; 4c 3e b0

B6_3019:		ldx #$05		; a2 05
B6_301b:		cmp #$fe		; c9 fe
B6_301d:		bne B6_3021 ; d0 02

B6_301f:		ldx #$04		; a2 04
B6_3021:		stx $f0			; 86 f0
B6_3023:		jmp B6_303e		; 4c 3e b0

B6_3026:		lda wJoy1ButtonsPressed			; a5 27
B6_3028:		and #PADF_LEFT|PADF_RIGHT		; 29 03
B6_302a:		beq B6_303e ; f0 12

B6_302c:		lda #$27		; a9 27
B6_302e:		jsr queueSoundAtoPlay		; 20 ad c4
B6_3031:		lda $f0			; a5 f0
B6_3033:		eor #$01		; 49 01
B6_3035:		sta $f0			; 85 f0
B6_3037:		jmp B6_303e		; 4c 3e b0

B6_303a:		lda #$e0		; a9 e0
B6_303c:		sta $01			; 85 01

B6_303e:		lda $00			; a5 00
B6_3040:		cmp $f0			; c5 f0
B6_3042:		bcs B6_3048 ; b0 04

B6_3044:		lda $f2			; a5 f2
B6_3046:		sta $f0			; 85 f0
B6_3048:		ldx #$90		; a2 90
B6_304a:		ldy $f0			; a4 f0
B6_304c:		lda wMajorNMIUpdatesCounter			; a5 23
B6_304e:		and #$08		; 29 08
B6_3050:		beq B6_306b ; f0 19

B6_3052:		lda $b244, y	; b9 44 b2
B6_3055:		sta wOam.Y.w, x	; 9d 00 02
B6_3058:		lda $b24a, y	; b9 4a b2
B6_305b:		sta wOam.X.w, x	; 9d 03 02
B6_305e:		lda #$6e		; a9 6e
B6_3060:		sta wOam.tile.w, x	; 9d 01 02
B6_3063:		lda #$02		; a9 02
B6_3065:		sta wOam.attr.w, x	; 9d 02 02
B6_3068:		jmp $afcd		; 4c cd af

B6_306b:		lda #$f8		; a9 f8
B6_306d:		sta wOam.Y.w, x	; 9d 00 02
B6_3070:		jmp $afcd		; 4c cd af

; pressed a/b
B6_3073:		lda $00			; a5 00
B6_3075:		cmp $f0			; c5 f0
B6_3077:		bcs B6_307c ; b0 03

B6_3079:		jmp $afcd		; 4c cd af


B6_307c:		lda $f0			; a5 f0
B6_307e:		asl a			; 0a
B6_307f:		tax				; aa 
B6_3080:		lda $e065, x	; bd 65 e0
B6_3083:		sta wRoomY			; 85 43
B6_3085:		lda $e066, x	; bd 66 e0
B6_3088:		sta wRoomX			; 85 42
B6_308a:		jsr $a9e6		; 20 e6 a9
B6_308d:		lda #$00		; a9 00
B6_308f:		sta $69			; 85 69
B6_3091:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteFC_3_attemptHealFin:
B6_3094:		lda #$38		; a9 38
B6_3096:		jsr queueSoundAtoPlay		; 20 ad c4
B6_3099:		ldx #$08		; a2 08
B6_309b:		lda #$39		; a9 39
B6_309d:		jsr $a228		; 20 28 a2
B6_30a0:		inx				; e8 
B6_30a1:		cpx #$0c		; e0 0c
B6_30a3:		bne B6_309b ; d0 f6

B6_30a5:		ldx #$09		; a2 09
B6_30a7:		ldy #$00		; a0 00
B6_30a9:		lda $b3bd, y	; b9 bd b3
B6_30ac:		sta wEntitiesY.w, x	; 9d 80 04
B6_30af:		lda $b3c0, y	; b9 c0 b3
B6_30b2:		sta wEntitiesX.w, x	; 9d b0 04
B6_30b5:		inx				; e8 
B6_30b6:		iny				; c8 
B6_30b7:		cpx #$0c		; e0 0c
B6_30b9:		bne B6_30a9 ; d0 ee

B6_30bb:		lda #$58		; a9 58
B6_30bd:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_30c0:		lda #$fc		; a9 fc
B6_30c2:		sta wGenericCounter			; 85 2d
B6_30c4:		jsr drawEntities		; 20 03 c4
B6_30c7:		jsr drawPlayer		; 20 dd c3
B6_30ca:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_30cd:		dec wGenericCounter			; c6 2d
B6_30cf:		bne B6_30c4 ; d0 f3

; level must be >= $12 (13 ingame) to heal fin raziel
B6_30d1:		ldy #$05		; a0 05
B6_30d3:		ldx #$41		; a2 41
B6_30d5:		lda wCurrLevel			; a5 71
B6_30d7:		cmp #12		; c9 0c
B6_30d9:		bcs B6_30e6 ; b0 0b

B6_30db:		dex				; ca 
B6_30dc:		inc $a2			; e6 a2
B6_30de:		ldy $a2			; a4 a2
B6_30e0:		cpy #$05		; c0 05
B6_30e2:		bcc B6_30e8 ; 90 04

B6_30e4:		ldy #$01		; a0 01
B6_30e6:		sty $a2			; 84 a2
B6_30e8:		stx $6b			; 86 6b
B6_30ea:		lda #$00		; a9 00
B6_30ec:		sta wNPCTextByteOffset			; 85 62
B6_30ee:		tya				; 98 
B6_30ef:		jsr func_6_3192		; 20 92 b1
B6_30f2:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_30f5:		ldy $a2			; a4 a2
B6_30f7:		lda $b3b1, y	; b9 b1 b3
B6_30fa:		ldx #$08		; a2 08
B6_30fc:		jsr $a228		; 20 28 a2
B6_30ff:		lda #$00		; a9 00
B6_3101:		sta $0301, x	; 9d 01 03
B6_3104:		sta $0302, x	; 9d 02 03
B6_3107:		sta $0303, x	; 9d 03 03
B6_310a:		ldy $a2			; a4 a2
B6_310c:		lda $b3b7, y	; b9 b7 b3
B6_310f:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_3112:		jsr drawEntities		; 20 03 c4
B6_3115:		jsr drawPlayer		; 20 dd c3
B6_3118:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_311b:		jmp $a7e0		; 4c e0 a7


B6_311e:		lda #GF_HEALED_FIN_RAZIEL		; a9 04
B6_3120:		jsr checkGlobalFlag		; 20 6c c4
B6_3123:		beq B6_3129 ; f0 04

B6_3125:		lda #$05		; a9 05
B6_3127:		sta $a2			; 85 a2
B6_3129:		lda $a2			; a5 a2
B6_312b:		beq B6_3141 ; f0 14

B6_312d:		jsr func_6_3192		; 20 92 b1
B6_3130:		ldy $a2			; a4 a2
B6_3132:		lda $b3b1, y	; b9 b1 b3
B6_3135:		ldx #$08		; a2 08
B6_3137:		jsr $a228		; 20 28 a2
B6_313a:		ldy $a2			; a4 a2
B6_313c:		lda $b3b7, y	; b9 b7 b3
B6_313f:		sta $6e			; 85 6e
B6_3141:		rts				; 60 


textByteF6_todo:
B6_3142:		jsr getTextByteIncPointer		; 20 b9 aa
B6_3145:		jsr func_6_3192		; 20 92 b1
B6_3148:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_314b:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteF5_setRoomYX:
B6_314e:		jsr getTextByteIncPointer		; 20 b9 aa
B6_3151:		sta wRoomY			; 85 43
B6_3153:		jsr getTextByteIncPointer		; 20 b9 aa
B6_3156:		sta wRoomX			; 85 42
B6_3158:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteFC_4_healMuzh:
B6_315b:		lda #$24		; a9 24
B6_315d:		ldx #$08		; a2 08
B6_315f:		jsr $a228		; 20 28 a2
B6_3162:		inx				; e8 
B6_3163:		lda #$5c		; a9 5c
B6_3165:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_3168:		lda #$c0		; a9 c0
B6_316a:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_316d:		lda #$48		; a9 48
B6_316f:		sta wEntitiesY.w, x	; 9d 80 04
B6_3172:		lda #$c0		; a9 c0
B6_3174:		sta wEntitiesX.w, x	; 9d b0 04
B6_3177:		jmp incTextByteOffset_setDelay		; 4c 56 a8


textByteFC_5_scareGuardWithSlime:
B6_317a:		lda #$00		; a9 00
B6_317c:		sta $0308		; 8d 08 03
B6_317f:		sta $0309		; 8d 09 03
B6_3182:		jmp incTextByteOffset_setDelay		; 4c 56 a8

; changes script 67 to 68 (guard at final dungeon) if slime
; ie if $bf == 09
B6_3185:		ldy #$67		; a0 67
B6_3187:		lda $bf			; a5 bf
B6_3189:		cmp #$09		; c9 09
B6_318b:		bne B6_318f ; d0 02

B6_318d:		ldy #$68		; a0 68
B6_318f:		sty $6b			; 84 6b
B6_3191:		rts				; 60 


func_6_3192:
B6_3192:		asl a			; 0a
B6_3193:		tax				; aa 
B6_3194:		lda data_6_3250.w, x	; bd 50 b2
B6_3197:		sta wRLEStructAddressToCopy			; 85 33
B6_3199:		lda data_6_3250.w+1, x	; bd 51 b2
B6_319c:		sta wRLEStructAddressToCopy+1			; 85 34
B6_319e:		rts				; 60 


data_6_319f:
	.dw $b204 ; nelwyn
	.dw $b20e ; dew
	.dw $b215
	.dw $b223
	.dw $b22a
	.dw $b238


B6_31ab:	.db $22
B6_31ac:		inc $08			; e6 08
B6_31ae:	.db $5a
B6_31af:	.db $6b
B6_31b0:	.db $22
B6_31b1:		adc $70, x		; 75 70
B6_31b3:		and #$31		; 29 31
B6_31b5:	.db $37
B6_31b6:	.db $ff
B6_31b7:	.db $22
B6_31b8:		sbc ($06), y	; f1 06
B6_31ba:		eor $73, x		; 55 73
B6_31bc:	.db $0f
B6_31bd:		and #$31		; 29 31
B6_31bf:	.db $37
B6_31c0:	.db $22
B6_31c1:		cmp ($01), y	; d1 01
B6_31c3:		adc $23ff, y	; 79 ff 23
B6_31c6:		rol $05			; 26 05
B6_31c8:	.db $5f
B6_31c9:	.db $0f
B6_31ca:		and #$2b		; 29 2b
B6_31cc:		and $0623		; 2d 23 06
B6_31cf:		ora ($78, x)	; 01 78
B6_31d1:	.db $ff
B6_31d2:	.db $23
B6_31d3:		and ($08), y	; 31 08
B6_31d5:	.db $43
B6_31d6:		ora ($11), y	; 11 11
B6_31d8:	.db $47
B6_31d9:		and #$1a		; 29 1a
B6_31db:		ora $10, x		; 15 10
B6_31dd:	.db $23
B6_31de:	.db $12
B6_31df:	.db $02
B6_31e0:		adc $2379, y	; 79 79 23
B6_31e3:		clc				; 18 
B6_31e4:		ora ($79, x)	; 01 79
B6_31e6:	.db $ff
B6_31e7:	.db $23
B6_31e8:		ror $09			; 66 09
B6_31ea:		eor $75, x		; 55 75
B6_31ec:	.db $1f
B6_31ed:		jsr $4f1f		; 20 1f 4f
B6_31f0:		ror a			; 6a
B6_31f1:	.db $0f
B6_31f2:		;removed
	.db $70 $ff

B6_31f4:	.db $23
B6_31f5:		adc ($08), y	; 71 08
B6_31f7:		rts				; 60 


B6_31f8:		adc ($4a), y	; 71 4a
B6_31fa:		adc ($0f, x)	; 61 0f
B6_31fc:	.db $1b
B6_31fd:	.db $42
B6_31fe:		bit $5623		; 2c 23 56
B6_3201:		ora ($79, x)	; 01 79
B6_3203:	.db $ff
B6_3204:	.db $22
B6_3205:		inc $06			; e6 06
B6_3207:		lsr $4c45		; 4e 45 4c
B6_320a:	.db $57
B6_320b:		eor $ff4e, y	; 59 4e ff
B6_320e:	.db $22
B6_320f:		sbc ($03), y	; f1 03
B6_3211:	.db $44
B6_3212:		eor $57			; 45 57
B6_3214:	.db $ff
B6_3215:	.db $23
B6_3216:		rol $0a			; 26 0a
B6_3218:		bvc B6_3269 ; 50 4f

B6_321a:	.db $27
B6_321b:	.db $53
B6_321c:		jsr $4f48		; 20 48 4f
B6_321f:		eor $53, x		; 55 53
B6_3221:		eor $ff			; 45 ff
B6_3223:	.db $23
B6_3224:		and ($03), y	; 31 03
B6_3226:	.db $42
B6_3227:		eor ($52, x)	; 41 52
B6_3229:	.db $ff
B6_322a:	.db $23
B6_322b:		ror $0a			; 66 0a
B6_322d:	.db $54
B6_322e:		eor #$52		; 49 52
B6_3230:		jsr $5341		; 20 41 53
B6_3233:		jmp $4545		; 4c 45 45


B6_3236:		lsr $23ff		; 4e ff 23
B6_3239:		adc ($08), y	; 71 08
B6_323b:		lsr $434f		; 4e 4f 43
B6_323e:	.db $4b
B6_323f:		eor $4141		; 4d 41 41
B6_3242:	.db $52
B6_3243:	.db $ff
B6_3244:		clv				; b8 
B6_3245:		clv				; b8 
B6_3246:		iny				; c8 
B6_3247:		iny				; c8 
B6_3248:		cld				; d8 
B6_3249:		cld				; d8 
B6_324a:		plp				; 28 
B6_324b:	.db $80
B6_324c:		plp				; 28 
B6_324d:	.db $80
B6_324e:		plp				; 28 
B6_324f:	.db $80

data_6_3250:
	.dw $b264
	.dw $b264
	.dw $b289
	.dw $b2ae
	.dw $b2d3
	.dw $b2f8
	.dw $b31d
	.dw $b342
	.dw $b367
	.dw $b38c


B6_3264:		.db $21
B6_3265:		sty $86			; 84 86
B6_3267:		ldy #$a1		; a0 a1
B6_3269:		cpy #$c1		; c0 c1
B6_326b:		cpx #$e1		; e0 e1

B6_326d:		and ($85, x)	; 21 85
B6_326f:		stx $a2			; 86 a2
B6_3271:	.db $a3
B6_3272:	.db $c2
B6_3273:	.db $c3
B6_3274:	.db $e2
B6_3275:	.db $e3

B6_3276:		and ($86, x)	; 21 86
B6_3278:		stx $a4			; 86 a4
B6_327a:		lda $c4			; a5 c4
B6_327c:		cmp $e4			; c5 e4
B6_327e:		sbc $21			; e5 21
B6_3280:	.db $87
B6_3281:		stx $a6			; 86 a6
B6_3283:	.db $a7
B6_3284:		dec wPlayerKnockbackCounter			; c6 c7
B6_3286:		inc $e7			; e6 e7
B6_3288:	.db $ff


B6_3289:		and ($84, x)	; 21 84
B6_328b:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B6_328d:		eor ($60, x)	; 41 60
B6_328f:		adc ($80, x)	; 61 80
B6_3291:		sta ($21, x)	; 81 21
B6_3293:		sta $86			; 85 86
B6_3295:	.db $42
B6_3296:	.db $43
B6_3297:	.db $62
B6_3298:	.db $63
B6_3299:	.db $82
B6_329a:	.db $83
B6_329b:		and ($86, x)	; 21 86
B6_329d:		stx $44			; 86 44
B6_329f:		eor $64			; 45 64
B6_32a1:		adc $84			; 65 84
B6_32a3:		sta $21			; 85 21
B6_32a5:	.db $87
B6_32a6:		stx $46			; 86 46
B6_32a8:	.db $47
B6_32a9:		ror $67			; 66 67
B6_32ab:		stx $87			; 86 87
B6_32ad:	.db $ff
B6_32ae:		and ($84, x)	; 21 84
B6_32b0:		stx $a8			; 86 a8
B6_32b2:		lda #$c8		; a9 c8
B6_32b4:		cmp #$e8		; c9 e8
B6_32b6:		sbc #$21		; e9 21
B6_32b8:		sta $86			; 85 86
B6_32ba:		tax				; aa 
B6_32bb:	.db $ab
B6_32bc:		dex				; ca 
B6_32bd:	.db $cb
B6_32be:		nop				; ea 
B6_32bf:	.db $eb
B6_32c0:		and ($86, x)	; 21 86
B6_32c2:		stx $ac			; 86 ac
B6_32c4:		lda $cdcc		; ad cc cd
B6_32c7:		cpx $21ed		; ec ed 21
B6_32ca:	.db $87
B6_32cb:		stx $ae			; 86 ae
B6_32cd:	.db $af
B6_32ce:		dec $eecf		; ce cf ee
B6_32d1:	.db $ef
B6_32d2:	.db $ff
B6_32d3:		and ($84, x)	; 21 84
B6_32d5:		stx $58			; 86 58
B6_32d7:		eor $7978, y	; 59 78 79
B6_32da:		tya				; 98 
B6_32db:		sta $8521, y	; 99 21 85
B6_32de:		stx $5a			; 86 5a
B6_32e0:	.db $5b
B6_32e1:	.db $7a
B6_32e2:	.db $7b
B6_32e3:		txs				; 9a 
B6_32e4:	.db $9b
B6_32e5:		and ($86, x)	; 21 86
B6_32e7:		stx $5c			; 86 5c
B6_32e9:		eor $7d7c, x	; 5d 7c 7d
B6_32ec:	.db $9c
B6_32ed:		sta $8721, x	; 9d 21 87
B6_32f0:		stx $5e			; 86 5e
B6_32f2:	.db $5f
B6_32f3:		ror $9e7f, x	; 7e 7f 9e
B6_32f6:	.db $9f
B6_32f7:	.db $ff
B6_32f8:		and ($84, x)	; 21 84
B6_32fa:		stx $b0			; 86 b0
B6_32fc:		lda ($d0), y	; b1 d0
B6_32fe:		cmp ($f0), y	; d1 f0
B6_3300:		sbc ($21), y	; f1 21
B6_3302:		sta $86			; 85 86
B6_3304:	.db $b2
B6_3305:	.db $b3
B6_3306:	.db $d2
B6_3307:	.db $d3
B6_3308:	.db $f2
B6_3309:	.db $f3
B6_330a:		and ($86, x)	; 21 86
B6_330c:		stx $b4			; 86 b4
B6_330e:		lda $d4, x		; b5 d4
B6_3310:		cmp $f4, x		; d5 f4
B6_3312:		sbc $21, x		; f5 21
B6_3314:	.db $87
B6_3315:		stx $b6			; 86 b6
B6_3317:	.db $b7
B6_3318:		dec $d7, x		; d6 d7
B6_331a:		inc $f7, x		; f6 f7
B6_331c:	.db $ff
B6_331d:		and $84			; 25 84
B6_331f:		stx $50			; 86 50
B6_3321:		eor ($68), y	; 51 68
B6_3323:		adc #$90		; 69 90
B6_3325:		sta ($25), y	; 91 25
B6_3327:		sta $86			; 85 86
B6_3329:	.db $52
B6_332a:	.db $53
B6_332b:		ror a			; 6a
B6_332c:	.db $6b
B6_332d:	.db $92
B6_332e:	.db $93
B6_332f:		and $86			; 25 86
B6_3331:		stx $54			; 86 54
B6_3333:		eor $6c, x		; 55 6c
B6_3335:		adc $9594		; 6d 94 95
B6_3338:		and $87			; 25 87
B6_333a:		stx $56			; 86 56
B6_333c:	.db $57
B6_333d:		ror $966f		; 6e 6f 96
B6_3340:	.db $97
B6_3341:	.db $ff
B6_3342:		and $84			; 25 84
B6_3344:		stx $b8			; 86 b8
B6_3346:		lda $d9d8, y	; b9 d8 d9
B6_3349:		sed				; f8 
B6_334a:		sbc $8525, y	; f9 25 85
B6_334d:		stx $ba			; 86 ba
B6_334f:	.db $bb
B6_3350:	.db $da
B6_3351:	.db $db
B6_3352:	.db $fa
B6_3353:	.db $fb
B6_3354:		and $86			; 25 86
B6_3356:		stx $bc			; 86 bc
B6_3358:		lda $dddc, x	; bd dc dd
B6_335b:	.db $fc
B6_335c:		sbc $8725, x	; fd 25 87
B6_335f:		stx $be			; 86 be
B6_3361:	.db $bf
B6_3362:		dec $fedf, x	; de df fe
B6_3365:	.db $ff
B6_3366:	.db $ff
B6_3367:		and ($84, x)	; 21 84
B6_3369:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B6_336b:		eor ($60, x)	; 41 60
B6_336d:		adc ($80, x)	; 61 80
B6_336f:		sta ($21, x)	; 81 21
B6_3371:		sta $86			; 85 86
B6_3373:	.db $42
B6_3374:	.db $43
B6_3375:	.db $62
B6_3376:	.db $63
B6_3377:	.db $82
B6_3378:	.db $83
B6_3379:		and ($86, x)	; 21 86
B6_337b:		stx $44			; 86 44
B6_337d:		eor $64			; 45 64
B6_337f:		adc $84			; 65 84
B6_3381:		sta $21			; 85 21
B6_3383:	.db $87
B6_3384:		stx $46			; 86 46
B6_3386:	.db $47
B6_3387:		ror $67			; 66 67
B6_3389:		stx $87			; 86 87
B6_338b:	.db $ff
B6_338c:		and ($84, x)	; 21 84
B6_338e:		stx $a8			; 86 a8
B6_3390:		lda #$c8		; a9 c8
B6_3392:		cmp #$e8		; c9 e8
B6_3394:		sbc #$21		; e9 21
B6_3396:		sta $86			; 85 86
B6_3398:		tax				; aa 
B6_3399:	.db $ab
B6_339a:		dex				; ca 
B6_339b:	.db $cb
B6_339c:		nop				; ea 
B6_339d:	.db $eb
B6_339e:		and ($86, x)	; 21 86
B6_33a0:		stx $ac			; 86 ac
B6_33a2:		lda $cdcc		; ad cc cd
B6_33a5:		cpx $21ed		; ec ed 21
B6_33a8:	.db $87
B6_33a9:		stx $ae			; 86 ae
B6_33ab:	.db $af
B6_33ac:		dec $eecf		; ce cf ee
B6_33af:	.db $ef
B6_33b0:	.db $ff
B6_33b1:	.db $37
B6_33b2:		sec				; 38 
B6_33b3:	.db $3b
B6_33b4:	.db $3a
B6_33b5:	.db $37
B6_33b6:	.db $3c
B6_33b7:	.db $54
B6_33b8:	.db $52
B6_33b9:		bvc B6_340d ; 50 52

B6_33bb:	.db $54
B6_33bc:		eor $686c, y	; 59 6c 68
B6_33bf:		rts				; 60 


B6_33c0:		sty $a4, x		; 94 a4
B6_33c2:		tya				; 98 

func_6_33c3:
B6_33c3:		ldy #$04		; a0 04
B6_33c5:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B6_33c8:		jsr func_6_1fa0		; 20 a0 9f
B6_33cb:		jsr func_6_02a1		; 20 a1 82
B6_33ce:		lda #$02		; a9 02
B6_33d0:		sta wPlayerDirectionFacing			; 85 c9
B6_33d2:		jsr setPlayerMovementAnimationDetails		; 20 c4 82
B6_33d5:		jsr drawEntities		; 20 03 c4
B6_33d8:		jsr drawPlayer		; 20 dd c3
B6_33db:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_33de:		ldx #$ff		; a2 ff
B6_33e0:		txs				; 9a 
B6_33e1:		jmp mainLoop		; 4c a9 de


func_6_33e4:
B6_33e4:		jsr setPPUMask_noSprites		; 20 53 c1
B6_33e7:		jsr setPPUCtrl_noNMI		; 20 64 c1
B6_33ea:		lda wPPUCtrl			; a5 20
B6_33ec:		ora #$01		; 09 01
B6_33ee:		sta wPPUCtrl			; 85 20
B6_33f0:		sta PPUCTRL.w		; 8d 00 20
B6_33f3:		jsr fillNametables01With20h		; 20 b1 c2
B6_33f6:		jsr hideAllOam		; 20 9f c3

B6_33f9:		lda #$1e		; a9 1e
B6_33fb:		sta wRoomY			; 85 43
B6_33fd:		lda #$1b		; a9 1b
B6_33ff:		sta wRoomX			; 85 42

B6_3401:		jsr b6_loadAllScreenRowsForCurrRoom		; 20 f3 de
B6_3404:		ldy #$20		; a0 20
B6_3406:		ldx #$00		; a2 00
B6_3408:		lda #$80		; a9 80
B6_340a:		sta $0640, x	; 9d 40 06
B6_340d:		inx				; e8 
B6_340e:		dey				; 88 
B6_340f:		bne B6_340a ; d0 f9

B6_3411:		lda #$7e		; a9 7e
B6_3413:		sta wRLEStructAddressToCopy			; 85 33
B6_3415:		lda #$b9		; a9 b9
B6_3417:		sta wRLEStructAddressToCopy+1			; 85 34
B6_3419:		jsr updateFromRLEStruct		; 20 2f c3
B6_341c:		lda #$b8		; a9 b8
B6_341e:		sta wRLEStructAddressToCopy			; 85 33
B6_3420:		lda #$b9		; a9 b9
B6_3422:		sta wRLEStructAddressToCopy+1			; 85 34
B6_3424:		jsr updateFromRLEStruct		; 20 2f c3
B6_3427:		lda #$0c		; a9 0c
B6_3429:		jsr queueSoundAtoPlay		; 20 ad c4
B6_342c:		jsr setPPUCtrl_addNMI_bgAt1000h		; 20 6e c1
B6_342f:		jsr setPPUMask_addShowAll		; 20 5d c1
B6_3432:		lda #$05		; a9 05
B6_3434:		ldy #$04		; a0 04
B6_3436:		jsr func_7_0636		; 20 36 c6

B6_3439:		lda #$00		; a9 00
B6_343b:		sta $a0			; 85 a0
B6_343d:		sta $a1			; 85 a1
B6_343f:		sta $01			; 85 01

B6_3441:		lda wJoy1NewButtonsPressed			; a5 29
B6_3443:		and #PADF_START		; 29 10
B6_3445:		beq B6_344a ; f0 03

B6_3447:		jmp B6_353b		; 4c 3b b5

B6_344a:		bit wJoy1NewButtonsPressed			; 24 29
B6_344c:		bmi B6_3453 ; 30 05

B6_344e:		bvc B6_3456 ; 50 06

B6_3450:		jmp func_6_360b		; 4c 0b b6

B6_3453:		jmp func_6_3591		; 4c 91 b5

B6_3456:		lda wJoy1ButtonsPressed			; a5 27
B6_3458:		and #PADF_UP|PADF_DOWN|PADF_LEFT|PADF_RIGHT		; 29 0f
B6_345a:		beq B6_34b2 ; f0 56

B6_345c:		lda $01			; a5 01
B6_345e:		clc				; 18 
B6_345f:		adc #$20		; 69 20
B6_3461:		sta $01			; 85 01
B6_3463:		bne B6_34b9 ; d0 54

B6_3465:		lda wJoy1ButtonsPressed			; a5 27
B6_3467:		and #$03		; 29 03
B6_3469:		beq B6_3486 ; f0 1b

B6_346b:		eor #$03		; 49 03
B6_346d:		asl a			; 0a
B6_346e:		sec				; 38 
B6_346f:		sbc #$03		; e9 03
B6_3471:		sta $00			; 85 00
B6_3473:		clc				; 18 
B6_3474:		adc $a1			; 65 a1
B6_3476:		and #$0f		; 29 0f
B6_3478:		sta $03			; 85 03
B6_347a:		lda $a1			; a5 a1
B6_347c:		and #$f0		; 29 f0
B6_347e:		clc				; 18 
B6_347f:		adc $03			; 65 03
B6_3481:		sta $a1			; 85 a1
B6_3483:		jmp B6_34b9		; 4c b9 b4

B6_3486:		lda wJoy1ButtonsPressed			; a5 27
B6_3488:		and #PADF_UP|PADF_DOWN		; 29 0c
B6_348a:		beq B6_34b2 ; f0 26

B6_348c:		eor #$0c		; 49 0c
B6_348e:		asl a			; 0a
B6_348f:		asl a			; 0a
B6_3490:		asl a			; 0a
B6_3491:		sec				; 38 
B6_3492:		sbc #$30		; e9 30
B6_3494:		sta $00			; 85 00
B6_3496:		clc				; 18 
B6_3497:		adc $a1			; 65 a1
B6_3499:		sta $a1			; 85 a1
B6_349b:		cmp #$50		; c9 50
B6_349d:		bcc B6_34b9 ; 90 1a

B6_349f:		cmp #$f0		; c9 f0
B6_34a1:		bcc B6_34aa ; 90 07

B6_34a3:		sbc #$b0		; e9 b0
B6_34a5:		sta $a1			; 85 a1
B6_34a7:		jmp B6_34b9		; 4c b9 b4

B6_34aa:		sec				; 38 
B6_34ab:		sbc #$50		; e9 50
B6_34ad:		sta $a1			; 85 a1
B6_34af:		jmp B6_34b9		; 4c b9 b4

B6_34b2:		lda #$e0		; a9 e0
B6_34b4:		sta $01			; 85 01
B6_34b6:		jmp B6_34dc		; 4c dc b4

B6_34b9:		lda $a1			; a5 a1
B6_34bb:		and #$0f		; 29 0f
B6_34bd:		cmp #$05		; c9 05
B6_34bf:		beq B6_34c5 ; f0 04

B6_34c1:		cmp #$0b		; c9 0b
B6_34c3:		bne B6_34c8 ; d0 03

B6_34c5:		jsr func_6_38fa		; 20 fa b8
B6_34c8:		ldx #$00		; a2 00
B6_34ca:		lda $a1			; a5 a1
B6_34cc:		cmp $ba21, x	; dd 21 ba
B6_34cf:		bne B6_34d7 ; d0 06

B6_34d1:		jsr func_6_38fa		; 20 fa b8
B6_34d4:		jmp B6_34b9		; 4c b9 b4

B6_34d7:		inx				; e8 
B6_34d8:		cpx #$04		; e0 04
B6_34da:		bne B6_34ca ; d0 ee

B6_34dc:		lda wMajorNMIUpdatesCounter			; a5 23
B6_34de:		and #$08		; 29 08
B6_34e0:		beq B6_3531 ; f0 4f

B6_34e2:		lda $a1			; a5 a1
B6_34e4:		and #$f0		; 29 f0
B6_34e6:		clc				; 18 
B6_34e7:		adc #$78		; 69 78
B6_34e9:		sta $0204		; 8d 04 02
B6_34ec:		lda $a1			; a5 a1
B6_34ee:		and #$0f		; 29 0f
B6_34f0:		asl a			; 0a
B6_34f1:		asl a			; 0a
B6_34f2:		asl a			; 0a
B6_34f3:		clc				; 18 
B6_34f4:		adc #$40		; 69 40
B6_34f6:		sta $0207		; 8d 07 02
B6_34f9:		lda #$6d		; a9 6d
B6_34fb:		sta $0205		; 8d 05 02
B6_34fe:		lda #$00		; a9 00
B6_3500:		sta $0206		; 8d 06 02
B6_3503:		ldx #$38		; a2 38
B6_3505:		lda $a0			; a5 a0
B6_3507:		cmp #$0b		; c9 0b
B6_3509:		bcc B6_350d ; 90 02

B6_350b:		ldx #$48		; a2 48
B6_350d:		stx $0208		; 8e 08 02
B6_3510:		lda $a0			; a5 a0
B6_3512:		cmp #$0b		; c9 0b
B6_3514:		bcc B6_3518 ; 90 02

B6_3516:		sbc #$0b		; e9 0b
B6_3518:		asl a			; 0a
B6_3519:		asl a			; 0a
B6_351a:		asl a			; 0a
B6_351b:		clc				; 18 
B6_351c:		adc #$50		; 69 50
B6_351e:		sta $020b		; 8d 0b 02
B6_3521:		lda #$6d		; a9 6d
B6_3523:		sta $0209		; 8d 09 02
B6_3526:		lda #$00		; a9 00
B6_3528:		sta $020a		; 8d 0a 02
B6_352b:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_352e:		jmp B6_3441		; 4c 41 b4

B6_3531:		lda #$f8		; a9 f8
B6_3533:		sta $0204		; 8d 04 02
B6_3536:		sta $0208		; 8d 08 02
B6_3539:		bne B6_352b ; d0 f0

B6_353b:		ldx #$12		; a2 12
B6_353d:		stx $02			; 86 02
B6_353f:		dex				; ca 
B6_3540:		lda $0640, x	; bd 40 06
B6_3543:		cmp #$40		; c9 40
B6_3545:		bcs B6_3558 ; b0 11

B6_3547:		dex				; ca 
B6_3548:		bpl B6_3540 ; 10 f6

B6_354a:		jsr func_6_3574		; 20 74 b5
B6_354d:		bcc B6_3565 ; 90 16

B6_354f:		jsr func_6_376e		; 20 6e b7
B6_3552:		jsr func_6_378e		; 20 8e b7
B6_3555:		jsr $b7e1		; 20 e1 b7
B6_3558:		lda #$2b		; a9 2b
B6_355a:		jsr queueSoundAtoPlay		; 20 ad c4
B6_355d:		lda #$3f		; a9 3f
B6_355f:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B6_3562:		jmp B6_3439		; 4c 39 b4

B6_3565:		lda $f5			; a5 f5
B6_3567:		sta $23			; 85 23
B6_3569:		lda #$24		; a9 24
B6_356b:		jsr queueSoundAtoPlay		; 20 ad c4
B6_356e:		lda #$3e		; a9 3e
B6_3570:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B6_3573:		rts				; 60 


func_6_3574:
B6_3574:		lda #$20		; a9 20
B6_3576:		sta $03			; 85 03

B6_3578:		lda #<$0640		; a9 40
B6_357a:		sta $0a			; 85 0a
B6_357c:		lda #>$0640		; a9 06
B6_357e:		sta $0b			; 85 0b

B6_3580:		jsr func_6_37c6		; 20 c6 b7
B6_3583:		jsr func_6_37a7		; 20 a7 b7
B6_3586:		lda #$00		; a9 00
B6_3588:		sta $01			; 85 01
B6_358a:		jsr func_6_367a		; 20 7a b6
B6_358d:		jsr $b737		; 20 37 b7
B6_3590:		rts				; 60 


func_6_3591:
B6_3591:		lda $a1			; a5 a1
B6_3593:		sec				; 38 
B6_3594:		sbc #$4e		; e9 4e
B6_3596:		bcc B6_35a0 ; 90 08

B6_3598:		bne B6_359d ; d0 03

B6_359a:		jmp func_6_360b		; 4c 0b b6


B6_359d:		jmp $b5e7		; 4c e7 b5


B6_35a0:		lda $a1			; a5 a1
B6_35a2:		sta $05			; 85 05
B6_35a4:		lsr a			; 4a
B6_35a5:		lsr a			; 4a
B6_35a6:		lsr a			; 4a
B6_35a7:		lsr a			; 4a
B6_35a8:		tax				; aa 
B6_35a9:		dec $05			; c6 05
B6_35ab:		dec $05			; c6 05
B6_35ad:		dex				; ca 
B6_35ae:		bne B6_35a9 ; d0 f9

B6_35b0:		lda $a1			; a5 a1
B6_35b2:		and #$0f		; 29 0f
B6_35b4:		cmp #$05		; c9 05
B6_35b6:		bcc B6_35c0 ; 90 08

B6_35b8:		dec $05			; c6 05
B6_35ba:		cmp #$0b		; c9 0b
B6_35bc:		bcc B6_35c0 ; 90 02

B6_35be:		dec $05			; c6 05
B6_35c0:		ldx #$00		; a2 00
B6_35c2:		lda $a1			; a5 a1
B6_35c4:		cmp $ba21, x	; dd 21 ba
B6_35c7:		bcc B6_35d0 ; 90 07

B6_35c9:		dec $05			; c6 05
B6_35cb:		inx				; e8 
B6_35cc:		cpx #$04		; e0 04
B6_35ce:		bne B6_35c2 ; d0 f2

B6_35d0:		lda $a0			; a5 a0
B6_35d2:		tay				; a8 
B6_35d3:		ldx #$00		; a2 00
B6_35d5:		lda $a0			; a5 a0
B6_35d7:		cmp $ba25, x	; dd 25 ba
B6_35da:		bcc B6_35e2 ; 90 06

B6_35dc:		dey				; 88 
B6_35dd:		inx				; e8 
B6_35de:		cpx #$04		; e0 04
B6_35e0:		bne B6_35d5 ; d0 f3

B6_35e2:		lda $05			; a5 05
B6_35e4:		sta $0640, y	; 99 40 06
B6_35e7:		inc $a0			; e6 a0
B6_35e9:		ldx #$00		; a2 00
B6_35eb:		lda $a0			; a5 a0
B6_35ed:		cmp $ba25, x	; dd 25 ba
B6_35f0:		bne B6_35f4 ; d0 02

B6_35f2:		inc $a0			; e6 a0
B6_35f4:		inx				; e8 
B6_35f5:		cpx #$04		; e0 04
B6_35f7:		bne B6_35eb ; d0 f2

B6_35f9:		lda $a0			; a5 a0
B6_35fb:		cmp #$16		; c9 16
B6_35fd:		bcc B6_3601 ; 90 02

B6_35ff:		dec $a0			; c6 a0
B6_3601:		lda #$12		; a9 12
B6_3603:		sta $02			; 85 02
B6_3605:		jsr $b7e1		; 20 e1 b7
B6_3608:		jmp B6_34dc		; 4c dc b4


func_6_360b:
B6_360b:		dec $a0			; c6 a0
B6_360d:		ldx #$00		; a2 00
B6_360f:		lda $a0			; a5 a0
B6_3611:		cmp $ba25, x	; dd 25 ba
B6_3614:		bne B6_3618 ; d0 02

B6_3616:		dec $a0			; c6 a0
B6_3618:		inx				; e8 
B6_3619:		cpx #$04		; e0 04
B6_361b:		bne B6_360f ; d0 f2

B6_361d:		bit $a0			; 24 a0
B6_361f:		bpl B6_3623 ; 10 02

B6_3621:		inc $a0			; e6 a0
B6_3623:		jmp B6_34dc		; 4c dc b4


func_6_3626:
B6_3626:		lda wMajorNMIUpdatesCounter			; a5 23
B6_3628:		sta wRespawnSavedNMIUpdatesCounter			; 85 f5
B6_362a:		lda wRngVar2			; a5 32
B6_362c:		sta wRespawnSavedRngVar2			; 85 f6

B6_362e:		ldx #$00		; a2 00
B6_3630:		stx $00			; 86 00
B6_3632:		txa				; 8a 
B6_3633:		sta $0640, x	; 9d 40 06
B6_3636:		lda #$20		; a9 20
B6_3638:		sta $01			; 85 01
B6_363a:		jsr func_6_3650		; 20 50 b6
B6_363d:		jsr func_6_3700		; 20 00 b7
B6_3640:		stx $02			; 86 02
B6_3642:		jsr func_6_370b		; 20 0b b7
B6_3645:		jsr func_6_376e		; 20 6e b7
B6_3648:		jsr func_6_378e		; 20 8e b7
B6_364b:		rts				; 60 


B6_364c:		jsr $b7e1		; 20 e1 b7
B6_364f:		rts				; 60 


func_6_3650:
B6_3650:		lda #$00		; a9 00
B6_3652:		sta $06			; 85 06
B6_3654:		ldx $06			; a6 06
B6_3656:		lda $b91c, x	; bd 1c b9
B6_3659:		beq B6_3679 ; f0 1e

B6_365b:		sta $07			; 85 07
B6_365d:		lda $b91d, x	; bd 1d b9
B6_3660:		sta $08			; 85 08
B6_3662:		lda $b91e, x	; bd 1e b9
B6_3665:		sta $09			; 85 09
B6_3667:		ldy #$00		; a0 00
B6_3669:		lda ($08), y	; b1 08
B6_366b:		ldy $07			; a4 07
B6_366d:		jsr $b6a0		; 20 a0 b6
B6_3670:		inc $06			; e6 06
B6_3672:		inc $06			; e6 06
B6_3674:		inc $06			; e6 06
B6_3676:		jmp $b654		; 4c 54 b6


B6_3679:		rts				; 60 


; when continuing after game over
func_6_367a:
B6_367a:		lda #$00		; a9 00
B6_367c:		sta $06			; 85 06

-	ldx $06			; a6 06
B6_3680:		lda passwordSavedBits.w+1, x	; bd 1d b9
B6_3683:		sta $08			; 85 08
B6_3685:		lda passwordSavedBits.w+2, x	; bd 1e b9
B6_3688:		sta $09			; 85 09
B6_368a:		lda passwordSavedBits.w, x	; bd 1c b9
B6_368d:		beq B6_369f ; @done

B6_368f:		jsr getNextABitsFrom6bitStruct		; 20 d8 b6
B6_3692:		ldy #$00		; a0 00
B6_3694:		sta ($08), y	; 91 08
B6_3696:		inc $06			; e6 06
B6_3698:		inc $06			; e6 06
B6_369a:		inc $06			; e6 06
	jmp -

@done:
B6_369f:		rts				; 60 


B6_36a0:		sta $0c			; 85 0c
B6_36a2:		txa				; 8a 
B6_36a3:		pha				; 48 
B6_36a4:		tya				; 98 
B6_36a5:		pha				; 48 
B6_36a6:		cpy #$08		; c0 08
B6_36a8:		beq B6_36af ; f0 05

B6_36aa:		asl $0c			; 06 0c
B6_36ac:		iny				; c8 
B6_36ad:		bne B6_36a6 ; d0 f7

B6_36af:		pla				; 68 
B6_36b0:		tay				; a8 
B6_36b1:		asl $0c			; 06 0c
B6_36b3:		bcc B6_36bf ; 90 0a

B6_36b5:		ldx $00			; a6 00
B6_36b7:		lda $0640, x	; bd 40 06
B6_36ba:		ora $01			; 05 01
B6_36bc:		sta $0640, x	; 9d 40 06
B6_36bf:		lsr $01			; 46 01
B6_36c1:		lda $01			; a5 01
B6_36c3:		bne B6_36d2 ; d0 0d

B6_36c5:		inc $00			; e6 00
B6_36c7:		lda #$20		; a9 20
B6_36c9:		sta $01			; 85 01
B6_36cb:		ldx $00			; a6 00
B6_36cd:		lda #$00		; a9 00
B6_36cf:		sta $0640, x	; 9d 40 06
B6_36d2:		dey				; 88 
B6_36d3:		bne B6_36b1 ; d0 dc

B6_36d5:		pla				; 68 
B6_36d6:		tax				; aa 
B6_36d7:		rts				; 60 


getNextABitsFrom6bitStruct:
; from passwordSavedBits, A is param before addr
; num bytes to do below loop
B6_36d8:		sta $0c			; 85 0c

B6_36da:		lda #$00		; a9 00
B6_36dc:		sta $07			; 85 07

; 0 from the very beginning
B6_36de:		ldy $01			; a4 01
; loop here
B6_36e0:		clc				; 18 
B6_36e1:		lda ($0a), y	; b1 0a - eg 640
B6_36e3:		and $03			; 25 03
B6_36e5:		beq B6_36e8 ; f0 01
B6_36e7:		sec				; 38 
B6_36e8:		rol $07			; 26 07
B6_36ea:		lsr $03			; 46 03
B6_36ec:		bne B6_36f7 ; @toLoop

B6_36ee:		lda #$20		; a9 20
B6_36f0:		sta $03			; 85 03
B6_36f2:		iny				; c8 
B6_36f3:		bne B6_36f7 ; @toLoop

B6_36f5:		inc $0b			; e6 0b
@toLoop:
B6_36f7:		dec $0c			; c6 0c
B6_36f9:		bne B6_36e0 ; d0 e5

B6_36fb:		sty $01			; 84 01
B6_36fd:		lda $07			; a5 07
B6_36ff:		rts				; 60 


func_6_3700:
B6_3700:		ldx $00			; a6 00
B6_3702:		lda $01			; a5 01
B6_3704:		cmp #$20		; c9 20
B6_3706:		bne B6_3709 ; d0 01

B6_3708:		dex				; ca 
B6_3709:		inx				; e8 
B6_370a:		rts				; 60 


func_6_370b:
B6_370b:		jsr $b712		; 20 12 b7
B6_370e:		jsr $b725		; 20 25 b7
B6_3711:		rts				; 60 


B6_3712:		ldx #$02		; a2 02
B6_3714:		lda #$00		; a9 00
B6_3716:		clc				; 18 
B6_3717:		adc $0640, x	; 7d 40 06
B6_371a:		inx				; e8 
B6_371b:		cpx $02			; e4 02
B6_371d:		bcc B6_3716 ; 90 f7

B6_371f:		and #$3f		; 29 3f
B6_3721:		sta $0640		; 8d 40 06
B6_3724:		rts				; 60 


B6_3725:		ldx #$02		; a2 02
B6_3727:		lda #$00		; a9 00
B6_3729:		eor $0640, x	; 5d 40 06
B6_372c:		inx				; e8 
B6_372d:		cpx $02			; e4 02
B6_372f:		bcc B6_3729 ; 90 f8

B6_3731:		and #$3f		; 29 3f
B6_3733:		sta $0641		; 8d 41 06
B6_3736:		rts				; 60 


B6_3737:		jsr $b74b		; 20 4b b7
B6_373a:		bne B6_3749 ; d0 0d

B6_373c:		jsr $b75d		; 20 5d b7
B6_373f:		bne B6_3749 ; d0 08

B6_3741:		lda wCurrLevel			; a5 71
B6_3743:		cmp #$10		; c9 10
B6_3745:		bcs B6_3749 ; b0 02

B6_3747:		clc				; 18 
B6_3748:		rts				; 60 


B6_3749:		sec				; 38 
B6_374a:		rts				; 60 


B6_374b:		ldx #$02		; a2 02
B6_374d:		lda #$00		; a9 00
B6_374f:		clc				; 18 
B6_3750:		adc $0640, x	; 7d 40 06
B6_3753:		inx				; e8 
B6_3754:		cpx $02			; e4 02
B6_3756:		bcc B6_374f ; 90 f7

B6_3758:		and #$3f		; 29 3f
B6_375a:		cmp $f0			; c5 f0
B6_375c:		rts				; 60 


B6_375d:		ldx #$02		; a2 02
B6_375f:		lda #$00		; a9 00
B6_3761:		eor $0640, x	; 5d 40 06
B6_3764:		inx				; e8 
B6_3765:		cpx $02			; e4 02
B6_3767:		bcc B6_3761 ; 90 f8

B6_3769:		and #$3f		; 29 3f
B6_376b:		cmp $f1			; c5 f1
B6_376d:		rts				; 60 


func_6_376e:
B6_376e:		ldx #$00		; a2 00
B6_3770:		stx $03			; 86 03
B6_3772:		lda $03			; a5 03
B6_3774:		cmp $02			; c5 02
B6_3776:		beq B6_378d ; f0 15

B6_3778:		tax				; aa 
B6_3779:		and #$03		; 29 03
B6_377b:		tay				; a8 
B6_377c:		lda $0640, x	; bd 40 06
B6_377f:		clc				; 18 
B6_3780:		adc $b94c, y	; 79 4c b9
B6_3783:		and #$3f		; 29 3f
B6_3785:		sta $0640, x	; 9d 40 06
B6_3788:		inc $03			; e6 03
B6_378a:		jmp $b772		; 4c 72 b7


B6_378d:		rts				; 60 


func_6_378e:
B6_378e:		lda #$1f		; a9 1f
B6_3790:		ldx #$00		; a2 00
B6_3792:		cpx $02			; e4 02
B6_3794:		beq B6_37a6 ; f0 10

B6_3796:		bne B6_379b ; d0 03

B6_3798:		lda $063f, x	; bd 3f 06
B6_379b:		eor $0640, x	; 5d 40 06
B6_379e:		sta $0640, x	; 9d 40 06
B6_37a1:		inx				; e8 
B6_37a2:		cpx $02			; e4 02
B6_37a4:		bcc B6_3798 ; 90 f2

B6_37a6:		rts				; 60 


func_6_37a7:
B6_37a7:		ldx #$00		; a2 00
B6_37a9:		stx $00			; 86 00
; loop here
B6_37ab:		lda $00			; a5 00
B6_37ad:		cmp $02			; c5 02
B6_37af:		beq B6_37c5 ; f0 14

B6_37b1:		tax				; aa 
B6_37b2:		and #$03		; 29 03
B6_37b4:		tay				; a8 
B6_37b5:		lda $0640, x	; bd 40 06
B6_37b8:		sec				; 38 
B6_37b9:		sbc $b94c, y	; f9 4c b9
B6_37bc:		and #$3f		; 29 3f
B6_37be:		sta $0640, x	; 9d 40 06
B6_37c1:		inc $00			; e6 00
B6_37c3:		bne B6_37ab ; d0 e6

B6_37c5:		rts				; 60 


; 640 is the idxes of characters entered into password
; eg A = 0, Z = 5
func_6_37c6:
; originally $12
B6_37c6:		ldx $02			; a6 02
B6_37c8:		beq B6_37e0 ; f0 16

B6_37ca:		bne B6_37d5 ; d0 09

B6_37cc:		lda $0640, x	; bd 40 06
B6_37cf:		eor $063f, x	; 5d 3f 06
B6_37d2:		sta $0640, x	; 9d 40 06
B6_37d5:		dex				; ca 
B6_37d6:		bne B6_37cc ; d0 f4

B6_37d8:		lda #$1f		; a9 1f
B6_37da:		eor $0640, x	; 5d 40 06
B6_37dd:		sta $0640, x	; 9d 40 06
B6_37e0:		rts				; 60 


B6_37e1:		jsr $b826		; 20 26 b8
B6_37e4:		lda #$02		; a9 02
B6_37e6:		sta $04			; 85 04
B6_37e8:		ldx wNextVramQueueIdxToFillInFrom			; a6 40
B6_37ea:		ldy #$00		; a0 00
B6_37ec:		lda #$24		; a9 24
B6_37ee:		sta wVramQueue.w, x	; 9d 00 05
B6_37f1:		inx				; e8 
B6_37f2:		lda #$ca		; a9 ca
B6_37f4:		sta wVramQueue.w, x	; 9d 00 05
B6_37f7:		inx				; e8 
B6_37f8:		lda #$0b		; a9 0b
B6_37fa:		sta wVramQueue.w, x	; 9d 00 05
B6_37fd:		inx				; e8 
B6_37fe:		lda $0658, y	; b9 58 06
B6_3801:		sta wVramQueue.w, x	; 9d 00 05
B6_3804:		inx				; e8 
B6_3805:		iny				; c8 
B6_3806:		cpy #$0b		; c0 0b
B6_3808:		beq B6_3810 ; f0 06

B6_380a:		cpy #$16		; c0 16
B6_380c:		beq B6_381e ; f0 10

B6_380e:		bne B6_37fe ; d0 ee

B6_3810:		lda #$25		; a9 25
B6_3812:		sta wVramQueue.w, x	; 9d 00 05
B6_3815:		inx				; e8 
B6_3816:		lda #$0a		; a9 0a
B6_3818:		sta wVramQueue.w, x	; 9d 00 05
B6_381b:		jmp $b7f7		; 4c f7 b7


B6_381e:		stx wNextVramQueueIdxToFillInFrom			; 86 40
B6_3820:		lda #$00		; a9 00
B6_3822:		sta wVramQueue.w, x	; 9d 00 05
B6_3825:		rts				; 60 


B6_3826:		lda #$00		; a9 00
B6_3828:		sta $04			; 85 04
B6_382a:		tay				; a8 
B6_382b:		ldx $04			; a6 04
B6_382d:		lda $0640, x	; bd 40 06
B6_3830:		bmi B6_3836 ; 30 04

B6_3832:		tax				; aa 
B6_3833:		lda $b9df, x	; bd df b9
B6_3836:		sta $0658, y	; 99 58 06
B6_3839:		inc $04			; e6 04
B6_383b:		iny				; c8 
B6_383c:		cpy #$03		; c0 03
B6_383e:		beq B6_384c ; f0 0c

B6_3840:		cpy #$07		; c0 07
B6_3842:		beq B6_384c ; f0 08

B6_3844:		cpy #$0e		; c0 0e
B6_3846:		beq B6_384c ; f0 04

B6_3848:		cpy #$12		; c0 12
B6_384a:		bne B6_3852 ; d0 06

B6_384c:		lda #$80		; a9 80
B6_384e:		sta $0658, y	; 99 58 06
B6_3851:		iny				; c8 
B6_3852:		lda $04			; a5 04
B6_3854:		cmp $02			; c5 02
B6_3856:		bcc B6_382b ; 90 d3

B6_3858:		rts				; 60 


B6_3859:		ldx #$17		; a2 17
B6_385b:		lda $0670, x	; bd 70 06
B6_385e:		sta $0640, x	; 9d 40 06
B6_3861:		dex				; ca 
B6_3862:		bpl B6_385b ; 10 f7

B6_3864:		rts				; 60 


func_6_3865:
B6_3865:		ldx #$17		; a2 17
-	lda $0640, x	; bd 40 06
B6_386a:		sta $0670, x	; 9d 70 06
B6_386d:		dex				; ca 
	bpl -

B6_3870:		rts				; 60 


setRespawnVars:
	ldx wCurrLevel
	lda levelAgility.w, x
	sta wCurrAgility

	lda levelMaxHealth.w, x
	sta wCurrHealth

	lda levelMaxMP.w, x
	sta wCurrMP

; set all exp to 0 first
	lda #$00
	tay
-	sta wCurrExpDigits.w, y
	iny
	cpy #$05
	bcc -

; skip setting base level exp if level 0 (1)
	txa
	beq @afterSettingExp

; set base exp required for current level
	dex
; A/X = 5 * wGenericVar
	stx wGenericVar
	txa
	asl a
	asl a
	clc
	adc wGenericVar
	tax
	ldy #$00
-	lda levelExpReqs.w, x
	sta wCurrExpDigits.w, y
	inx
	iny
	cpy #$05
	bcc -

@afterSettingExp:
B6_38a8:		lda #$80		; a9 80
B6_38aa:		sta $c0			; 85 c0
B6_38ac:		lda #ANIM_PLAYER_FACING_DOWN		; a9 02
B6_38ae:		sta wNewPlayerAnimationIdx			; 85 c1
B6_38b0:		lda #$06		; a9 06
B6_38b2:		sta wPlayerAnimationDelaySpeed			; 85 c8

	lda #$89
	sta wPlayerY
	lda #$98
	sta wPlayerX

; 8 entries
	lda #$07
	sta wCheckpointIdxToCheck

; not needed
	lda #$00
	sta wRespawnVarToClear+1

-	ldx wCheckpointIdxToCheck
	lda checkpointGlobalFlagCheck.w, x

	jsr checkGlobalFlag
	bne @afterCheckpointIdx

	dec wCheckpointIdxToCheck
	bne -

@afterCheckpointIdx:
; set room y, x idxed in the other table
	lda wCheckpointIdxToCheck
	asl a
	tax

	lda checkpointRoomYX.w, x
	sta wRoomY
	lda checkpointRoomYX.w+1, x
	sta wRoomX

; clear the vars in the table
	ldx #$00
	ldy #$00
-	lda respawnVarsToClear.w+1, x
	cmp #$ff
	beq @done

	sta wRespawnVarToClear+1
	lda respawnVarsToClear.w, x
	sta wRespawnVarToClear

; A and Y = 0
	tya
	sta (wRespawnVarToClear), y
	inx
	inx
	bne -

@done:
	rts


func_6_38fa:
B6_38fa:		bit $00			; 24 00
B6_38fc:		bmi B6_3901 ; 30 03

B6_38fe:		inc $a1			; e6 a1
B6_3900:		rts				; 60 

B6_3901:		dec $a1			; c6 a1
B6_3903:		rts				; 60 


checkpointGlobalFlagCheck:
	.db GF_VISITED_NELWYN
	.db GF_VISITED_DEW
	.db GF_VISITED_POS_HOUSE
	.db GF_VISITED_BAR
	.db GF_VISITED_SACRED_TOWERS_HOUSE
	.db GF_VISITED_CANYON_MAZE_HOUSE
	.db GF_VISITED_TIR_ASLEEN
	.db GF_VISITED_NOCKMAAR

checkpointRoomYX:
	.db $1a $0e
	.db $13 $0f
	.db $13 $03
	.db $0a $09
	.db $08 $03
	.db $0c $10
	.db $0f $19
	.db $02 $18


passwordSavedBits:
	.db $06
	.dw $00f0
	.db $06
	.dw $00f1
	.db $03
	.dw wRespawnSavedNMIUpdatesCounter
	.db $08
	.dw wStoryGlobalFlags0
	.db $08
	.dw wStoryGlobalFlags1
	.db $08
	.dw wStoryGlobalFlags2
	.db $08
	.dw wSwordGlobalFlags
	.db $08
	.dw wShieldGlobalFlags
	.db $08
	.dw wMagicGlobalFlags0
	.db $08
	.dw wMagicGlobalFlags1
	.db $08
	.dw wItemGlobalFlags0
	.db $08
	.dw wItemGlobalFlags1
	.db $08
	.dw wMiscGlobalFlags
	.db $08
	.dw wCurrLevel
	.db $03
	.dw wRespawnSavedRngVar2
	.db $00 $00 $00
	

	
B6_394c:		ora $19			; 05 19
B6_394e:	.db $32
B6_394f:		.db $21


respawnVarsToClear:
	.dw $0059
	.dw $00b3
	.dw $00b3
	.dw $00bf
	.dw wEquippedSword
	.dw wEquippedShield
	.dw wEquippedMagic
	.dw $00b9
	.dw $0050
	.dw $0058
	.dw $005e
	.dw wHealthTaken
	.dw wMPUsed
	.dw $0074
	.dw $0075
	.dw $00f9
	.dw $00d4
	.dw $00f8
	.dw $00a3
	.dw $0070
	.dw $00b3
	.dw $00b4
	.dw $ffff


B6_397e:		and $c8			; 25 c8
B6_3980:		;removed
	.db $10 $2a

B6_3982:	.db $2b
B6_3983:		bit $2e2d		; 2c 2d 2e
B6_3986:	.db $80
B6_3987:		;removed
	.db $10 $11

B6_3989:	.db $12
B6_398a:	.db $13
B6_398b:	.db $14
B6_398c:	.db $80
B6_398d:		beq B6_3980 ; f0 f1

B6_398f:	.db $f2
B6_3990:	.db $f3
B6_3991:		rol $08			; 26 08
B6_3993:		bpl B6_39aa ; 10 15

B6_3995:		asl $17, x		; 16 17
B6_3997:		clc				; 18 
B6_3998:		ora $2f80, y	; 19 80 2f
B6_399b:		;removed
	.db $30 $31

B6_399d:	.db $32
B6_399e:	.db $33
B6_399f:	.db $80
B6_39a0:	.db $f4
B6_39a1:		sbc $f6, x		; f5 f6
B6_39a3:	.db $f7
B6_39a4:		rol $48			; 26 48
B6_39a6:		bpl B6_39c2 ; 10 1a

B6_39a8:	.db $1b
B6_39a9:	.db $1c
B6_39aa:		ora $801e, x	; 1d 1e 80
B6_39ad:	.db $34
B6_39ae:	.db $80
B6_39af:		and $80, x		; 35 80
B6_39b1:		rol $80, x		; 36 80
B6_39b3:		sed				; f8 
B6_39b4:		sbc $e1e0, y	; f9 e0 e1
B6_39b7:	.db $ff
B6_39b8:		rol $88			; 26 88
B6_39ba:		;removed
	.db $10 $43

B6_39bc:	.db $44
B6_39bd:		eor $46			; 45 46
B6_39bf:	.db $47
B6_39c0:	.db $80
B6_39c1:	.db $37
B6_39c2:		ror a			; 6a
B6_39c3:		and $3b3a, y	; 39 3a 3b
B6_39c6:	.db $80
B6_39c7:	.db $e2
B6_39c8:	.db $e3
B6_39c9:		cpx $e5			; e4 e5
B6_39cb:		rol $c8			; 26 c8
B6_39cd:		bpl B6_39f4 ; 10 25

B6_39cf:		rol $27			; 26 27
B6_39d1:		plp				; 28 
B6_39d2:		and #$80		; 29 80
B6_39d4:		and $3c80, x	; 3d 80 3c
B6_39d7:	.db $80
B6_39d8:		rol $e680, x	; 3e 80 e6
B6_39db:	.db $e7
B6_39dc:	.db $04
B6_39dd:		ora $ff			; 05 ff
B6_39df:		rol a			; 2a
B6_39e0:	.db $2b
B6_39e1:		bit $2e2d		; 2c 2d 2e
B6_39e4:		bpl B6_39f7 ; 10 11

B6_39e6:	.db $12
B6_39e7:	.db $13
B6_39e8:	.db $14
B6_39e9:		beq B6_39dc ; f0 f1

B6_39eb:	.db $f2
B6_39ec:	.db $f3
B6_39ed:		ora $16, x		; 15 16
B6_39ef:	.db $17
B6_39f0:		clc				; 18 
B6_39f1:		ora $302f, y	; 19 2f 30
B6_39f4:		and ($32), y	; 31 32
B6_39f6:	.db $33
B6_39f7:	.db $f4
B6_39f8:		sbc $f6, x		; f5 f6
B6_39fa:	.db $f7
B6_39fb:	.db $1a
B6_39fc:	.db $1b
B6_39fd:	.db $1c
B6_39fe:		ora $341e, x	; 1d 1e 34
B6_3a01:		and $36, x		; 35 36
B6_3a03:		sed				; f8 
B6_3a04:		sbc $e1e0, y	; f9 e0 e1
B6_3a07:	.db $43
B6_3a08:	.db $44
B6_3a09:		eor $46			; 45 46
B6_3a0b:	.db $47
B6_3a0c:	.db $37
B6_3a0d:		ror a			; 6a
B6_3a0e:		and $3b3a, y	; 39 3a 3b
B6_3a11:	.db $e2
B6_3a12:	.db $e3
B6_3a13:		cpx $e5			; e4 e5
B6_3a15:		and $26			; 25 26
B6_3a17:	.db $27
B6_3a18:		plp				; 28 
B6_3a19:		and #$3d		; 29 3d
B6_3a1b:	.db $3c
B6_3a1c:		rol $e7e6, x	; 3e e6 e7
B6_3a1f:	.db $04
B6_3a20:		ora $27			; 05 27
B6_3a22:		and #$47		; 29 47
B6_3a24:		eor #$03		; 49 03
B6_3a26:	.db $07
B6_3a27:		asl $a912		; 0e 12 a9
B6_3a2a:	.db $ff


;
B6_3a2b:		jsr queueSoundAtoPlay		; 20 ad c4
B6_3a2e:		lda #$32		; a9 32
B6_3a30:		jsr queueSoundAtoPlay		; 20 ad c4
B6_3a33:		jsr clearAllEntities		; 20 94 c3
B6_3a36:		lda #$00		; a9 00
B6_3a38:		sta wPlayerKnockbackCounter			; 85 c7
B6_3a3a:		jsr drawEntities		; 20 03 c4
B6_3a3d:		jsr drawPlayer		; 20 dd c3
B6_3a40:		lda #$3f		; a9 3f
B6_3a42:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B6_3a45:		lda #$7e		; a9 7e
B6_3a47:		sta $00			; 85 00
-	lda #$73		; a9 73
B6_3a4b:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_3a4e:		lda #$20		; a9 20
.ifndef NO_FLASH
B6_3a50:		sta wInternalPalettesInvisColour.w		; 8d b0 06
.else
B6_3a50:	.db $ea $ea $ea
.endif
B6_3a53:		lda wMajorNMIUpdatesCounter			; a5 23
B6_3a55:		and #$04		; 29 04
B6_3a57:		bne B6_3a5c ; d0 03

B6_3a59:		jsr updateCurrScreensSprPalettes		; 20 40 dd
B6_3a5c:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3a5f:		dec $00			; c6 00
	bne -

B6_3a63:		ldx #$0f		; a2 0f
B6_3a65:		lda #$20		; a9 20
B6_3a67:		sta wInternalPalettes.w, x	; 9d a0 06
B6_3a6a:		dex				; ca 
B6_3a6b:		bpl B6_3a65 ; 10 f8

B6_3a6d:		ldx #$1f		; a2 1f
B6_3a6f:		lda #$0f		; a9 0f
B6_3a71:		sta wInternalPalettes.w, x	; 9d a0 06
B6_3a74:		dex				; ca 
B6_3a75:		cpx #$10		; e0 10
B6_3a77:		bcs B6_3a6f ; b0 f6

B6_3a79:		stx $30			; 86 30
B6_3a7b:		lda #$3f		; a9 3f
B6_3a7d:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B6_3a80:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B6_3a82:		sta $2e			; 85 2e
B6_3a84:		ldy #$04		; a0 04
B6_3a86:		jsr palettesBGFadeOut		; 20 0e c6
B6_3a89:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3a8c:		jsr setPPUMask_noSprites		; 20 53 c1
B6_3a8f:		jsr setPPUCtrl_noNMI		; 20 64 c1
B6_3a92:		jsr fillNametables01With20h		; 20 b1 c2
B6_3a95:		jsr hideAllOam		; 20 9f c3
B6_3a98:		lda #$1e		; a9 1e
B6_3a9a:		sta wRoomY			; 85 43
B6_3a9c:		lda #$1a		; a9 1a
B6_3a9e:		sta wRoomX			; 85 42
B6_3aa0:		jsr b6_loadAllScreenRowsForCurrRoom		; 20 f3 de
B6_3aa3:		inc wRoomX			; e6 42
B6_3aa5:		jsr b6_loadAllScreenRowsForCurrRoom		; 20 f3 de
B6_3aa8:		lda wPPUCtrl			; a5 20
B6_3aaa:		and #$fe		; 29 fe
B6_3aac:		sta wPPUCtrl			; 85 20
B6_3aae:		lda #$13		; a9 13
B6_3ab0:		jsr set_wChrBank1		; 20 db c1
B6_3ab3:		lda #$1f		; a9 1f
B6_3ab5:		jsr set_wChrBank0		; 20 c2 c1
B6_3ab8:		bit $58			; 24 58
B6_3aba:		bvc B6_3ac2 ; 50 06

B6_3abc:		jsr $b859		; 20 59 b8
B6_3abf:		jmp $bac5		; 4c c5 ba


B6_3ac2:		jsr func_6_3626		; 20 26 b6
B6_3ac5:		jsr setPPUCtrl_addNMI_bgAt1000h		; 20 6e c1
B6_3ac8:		lda #$15		; a9 15
B6_3aca:		jsr queueSoundAtoPlay		; 20 ad c4
B6_3acd:		lda #$05		; a9 05
B6_3acf:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_3ad2:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3ad5:		jsr setPPUMask_addShowAll		; 20 5d c1
B6_3ad8:		lda #$e9		; a9 e9
B6_3ada:		sta wRLEStructAddressToCopy			; 85 33
B6_3adc:		lda #$bb		; a9 bb
B6_3ade:		sta wRLEStructAddressToCopy+1			; 85 34
B6_3ae0:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3ae3:		lda wJoy1NewButtonsPressed			; a5 29
B6_3ae5:		and #$d0		; 29 d0
B6_3ae7:		beq B6_3ae0 ; f0 f7

B6_3ae9:		lda #$c5		; a9 c5
B6_3aeb:		sta wRLEStructAddressToCopy			; 85 33
B6_3aed:		lda #$bb		; a9 bb
B6_3aef:		sta wRLEStructAddressToCopy+1			; 85 34
B6_3af1:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3af4:		lda #$68		; a9 68
B6_3af6:		sta $0204		; 8d 04 02
B6_3af9:		lda #$83		; a9 83
B6_3afb:		sta $0205		; 8d 05 02
B6_3afe:		lda #$01		; a9 01
B6_3b00:		sta $0206		; 8d 06 02
B6_3b03:		lda #$50		; a9 50
B6_3b05:		sta $0207		; 8d 07 02
B6_3b08:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3b0b:		lda wJoy1NewButtonsPressed			; a5 29
B6_3b0d:		and #$10		; 29 10
B6_3b0f:		bne B6_3b28 ; d0 17

B6_3b11:		lda wJoy1NewButtonsPressed			; a5 29
B6_3b13:		and #$2c		; 29 2c
B6_3b15:		beq B6_3b08 ; f0 f1

B6_3b17:		ldx #$68		; a2 68
B6_3b19:		lda $0204		; ad 04 02
B6_3b1c:		cmp #$70		; c9 70
B6_3b1e:		bcs B6_3b22 ; b0 02

B6_3b20:		ldx #$78		; a2 78
B6_3b22:		stx $0204		; 8e 04 02
B6_3b25:		jmp $bb08		; 4c 08 bb


B6_3b28:		lda $0204		; ad 04 02
B6_3b2b:		cmp #$70		; c9 70
B6_3b2d:		bcs B6_3b84 ; b0 55

B6_3b2f:		lda #$24		; a9 24
B6_3b31:		jsr queueSoundAtoPlay		; 20 ad c4
B6_3b34:		lda #$3e		; a9 3e
B6_3b36:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B6_3b39:		ldy #$04		; a0 04
B6_3b3b:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B6_3b3e:		jsr setPPUMask_noSprites		; 20 53 c1
B6_3b41:		jsr setPPUCtrl_noNMI		; 20 64 c1
B6_3b44:		ldx #$18		; a2 18
B6_3b46:		lda $0640, x	; bd 40 06
B6_3b49:		sta $0110, x	; 9d 10 01
B6_3b4c:		dex				; ca 
B6_3b4d:		bpl B6_3b46 ; 10 f7

B6_3b4f:		jsr fillNametables01With20h		; 20 b1 c2
B6_3b52:		jsr clearNametables01Palettes		; 20 90 c2
B6_3b55:		jsr hideAllOam		; 20 9f c3
B6_3b58:		ldx #$18		; a2 18
B6_3b5a:		lda $0110, x	; bd 10 01
B6_3b5d:		sta $0640, x	; 9d 40 06
B6_3b60:		dex				; ca 
B6_3b61:		bpl B6_3b5a ; 10 f7

B6_3b63:		jsr setPPUCtrl_addNMI_bgAt1000h		; 20 6e c1
B6_3b66:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3b69:		jsr setPPUMask_addShowAll		; 20 5d c1
B6_3b6c:		lda #$12		; a9 12
B6_3b6e:		sta $02			; 85 02
B6_3b70:		jsr func_6_3574		; 20 74 b5
B6_3b73:		bcc B6_3b7b ; 90 06

-	jsr waitForMajorityOfNMIFuncsDone
	jmp -

B6_3b7b:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3b7e:		ldx #$ff		; a2 ff
B6_3b80:		txs				; 9a 
B6_3b81:		jmp $de3a		; 4c 3a de


B6_3b84:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3b87:		ldy #$04		; a0 04
B6_3b89:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B6_3b8c:		lda wPPUCtrl			; a5 20
B6_3b8e:		ora #$01		; 09 01
B6_3b90:		sta wPPUCtrl			; 85 20
B6_3b92:		lda #$0c		; a9 0c
B6_3b94:		jsr queueSoundAtoPlay		; 20 ad c4
B6_3b97:		jsr hideAllOam		; 20 9f c3
B6_3b9a:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3b9d:		lda #$05		; a9 05
B6_3b9f:		ldy #$04		; a0 04
B6_3ba1:		jsr func_7_0636		; 20 36 c6
B6_3ba4:		jsr $b64c		; 20 4c b6
B6_3ba7:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_3baa:		lda wJoy1NewButtonsPressed			; a5 29
B6_3bac:		and #$10		; 29 10
B6_3bae:		beq B6_3ba7 ; f0 f7

B6_3bb0:		ldy #$04		; a0 04
B6_3bb2:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B6_3bb5:		lda wPPUCtrl			; a5 20
B6_3bb7:		and #$fe		; 29 fe
B6_3bb9:		sta wPPUCtrl			; 85 20
B6_3bbb:		lda #$05		; a9 05
B6_3bbd:		ldy #$04		; a0 04
B6_3bbf:		jsr func_7_0636		; 20 36 c6
B6_3bc2:		jmp $baf1		; 4c f1 ba


B6_3bc5:		and ($ac, x)	; 21 ac
B6_3bc7:		php				; 08 
B6_3bc8:		bit $1d1e		; 2c 1e 1d
B6_3bcb:	.db $47
B6_3bcc:		clc				; 18 
B6_3bcd:		ora $2e25, x	; 1d 25 2e
B6_3bd0:		and ($ec, x)	; 21 ec
B6_3bd2:		ora #$43		; 09 43
B6_3bd4:		rol a			; 2a
B6_3bd5:		lsr $46			; 46 46
B6_3bd7:	.db $80
B6_3bd8:	.db $27
B6_3bd9:		asl $2d45, x	; 1e 45 2d
B6_3bdc:		and ($cb, x)	; 21 cb
B6_3bde:		ora #$80		; 09 80
B6_3be0:	.db $80
B6_3be1:	.db $80
B6_3be2:	.db $80
B6_3be3:	.db $80
B6_3be4:	.db $80
B6_3be5:	.db $80
B6_3be6:	.db $80
B6_3be7:	.db $80
B6_3be8:	.db $ff
B6_3be9:		and ($cb, x)	; 21 cb
B6_3beb:		ora #$16		; 09 16
B6_3bed:		rol a			; 2a
B6_3bee:	.db $1c
B6_3bef:		rol $1e80		; 2e 80 1e
B6_3bf2:		rol $2e			; 26 2e
B6_3bf4:		eor $ff			; 45 ff
B6_3bf6:		.db $00				; 00
B6_3bf7:		.db $00				; 00
B6_3bf8:		.db $00				; 00
B6_3bf9:		.db $00				; 00
B6_3bfa:		.db $00				; 00
B6_3bfb:		.db $00				; 00
B6_3bfc:		.db $00				; 00
B6_3bfd:		.db $00				; 00
B6_3bfe:		rti				; 40 


B6_3bff:		.db $00				; 00
