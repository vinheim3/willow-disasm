
useMagic_healmace:
B6_0842:		lda #$48		; a9 48
B6_0844:		sta wHealthGiven			; 85 77
	bne +

useMagic_healball:
B6_0848:		lda #$a8		; a9 a8
B6_084a:		sta wHealthGiven			; 85 77

+	ldy wCurrLevel			; a4 71
B6_084e:		lda wCurrHealth			; a5 7b
B6_0850:		cmp levelMaxHealth.w, y	; d9 fb d1
B6_0853:		bne B6_0861 ; d0 0c

func_6_0855:
B6_0855:		lda #$00		; a9 00
B6_0857:		sta wHealthGiven			; 85 77
B6_0859:		sta wMPUsed			; 85 78
B6_085b:		jsr markMagicNotInUse		; 20 94 88
B6_085e:		jmp $8128		; 4c 28 81

B6_0861:		lda #$2a		; a9 2a
B6_0863:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0866:		lda #$18		; a9 18
B6_0868:		sta $b0			; 85 b0
B6_086a:		ldx #$15		; a2 15
B6_086c:		lda wMajorNMIUpdatesCounter			; a5 23
B6_086e:		and #$04		; 29 04
B6_0870:		bne B6_0874 ; d0 02

B6_0872:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_0874:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_0874:	.db $ea $ea $ea
.endif
B6_0877:		stx $30			; 86 30
B6_0879:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_087c:		dec $b0			; c6 b0
B6_087e:		bne B6_086a ; d0 ea

B6_0880:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_0882:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_0882:	.db $ea $ea $ea
.endif
B6_0885:		stx $30			; 86 30

-	lda wHealthGiven			; a5 77
B6_0889:		beq markMagicNotInUse

B6_088b:		jsr processExp_etc_todo		; 20 44 f3
B6_088e:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
	jmp -

markMagicNotInUse:
	lda wEquippedMagic
	and #$7f
	sta wEquippedMagic
	rts


useMagic_ocarina:
B6_089b:		bit $58			; 24 58
B6_089d:		bvs B6_08ab ; 70 0c

B6_089f:		ldx #$17		; a2 17
B6_08a1:		lda wEntitiesControlByte.w, x	; bd 00 03
B6_08a4:		bpl B6_08ae ; 10 08

B6_08a6:		lda wEntitiesId.w, x	; bd 18 03
B6_08a9:		beq B6_08ae ; f0 03

B6_08ab:		jmp func_6_0855		; 4c 55 88

B6_08ae:		dex				; ca 
B6_08af:		cpx #$08		; e0 08
B6_08b1:		bcs B6_08a1 ; b0 ee

B6_08b3:		lda #$18		; a9 18
B6_08b5:		jsr set_wChrBank0		; 20 c2 c1
B6_08b8:		lda #$11		; a9 11
B6_08ba:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_08bd:		lda #$ff		; a9 ff
B6_08bf:		jsr queueSoundAtoPlay		; 20 ad c4
B6_08c2:		lda #$2c		; a9 2c
B6_08c4:		jsr func_7_04ab		; 20 ab c4
B6_08c7:		lda #$00		; a9 00
B6_08c9:		sta $b0			; 85 b0
B6_08cb:		sta $d6			; 85 d6
B6_08cd:		sta $55			; 85 55
B6_08cf:		jsr processExp_etc_todo		; 20 44 f3
B6_08d2:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_08d5:		dec $b0			; c6 b0
B6_08d7:		bne B6_08d2 ; d0 f9

B6_08d9:		ldx #$00		; a2 00
B6_08db:		lda #$10		; a9 10
B6_08dd:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_08e0:		lda #$00		; a9 00
B6_08e2:		sta wEntitiesY.w, x	; 9d 80 04
B6_08e5:		lda wPlayerX			; a5 ce
B6_08e7:		sta wEntitiesX.w, x	; 9d b0 04
B6_08ea:		jsr drawEntities		; 20 03 c4
B6_08ed:		jsr drawPlayer		; 20 dd c3
B6_08f0:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_08f3:		lda wMajorNMIUpdatesCounter			; a5 23
B6_08f5:		and #$07		; 29 07
B6_08f7:		bne B6_08fe ; d0 05

B6_08f9:		lda #$2d		; a9 2d
B6_08fb:		jsr queueSoundAtoPlay		; 20 ad c4
B6_08fe:		inc wEntitiesY.w		; ee 80 04
B6_0901:		lda wPlayerY			; a5 cc
B6_0903:		sec				; 38 
B6_0904:		sbc #$18		; e9 18
B6_0906:		cmp wEntitiesY.w		; cd 80 04
B6_0909:		bcs B6_08ea ; b0 df

B6_090b:		ldy #$04		; a0 04
B6_090d:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B6_0910:		jsr setPPUMask_noSprites		; 20 53 c1
B6_0913:		lda #$1f		; a9 1f
B6_0915:		sta wRoomY			; 85 43
B6_0917:		sta wRoomX			; 85 42
B6_0919:		jsr clearAllEntities		; 20 94 c3
B6_091c:		jsr hideAllOam		; 20 9f c3
B6_091f:		jsr drawEntities		; 20 03 c4
B6_0922:		jsr drawPlayer		; 20 dd c3
B6_0925:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0928:		jsr func_6_2020		; 20 20 a0
B6_092b:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_092e:		bit $6c			; 24 6c
B6_0930:		bmi B6_0944 ; 30 12

