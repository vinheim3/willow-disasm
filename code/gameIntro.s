
handleUpToBeforeStartPwScreen:
	jmp handleUpToBeforeStartPwScreen_body


handleUpToBeforeStartPwScreen_body:
; clear screen
	jsr setPPUMask_noSprites
	jsr setPPUCtrl_noNMI
	jsr fillNametables01With20h
	jsr clearNametables01Palettes

	lda #$13
	jsr set_wChrBank1
	lda #$1f
	jsr set_wChrBank0

; nametable 1
	lda #rle_pressStartScreen
	jsr updateNonSpr0HitScreenFromRLEStructA
	lda #rle_pressStartPalettes
	jsr updateNonSpr0HitScreenFromRLEStructA

; rle_copyrightScreen0 to rle_copyrightScreen4 in nametable 0
	lda #$00
	sta wCopyrightScreenRLEStructToProcess
-	jsr updateNonSpr0HitScreenFromRLEStructA
	inc wCopyrightScreenRLEStructToProcess
	lda wCopyrightScreenRLEStructToProcess
	cmp #$05
	bcc -

; start processing nmi, and show all
	jsr setPPUCtrl_addNMI_bgAt1000h
	jsr waitForNMIdone_interruptableByStart
	jsr setPPUMask_addShowAll

; fade in with text palette spec, 4 frames per fade
	lda #PS_JUST_TEXT
	ldy #$04
	jsr paletteSpecAFadeIn

; wait while showing screen, then fade out same speed
	lda #$bd
	jsr waitForA_NMIsDone_interruptableByStart

	ldy #$04
	jsr palettesAllFadeOutDelayY

func_0_342c:
; clear screen
	jsr setPPUMask_noSprites
	jsr setPPUCtrl_noNMI
	jsr fillNametables01With20h
	jsr clearNametables01Palettes

; set up nt 0 and 1 with next screen
	lda #rle_pressStartScreen
	jsr updateNonSpr0HitScreenFromRLEStructA
	lda #rle_pressStartPalettes
	jsr updateNonSpr0HitScreenFromRLEStructA
	lda #rle_talesOfDreams
	jsr updateNonSpr0HitScreenFromRLEStructA

	jsr setPPUCtrl_addNMI_bgAt1000h

; wait, fade in with text palette spec
	lda #$3d
	jsr waitForA_NMIsDone_interruptableByStart
	jsr setPPUMask_addShowAll

	lda #PS_JUST_TEXT
	ldy #$04
	jsr paletteSpecAFadeIn

; wait, then play sound
	lda #$3f
	jsr waitForA_NMIsDone_interruptableByStart

	lda #MUS_INTRO_CUTSCENE
	jsr queueSoundAtoPlay

; wait, then fade out, and hide sprites
	lda #$7e
	jsr waitForA_NMIsDone_interruptableByStart

	ldy #$04
	jsr palettesAllFadeOutDelayY

	jsr setPPUMask_noSprites

; set new room (2 animals with 2 halves of crest)
	lda #$1f
	sta wRoomY
	lda #$0e
	sta wRoomX

; draw room layout
B0_3478:		jsr loadAllScreenRowsForCurrRoom		; 20 1a c4
B0_347b:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7

	jsr introCutscene_clearTextArea
	jsr waitForNMIdone_interruptableByStart

	lda #rle_2SpiritsWatchingOver
	jsr updateNonSpr0HitScreenFromRLEStructA
	jsr waitForNMIdone_interruptableByStart

