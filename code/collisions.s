
getPlayerCollisionTileCoords:
	lda collisionCheckOffsetsY.w, x
	clc
	adc wPlayerCollisionY
	and #$f0
	lsr a
	lsr a
	lsr a
	lsr a
	sta wPlayerCollisionTileY

	lda collisionCheckOffsetsX.w, x
	clc
	adc wPlayerCollisionX
	and #$f0
	lsr a
	lsr a
	lsr a
	lsr a
	sta wPlayerCollisionTileX
	rts


processCollision_secIfWall:
	jsr getPlayerCollisionTileCoords

; y is idx from 0 to 3 of tile to process
	jsr getCollisionValOfRoomTileY
	ldy wTileCollisionVal
	beq collision_clc

	cpy #$01
	bne collision_special

; i cant walk here
collision_sec:
	sec
	rts

; i can walk here
collision_clc:
	clc
	rts

collision_special:
	dey
	dey
	tya
	jsr jumpTable
	.dw collisionVal02
	.dw collisionVal03_2wayEntrances
	.dw collisionVal04_nockmaarKeyDoor
	.dw collisionVal05
	.dw collisionVal06_tirAsleenGate
	.dw collisionVal07_redCrystalTowerDoor
	.dw collisionVal08_morphingBridge
	.dw collisionVal09
	.dw collisionVal0a
	.dw collisionVal0b_hiddenJailSwitch
	.dw collisionVal0c_muzhBlocked
	.dw collisionVal0d_braceletSwitch
	.dw collisionVal0e ; door?
	.dw collisionVal0f_damagingWater
	.dw collisionVal10_witchsHouse
	.dw collisionVal11_openJailDoor
	.dw collisionVal12

-	jmp collision_sec

collisionVal12:
B6_036a:		lda $a3			; a5 a3
B6_036c:		and #$01		; 29 01
	bne -

B6_0370:		jmp collision_clc		; 4c 3d 83


collisionVal04_nockmaarKeyDoor:
B6_0373:		lda wRoomY			; a5 43
B6_0375:		cmp #$16		; c9 16
B6_0377:		bne B6_0388 ; d0 0f

B6_0379:		lda wRoomX			; a5 42
B6_037b:		cmp #$1e		; c9 1e
B6_037d:		bne B6_0388 ; d0 09

B6_037f:		lda #GF_USED_POWDER_ON_MADMARTIGAN		; a9 10
B6_0381:		jsr checkGlobalFlag		; 20 6c c4
B6_0384:		beq B6_038f ; f0 09

B6_0386:		bne B6_0392 ; d0 0a

B6_0388:		lda #GF_NOCKMAAR_KEY_ITEM		; a9 43
B6_038a:		jsr checkGlobalFlag		; 20 6c c4
B6_038d:		bne B6_0392 ; d0 03

B6_038f:		jmp collision_sec		; 4c 3b 83

B6_0392:		lda $59			; a5 59
B6_0394:		cmp #$01		; c9 01
B6_0396:		beq collision_clc ; f0 a5

B6_0398:		cmp #$05		; c9 05
B6_039a:		beq collision_clc ; f0 a1

B6_039c:		ldy #$01		; a0 01
B6_039e:		lda #$b1		; a9 b1
B6_03a0:		sta wRLEStructAddressToCopy			; 85 33
B6_03a2:		lda #$87		; a9 87
B6_03a4:		sta wRLEStructAddressToCopy+1			; 85 34
B6_03a6:		lda wPPUCtrl			; a5 20
B6_03a8:		lsr a			; 4a
B6_03a9:		bcc B6_03b5 ; 90 0a

B6_03ab:		ldy #$05		; a0 05
B6_03ad:		lda #$ce		; a9 ce
B6_03af:		sta wRLEStructAddressToCopy			; 85 33
B6_03b1:		lda #$87		; a9 87
B6_03b3:		sta wRLEStructAddressToCopy+1			; 85 34
B6_03b5:		sty $59			; 84 59
B6_03b7:		jmp $840a		; 4c 0a 84


collisionVal05:
B6_03ba:		lda $59			; a5 59
B6_03bc:		cmp #$02		; c9 02
B6_03be:		beq B6_040f ; f0 4f

B6_03c0:		lda #$83		; a9 83
B6_03c2:		sta wRLEStructAddressToCopy			; 85 33
B6_03c4:		lda #$87		; a9 87
B6_03c6:		sta wRLEStructAddressToCopy+1			; 85 34
B6_03c8:		lda #$02		; a9 02
B6_03ca:		sta $59			; 85 59
B6_03cc:		jmp $840a		; 4c 0a 84