B6_0932:		jsr updateMagicEntities		; 20 2e c4
B6_0935:		jsr updateScreenEntities		; 20 23 c4
B6_0938:		jsr drawEntities		; 20 03 c4
B6_093b:		jsr drawPlayer		; 20 dd c3
B6_093e:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_0941:		jmp $892e		; 4c 2e 89

B6_0944:		lda #$00		; a9 00
B6_0946:		sta $68			; 85 68
B6_0948:		bit $68			; 24 68
B6_094a:		bpl B6_0952 ; 10 06

B6_094c:		lda wJoy1NewButtonsPressed			; a5 29
B6_094e:		and #$c0		; 29 c0
B6_0950:		bne B6_0964 ; d0 12

B6_0952:		jsr func_6_27b5		; 20 b5 a7
B6_0955:		jsr updateScreenEntities		; 20 23 c4
B6_0958:		jsr drawEntities		; 20 03 c4
B6_095b:		jsr drawPlayer		; 20 dd c3
B6_095e:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_0961:		jmp $8948		; 4c 48 89

B6_0964:		lda $6c			; a5 6c
B6_0966:		ora #$40		; 09 40
B6_0968:		sta $6c			; 85 6c
B6_096a:		lda $6c			; a5 6c
B6_096c:		and #$20		; 29 20
B6_096e:		bne B6_097f ; d0 0f

B6_0970:		jsr updateScreenEntities		; 20 23 c4
B6_0973:		jsr drawEntities		; 20 03 c4
B6_0976:		jsr drawPlayer		; 20 dd c3
B6_0979:		jsr waitForMajorityOfNMIFuncsDone_spr0HitScreen		; 20 36 c1
B6_097c:		jmp $896a		; 4c 6a 89

B6_097f:		jsr $a9e6		; 20 e6 a9
B6_0982:		lda #$1e		; a9 1e
B6_0984:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B6_0987:		ldy #$04		; a0 04
B6_0989:		jsr palettesAllFadeOutDelayY		; 20 4d c6
B6_098c:		jsr clearAllEntities		; 20 94 c3
B6_098f:		jsr drawEntities		; 20 03 c4
B6_0992:		jsr setPPUMask_noSprites		; 20 53 c1
B6_0995:		jsr roomTransitionUpdateChrPalMus2EntityBytes		; 20 c9 9d
B6_0998:		lda #$00		; a9 00
B6_099a:		sta $6c			; 85 6c
B6_099c:		sta wEntityDataByte2			; 85 52
B6_099e:		lda #$f8		; a9 f8
B6_09a0:		sta $0200		; 8d 00 02
B6_09a3:		jsr setNametable1IfOddRoomX		; 20 d7 dc
B6_09a6:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_09a9:		jsr b6_loadAllScreenRowsForCurrRoom		; 20 f3 de
B6_09ac:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_09af:		jsr func_7_3000		; 20 00 f0
B6_09b2:		lda $c0			; a5 c0
B6_09b4:		and #$ef		; 29 ef
B6_09b6:		sta $c0			; 85 c0
B6_09b8:		lda #$89		; a9 89
B6_09ba:		sta wPlayerY			; 85 cc
B6_09bc:		lda #$98		; a9 98
B6_09be:		sta wPlayerX			; 85 ce
B6_09c0:		jsr markMagicNotInUse		; 20 94 88
B6_09c3:		lda #$02		; a9 02
B6_09c5:		sta wPlayerDirectionFacing			; 85 c9
B6_09c7:		jsr func_6_02a1		; 20 a1 82
B6_09ca:		ldx #$00		; a2 00
B6_09cc:		lda #$10		; a9 10
B6_09ce:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_09d1:		lda #$59		; a9 59
B6_09d3:		sta wEntitiesY.w, x	; 9d 80 04
B6_09d6:		lda #$98		; a9 98
B6_09d8:		sta wEntitiesX.w, x	; 9d b0 04
B6_09db:		lda #$18		; a9 18
B6_09dd:		jsr set_wChrBank0		; 20 c2 c1
B6_09e0:		lda #$11		; a9 11
B6_09e2:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_09e5:		jsr setPPUMask_addShowAll		; 20 5d c1
B6_09e8:		jsr drawEntities		; 20 03 c4
B6_09eb:		jsr drawPlayer		; 20 dd c3
B6_09ee:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_09f1:		dec wEntitiesY.w		; ce 80 04
B6_09f4:		lda wEntitiesY.w		; ad 80 04
B6_09f7:		cmp #$08		; c9 08
B6_09f9:		bcs B6_09e8 ; b0 ed

