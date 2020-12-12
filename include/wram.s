; ========================================================================================
; Bank 0
; ========================================================================================

.ramsection "RAM 0" bank 0 slot 0

.union
	wGenericVar: ; $00
		db
.nextu
	wRoomGroupAndShapeIdxAddr: ; $00
		dw
.nextu
	wCopyrightScreenRLEStructToProcess: ; $00
		db
.nextu
	wRoomEntityBytesAddr: ; $00
		db
.nextu
	wScreenEntitiesSpecOffset: ; $00
		db
.nextu
	wScreenNumEntities: ; $00
		db

	wScreenEntitiesSpecAddr: ; $01
		dw

	wScreenEntitiesPositionsAddr: ; $03
		dw

	wScreenEntitiesSpecId_408_offset: ; $05
		db

	wScreenEntitiesCurrPositionsOffset: ; $06
		db

	w007:
		db
.nextu
	wWarpSelectOamX: ; $00
		db
.nextu
	wRespawnVarToClear: ; $00
		dw
.nextu
	wCheckpointIdxToCheck: ; $00
		db
.nextu
	wPlayerAnimationAddr: ; $00
		dw
.nextu
	wCurrOamSpecAddr: ; $00
		dw

	wTempEntityY: ; $02
		db

	wTempEntityX: ; $03
		db

	wNumEntityTiles: ; $04
		db

	wEntityAttrHorizOrBehindBG: ; $05
		db

	wEntityLayoutAddr: ; $06
		dw
.nextu
	wScreenMorphFramesCounter: ; $00
		dsb 2
.nextu
	w000_1:
		db

	; starts at $e0, incs $10 on button press
	; process selected input when it hits $00
	wInvCursorDelay: ; $01
		db
.nextu
	w000_4:
		dsb 4

	.union
		wMetatileTileAddr: ; $04
			dw
	.nextu
		wMetatileCollisionAddr: ; $04
			dw
	.nextu
		wTileCollisionVal: ; $04
			db
	.nextu
		w16x16TileValue: ; $04
			db
	.endu
.nextu
	w000_6:
		dsb 6

	w16x16tileIdxToLoad: ; $06
		db
.nextu
	w000_7:
		dsb 7

	wPlayerDirectionOrthogonal: ; $07
		db
.endu

.union
	.union
		wNewNpcSpecID: ; $08
			db
	.nextu
		wNewNpcPreservedY: ; $08
			db
	.endu

	wNewNpcIdx: ; $09
		db

	wEntityLoadStructAddr: ; $0a
		dw

	wEntityLoadStructBytes: ; $0c
		db
.nextu
	w008_3:
		dsb 3

	wInternalPaletteValToAddToFade: ; $0b
		db

	wInternalPaletteLastIdxToFade: ; $0c
		db

	wInternalPalette1stIdxMinus1toFade: ; $0d
		db

	wInternalPaletteFramesBetweenEachFade: ; $0e
		db

	wInternalPaletteInitialFadeVal: ; $0f
		db
.nextu
	w008_4:
		dsb 4

	.union
		; row and col idx are 16x16 tile idxes
		wRoomLoadingRowIdx: ; $0c
			db

		wTempRoomY: ; $0d
			db

		wRoomLoadingColIdx: ; $0e
			db

		wTempRoomX: ; $0f
			db
	.nextu
		wWarpSelectValAddition: ; $0c
			db

		wWarpInputBuffer: ; $0d
			db
	.nextu
		wPlayerCollisionY: ; $0c
			db

		w00d_0:
			db

		wPlayerCollisionX: ; $0e
			db
	.nextu
		wPlayerCollisionTileY: ; $0c
			db

		w00d_1:
			db

		wPlayerCollisionTileX: ; $0e
			db
	.endu
.endu

wGenericWord: ; $10
	dw

wJumpAddr: ; $12
	dw

w014:
	dsb 2

wEntityTileXOffset: ; $16
	db

w017:
	dsb $20-$17

wPPUCtrl: ; $20
	db

wPPUMask: ; $21
	db

wShouldWaitForMajorityNMIFuncsDone: ; $22
	db

wMajorNMIUpdatesCounter: ; $23
	db

wPPUScrollY: ; $24
	db

wPPUScrollX: ; $25
	db

wDefaultPrgBank: ; $26
	db

wJoy1ButtonsPressed: ; $27
	db

wJoy2ButtonsPressed: ; $28
	db

.union
	wTempButtonPressed: ; $29
		db
.nextu
	wJoy1NewButtonsPressed: ; $29
		db

	wJoy2NewButtonsPressed: ; $2a
		db
.endu

wJoy1OldButtonsPressed: ; $2b
	db

wJoy2OldButtonsPressed: ; $2c
	db

wGenericCounter: ; $2d
	db