collisionVal06_tirAsleenGate:
B6_03cf:		lda #GF_UNLOCKED_TIR_ASLEEN_CASTLE		; a9 0f
B6_03d1:		jsr checkGlobalFlag		; 20 6c c4
B6_03d4:		bne B6_03d9 ; d0 03

B6_03d6:		jmp collision_sec		; 4c 3b 83

B6_03d9:		lda $59			; a5 59
B6_03db:		cmp #$03		; c9 03
B6_03dd:		beq B6_040f ; f0 30

B6_03df:		lda #$6c		; a9 6c
B6_03e1:		sta wRLEStructAddressToCopy			; 85 33
B6_03e3:		lda #$87		; a9 87
B6_03e5:		sta wRLEStructAddressToCopy+1			; 85 34
B6_03e7:		lda #$03		; a9 03
B6_03e9:		sta $59			; 85 59
B6_03eb:		jmp $840a		; 4c 0a 84


collisionVal07_redCrystalTowerDoor:
B6_03ee:		lda #GF_BLUE_CRYSTAL_ITEM		; a9 40
B6_03f0:		jsr checkGlobalFlag		; 20 6c c4
B6_03f3:		bne B6_03f8 ; d0 03

B6_03f5:		jmp collision_sec		; 4c 3b 83

B6_03f8:		lda $59			; a5 59
B6_03fa:		cmp #$04		; c9 04
B6_03fc:		beq B6_040f ; f0 11

B6_03fe:		lda #$9a		; a9 9a
B6_0400:		sta wRLEStructAddressToCopy			; 85 33
B6_0402:		lda #$87		; a9 87
B6_0404:		sta wRLEStructAddressToCopy+1			; 85 34
B6_0406:		lda #$04		; a9 04
B6_0408:		sta $59			; 85 59
B6_040a:		lda #$24		; a9 24
B6_040c:		jsr queueSoundAtoPlay		; 20 ad c4
B6_040f:		jmp collision_clc		; 4c 3d 83


collisionVal0a:
B6_0412:		lda wRoomY			; a5 43
B6_0414:		bne B6_043a ; d0 24

B6_0416:		lda #GF_BEAT_KAEL		; a9 0c
B6_0418:		jsr checkGlobalFlag		; 20 6c c4
B6_041b:		bne B6_0420 ; d0 03

B6_041d:		jmp collision_sec		; 4c 3b 83

B6_0420:		lda $59			; a5 59
B6_0422:		cmp #$06		; c9 06
B6_0424:		beq B6_0437 ; f0 11

B6_0426:		lda #$eb		; a9 eb
B6_0428:		sta wRLEStructAddressToCopy			; 85 33
B6_042a:		lda #$87		; a9 87
B6_042c:		sta wRLEStructAddressToCopy+1			; 85 34
B6_042e:		lda #$06		; a9 06
B6_0430:		sta $59			; 85 59
B6_0432:		lda #$24		; a9 24
B6_0434:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0437:		jmp collision_clc		; 4c 3d 83

; eborsisk door
B6_043a:		lda #GF_POWDER_ITEM		; a9 45
B6_043c:		jsr checkGlobalFlag		; 20 6c c4
B6_043f:		bne B6_0448 ; d0 07

B6_0441:		lda #GF_BEAT_EBORSISK		; a9 0d
B6_0443:		jsr checkGlobalFlag		; 20 6c c4
B6_0446:		bne B6_0420 ; d0 d8

B6_0448:		jmp collision_sec		; 4c 3b 83


collisionVal11_openJailDoor:
B6_044b:		lda #GF_STEPPED_ON_HIDDEN_JAIL_SWITCH		; a9 0e
B6_044d:		jsr checkGlobalFlag		; 20 6c c4
B6_0450:		beq B6_0448 ; f0 f6

B6_0452:		jmp collision_clc		; 4c 3d 83


collisionVal0b_hiddenJailSwitch:
B6_0455:		lda #GF_POWDER_ITEM		; a9 45
B6_0457:		jsr checkGlobalFlag		; 20 6c c4
B6_045a:		bne B6_0452 ; d0 f6