B6_09fb:		lda #$00		; a9 00
B6_09fd:		sta wEntitiesControlByte.w		; 8d 00 03
B6_0a00:		sta $59			; 85 59
B6_0a02:		jsr drawEntities		; 20 03 c4
B6_0a05:		jsr drawPlayer		; 20 dd c3
B6_0a08:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0a0b:		ldx #$ff		; a2 ff
B6_0a0d:		txs				; 9a 
B6_0a0e:		jmp mainLoop		; 4c a9 de


useMagic_fleet:
B6_0a11:		bit $58			; 24 58
B6_0a13:		bvs B6_0a18 ; 70 03

B6_0a15:		jmp func_6_0855		; 4c 55 88

B6_0a18:		ldx #$17		; a2 17
B6_0a1a:		lda wEntitiesControlByte.w, x	; bd 00 03
B6_0a1d:		and #$fb		; 29 fb
B6_0a1f:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_0a22:		dex				; ca 
B6_0a23:		bpl B6_0a1a ; 10 f5

B6_0a25:		lda #$2a		; a9 2a
B6_0a27:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0a2a:		lda #$5d		; a9 5d
B6_0a2c:		sta $b0			; 85 b0
B6_0a2e:		ldx #$20		; a2 20
B6_0a30:		lda wMajorNMIUpdatesCounter			; a5 23
B6_0a32:		and #$04		; 29 04
B6_0a34:		bne B6_0a38 ; d0 02

B6_0a36:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_0a38:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_0a38:	.db $ea $ea $ea
.endif
B6_0a3b:		stx $30			; 86 30
B6_0a3d:		jsr processExp_etc_todo		; 20 44 f3
B6_0a40:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0a43:		dec $b0			; c6 b0
B6_0a45:		bne B6_0a2e ; d0 e7

B6_0a47:		ldy #$04		; a0 04
B6_0a49:		jsr palettesBGFadeOut		; 20 0e c6
B6_0a4c:		lda #$ff		; a9 ff
B6_0a4e:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0a51:		lda #$2e		; a9 2e
B6_0a53:		jsr func_7_04ab		; 20 ab c4
B6_0a56:		lda #$03		; a9 03
B6_0a58:		ldx #$7c		; a2 7c
B6_0a5a:		jsr $8ea9		; 20 a9 8e
B6_0a5d:		lda wPlayerY			; a5 cc
B6_0a5f:		cmp #$08		; c9 08
B6_0a61:		bcc B6_0a74 ; 90 11

B6_0a63:		sec				; 38 
B6_0a64:		sbc #$08		; e9 08
B6_0a66:		sta wPlayerY			; 85 cc
B6_0a68:		inc $b0			; e6 b0
B6_0a6a:		lda #$03		; a9 03
B6_0a6c:		ldx #$01		; a2 01
B6_0a6e:		jsr $8ea9		; 20 a9 8e
B6_0a71:		jmp $8a5d		; 4c 5d 8a

B6_0a74:		lda $c0			; a5 c0
B6_0a76:		ora #$10		; 09 10
B6_0a78:		sta $c0			; 85 c0
B6_0a7a:		jsr clearAllEntities		; 20 94 c3
B6_0a7d:		jsr drawEntities		; 20 03 c4
B6_0a80:		jsr drawPlayer		; 20 dd c3
B6_0a83:		ldy #$04		; a0 04
B6_0a85:		jsr palettesSprFadeOut		; 20 1b c6
B6_0a88:		jsr setPPUMask_noSprites		; 20 53 c1
B6_0a8b:		ldx #$00		; a2 00

B6_0a8d:		lda entranceAData.w, x	; bd 07 ac
B6_0a90:		cmp wLastOutdoorEntranceUsedY			; c5 5a
B6_0a92:		bne B6_0a9b ; d0 07

B6_0a94:		lda entranceAData.w+1, x	; bd 08 ac
B6_0a97:		cmp wLastOutdoorEntranceUsedX			; c5 5b
B6_0a99:		beq B6_0a9f ; f0 04

B6_0a9b:		inx				; e8 
B6_0a9c:		inx				; e8 
B6_0a9d:		bne B6_0a8d ; d0 ee

B6_0a9f:		lda entranceBData.w, x	; bd b8 ac
B6_0aa2:		sta wRoomY			; 85 43
B6_0aa4:		lda entranceBData.w+1, x	; bd b9 ac
B6_0aa7:		sta wRoomX			; 85 42
B6_0aa9:		jsr $aaeb		; 20 eb aa
B6_0aac:		lda $d5			; a5 d5
B6_0aae:		jsr func_7_04ab		; 20 ab c4
B6_0ab1:		lda $c0			; a5 c0
B6_0ab3:		and #$ef		; 29 ef
B6_0ab5:		sta $c0			; 85 c0
B6_0ab7:		lda #$03		; a9 03
B6_0ab9:		ldx #$7c		; a2 7c
B6_0abb:		jsr $8ea9		; 20 a9 8e
B6_0abe:		jsr markMagicNotInUse		; 20 94 88
B6_0ac1:		jmp B6_0517		; 4c 17 85