; load 2 npcs, 55 and 56
B0_348c:		ldx #$08		; a2 08
B0_348e:		lda #$55		; a9 55
B0_3490:		sta $00			; 85 00
-	lda $00			; a5 00
B0_3494:		jsr initNpcSpecAIdxX		; 20 ec c3
B0_3497:		lda wEntities_330.w, x	; bd 30 03
B0_349a:		sta wEntitiesY.w, x	; 9d 80 04
B0_349d:		lda wEntities_348.w, x	; bd 48 03
B0_34a0:		sta wEntitiesX.w, x	; 9d b0 04
B0_34a3:		lda wEntities_360.w, x	; bd 60 03
B0_34a6:		sta wEntities_408.w, x	; 9d 08 04
B0_34a9:		inx				; e8 
B0_34aa:		inc $00			; e6 00
B0_34ac:		cpx #$0a		; e0 0a
	bne -

B0_34b0:		jsr drawEntities		; 20 03 c4
B0_34b3:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7

B0_34b6:		lda #$11		; a9 11
B0_34b8:		jsr set_wChrBank1		; 20 db c1
B0_34bb:		jsr setPPUMask_addShowAll		; 20 5d c1

B0_34be:		lda #$31		; a9 31
B0_34c0:		ldy #$04		; a0 04
B0_34c2:		jsr paletteSpecAFadeIn		; 20 2e c6
B0_34c5:		lda #$7e		; a9 7e
B0_34c7:		jsr waitForA_NMIsDone_interruptableByStart		; 20 e3 b7

B0_34ca:		lda $03f8		; ad f8 03
B0_34cd:		and $03f9		; 2d f9 03
B0_34d0:		and #$01		; 29 01
B0_34d2:		bne B0_34e3 ; d0 0f

B0_34d4:		jsr updateScreenEntities		; 20 23 c4
B0_34d7:		jsr drawEntities		; 20 03 c4
B0_34da:		jsr drawPlayer		; 20 dd c3
B0_34dd:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_34e0:		jmp B0_34ca		; 4c ca b4

B0_34e3:		lda #$00		; a9 00
B0_34e5:		sta $0308		; 8d 08 03
B0_34e8:		sta $0309		; 8d 09 03
B0_34eb:		jsr hideAllOam		; 20 9f c3
B0_34ee:		lda #$35		; a9 35
B0_34f0:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B0_34f3:		jsr func_7_11b6		; 20 b6 d1
B0_34f6:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_34f9:		lda #$1c		; a9 1c
B0_34fb:		jsr set_wChrBank0		; 20 c2 c1
B0_34fe:		jsr func_7_04b9		; 20 b9 c4
B0_3501:		lda #$bd		; a9 bd
B0_3503:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3506:		jsr func_7_04c4		; 20 c4 c4
B0_3509:		jsr func_0_37a4		; 20 a4 b7
B0_350c:		lda #$07		; a9 07
B0_350e:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_3511:		sec				; 38 
B0_3512:		ror $5d			; 66 5d
B0_3514:		lda #$32		; a9 32
B0_3516:		ldy #$04		; a0 04
B0_3518:		jsr func_7_05e7		; 20 e7 c5
B0_351b:		jsr func_7_04b9		; 20 b9 c4
B0_351e:		lda #$fc		; a9 fc
B0_3520:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3523:		jsr func_7_04c4		; 20 c4 c4
B0_3526:		jsr func_0_37a4		; 20 a4 b7
B0_3529:		lda #$08		; a9 08
B0_352b:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_352e:		sec				; 38 
B0_352f:		ror $5d			; 66 5d
B0_3531:		lda #$33		; a9 33
B0_3533:		ldy #$04		; a0 04
B0_3535:		jsr func_7_05cf		; 20 cf c5
B0_3538:		jsr func_7_04b9		; 20 b9 c4
B0_353b:		lda #$fc		; a9 fc
B0_353d:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3540:		jsr func_7_04c4		; 20 c4 c4
B0_3543:		jsr func_0_37a4		; 20 a4 b7
B0_3546:		lda #$09		; a9 09
B0_3548:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_354b:		lda #$16		; a9 16
B0_354d:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_3550:		jsr func_7_04b9		; 20 b9 c4
B0_3553:		lda #$fc		; a9 fc
B0_3555:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3558:		lda #$3f		; a9 3f
B0_355a:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_355d:		jsr func_7_04c4		; 20 c4 c4
B0_3560:		jsr func_0_37a4		; 20 a4 b7
B0_3563:		lda #$0a		; a9 0a
B0_3565:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_3568:		lda #$17		; a9 17
B0_356a:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_356d:		jsr func_7_04b9		; 20 b9 c4
B0_3570:		lda #$fc		; a9 fc
B0_3572:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3575:		jsr func_7_04c4		; 20 c4 c4
B0_3578:		jsr func_0_37a4		; 20 a4 b7
B0_357b:		lda #$0b		; a9 0b
B0_357d:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_3580:		jsr func_7_04b9		; 20 b9 c4
B0_3583:		lda #$fc		; a9 fc
B0_3585:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3588:		lda #$3f		; a9 3f
B0_358a:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_358d:		lda #$37		; a9 37
B0_358f:		sta $00			; 85 00
B0_3591:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B0_3594:		lda #$04		; a9 04
B0_3596:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3599:		inc $00			; e6 00
B0_359b:		lda $00			; a5 00
B0_359d:		cmp #$3a		; c9 3a
B0_359f:		bcc B0_3591 ; 90 f0