B6_045c:		lda #GF_SPOKE_TO_MADMARTIGAN_IN_PRISON		; a9 00
B6_045e:		jsr checkGlobalFlag		; 20 6c c4
B6_0461:		beq B6_0452 ; f0 ef

B6_0463:		lda $59			; a5 59
B6_0465:		cmp #$07		; c9 07
B6_0467:		beq collision_clc_049a ; f0 31

B6_0469:		lda #$08		; a9 08
B6_046b:		sta wRLEStructAddressToCopy			; 85 33
B6_046d:		lda #$88		; a9 88
B6_046f:		sta wRLEStructAddressToCopy+1			; 85 34
B6_0471:		lda #GF_STEPPED_ON_HIDDEN_JAIL_SWITCH		; a9 0e
B6_0473:		jsr setGlobalFlag		; 20 60 c4
B6_0476:		lda #$07		; a9 07
B6_0478:		sta $59			; 85 59
B6_047a:		lda #$24		; a9 24
B6_047c:		jsr queueSoundAtoPlay		; 20 ad c4
B6_047f:		lda #$7e		; a9 7e
B6_0481:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B6_0484:		lda #$1f		; a9 1f
B6_0486:		sta wRoomY			; 85 43
B6_0488:		lda #$1d		; a9 1d
B6_048a:		sta wRoomX			; 85 42
B6_048c:		lda #$00		; a9 00
B6_048e:		sta $0317		; 8d 17 03
B6_0491:		lda #$14		; a9 14
B6_0493:		sta $d5			; 85 d5
B6_0495:		sta $d7			; 85 d7
B6_0497:		jmp func_7_203c		; 4c 3c e0


collision_clc_049a:
	jmp collision_clc


collisionVal0c_muzhBlocked:
	lda #GF_BOMBARD_MAGIC
	jsr checkGlobalFlag
	bne collision_clc_049a

	jmp collision_sec


collisionVal0f_damagingWater:
	lda #GF_WAKKA_ITEM
	jsr checkGlobalFlag
	bne collision_clc_049a

; take 1 damage every other frame
	lda wMajorNMIUpdatesCounter
	and #$01
	bne collision_clc_049a

	lda #$01
	clc
	adc wHealthTaken
	sta wHealthTaken
	jmp collision_clc


collisionVal0e:
B6_04be:		inc $5e			; e6 5e
B6_04c0:		ldx #$00		; a2 00
B6_04c2:		lda $5e			; a5 5e
B6_04c4:		and #$01		; 29 01
B6_04c6:		sta $5e			; 85 5e
B6_04c8:		beq B6_04cc ; f0 02

B6_04ca:		ldx #$90		; a2 90
B6_04cc:		stx $50			; 86 50
B6_04ce:		jsr $867b		; 20 7b 86
B6_04d1:		lda #$00		; a9 00
B6_04d3:		sta $59			; 85 59
B6_04d5:		jsr $aad0		; 20 d0 aa- transitions ou of room?
B6_04d8:		jmp B6_0517		; 4c 17 85


collisionVal03_2wayEntrances:
B6_04db:		ldy #$00		; a0 00
B6_04dd:		lda caveInnerRoomEntrances.w, y	; b9 5a 87
B6_04e0:		bmi B6_04f4 ; 30 12

B6_04e2:		cmp wRoomY			; c5 43
B6_04e4:		bne B6_04f0 ; d0 0a

B6_04e6:		lda caveInnerRoomEntrances.w+1, y	; b9 5b 87
B6_04e9:		cmp wRoomX			; c5 42
B6_04eb:		bne B6_04f0 ; d0 03

B6_04ed:		jmp $8551		; 4c 51 85

B6_04f0:		iny				; c8 
B6_04f1:		iny				; c8 
B6_04f2:		bne B6_04dd ; d0 e9

B6_04f4:		ldy #$00		; a0 00
B6_04f6:		lda caveInnerRoomDests.w, y	; b9 63 87
B6_04f9:		bmi B6_050d ; 30 12

B6_04fb:		cmp wRoomY			; c5 43
B6_04fd:		bne B6_0509 ; d0 0a

B6_04ff:		lda caveInnerRoomDests.w+1, y	; b9 64 87
B6_0502:		cmp wRoomX			; c5 42
B6_0504:		bne B6_0509 ; d0 03

B6_0506:		jmp func_6_060f		; 4c 0f 86

B6_0509:		iny				; c8 
B6_050a:		iny				; c8 
B6_050b:		bne B6_04f6 ; d0 e9