useMagic_specter:
B6_0ac4:		lda #$34		; a9 34
B6_0ac6:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0ac9:		lda #$09		; a9 09
B6_0acb:		sta $bf			; 85 bf
B6_0acd:		lda $c0			; a5 c0
B6_0acf:		and #$f7		; 29 f7
B6_0ad1:		sta $c0			; 85 c0
B6_0ad3:		jsr setPlayerMovementAnimationDetails		; 20 c4 82
B6_0ad6:		lda #$04		; a9 04
B6_0ad8:		sta $b1			; 85 b1
B6_0ada:		lda #$ff		; a9 ff
B6_0adc:		sta $b0			; 85 b0
B6_0ade:		lda #$13		; a9 13
B6_0ae0:		sta $f0			; 85 f0
B6_0ae2:		ldx #$00		; a2 00

B6_0ae4:		lda $f0			; a5 f0
B6_0ae6:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_0ae9:		lda $8b0e, x	; bd 0e 8b
B6_0aec:		sta wEntities_408.w, x	; 9d 08 04
B6_0aef:		lda $8b12, x	; bd 12 8b
B6_0af2:		clc				; 18 
B6_0af3:		adc wPlayerY			; 65 cc
B6_0af5:		sta wEntitiesY.w, x	; 9d 80 04
B6_0af8:		lda $8b16, x	; bd 16 8b
B6_0afb:		clc				; 18 
B6_0afc:		adc wPlayerX			; 65 ce
B6_0afe:		sta wEntitiesX.w, x	; 9d b0 04
B6_0b01:		lda #$08		; a9 08
B6_0b03:		sta wEntities_378.w, x	; 9d 78 03
B6_0b06:		inc $f0			; e6 f0
B6_0b08:		inx				; e8 
B6_0b09:		cpx #$04		; e0 04
B6_0b0b:		bne B6_0ae4 ; d0 d7

B6_0b0d:		rts				; 60 


B6_0b0e:	.db $3c
B6_0b0f:	.db $34
B6_0b10:		bit $2c			; 24 2c
B6_0b12:	.db $fc
B6_0b13:	.db $04
B6_0b14:	.db $fc
B6_0b15:	.db $04
B6_0b16:	.db $fc
B6_0b17:	.db $fc
B6_0b18:	.db $04
B6_0b19:	.db $04


useMagic_bombard:
B6_0b1a:		lda #SND_USING_BOMBARD		; a9 37
B6_0b1c:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0b1f:		jsr processExp_etc_todo		; 20 44 f3

B6_0b22:		lda #$c0		; a9 c0
B6_0b24:		sta $b0			; 85 b0
B6_0b26:		jsr func_6_0e63		; 20 63 8e
B6_0b29:		lda #$12		; a9 12
B6_0b2b:		sta $b0			; 85 b0
B6_0b2d:		ldx #$20		; a2 20
B6_0b2f:		lda wMajorNMIUpdatesCounter			; a5 23
B6_0b31:		and #$04		; 29 04
B6_0b33:		bne B6_0b37 ; d0 02

B6_0b35:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_0b37:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_0b37:	.db $ea $ea $ea
.endif
B6_0b3a:		stx $30			; 86 30
B6_0b3c:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0b3f:		dec $b0			; c6 b0
B6_0b41:		bne B6_0b2d ; d0 ea

B6_0b43:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_0b45:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_0b45:	.db $ea $ea $ea
.endif
B6_0b48:		stx $30			; 86 30
	jsr drawEntities
	jsr drawPlayer
	jsr waitForMajorityOfNMIFuncsDone
	jsr markMagicNotInUse
	rts


useMagic_acorn:
B6_0b57:		lda $0307		; ad 07 03
B6_0b5a:		bpl B6_0b66 ; 10 0a

B6_0b5c:		lda $031f		; ad 1f 03
B6_0b5f:		cmp #$2c		; c9 2c
B6_0b61:		bne B6_0b66 ; d0 03

B6_0b63:		jmp func_6_0855		; 4c 55 88

B6_0b66:		lda #$36		; a9 36
B6_0b68:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0b6b:		ldx #$07		; a2 07
B6_0b6d:		lda #$18		; a9 18
B6_0b6f:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_0b72:		lda $c9			; a5 c9
B6_0b74:		asl a			; 0a
B6_0b75:		asl a			; 0a
B6_0b76:		asl a			; 0a
B6_0b77:		ora #$00		; 09 00
B6_0b79:		sta wEntities_408.w, x	; 9d 08 04
B6_0b7c:		lda wPlayerY			; a5 cc
B6_0b7e:		sta wEntitiesY.w, x	; 9d 80 04
B6_0b81:		lda wPlayerX			; a5 ce
B6_0b83:		sta wEntitiesX.w, x	; 9d b0 04
B6_0b86:		rts				; 60 


useMagic_cane:
B6_0b87:		lda $0306		; ad 06 03
B6_0b8a:		bpl B6_0b96 ; 10 0a

B6_0b8c:		lda $031e		; ad 1e 03
B6_0b8f:		cmp #$2d		; c9 2d
B6_0b91:		bne B6_0b96 ; d0 03

B6_0b93:		jmp func_6_0855		; 4c 55 88