B0_35a1:		ldx #$00		; a2 00
B0_35a3:		ldy #$1f		; a0 1f
B0_35a5:		lda #$27		; a9 27
B0_35a7:		sta wInternalPalettes.w, x	; 9d a0 06
B0_35aa:		inx				; e8 
B0_35ab:		dey				; 88 
B0_35ac:		bpl B0_35a5 ; 10 f7

B0_35ae:		sty wShouldUpdateInternalPalettes			; 84 30
B0_35b0:		lda #$04		; a9 04
B0_35b2:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_35b5:		lda #$0c		; a9 0c
B0_35b7:		sta wRoomX			; 85 42
B0_35b9:		jsr func_7_041d		; 20 1d c4
B0_35bc:		lda #$18		; a9 18
B0_35be:		sta $00			; 85 00
B0_35c0:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_35c3:		inc $00			; e6 00
B0_35c5:		lda $00			; a5 00
B0_35c7:		cmp #$1c		; c9 1c
B0_35c9:		bcc B0_35c0 ; 90 f5

B0_35cb:		lda #$28		; a9 28
B0_35cd:		sta $00			; 85 00
B0_35cf:		lda #$03		; a9 03
B0_35d1:		sta $01			; 85 01
B0_35d3:		lda #$3a		; a9 3a
B0_35d5:		sta $02			; 85 02
B0_35d7:		lda #$00		; a9 00
B0_35d9:		sta $03			; 85 03
B0_35db:		lda $03			; a5 03
B0_35dd:		and #$07		; 29 07
B0_35df:		bne B0_35f7 ; d0 16

B0_35e1:		lda $02			; a5 02
B0_35e3:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B0_35e6:		lda #$30		; a9 30
B0_35e8:		sta wInternalPalettesInvisColour.w		; 8d b0 06
B0_35eb:		inc $02			; e6 02
B0_35ed:		lda $02			; a5 02
B0_35ef:		cmp #$3d		; c9 3d
B0_35f1:		bcc B0_35f7 ; 90 04

B0_35f3:		lda #$3a		; a9 3a
B0_35f5:		sta $02			; 85 02
B0_35f7:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_35fa:		inc $03			; e6 03
B0_35fc:		dec $00			; c6 00
B0_35fe:		bne B0_35db ; d0 db

B0_3600:		dec $01			; c6 01
B0_3602:		bne B0_35db ; d0 d7