B6_050d:		jsr $867b		; 20 7b 86
B6_0510:		lda #$00		; a9 00
B6_0512:		sta $59			; 85 59
B6_0514:		jsr func_6_2ac6		; 20 c6 aa

B6_0517:		lda #$02		; a9 02
B6_0519:		sta wPlayerDirectionFacing			; 85 c9
B6_051b:		jsr func_6_02a1		; 20 a1 82
B6_051e:		jsr drawEntities		; 20 03 c4
B6_0521:		jsr drawPlayer		; 20 dd c3
B6_0524:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0527:		ldx #$ff		; a2 ff
B6_0529:		txs				; 9a 
B6_052a:		jmp mainLoop		; 4c a9 de


collisionVal10_witchsHouse:
B6_052d:		lda #GF_UPGRADED_WING_SWORD		; a9 03
B6_052f:		jsr checkGlobalFlag		; 20 6c c4
	bne +

B6_0534:		jmp collision_sec		; 4c 3b 83

+	lda $59			; a5 59
B6_0539:		cmp #$08		; c9 08
B6_053b:		beq B6_054e ; f0 11

B6_053d:		lda #$25		; a9 25
B6_053f:		sta wRLEStructAddressToCopy			; 85 33
B6_0541:		lda #$88		; a9 88
B6_0543:		sta wRLEStructAddressToCopy+1			; 85 34
B6_0545:		lda #$08		; a9 08
B6_0547:		sta $59			; 85 59
B6_0549:		lda #$24		; a9 24
B6_054b:		jsr queueSoundAtoPlay		; 20 ad c4
B6_054e:		jmp collision_clc		; 4c 3d 83


collisionVal02:
B6_0551:		jsr $867b		; 20 7b 86
B6_0554:		jsr func_6_1f8d		; 20 8d 9f
B6_0557:		jsr func_6_02a1		; 20 a1 82
B6_055a:		lda #$10		; a9 10
B6_055c:		clc				; 18 
B6_055d:		jsr $86cb		; 20 cb 86
B6_0560:		lda #$02		; a9 02
B6_0562:		sta wPlayerDirectionFacing			; 85 c9
B6_0564:		jsr setPlayerMovementAnimationDetails		; 20 c4 82
B6_0567:		jsr drawEntities		; 20 03 c4
B6_056a:		jsr drawPlayer		; 20 dd c3
B6_056d:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0570:		ldx #$ff		; a2 ff
B6_0572:		txs				; 9a 
B6_0573:		jmp mainLoop		; 4c a9 de


collisionVal09:
B6_0576:		lda $55			; a5 55
B6_0578:		cmp #$01		; c9 01
B6_057a:		bne B6_0597 ; d0 1b

B6_057c:		lda wPlayerKnockbackCounter			; a5 c7
B6_057e:		bne B6_0597 ; d0 17

B6_0580:		lda #$20		; a9 20
B6_0582:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0585:		lda #$24		; a9 24
B6_0587:		sta wPlayerKnockbackCounter			; 85 c7

B6_0589:		lda wPlayerDirection			; a5 c3
B6_058b:		lsr a			; 4a
B6_058c:		eor #$02		; 49 02
B6_058e:		sta wPlayerDirection			; 85 c3

B6_0590:		lda #$06		; a9 06
B6_0592:		clc				; 18 
B6_0593:		adc wHealthTaken			; 65 79
B6_0595:		sta wHealthTaken			; 85 79
B6_0597:		jmp collision_clc		; 4c 3d 83


collisionVal08_morphingBridge:
	lda wRoomY
	cmp #$17
	bne @notBogardaBridge

	lda wRoomX
	cmp #$06
	bne @notBogardaBridge

; at bogarda-blocked-bridge right side
	lda #GF_FIREFLOR_MAGIC
	jsr checkGlobalFlag
	beq bogardaBridgeMorph

	jmp collision_clc

@notBogardaBridge:
; other bridge requires shoes
	lda #GF_SHOES_ITEM
	jsr checkGlobalFlag
	beq bogardaBridgeMorph

bogardaBlockedBridge_clc:
	jmp collision_clc

bogardaBridgeMorph:
	lda #SND_BOGARDA_BRIDGE_MORPHING
	jsr queueSoundAtoPlay

; morph this number of frames
	lda #$bd