B6_0b96:		lda #$39		; a9 39
B6_0b98:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0b9b:		ldx #$06		; a2 06
B6_0b9d:		lda #$19		; a9 19
B6_0b9f:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_0ba2:		lda $c9			; a5 c9
B6_0ba4:		asl a			; 0a
B6_0ba5:		asl a			; 0a
B6_0ba6:		asl a			; 0a
B6_0ba7:		ora #$00		; 09 00
B6_0ba9:		sta wEntities_408.w, x	; 9d 08 04
B6_0bac:		jmp $8b7c		; 4c 7c 8b


useMagic_fireflor:
B6_0baf:		lda #$30		; a9 30
B6_0bb1:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0bb4:		ldx #$07		; a2 07
B6_0bb6:		lda $8c01, x	; bd 01 8c
B6_0bb9:		bmi B6_0bc2 ; 30 07

B6_0bbb:		clc				; 18 
B6_0bbc:		adc wPlayerY			; 65 cc
B6_0bbe:		bcs B6_0bf5 ; b0 35

B6_0bc0:		bcc B6_0bc7 ; 90 05

B6_0bc2:		clc				; 18 
B6_0bc3:		adc wPlayerY			; 65 cc
B6_0bc5:		bcc B6_0bf5 ; 90 2e

B6_0bc7:		sta wEntitiesY.w, x	; 9d 80 04
B6_0bca:		lda $8c09, x	; bd 09 8c
B6_0bcd:		bmi B6_0bd6 ; 30 07

B6_0bcf:		clc				; 18 
B6_0bd0:		adc wPlayerX			; 65 ce
B6_0bd2:		bcs B6_0bf5 ; b0 21

B6_0bd4:		bcc B6_0bdb ; 90 05

B6_0bd6:		clc				; 18 
B6_0bd7:		adc wPlayerX			; 65 ce
B6_0bd9:		bcc B6_0bf5 ; 90 1a

B6_0bdb:		sta wEntitiesX.w, x	; 9d b0 04
B6_0bde:		lda #$17		; a9 17
B6_0be0:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_0be3:		txa				; 8a 
B6_0be4:		pha				; 48 
B6_0be5:		jsr processExp_etc_todo		; 20 44 f3
B6_0be8:		jsr drawEntities		; 20 03 c4
B6_0beb:		jsr drawPlayer		; 20 dd c3
B6_0bee:		lda #$04		; a9 04
B6_0bf0:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B6_0bf3:		pla				; 68 
B6_0bf4:		tax				; aa 
B6_0bf5:		dex				; ca 
B6_0bf6:		bpl B6_0bb6 ; 10 be

B6_0bf8:		lda #$3f		; a9 3f
B6_0bfa:		sta $b0			; 85 b0
B6_0bfc:		lda #$01		; a9 01
B6_0bfe:		sta $b1			; 85 b1
B6_0c00:		rts				; 60 


B6_0c01:		cpx #$00		; e0 00
B6_0c03:		jsr $2028		; 20 28 20
B6_0c06:		.db $00				; 00
B6_0c07:		cpx #$d8		; e0 d8
B6_0c09:		jsr $2028		; 20 28 20
B6_0c0c:		.db $00				; 00
B6_0c0d:		cpx #$d8		; e0 d8
B6_0c0f:		cpx #$00		; e0 00


useMagic_terstorm:
B6_0c11:		lda #$31		; a9 31
B6_0c13:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0c16:		lda #$07		; a9 07
B6_0c18:		ldx #$3f		; a2 3f
B6_0c1a:		jsr $8ea9		; 20 a9 8e
B6_0c1d:		lda #$03		; a9 03
B6_0c1f:		ldx #$3f		; a2 3f
B6_0c21:		jsr $8ea9		; 20 a9 8e
B6_0c24:		lda #$00		; a9 00
B6_0c26:		sta $b1			; 85 b1
B6_0c28:		lda #$7e		; a9 7e
B6_0c2a:		sta $b0			; 85 b0
B6_0c2c:		lda #$07		; a9 07
B6_0c2e:		sta $b2			; 85 b2
B6_0c30:		jsr drawEntities		; 20 03 c4
B6_0c33:		jsr drawPlayer		; 20 dd c3
B6_0c36:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0c39:		jsr markMagicNotInUse		; 20 94 88
B6_0c3c:		lda $b1			; a5 b1
B6_0c3e:		bne B6_0c63 ; d0 23

B6_0c40:		ldx $b2			; a6 b2
B6_0c42:		lda #$44		; a9 44
B6_0c44:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_0c47:		lda $8cd4, x	; bd d4 8c
B6_0c4a:		sta wEntities_408.w, x	; 9d 08 04
B6_0c4d:		lda wPlayerY			; a5 cc
B6_0c4f:		sta wEntitiesY.w, x	; 9d 80 04
B6_0c52:		lda wPlayerX			; a5 ce
B6_0c54:		sta wEntitiesX.w, x	; 9d b0 04
B6_0c57:		dec $b2			; c6 b2
B6_0c59:		lda $b2			; a5 b2
B6_0c5b:		and #$07		; 29 07
B6_0c5d:		sta $b2			; 85 b2
B6_0c5f:		lda #$04		; a9 04
B6_0c61:		sta $b1			; 85 b1
B6_0c63:		lda $b0			; a5 b0
B6_0c65:		beq B6_0c8e ; f0 27