B0_3604:		ldy #$04		; a0 04
B0_3606:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B0_3609:		jsr setPPUMask_noSprites		; 20 53 c1
B0_360c:		dec wRoomX			; c6 42
B0_360e:		dec wRoomX			; c6 42
B0_3610:		jsr loadAllScreenRowsForCurrRoom		; 20 1a c4
B0_3613:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_3616:		jsr introCutscene_clearTextArea		; 20 85 b7
B0_3619:		lda #$21		; a9 21
B0_361b:		jsr updateNonSpr0HitScreenFromRLEStructA		; 20 65 b7
B0_361e:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_3621:		lda #$0d		; a9 0d
B0_3623:		jsr updateNonSpr0HitScreenFromRLEStructA		; 20 65 b7
B0_3626:		jsr func_7_11b6		; 20 b6 d1
B0_3629:		lda #$0e		; a9 0e
B0_362b:		jsr set_wChrBank1		; 20 db c1
B0_362e:		jsr setPPUMask_addShowAll		; 20 5d c1
B0_3631:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_3634:		jsr func_7_04b9		; 20 b9 c4
B0_3637:		lda #$fc		; a9 fc
B0_3639:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_363c:		lda #$3f		; a9 3f
B0_363e:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3641:		jsr func_7_04c4		; 20 c4 c4
B0_3644:		jsr func_0_37a4		; 20 a4 b7
B0_3647:		lda #$0e		; a9 0e
B0_3649:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_364c:		lda #$1f		; a9 1f
B0_364e:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_3651:		sec				; 38 
B0_3652:		ror $5d			; 66 5d
B0_3654:		lda #$3d		; a9 3d
B0_3656:		ldy #$04		; a0 04
B0_3658:		jsr func_7_059f		; 20 9f c5
B0_365b:		lda #$fc		; a9 fc
B0_365d:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3660:		lda #$3f		; a9 3f
B0_3662:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3665:		jsr func_7_04c4		; 20 c4 c4
B0_3668:		jsr func_0_37a4		; 20 a4 b7
B0_366b:		lda #$0f		; a9 0f
B0_366d:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_3670:		lda #$1e		; a9 1e
B0_3672:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_3675:		jsr func_7_04b9		; 20 b9 c4
B0_3678:		lda #$fc		; a9 fc
B0_367a:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_367d:		lda #$3f		; a9 3f
B0_367f:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3682:		sec				; 38 
B0_3683:		ror $5d			; 66 5d
B0_3685:		ldy #$04		; a0 04
B0_3687:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B0_368a:		jsr setPPUMask_noSprites		; 20 53 c1
B0_368d:		dec wRoomX			; c6 42
B0_368f:		dec wRoomX			; c6 42
B0_3691:		jsr loadAllScreenRowsForCurrRoom		; 20 1a c4
B0_3694:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_3697:		jsr introCutscene_clearTextArea		; 20 85 b7
B0_369a:		lda #$21		; a9 21
B0_369c:		jsr updateNonSpr0HitScreenFromRLEStructA		; 20 65 b7
B0_369f:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_36a2:		lda #$10		; a9 10
B0_36a4:		jsr updateNonSpr0HitScreenFromRLEStructA		; 20 65 b7
B0_36a7:		lda #$09		; a9 09
B0_36a9:		jsr set_wChrBank1		; 20 db c1
B0_36ac:		jsr setPPUMask_addShowAll		; 20 5d c1
B0_36af:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_36b2:		sec				; 38 
B0_36b3:		ror $5d			; 66 5d
B0_36b5:		lda #$3e		; a9 3e
B0_36b7:		ldy #$04		; a0 04
B0_36b9:		jsr func_7_059f		; 20 9f c5
B0_36bc:		lda #$fc		; a9 fc
B0_36be:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_36c1:		lda #$3f		; a9 3f
B0_36c3:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_36c6:		jsr func_7_04c4		; 20 c4 c4
B0_36c9:		jsr func_0_37a4		; 20 a4 b7
B0_36cc:		lda #$11		; a9 11
B0_36ce:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_36d1:		jsr func_7_04b9		; 20 b9 c4
B0_36d4:		lda #$fc		; a9 fc
B0_36d6:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_36d9:		lda #$3f		; a9 3f
B0_36db:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_36de:		jsr func_7_04c4		; 20 c4 c4
B0_36e1:		jsr func_0_37a4		; 20 a4 b7
B0_36e4:		lda #$12		; a9 12
B0_36e6:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_36e9:		lda #$20		; a9 20
B0_36eb:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_36ee:		lda #$22		; a9 22
B0_36f0:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_36f3:		jsr func_7_04b9		; 20 b9 c4
B0_36f6:		lda #$fc		; a9 fc
B0_36f8:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_36fb:		lda #$3f		; a9 3f
B0_36fd:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3700:		sec				; 38 
B0_3701:		ror $5d			; 66 5d
B0_3703:		ldy #$04		; a0 04
B0_3705:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B0_3708:		jsr setPPUMask_noSprites		; 20 53 c1
B0_370b:		inc wRoomX			; e6 42
B0_370d:		inc wRoomX			; e6 42
B0_370f:		jsr loadAllScreenRowsForCurrRoom		; 20 1a c4
B0_3712:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_3715:		jsr introCutscene_clearTextArea		; 20 85 b7
B0_3718:		lda #$21		; a9 21
B0_371a:		jsr updateNonSpr0HitScreenFromRLEStructA		; 20 65 b7
B0_371d:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_3720:		lda #$13		; a9 13
B0_3722:		jsr updateNonSpr0HitScreenFromRLEStructA		; 20 65 b7
B0_3725:		jsr func_7_11b6		; 20 b6 d1
B0_3728:		lda #$0e		; a9 0e
B0_372a:		jsr set_wChrBank1		; 20 db c1
B0_372d:		jsr setPPUMask_addShowAll		; 20 5d c1
B0_3730:		jsr waitForNMIdone_interruptableByStart		; 20 d1 b7
B0_3733:		sec				; 38 
B0_3734:		ror $5d			; 66 5d
B0_3736:		lda #$3d		; a9 3d
B0_3738:		ldy #$04		; a0 04
B0_373a:		jsr func_7_059f		; 20 9f c5
B0_373d:		lda #$fc		; a9 fc
B0_373f:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3742:		lda #$bd		; a9 bd
B0_3744:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_3747:		jsr func_7_04c4		; 20 c4 c4
B0_374a:		jsr func_0_37a4		; 20 a4 b7
B0_374d:		lda #$14		; a9 14
B0_374f:		jsr updateSpr0HitScreenFromRLEStructA		; 20 75 b7
B0_3752:		jsr func_7_04b9		; 20 b9 c4
B0_3755:		lda #$fc		; a9 fc
B0_3757:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_375a:		lda #$3f		; a9 3f
B0_375c:		jsr waitForA_Spr0HitAfterNMIs_interruptableByStart		; 20 f2 b7
B0_375f:		jsr func_7_04c4		; 20 c4 c4
B0_3762:		jmp func_0_381f		; 4c 1f b8