-	pha
	jsr screenMorphEffect
	jsr waitForMajorityOfNMIFuncsDone
	pla
	sec
	sbc #$01
	bne -

	lda #$00
	sta wBGChrBank
	jsr set_wChrBank1
	jmp collision_sec


collisionVal0d_braceletSwitch:
; no need to process if already unblocked
	lda #GF_BRACELET_UNBLOCKED_CAVE
	jsr checkGlobalFlag
	beq +

	rts

+
; if not in blocked room, or no bracelet, just walk through
	lda wRoomY
	cmp #$01
	bne bogardaBlockedBridge_clc

	lda wRoomX
	cmp #$04
	bne bogardaBlockedBridge_clc

	lda #GF_BRACELET_ITEM
	jsr checkGlobalFlag
	beq bogardaBlockedBridge_clc

; changes room to unblocked room
	dec wRoomY

	lda #SND_BRACELET_PATH_OPENING
	jsr queueSoundAtoPlay

	jsr waitForMajorityOfNMIFuncsDone
B6_05fd:		jsr roomTransitionUpdateChrPalMus2EntityBytes		; 20 c9 9d
	jsr setNametable1IfOddRoomX

	lda #GF_BRACELET_UNBLOCKED_CAVE
	jsr setGlobalFlag

B6_0608:		jsr func_7_1cb3		; 20 b3 dc
B6_060b:		jsr func_7_3000		; 20 00 f0
	rts


func_6_060f:
B6_060f:		lda #$25		; a9 25
B6_0611:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0614:		ldy #$10		; a0 10
B6_0616:		jsr palettesSprFadeOut		; 20 1b c6
B6_0619:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B6_061b:		sta $2e			; 85 2e
B6_061d:		ldy #$04		; a0 04
B6_061f:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B6_0622:		jsr clearAllEntities		; 20 94 c3
B6_0625:		jsr drawEntities		; 20 03 c4
B6_0628:		jsr drawPlayer		; 20 dd c3
B6_062b:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_062e:		lda #$00		; a9 00
B6_0630:		sta wPlayerY			; 85 cc
B6_0632:		lda #$80		; a9 80
B6_0634:		sta wPlayerX			; 85 ce
B6_0636:		lda wSprPaletteSpecAndChrBank			; a5 50
B6_0638:		lsr a			; 4a
B6_0639:		lsr a			; 4a
B6_063a:		lsr a			; 4a
B6_063b:		lsr a			; 4a
B6_063c:		clc				; 18 
B6_063d:		adc #$10		; 69 10
B6_063f:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_0642:		lda #$28		; a9 28
B6_0644:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0647:		lda #$03		; a9 03
B6_0649:		ldx #$01		; a2 01
B6_064b:		jsr $8ea9		; 20 a9 8e
B6_064e:		lda wPlayerY			; a5 cc
B6_0650:		clc				; 18 
B6_0651:		adc #$04		; 69 04
B6_0653:		sta wPlayerY			; 85 cc
B6_0655:		cmp #$f8		; c9 f8
B6_0657:		bcc B6_0647 ; 90 ee

B6_0659:		jsr $867b		; 20 7b 86
B6_065c:		lda #$00		; a9 00
B6_065e:		sta $59			; 85 59
B6_0660:		ldx #$10		; a2 10
B6_0662:		ldy #$10		; a0 10
B6_0664:		lda #$0f		; a9 0f
B6_0666:		sta wInternalPalettes.w, x	; 9d a0 06
B6_0669:		inx				; e8 
B6_066a:		dey				; 88 
B6_066b:		bne B6_0664 ; d0 f7

B6_066d:		stx $30			; 86 30
B6_066f:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0672:		jsr setPPUMask_noSprites		; 20 53 c1
B6_0675:		jsr $aaeb		; 20 eb aa
B6_0678:		jmp B6_0517		; 4c 17 85


B6_067b:		lda $bf			; a5 bf
B6_067d:		cmp #$08		; c9 08
B6_067f:		bcs B6_0688 ; b0 07

B6_0681:		lda #$00		; a9 00
B6_0683:		sta $bf			; 85 bf
B6_0685:		jsr setPlayerMovementAnimationDetails		; 20 c4 82
B6_0688:		lda wTempPlayerX			; a5 cb
B6_068a:		sta wPlayerX			; 85 ce
B6_068c:		lda wTempPlayerY			; a5 ca
B6_068e:		sta wPlayerY			; 85 cc
B6_0690:		jsr drawPlayer		; 20 dd c3
B6_0693:		rts				; 60 