B6_0c67:		dec $b0			; c6 b0
B6_0c69:		dec $b1			; c6 b1
B6_0c6b:		lda #$01		; a9 01
B6_0c6d:		and wMajorNMIUpdatesCounter			; 25 23
B6_0c6f:		bne B6_0c7c ; d0 0b

B6_0c71:		inc $c9			; e6 c9
B6_0c73:		lda $c9			; a5 c9
B6_0c75:		and #$03		; 29 03
B6_0c77:		sta wPlayerDirectionFacing			; 85 c9
B6_0c79:		jsr setPlayerMovementAnimationDetails		; 20 c4 82
B6_0c7c:		jsr updateMagicEntities		; 20 2e c4
B6_0c7f:		jsr drawEntities		; 20 03 c4
B6_0c82:		jsr drawPlayer		; 20 dd c3
B6_0c85:		jsr processExp_etc_todo		; 20 44 f3
B6_0c88:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0c8b:		jmp $8c3c		; 4c 3c 8c

B6_0c8e:		dec $b1			; c6 b1
B6_0c90:		lda #$01		; a9 01
B6_0c92:		and wMajorNMIUpdatesCounter			; 25 23
B6_0c94:		bne B6_0ca1 ; d0 0b

B6_0c96:		inc $c9			; e6 c9
B6_0c98:		lda $c9			; a5 c9
B6_0c9a:		and #$03		; 29 03
B6_0c9c:		sta wPlayerDirectionFacing			; 85 c9
B6_0c9e:		jsr setPlayerMovementAnimationDetails		; 20 c4 82
B6_0ca1:		jsr updateMagicEntities		; 20 2e c4
B6_0ca4:		jsr updateScreenEntities		; 20 23 c4
B6_0ca7:		jsr drawEntities		; 20 03 c4
B6_0caa:		jsr drawPlayer		; 20 dd c3
B6_0cad:		jsr processExp_etc_todo		; 20 44 f3
B6_0cb0:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0cb3:		ldx #$17		; a2 17
B6_0cb5:		lda wEntitiesControlByte.w, x	; bd 00 03
B6_0cb8:		bpl B6_0cc4 ; 10 0a

B6_0cba:		lda wEntities_330.w, x	; bd 30 03
B6_0cbd:		and $b9			; 25 b9
B6_0cbf:		bne B6_0cc4 ; d0 03

B6_0cc1:		jmp $8c3c		; 4c 3c 8c

B6_0cc4:		dex				; ca 
B6_0cc5:		cpx #$08		; e0 08
B6_0cc7:		bcs B6_0cb5 ; b0 ec

B6_0cc9:		ldx #$07		; a2 07
B6_0ccb:		lda #$00		; a9 00
B6_0ccd:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_0cd0:		dex				; ca 
B6_0cd1:		bpl B6_0ccb ; 10 f8

B6_0cd3:		rts				; 60 


B6_0cd4:		;removed
	.db $10 $1c

B6_0cd6:		php				; 08 
B6_0cd7:	.db $14
B6_0cd8:		.db $00				; 00
B6_0cd9:	.db $0c
B6_0cda:		clc				; 18 
B6_0cdb:	.db $04


useMagic_renew:
B6_0cdc:		lda #$38		; a9 38
B6_0cde:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0ce1:		jsr processExp_etc_todo		; 20 44 f3
B6_0ce4:		ldy #$04		; a0 04
B6_0ce6:		jsr palettesBGFadeOut		; 20 0e c6
B6_0ce9:		lda #$ff		; a9 ff
B6_0ceb:		sta $b0			; 85 b0
B6_0ced:		lda #$ba		; a9 ba
B6_0cef:		sta $b1			; 85 b1
B6_0cf1:		jsr markMagicNotInUse		; 20 94 88
B6_0cf4:		jsr $8ecf		; 20 cf 8e
B6_0cf7:		jsr drawEntities		; 20 03 c4
B6_0cfa:		jsr drawPlayer		; 20 dd c3
B6_0cfd:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0d00:		dec $b1			; c6 b1
B6_0d02:		beq B6_0d0a ; f0 06

B6_0d04:		jsr $8ed9		; 20 d9 8e
B6_0d07:		jmp $8cf7		; 4c f7 8c

B6_0d0a:		lda #$3e		; a9 3e
B6_0d0c:		sta $b1			; 85 b1
B6_0d0e:		lda #$30		; a9 30
B6_0d10:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_0d13:		jsr $8ed9		; 20 d9 8e
B6_0d16:		jsr drawEntities		; 20 03 c4
B6_0d19:		jsr drawPlayer		; 20 dd c3
B6_0d1c:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0d1f:		dec $b1			; c6 b1
B6_0d21:		beq B6_0d26 ; f0 03

B6_0d23:		jmp $8d13		; 4c 13 8d