updateNonSpr0HitScreenFromRLEStructA:
	asl a
	tay
	lda b0_rleStructsAddresses.w, y
	sta wRLEStructAddressToCopy
	lda b0_rleStructsAddresses.w+1, y
	sta wRLEStructAddressToCopy+1
	jsr updateFromRLEStruct
	rts


updateSpr0HitScreenFromRLEStructA:
	asl a
	tay
	lda b0_rleStructsAddresses.w, y
	sta wRLEStructAddressToCopy
	lda b0_rleStructsAddresses.w+1, y
	sta wRLEStructAddressToCopy+1
	jsr waitForSpr0HitAfterNMI_interruptableByStart
	rts


introCutscene_clearTextArea:
	lda PPUSTATUS.w
	ldx #>$2280
	stx PPUADDR.w
	lda #<$2280
	sta PPUADDR.w

; clear $140 bytes ($2280 to $23bf)
	ldx #$00
	ldy #$02
-	lda #$20
	sta PPUDATA.w
	inx
	cpx #$40
	bne -
	dey
	bne -

	rts


func_0_37a4:
B0_37a4:		lda #$22		; a9 22
B0_37a6:		ldy #$e0		; a0 e0
B0_37a8:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2

B0_37ab:		lda #$23		; a9 23
B0_37ad:		ldy #$00		; a0 00
B0_37af:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2