wInternalPalettesSpecIdx: ; $2e
	db

; for when exiting inventory, and possibly scripts?
wSavedInternalPalettesSpecIdx: ; $2f
	db

wShouldUpdateInternalPalettes: ; $30
	db

wRngVar1: ; $31
	db

wRngVar2: ; $32
	db

wRLEStructAddressToCopy: ; $33
	dw

wPrgBank: ; $35
	db

wIsSettingPrgBank: ; $36
	db

w037:
	dsb $40-$37

wNextVramQueueIdxToFillInFrom: ; $40
	db

wNextVramQueueIdxToUpdateFrom: ; $41
	db

wRoomX: ; $42
	db

wRoomY: ; $43
	db

wRoomsMetatilesAddr: ; $44
	dw

wRoomGroup: ; $46
	db

wRoomLoadingDestAddr: ; $47
	dw

wCurr16x16tileRoomPaletteOffset: ; $49
	db

w04a:
	dsb $50-$4a

; lower nybble is spr chr bank (+$14)
; upper nybble is internal palette spec idx (+$10)
wSprPaletteSpecAndChrBank: ; $50
	db

wEntityDataByte1: ; $51
	db

wEntityDataByte2: ; $52
	db

wBGChrBank: ; $53
	db

w054:
	dsb $a-$4

; 58 - bit 6 set when going indoors, reset when going out

wLastOutdoorEntranceUsedY: ; $5a
	db

wLastOutdoorEntranceUsedX: ; $5b
	db

wInventoryPageSelected: ; $5c
	db

; 5d
; - bit 7 set means it's a spr 0 hit screen?
; - bit 6 set when fading out sprites,
;   update internal paletets from $50 (spr) instead of wInternalPalettesSpecIdx

w05d:
	dsb $62-$5d

wNPCTextByteOffset: ; $62
	db

wTimeUntilDisplayingNextTextByte: ; $63
	db

.union
	wNPCTextAddressSrc: ; $64
		dw
.nextu
	wNPCTextAddress: ; $64
		dw
.endu

w066:
	dsb $b-6

wScriptIdx: ; $6b
	db

w06c:
	dsb $71-$6c

wCurrLevel: ; $71
	db

w072:
	dsb 4

wMPGiven: ; $76
	db

wHealthGiven: ; $77
	db

wMPUsed: ; $78
	db

wHealthTaken: ; $79
	db

wCurrMP: ; $7a
	db

wCurrHealth: ; $7b
	db

wCurrExpDigits: ; $7c
	dsb 5

w081:
	dsb $a7-$81

wChrBank0: ; $a7
	db

wChrBank1: ; $a8
	db

wNeedsToUpdateSound: ; $a9
	db

w0aa:
	dsb $b5-$aa

wCurrAgility: ; $b5
	db

wEquippedSword: ; $b6
	db

wEquippedShield: ; $b7
	db

; bit 7 set when magic is being used
wEquippedMagic: ; $b8
	db

w0b9:
	dsb $c1-$b9

; bf - if 4 to 7, sword swing speed is calculated
; bf - if 09, player is a slime

; c0 - player not drawn if bit 7 unset
; bit 6 and 5 get xor'd with oam attr
; bit 4 set, don't draw player (get diff from bit 7)
; bit 3 set, don't process new animations

wNewPlayerAnimationIdx: ; $c1
	db

w0c2:
	db

; 0 n, 7 nw
wPlayerDirection: ; $c3
	db

wCurrPlayerAnimationIdx: ; $c4
	db

wPlayerAnimationDataOffset: ; $c5
	db

wPlayerAnimationFramesCounter: ; $c6
	db

wPlayerKnockbackCounter: ; $c7
	db

wPlayerAnimationDelaySpeed: ; $c8
	db

wPlayerDirectionFacing: ; $c9
	db

wTempPlayerY: ; $ca
	db

wTempPlayerX: ; $cb
	db

wPlayerY: ; $cc
	db

wPlayerSubY: ; $cd
	db

wPlayerX: ; $ce
	db

wPlayerSubX: ; $cf
	db

wEntityOamLowerBound: ; $d0
	db

wDrawEntitiesCounter: ; $d1
	db

w0d2:
	db

wEntityOamUpperBound: ; $d3
	db

w0d4:
	dsb 5

wNumQueuedSounds: ; $d9
	db

w0da:
	dsb 2

wCurrSoundDataAddr: ; $dc
	dw

wIsSoundMuted: ; $de
	db

w0df:
	dsb $e4-$df

wUpdateSoundCounter: ; $e4
	db

; eg 4 for SQ2
wCurrSoundChnRegOffset: ; $e5
	db

wCurrSoundChannelStructPtr: ; $e6
	dw