B6_0d26:		lda #$3e		; a9 3e
B6_0d28:		sta $b1			; 85 b1
B6_0d2a:		lda wEquippedMagic			; a5 b8
B6_0d2c:		ora #$80		; 09 80
B6_0d2e:		sta wEquippedMagic			; 85 b8
B6_0d30:		jsr getNewRandomVal		; 20 8a c4
B6_0d33:		and #$07		; 29 07
B6_0d35:		sta $b2			; 85 b2
B6_0d37:		jsr $8ed9		; 20 d9 8e
B6_0d3a:		jsr drawEntities		; 20 03 c4
B6_0d3d:		jsr drawPlayer		; 20 dd c3
B6_0d40:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0d43:		jsr markMagicNotInUse		; 20 94 88
B6_0d46:		jsr $8ed9		; 20 d9 8e
B6_0d49:		jsr drawEntities		; 20 03 c4
B6_0d4c:		jsr drawPlayer		; 20 dd c3
B6_0d4f:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0d52:		dec $b1			; c6 b1
B6_0d54:		beq B6_0d59 ; f0 03

B6_0d56:		jmp $8d46		; 4c 46 8d

B6_0d59:		lda #$3e		; a9 3e
B6_0d5b:		sta $b1			; 85 b1
B6_0d5d:		lda wSprPaletteSpecAndChrBank			; a5 50
B6_0d5f:		lsr a			; 4a
B6_0d60:		lsr a			; 4a
B6_0d61:		lsr a			; 4a
B6_0d62:		lsr a			; 4a
B6_0d63:		clc				; 18 
B6_0d64:		adc #$10		; 69 10
B6_0d66:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B6_0d69:		jsr $8ed9		; 20 d9 8e
B6_0d6c:		jsr drawEntities		; 20 03 c4
B6_0d6f:		jsr drawPlayer		; 20 dd c3
B6_0d72:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0d75:		dec $b1			; c6 b1
B6_0d77:		beq B6_0d7c ; f0 03

B6_0d79:		jmp $8d69		; 4c 69 8d

B6_0d7c:		ldx #$07		; a2 07
B6_0d7e:		lda #$00		; a9 00
B6_0d80:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_0d83:		dex				; ca 
B6_0d84:		bpl B6_0d7e ; 10 f8

B6_0d86:		ldy #$04		; a0 04
B6_0d88:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B6_0d8a:		jsr palettesBGFadeOut_saveSpecADelayY		; 20 ff c5
B6_0d8d:		rts				; 60 


useMagic_thunder:
B6_0d8e:		ldy #$04		; a0 04
B6_0d90:		jsr palettesBGFadeOut		; 20 0e c6
B6_0d93:		jsr processExp_etc_todo		; 20 44 f3
B6_0d96:		jsr markMagicNotInUse		; 20 94 88
B6_0d99:		lda #$2f		; a9 2f
B6_0d9b:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0d9e:		lda #$00		; a9 00
B6_0da0:		sta $b0			; 85 b0

@nextThunder:
B6_0da2:		ldx #$05		; a2 05
B6_0da4:		ldy $b0			; a4 b0
B6_0da6:		lda $8e21, y	; b9 21 8e
B6_0da9:		sta wEntitiesY.w, x	; 9d 80 04
B6_0dac:		lda $8e37, y	; b9 37 8e
B6_0daf:		sta wEntitiesX.w, x	; 9d b0 04
B6_0db2:		lda $8e4d, y	; b9 4d 8e
B6_0db5:		jsr initNpcSpecAIdxX		; 20 ec c3
B6_0db8:		inc $b0			; e6 b0
B6_0dba:		lda $b0			; a5 b0
B6_0dbc:		cmp #$0b		; c9 0b
B6_0dbe:		beq B6_0ddf ; @firstThundersDone

B6_0dc0:		cmp #$16		; c9 16
B6_0dc2:		bcs B6_0de7 ; @lastThundersDone

@afterAThunder:
B6_0dc4:		jsr drawEntities		; 20 03 c4
B6_0dc7:		jsr drawPlayer		; 20 dd c3
B6_0dca:		ldx #$02		; a2 02
B6_0dcc:		lda wMajorNMIUpdatesCounter			; a5 23
B6_0dce:		and #$04		; 29 04
B6_0dd0:		bne B6_0dd4 ; d0 02

B6_0dd2:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_0dd4:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_0dd4:	.db $ea $ea $ea
.endif
B6_0dd7:		stx $30			; 86 30
B6_0dd9:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0ddc:		jmp B6_0da2		; @nextThunder

@firstThundersDone:
B6_0ddf:		lda #$2f		; a9 2f
B6_0de1:		jsr queueSoundAtoPlay		; 20 ad c4
B6_0de4:		jmp B6_0dc4		; @afterAThunder

@lastThundersDone:
B6_0de7:		jsr drawEntities		; 20 03 c4
B6_0dea:		jsr drawPlayer		; 20 dd c3
B6_0ded:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0df0:		ldx #$07		; a2 07
-	lda #$00		; a9 00
B6_0df4:		sta wEntitiesControlByte.w, x	; 9d 00 03
B6_0df7:		dex				; ca 
	bpl -