B0_37b2:		jsr waitForSpr0HitAfterNMI_interruptableByStart		; 20 da b7

B0_37b5:		lda #$23		; a9 23
B0_37b7:		ldy #$20		; a0 20
B0_37b9:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2

B0_37bc:		lda #$23		; a9 23
B0_37be:		ldy #$40		; a0 40
B0_37c0:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2

B0_37c3:		jsr waitForSpr0HitAfterNMI_interruptableByStart		; 20 da b7

B0_37c6:		lda #$23		; a9 23
B0_37c8:		ldy #$60		; a0 60
B0_37ca:		jsr vramQueueARowOfBlankTilesAtAY		; 20 d0 c2

B0_37cd:		jsr waitForSpr0HitAfterNMI_interruptableByStart		; 20 da b7
B0_37d0:		rts				; 60 


waitForNMIdone_interruptableByStart:
	jsr waitForMajorityOfNMIFuncsDone
	jsr secIfStartPressed
	bcs func_0_3801

	rts


waitForSpr0HitAfterNMI_interruptableByStart:
	jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen
	jsr secIfStartPressed
	bcs func_0_3801

	rts


waitForA_NMIsDone_interruptableByStart:
	sta wGenericCounter
-	jsr waitForMajorityOfNMIFuncsDone
	jsr secIfStartPressed
	bcs func_0_3801

	dec wGenericCounter
	bne -

	rts


waitForA_Spr0HitAfterNMIs_interruptableByStart:
	sta wGenericCounter
-	jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen
	jsr secIfStartPressed
	bcs func_0_3801

	dec wGenericCounter
	bne -

	rts


func_0_3801:
	jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B0_3804:		lda #$00		; a9 00
B0_3806:		sta wPPUScrollX			; 85 25
B0_3808:		lda wPPUCtrl			; a5 20
B0_380a:		ora #$01		; 09 01
B0_380c:		sta wPPUCtrl			; 85 20
B0_380e:		sta PPUCTRL.w		; 8d 00 20
B0_3811:		lda #$ff		; a9 ff
B0_3813:		jsr queueSoundAtoPlay		; 20 ad c4
B0_3816:		jsr func_0_38c7		; 20 c7 b8
B0_3819:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B0_381c:		jmp B0_383c		; 4c 3c b8


func_0_381f:
B0_381f:		jsr func_0_38c7		; 20 c7 b8
B0_3822:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B0_3825:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B0_3828:		inc $25			; e6 25
B0_382a:		beq B0_3832 ; f0 06

B0_382c:		lda wJoy1NewButtonsPressed			; a5 29
B0_382e:		and #PADF_START		; 29 10
B0_3830:		beq B0_3825 ; f0 f3

B0_3832:		lda #$00		; a9 00
B0_3834:		sta wPPUScrollX			; 85 25
B0_3836:		lda wPPUCtrl			; a5 20
B0_3838:		ora #$01		; 09 01
B0_383a:		sta wPPUCtrl			; 85 20

B0_383c:		lda #$f0		; a9 f0
B0_383e:		sta $00			; 85 00
B0_3840:		lda #$03		; a9 03
B0_3842:		sta $01			; 85 01
B0_3844:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B0_3847:		lda wMajorNMIUpdatesCounter			; a5 23
B0_3849:		and #$07		; 29 07
B0_384b:		bne B0_3863 ; d0 16