; 4 - sq1, 1 - noise
wCurrSoundChnIdxReversed: ; $e8
	db

w0e9:
	db

wTodoCurrSoundDataAddrAfter2Bytes: ; $ea
	dw

w0ec:
	dsb $f2-$ec

.union
	wInternalPaletteSpecAddr: ; $f2
		dw
.nextu
	wGlobalFlagBitToCheck: ; $f2
		db
.nextu
	wDoubleTempRoomX: ; $f2
		db
.nextu
	wHalfColIdx: ; $f2
		db
.nextu
	wRoomLoadingDestOffset: ; $f2
		dw
.nextu
	wNumBytesToCopyRoomRow: ; $f2
		db
.nextu
	wCurrTilePaletteBits: ; $f2
		db

	wCurrTilePaletteOtherBitsMask: ; $f3
		db
.nextu
	wCurrScreenPaletteOffset: ; $f2
		db

	wCurrScreenPalettesToCopy: ; $f3
		db
.endu

w0f4:
	db

wRespawnSavedNMIUpdatesCounter: ; $f5
	db

wRespawnSavedRngVar2: ; $f6
	db

w0f7:
	dsb $100-$f7

wSecretInputCounter: ; $100
	dsb $10

w110:
	dsb $100-$10

wOam: ; $200
	instanceof Oam
wOamCont: ; $204
	dsb $100-4

; loadScreenEntities_body - bit 7 set means don't load screen entities
; updateScreenEntities_body - bit 7 set means update entity
wEntitiesControlByte: ; $300
	dsb MAX_ENTITIES

; used to decide update function
wEntitiesId: ; $318
	dsb MAX_ENTITIES

wEntities_330: ; $330
	dsb MAX_ENTITIES

wEntities_348: ; $348
	dsb MAX_ENTITIES

wEntities_360: ; $360
	dsb MAX_ENTITIES

wEntities_378: ; $378
	dsb MAX_ENTITIES

wEntities_390: ; $390
	dsb MAX_ENTITIES

wEntities_3a8: ; $3a8
	dsb MAX_ENTITIES

wEntities_3c0: ; $3c0
	dsb MAX_ENTITIES

wEntities_3d8: ; $3d8
	dsb MAX_ENTITIES

wEntitiesState: ; $3f0
	dsb MAX_ENTITIES

wEntities_408: ; $408
	dsb MAX_ENTITIES

wEntities_420: ; $420
	dsb MAX_ENTITIES

wEntities_438: ; $438
	dsb MAX_ENTITIES

wEntities_450: ; $450
	dsb MAX_ENTITIES

wEntities_468: ; $468
	dsb MAX_ENTITIES

wEntitiesY: ; $480
	dsb MAX_ENTITIES

wEntities_498: ; $498
	dsb MAX_ENTITIES

wEntitiesX: ; $4b0
	dsb MAX_ENTITIES

wEntitiesTempY: ; $4c8
	dsb MAX_ENTITIES

wEntitiesTempX: ; $4e0
	dsb MAX_ENTITIES

w4f8:
	dsb 8

wVramQueue: ; $500
	dsb $600-$500

; max size, though 10 bytes used ($00-$09)
wGlobalFlags: ; $600
	dsb $20

w620:
	dsb $90-$20

wQueuedSoundsToPlay: ; $690
	dsb $10

wInternalPalettes: ; $6a0
	dsb $20

wRoomLoadingRow1ToCopy: ; $6c0
	dsb $20

wRoomLoadingRow2ToCopy: ; $6e0
	dsb $20

; combines nt0 and nt1, such that
; for every $10 bytes, left 8 are for nt0
; and right 8 are for nt1
wRoomPalettes: ; $700
	dsb $80

wSoundChannelStructs: ; $780
	.db
wSoundChannelStructSQ1: ; $780
	instanceof SoundChannel
wSoundChannelStructSQ2: ; $79f
	instanceof SoundChannel
wSoundChannelStructTri: ; $7be
	instanceof SoundChannel
wSoundChannelStructNoise: ; $7dd
	instanceof SoundChannel

.ends

.define wStoryGlobalFlags0 wGlobalFlags+0
.define wStoryGlobalFlags1 wGlobalFlags+1
.define wStoryGlobalFlags2 wGlobalFlags+2
.define wSwordGlobalFlags wGlobalFlags+3
.define wShieldGlobalFlags wGlobalFlags+4
.define wMagicGlobalFlags0 wGlobalFlags+5
.define wMagicGlobalFlags1 wGlobalFlags+6
.define wItemGlobalFlags0 wGlobalFlags+7
.define wItemGlobalFlags1 wGlobalFlags+8
.define wMiscGlobalFlags wGlobalFlags+9

.define wInternalPalettesInvisColour wInternalPalettes+$10