B6_0dfa:		jsr drawEntities		; 20 03 c4
B6_0dfd:		jsr drawPlayer		; 20 dd c3
B6_0e00:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B6_0e02:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B6_0e02:	.db $ea $ea $ea
.endif
B6_0e05:		stx $30			; 86 30
B6_0e07:		lda wEquippedMagic			; a5 b8
B6_0e09:		ora #$80		; 09 80
B6_0e0b:		sta wEquippedMagic			; 85 b8
B6_0e0d:		jsr drawEntities		; 20 03 c4
B6_0e10:		jsr drawPlayer		; 20 dd c3
B6_0e13:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0e16:		jsr markMagicNotInUse		; 20 94 88
B6_0e19:		ldy #$04		; a0 04
B6_0e1b:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B6_0e1d:		jsr palettesBGFadeOut_saveSpecADelayY		; 20 ff c5
B6_0e20:		rts				; 60 


B6_0e21:	.db $04
B6_0e22:	.db $1f
B6_0e23:	.db $3c
B6_0e24:	.db $57
B6_0e25:	.db $62
B6_0e26:		ror a			; 6a
B6_0e27:	.db $72
B6_0e28:		sty $87			; 84 87
B6_0e2a:	.db $9f
B6_0e2b:		tsx				; ba 
B6_0e2c:	.db $04
B6_0e2d:	.db $1f
B6_0e2e:	.db $3a
B6_0e2f:	.db $3f
B6_0e30:	.db $47
B6_0e31:	.db $54
B6_0e32:	.db $5f
B6_0e33:	.db $74
B6_0e34:	.db $7c
B6_0e35:		sty $87			; 84 87
B6_0e37:		ldy $ae			; a4 ae
B6_0e39:		clv				; b8 
B6_0e3a:	.db $c2
B6_0e3b:	.db $a3
B6_0e3c:	.db $9e
B6_0e3d:		cpy $ee94		; cc 94 ee
B6_0e40:		txa				; 8a 
B6_0e41:	.db $80
B6_0e42:	.db $34
B6_0e43:		rol a			; 2a
B6_0e44:		jsr $5353		; 20 53 53
B6_0e47:		ror $3153		; 6e 53 31
B6_0e4a:		bit $4727		; 2c 27 47
B6_0e4d:	.db $47
B6_0e4e:	.db $47
B6_0e4f:	.db $47
B6_0e50:	.db $47
B6_0e51:		pha				; 48 
B6_0e52:		lsr $47			; 46 47
B6_0e54:		lsr $49			; 46 49
B6_0e56:		lsr $4a			; 46 4a
B6_0e58:		lsr $46			; 46 46
B6_0e5a:		lsr a			; 4a
B6_0e5b:		eor #$4a		; 49 4a
B6_0e5d:	.db $4b
B6_0e5e:		lsr $48			; 46 48
B6_0e60:		lsr a			; 4a
B6_0e61:		lsr $47			; 46 47


func_6_0e63:
B6_0e63:		pha				; 48 
B6_0e64:		lda wMajorNMIUpdatesCounter			; a5 23
B6_0e66:		lsr a			; 4a
B6_0e67:		bcc B6_0e90 ; 90 27

B6_0e69:		lda $b0			; a5 b0
B6_0e6b:		inc $b0			; e6 b0
B6_0e6d:		and #$03		; 29 03
B6_0e6f:		tax				; aa 
B6_0e70:		lda $8ea1, x	; bd a1 8e
B6_0e73:		clc				; 18 
B6_0e74:		adc #$00		; 69 00
B6_0e76:		sta wPPUScrollY			; 85 24
B6_0e78:		lda $8ea5, x	; bd a5 8e
B6_0e7b:		clc				; 18 
B6_0e7c:		adc #$00		; 69 00
B6_0e7e:		sta wPPUScrollX			; 85 25
B6_0e80:		cpx #$01		; e0 01
B6_0e82:		bne B6_0e8d ; d0 09

B6_0e84:		lda wPPUCtrl			; a5 20
B6_0e86:		eor #$01		; 49 01
B6_0e88:		sta wPPUCtrl			; 85 20
B6_0e8a:		jmp $8e90		; 4c 90 8e

B6_0e8d:		jsr setNametable1IfOddRoomX		; 20 d7 dc

B6_0e90:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B6_0e93:		pla				; 68 
B6_0e94:		sec				; 38 
B6_0e95:		sbc #$01		; e9 01
B6_0e97:		bne B6_0e63 ; d0 ca

B6_0e99:		sta wPPUScrollY			; 85 24
B6_0e9b:		sta wPPUScrollX			; 85 25
B6_0e9d:		jsr setNametable1IfOddRoomX		; 20 d7 dc
B6_0ea0:		rts				; 60 


B6_0ea1:		inx				; e8 
B6_0ea2:		.db $00				; 00
B6_0ea3:		php				; 08 
B6_0ea4:		.db $00				; 00
B6_0ea5:		.db $00				; 00
B6_0ea6:		sed				; f8 
B6_0ea7:		.db $00				; 00
B6_0ea8:		php				; 08 