B0_384d:		ldx #$26		; a2 26
B0_384f:		ldy #$16		; a0 16
B0_3851:		lda wMajorNMIUpdatesCounter			; a5 23
B0_3853:		and #$08		; 29 08
B0_3855:		bne B0_385b ; d0 04

B0_3857:		ldy #$26		; a0 26
B0_3859:		ldx #$16		; a2 16
B0_385b:		stx $06a6		; 8e a6 06
B0_385e:		sty $06a7		; 8c a7 06
B0_3861:		sty wShouldUpdateInternalPalettes			; 84 30
B0_3863:		dec $00			; c6 00
B0_3865:		bne B0_3890 ; d0 29

B0_3867:		dec $01			; c6 01
B0_3869:		bne B0_3890 ; d0 25

B0_386b:		jsr setPPUMask_noSprites		; 20 53 c1
B0_386e:		jsr setPPUCtrl_noNMI		; 20 64 c1
B0_3871:		jsr fillNametables01With20h		; 20 b1 c2
B0_3874:		jsr clearNametables01Palettes		; 20 90 c2
B0_3877:		jsr clearAllEntities		; 20 94 c3
B0_387a:		jsr hideAllOam		; 20 9f c3
B0_387d:		lda wPPUCtrl			; a5 20
B0_387f:		and #$fe		; 29 fe
B0_3881:		sta wPPUCtrl			; 85 20
B0_3883:		lda #$13		; a9 13
B0_3885:		jsr set_wChrBank1		; 20 db c1
B0_3888:		lda #$1f		; a9 1f
B0_388a:		jsr set_wChrBank0		; 20 c2 c1
B0_388d:		jmp func_0_342c		; 4c 2c b4

B0_3890:		lda wJoy1NewButtonsPressed			; a5 29
B0_3892:		and #PADF_START		; 29 10
B0_3894:		beq B0_3844 ; f0 ae

B0_3896:		lda #$00		; a9 00
B0_3898:		sta wShouldUpdateInternalPalettes			; 85 30
B0_389a:		ldx #$fd		; a2 fd
B0_389c:		txs				; 9a 
B0_389d:		rts				; 60 


secIfStartPressed:
	lda wJoy1ButtonsPressed
	and #PADF_START
	bne +

	clc
	rts

+	sec
	rts


func_0_38a8:
B0_38a8:		ldx #>(NAMETABLE1-NAMETABLE0)		; a2 04
B0_38aa:		ldy #$00		; a0 00
B0_38ac:		sta $10			; 85 10

; reset latch and fill nametable 0 with 20h tile
B0_38ae:		lda PPUSTATUS.w		; ad 02 20
B0_38b1:		lda #>NAMETABLE0		; a9 20
B0_38b3:		sta PPUADDR.w		; 8d 06 20
B0_38b6:		sty PPUADDR.w		; 8c 06 20

-	lda #$20		; a9 20
B0_38bb:		sta PPUDATA.w		; 8d 07 20
B0_38be:		dey				; 88 
	bne -
B0_38c1:		inc $00			; e6 00
B0_38c3:		dex				; ca 
	bne -

B0_38c6:		rts				; 60 


func_0_38c7:
B0_38c7:		jsr setPPUMask_noSprites		; 20 53 c1
B0_38ca:		jsr func_0_38a8		; 20 a8 b8
B0_38cd:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B0_38d0:		lda #$11		; a9 11
B0_38d2:		jsr set_wChrBank1		; 20 db c1
B0_38d5:		lda #$13		; a9 13
B0_38d7:		jsr set_wChrBank0		; 20 c2 c1
B0_38da:		lda #$36		; a9 36
B0_38dc:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B0_38df:		lda #$60		; a9 60
B0_38e1:		sta wOam.Y.w		; 8d 00 02
B0_38e4:		jsr func_7_11bb		; 20 bb d1
B0_38e7:		jsr setPPUMask_addShowAll		; 20 5d c1
B0_38ea:		rts				; 60 
