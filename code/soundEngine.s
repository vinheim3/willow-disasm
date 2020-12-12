updateSound:
B0_0000:		jmp updateSound_body		; 4c 35 82


; 24 when hitting Start on start menu
playSoundA:
B0_0003:		cmp #$fc		; c9 fc
B0_0005:		bne B0_000a ; d0 03

B0_0007:		jmp songFC		; 4c 29 81

B0_000a:		cmp #$fd		; c9 fd
B0_000c:		bne B0_0011 ; d0 03

B0_000e:		jmp songFD		; 4c 2d 81

B0_0011:		cmp #$fe		; c9 fe
B0_0013:		bne B0_0020 ; d0 0b

; song fe
B0_0015:		lda #$01		; a9 01
B0_0017:		sta wIsSoundMuted			; 85 de
B0_0019:		lda #$00		; a9 00
B0_001b:		sta $e6			; 85 e6
B0_001d:		jmp songFE		; 4c 3a 81

B0_0020:		cmp #$ff		; c9 ff
B0_0022:		bne B0_002f ; d0 0b

; song ff
B0_0024:		lda #$01		; a9 01
B0_0026:		sta wIsSoundMuted			; 85 de
B0_0028:		lda #$00		; a9 00
B0_002a:		sta $e6			; 85 e6
B0_002c:		jmp songFF		; 4c 8c 81

; non-control code sound
B0_002f:		asl a			; 0a
B0_0030:		tax				; aa 
B0_0031:		lda data_0_0a50.w, x	; bd 50 8a
B0_0034:		sta wCurrSoundDataAddr			; 85 dc
B0_0036:		lda data_0_0a50.w+1, x	; bd 51 8a
B0_0039:		sta wCurrSoundDataAddr+1			; 85 dd

; dc now address of new song data
B0_003b:		ldy #$00		; a0 00
B0_003d:		lda (wCurrSoundDataAddr), y	; b1 dc
B0_003f:		tax				; aa 
B0_0040:		and #$0f		; 29 0f
B0_0042:		beq B0_00bb ; f0 77

B0_0044:		lda $da			; a5 da
B0_0046:		and #$0f		; 29 0f
B0_0048:		sta $df			; 85 df
B0_004a:		cpx $df			; e4 df
B0_004c:		bcs B0_004f ; b0 01

B0_004e:		rts				; 60 

B0_004f:		stx $df			; 86 df
B0_0051:		lda $da			; a5 da
B0_0053:		and #$f0		; 29 f0
B0_0055:		ora $df			; 05 df
B0_0057:		sta $da			; 85 da
B0_0059:		lda #$01		; a9 01
B0_005b:		sta wIsSoundMuted			; 85 de
B0_005d:		lda #$00		; a9 00
B0_005f:		sta $e6			; 85 e6
B0_0061:		lda #$00		; a9 00
B0_0063:		sta $e1			; 85 e1
B0_0065:		sta $e2			; 85 e2
B0_0067:		lda #$04		; a9 04
B0_0069:		sta $df			; 85 df

B0_006b:		lda #$01		; a9 01

B0_006d:		clc				; 18 
B0_006e:		adc wCurrSoundDataAddr			; 65 dc
B0_0070:		sta wCurrSoundDataAddr			; 85 dc
B0_0072:		lda #$00		; a9 00
B0_0074:		adc wCurrSoundDataAddr+1			; 65 dd
B0_0076:		sta wCurrSoundDataAddr+1			; 85 dd

; store 1st word in 780/1
B0_0078:		ldx $e6			; a6 e6
B0_007a:		ldy #$00		; a0 00
B0_007c:		lda (wCurrSoundDataAddr), y	; b1 dc
B0_007e:		sta $0780, x	; 9d 80 07
B0_0081:		inx				; e8 
B0_0082:		iny				; c8 
B0_0083:		cpy #$02		; c0 02
B0_0085:		bne B0_007c ; d0 f5

; clear rest up to 78f
B0_0087:		ldy #$0e		; a0 0e
B0_0089:		lda #$00		; a9 00

B0_008b:		sta $0780, x	; 9d 80 07
B0_008e:		inx				; e8 
B0_008f:		dey				; 88 
B0_0090:		bne B0_008b ; d0 f9

B0_0092:		lda $db			; a5 db
B0_0094:		lsr a			; 4a
B0_0095:		bcs B0_009a ; b0 03

B0_0097:		jsr func_0_01b2		; 20 b2 81
B0_009a:		jsr rrc_db_e6PlusEqu1fh		; 20 07 82
B0_009d:		dec $df			; c6 df
B0_009f:		beq B0_00a6 ; f0 05

B0_00a1:		lda #$02		; a9 02
B0_00a3:		jmp B0_006d		; 4c 6d 80

B0_00a6:		ldy #$02		; a0 02
B0_00a8:		lda (wCurrSoundDataAddr), y	; b1 dc
B0_00aa:		sta $07fc		; 8d fc 07
B0_00ad:		iny				; c8 
B0_00ae:		lda (wCurrSoundDataAddr), y	; b1 dc
B0_00b0:		sta $07fd		; 8d fd 07
B0_00b3:		jsr lsr_db_4times		; 20 19 82
B0_00b6:		lda #$00		; a9 00
B0_00b8:		sta wIsSoundMuted			; 85 de
B0_00ba:		rts				; 60 

B0_00bb:		lda $da			; a5 da
B0_00bd:		and #$f0		; 29 f0
B0_00bf:		sta $df			; 85 df
B0_00c1:		cpx $df			; e4 df
B0_00c3:		bcs B0_00c6 ; b0 01

B0_00c5:		rts				; 60 

B0_00c6:		stx $df			; 86 df

B0_00c8:		lda $da			; a5 da
B0_00ca:		and #$0f		; 29 0f
B0_00cc:		ora $df			; 05 df
B0_00ce:		sta $da			; 85 da

B0_00d0:		lda #$01		; a9 01
B0_00d2:		sta wIsSoundMuted			; 85 de
B0_00d4:		lda #$00		; a9 00
B0_00d6:		sta $e6			; 85 e6
B0_00d8:		ldx #$00		; a2 00

; ea/eb starts 2 bytes after sound data addr
B0_00da:		lda #$02		; a9 02
B0_00dc:		clc				; 18 
B0_00dd:		adc wCurrSoundDataAddr			; 65 dc
B0_00df:		sta wTodoCurrSoundDataAddrAfter2Bytes			; 85 ea
B0_00e1:		txa				; 8a 
B0_00e2:		adc wCurrSoundDataAddr+1			; 65 dd
B0_00e4:		sta wTodoCurrSoundDataAddrAfter2Bytes+1			; 85 eb

B0_00e6:		stx $ec			; 86 ec
B0_00e8:		stx $ed			; 86 ed

B0_00ea:		ldy #$01		; a0 01
B0_00ec:		lda (wCurrSoundDataAddr), y	; b1 dc
B0_00ee:		and #$0f		; 29 0f
B0_00f0:		tax				; aa 
B0_00f1:		ora $db			; 05 db
B0_00f3:		pha				; 48 
B0_00f4:		stx $db			; 86 db

B0_00f6:		lda #$04		; a9 04
B0_00f8:		sta $df			; 85 df
B0_00fa:		lda #$02		; a9 02
B0_00fc:		sta $e0			; 85 e0

B0_00fe:		pla				; 68 
B0_00ff:		lsr a			; 4a
B0_0100:		pha				; 48 
B0_0101:		bcc B0_010e ; 90 0b

B0_0103:		jsr func_0_01b2		; 20 b2 81
B0_0106:		lda $db			; a5 db
B0_0108:		lsr a			; 4a
B0_0109:		bcs B0_010e ; b0 03

B0_010b:		jsr func_0_016c		; 20 6c 81

B0_010e:		jsr rrc_db_e6PlusEqu1fh		; 20 07 82
B0_0111:		lda #$04		; a9 04
B0_0113:		clc				; 18 
B0_0114:		adc $e0			; 65 e0
B0_0116:		sta $e0			; 85 e0
B0_0118:		dec $df			; c6 df
B0_011a:		bne B0_00fe ; d0 e2

B0_011c:		jsr lsr_db_4times		; 20 19 82
B0_011f:		lda $db			; a5 db
B0_0121:		sta $e9			; 85 e9
B0_0123:		pla				; 68 
B0_0124:		lda #$00		; a9 00
B0_0126:		sta wIsSoundMuted			; 85 de
B0_0128:		rts				; 60 


songFC:		iny				; c8 
B0_012a:		sty $e1			; 84 e1
B0_012c:		rts				; 60 


songFD:		sty $e2			; 84 e2
B0_012f:		lda #$01		; a9 01
B0_0131:		sta $e3			; 85 e3
B0_0133:		lda wUpdateSoundCounter			; a5 e4
B0_0135:		and #$01		; 29 01
B0_0137:		sta wUpdateSoundCounter			; 85 e4
B0_0139:		rts				; 60 


songFE:		lda $da			; a5 da
B0_013c:		and #$0f		; 29 0f
B0_013e:		sta $da			; 85 da
B0_0140:		lda #$04		; a9 04
B0_0142:		sta $df			; 85 df
B0_0144:		lda #$02		; a9 02
B0_0146:		sta $e0			; 85 e0
B0_0148:		lda $db			; a5 db
B0_014a:		lsr a			; 4a
B0_014b:		bcc B0_0153 ; 90 06

B0_014d:		jsr func_0_01b2		; 20 b2 81
B0_0150:		jsr func_0_016c		; 20 6c 81
B0_0153:		jsr rrc_db_e6PlusEqu1fh		; 20 07 82
B0_0156:		lda #$04		; a9 04
B0_0158:		clc				; 18 
B0_0159:		adc $e0			; 65 e0
B0_015b:		sta $e0			; 85 e0
B0_015d:		dec $df			; c6 df
B0_015f:		bne B0_0148 ; d0 e7

B0_0161:		lda #$00		; a9 00
B0_0163:		sta $db			; 85 db
B0_0165:		sta $e9			; 85 e9
B0_0167:		lda #$00		; a9 00
B0_0169:		sta wIsSoundMuted			; 85 de
B0_016b:		rts				; 60 


func_0_016c:
B0_016c:		lda $e6			; a5 e6
B0_016e:		clc				; 18 
B0_016f:		adc #$0a		; 69 0a
B0_0171:		tax				; aa 
B0_0172:		lda $0780, x	; bd 80 07
B0_0175:		ora $0781, x	; 1d 81 07
B0_0178:		bne func_0_01c4 ; d0 4a

B0_017a:		ldy $df			; a4 df
B0_017c:		ldx $e0			; a6 e0
B0_017e:		jsr clearChnYreversedFreq		; 20 22 82
B0_0181:		ldx $e6			; a6 e6
B0_0183:		lda $0780, x	; bd 80 07
B0_0186:		ora $0781, x	; 1d 81 07
B0_0189:		bne func_0_01c4 ; d0 39

B0_018b:		rts				; 60 


songFF:		lda $da			; a5 da
B0_018e:		and #$f0		; 29 f0
B0_0190:		sta $da			; 85 da
B0_0192:		lda #$00		; a9 00
B0_0194:		sta $e1			; 85 e1
B0_0196:		sta $e2			; 85 e2
B0_0198:		lda #$04		; a9 04
B0_019a:		sta $df			; 85 df

B0_019c:		lda #$00		; a9 00
B0_019e:		ldx $e6			; a6 e6
B0_01a0:		sta $0780, x	; 9d 80 07
B0_01a3:		sta $0781, x	; 9d 81 07
B0_01a6:		jsr e6PlusEqu1fh		; 20 11 82
B0_01a9:		dec $df			; c6 df
B0_01ab:		bne B0_019c ; d0 ef

B0_01ad:		lda #$00		; a9 00
B0_01af:		sta wIsSoundMuted			; 85 de
B0_01b1:		rts				; 60 


func_0_01b2:
B0_01b2:		ldy #$0f		; a0 0f
B0_01b4:		lda #$10		; a9 10
B0_01b6:		clc				; 18 
B0_01b7:		adc $e6			; 65 e6
B0_01b9:		tax				; aa 
B0_01ba:		lda #$00		; a9 00

B0_01bc:		sta $0780, x	; 9d 80 07
B0_01bf:		inx				; e8 
B0_01c0:		dey				; 88 
B0_01c1:		bne B0_01bc ; d0 f9

B0_01c3:		rts				; 60 


func_0_01c4:
B0_01c4:		lda $df			; a5 df
B0_01c6:		pha				; 48 
B0_01c7:		lda $e0			; a5 e0
B0_01c9:		pha				; 48 
B0_01ca:		lda $07fc		; ad fc 07
B0_01cd:		sta $df			; 85 df
B0_01cf:		lda $07fd		; ad fd 07
B0_01d2:		sta $e0			; 85 e0
B0_01d4:		lda $e6			; a5 e6
B0_01d6:		clc				; 18 
B0_01d7:		adc #$06		; 69 06
B0_01d9:		tax				; aa 
B0_01da:		lda $0780, x	; bd 80 07
B0_01dd:		and #$1f		; 29 1f
B0_01df:		beq B0_01ea ; f0 09

B0_01e1:		tay				; a8 
B0_01e2:		lda #$00		; a9 00
B0_01e4:		clc				; 18 
B0_01e5:		adc #$04		; 69 04
B0_01e7:		dey				; 88 
B0_01e8:		bne B0_01e4 ; d0 fa

B0_01ea:		tay				; a8 
B0_01eb:		txa				; 8a 
B0_01ec:		clc				; 18 
B0_01ed:		adc #$0e		; 69 0e
B0_01ef:		tax				; aa 
B0_01f0:		lda #$04		; a9 04
B0_01f2:		pha				; 48 
B0_01f3:		lda ($df), y	; b1 df
B0_01f5:		sta $0780, x	; 9d 80 07
B0_01f8:		iny				; c8 
B0_01f9:		inx				; e8 
B0_01fa:		pla				; 68 
B0_01fb:		sec				; 38 
B0_01fc:		sbc #$01		; e9 01
B0_01fe:		bne B0_01f2 ; d0 f2

B0_0200:		pla				; 68 
B0_0201:		sta $e0			; 85 e0
B0_0203:		pla				; 68 
B0_0204:		sta $df			; 85 df
B0_0206:		rts				; 60 


rrc_db_e6PlusEqu1fh:
; rotate db without carry
B0_0207:		lsr $db			; 46 db
B0_0209:		bcc B0_0211 ; 90 06

B0_020b:		lda $db			; a5 db
B0_020d:		ora #$80		; 09 80
B0_020f:		sta $db			; 85 db

e6PlusEqu1fh:
B0_0211:		lda #$1f		; a9 1f
B0_0213:		clc				; 18 
B0_0214:		adc $e6			; 65 e6
B0_0216:		sta $e6			; 85 e6
B0_0218:		rts				; 60 


lsr_db_4times:
B0_0219:		lsr $db			; 46 db
B0_021b:		lsr $db			; 46 db
B0_021d:		lsr $db			; 46 db
B0_021f:		lsr $db			; 46 db
B0_0221:		rts				; 60 


; 4 - sq1, 3 - sq2, 2 - tri, 1 - noise
clearChnYreversedFreq:
	cpy #$01
	beq @silenceNoise

	lda #$00
	sta CHN_LO.w-2, x
	sta CHN_HI.w-2, x
	rts

@silenceNoise:
	lda #SNDENA_TRI|SNDENA_SQ2|SNDENA_SQ1
	sta SND_CHN.w
	rts


updateSound_body:
; negate sweeps
	lda #SWEEP_NEGATE
	sta SQ1_SWEEP.w
	sta SQ2_SWEEP.w

	inc wUpdateSoundCounter
	lda wIsSoundMuted
	beq +

	rts

+	ldx #<wSoundChannelStructs
	ldy #>wSoundChannelStructs
	stx wCurrSoundChannelStructPtr
	sty wCurrSoundChannelStructPtr+1

	lda #$00
	sta wCurrSoundChnRegOffset

; loop from sq1 to noise, 4 to 1
	lda #$04
	sta wCurrSoundChnIdxReversed

@nextSoundChannel:
B0_0254:		lda #$01		; a9 01
B0_0256:		ldy #$18		; a0 18
B0_0258:		clc				; 18 
B0_0259:		adc ($e6), y	; 71 e6
B0_025b:		sta ($e6), y	; 91 e6
B0_025d:		lda #$01		; a9 01
B0_025f:		ldy #$1d		; a0 1d
B0_0261:		clc				; 18 
B0_0262:		adc ($e6), y	; 71 e6
B0_0264:		sta ($e6), y	; 91 e6
B0_0266:		lda $e9			; a5 e9
B0_0268:		lsr a			; 4a
B0_0269:		bcc B0_026e ; 90 03

B0_026b:		jsr func_0_0575		; 20 75 85
B0_026e:		lda $d8			; a5 d8
B0_0270:		lsr a			; 4a
B0_0271:		bcc B0_0276 ; 90 03

B0_0273:		jmp B0_028e		; 4c 8e 82

B0_0276:		ldy #$00		; a0 00
B0_0278:		lda ($e6), y	; b1 e6
B0_027a:		iny				; c8 
B0_027b:		ora ($e6), y	; 11 e6
B0_027d:		beq B0_028e ; f0 0f

B0_027f:		lda #$01		; a9 01
B0_0281:		ldy #$0e		; a0 0e
B0_0283:		clc				; 18 
B0_0284:		adc ($e6), y	; 71 e6
B0_0286:		sta ($e6), y	; 91 e6
B0_0288:		jsr func_0_06bc		; 20 bc 86
B0_028b:		jmp B0_029c		; 4c 9c 82

B0_028e:		lda $e9			; a5 e9
B0_0290:		lsr a			; 4a
B0_0291:		bcs B0_029c ; b0 09

B0_0293:		ldx wCurrSoundChnRegOffset			; a6 e5
B0_0295:		inx				; e8 
B0_0296:		inx				; e8 
B0_0297:		ldy wCurrSoundChnIdxReversed			; a4 e8
B0_0299:		jsr clearChnYreversedFreq		; 20 22 82

B0_029c:		lsr $e9			; 46 e9
B0_029e:		bcc B0_02a6 ; 90 06

B0_02a0:		lda $e9			; a5 e9
B0_02a2:		ora #$80		; 09 80
B0_02a4:		sta $e9			; 85 e9
B0_02a6:		dec wCurrSoundChnIdxReversed			; c6 e8
B0_02a8:		beq B0_02c1 ; @allSoundChannelsDone

; next sound channel hw regs
B0_02aa:		lda #$04		; a9 04
B0_02ac:		clc				; 18 
B0_02ad:		adc wCurrSoundChnRegOffset			; 65 e5
B0_02af:		sta wCurrSoundChnRegOffset			; 85 e5

; next sound channel struct
B0_02b1:		lda #$1f		; a9 1f
B0_02b3:		clc				; 18 
B0_02b4:		adc wCurrSoundChannelStructPtr			; 65 e6
B0_02b6:		sta wCurrSoundChannelStructPtr		; 85 e6
B0_02b8:		lda #$00		; a9 00
B0_02ba:		adc wCurrSoundChannelStructPtr+1			; 65 e7
B0_02bc:		sta wCurrSoundChannelStructPtr+1			; 85 e7
B0_02be:		jmp B0_0254		; @nextSoundChannel

@allSoundChannelsDone:
B0_02c1:		lda $e2			; a5 e2
B0_02c3:		and #$7f		; 29 7f
B0_02c5:		beq B0_02e5 ; f0 1e

B0_02c7:		cmp wUpdateSoundCounter			; c5 e4
B0_02c9:		bne B0_02e5 ; d0 1a

B0_02cb:		lda wUpdateSoundCounter			; a5 e4
B0_02cd:		and #$01		; 29 01
B0_02cf:		sta wUpdateSoundCounter			; 85 e4
B0_02d1:		inc $e3			; e6 e3
B0_02d3:		lda #$10		; a9 10
B0_02d5:		cmp $e3			; c5 e3
B0_02d7:		bne B0_02e5 ; d0 0c

B0_02d9:		lda $e2			; a5 e2
B0_02db:		bmi B0_02e1 ; 30 04

B0_02dd:		lda #$00		; a9 00
B0_02df:		sta $e2			; 85 e2
B0_02e1:		lda #$0f		; a9 0f
B0_02e3:		sta $e3			; 85 e3
B0_02e5:		lda $ec			; a5 ec
B0_02e7:		beq B0_02eb ; f0 02

B0_02e9:		dec $ec			; c6 ec
B0_02eb:		lsr $e9			; 46 e9
B0_02ed:		lsr $e9			; 46 e9
B0_02ef:		lsr $e9			; 46 e9
B0_02f1:		lsr $e9			; 46 e9
B0_02f3:		rts				; 60 


func_0_02f4:
B0_02f4:		ldy #$0c		; a0 0c
B0_02f6:		lda ($e6), y	; b1 e6
; jump if tri
B0_02f8:		ldy #$02		; a0 02
B0_02fa:		cpy wCurrSoundChnIdxReversed			; c4 e8
B0_02fc:		beq B0_0300 ; f0 02

B0_02fe:		and #$0f		; 29 0f

B0_0300:		sta $ee			; 85 ee
B0_0302:		lda $e2			; a5 e2
B0_0304:		and #$7f		; 29 7f
B0_0306:		beq B0_0333 ; f0 2b

B0_0308:		lda $e3			; a5 e3
; jump if tri
B0_030a:		ldy #$02		; a0 02
B0_030c:		cpy wCurrSoundChnIdxReversed			; c4 e8
B0_030e:		bne B0_0318 ; d0 08

B0_0310:		ldx #$0c		; a2 0c
B0_0312:		clc				; 18 
B0_0313:		adc $e3			; 65 e3
B0_0315:		dex				; ca 
B0_0316:		bne B0_0312 ; d0 fa

B0_0318:		tay				; a8 
B0_0319:		lda $e2			; a5 e2
B0_031b:		bmi B0_032c ; 30 0f

B0_031d:		ldx #$ff		; a2 ff
B0_031f:		inx				; e8 
B0_0320:		cpx $ee			; e4 ee
B0_0322:		beq B0_0333 ; f0 0f

B0_0324:		dey				; 88 
B0_0325:		bne B0_031f ; d0 f8

B0_0327:		stx $ee			; 86 ee
B0_0329:		jmp B0_0333		; 4c 33 83

B0_032c:		dec $ee			; c6 ee
B0_032e:		beq B0_0333 ; f0 03

B0_0330:		dey				; 88 
B0_0331:		bne B0_032c ; d0 f9

; jump if tri
B0_0333:		lda #$02		; a9 02
B0_0335:		cmp wCurrSoundChnIdxReversed			; c5 e8
B0_0337:		beq B0_0384 ; f0 4b

B0_0339:		ldy #$0d		; a0 0d
B0_033b:		lda ($e6), y	; b1 e6
B0_033d:		tax				; aa 
B0_033e:		and #$7f		; 29 7f
B0_0340:		beq B0_0384 ; f0 42

B0_0342:		iny				; c8 
B0_0343:		cmp ($e6), y	; d1 e6
B0_0345:		beq B0_034f ; f0 08

B0_0347:		iny				; c8 
B0_0348:		lda ($e6), y	; b1 e6
B0_034a:		and #$0f		; 29 0f
B0_034c:		jmp B0_0374		; 4c 74 83

B0_034f:		lda #$00		; a9 00
B0_0351:		sta ($e6), y	; 91 e6
B0_0353:		iny				; c8 
B0_0354:		lda ($e6), y	; b1 e6
B0_0356:		lsr a			; 4a
B0_0357:		lsr a			; 4a
B0_0358:		lsr a			; 4a
B0_0359:		lsr a			; 4a
B0_035a:		sta $ef			; 85 ef
B0_035c:		txa				; 8a 
B0_035d:		bpl B0_0366 ; 10 07

B0_035f:		lda #$00		; a9 00
B0_0361:		sec				; 38 
B0_0362:		sbc $ef			; e5 ef
B0_0364:		sta $ef			; 85 ef
B0_0366:		lda ($e6), y	; b1 e6
B0_0368:		and #$0f		; 29 0f
B0_036a:		clc				; 18 
B0_036b:		adc $ef			; 65 ef
B0_036d:		bpl B0_0374 ; 10 05

B0_036f:		lda #$00		; a9 00
B0_0371:		jmp B0_037a		; 4c 7a 83

B0_0374:		cmp $ee			; c5 ee
B0_0376:		bcc B0_037a ; 90 02

B0_0378:		lda $ee			; a5 ee

B0_037a:		sta $ee			; 85 ee
B0_037c:		lda ($e6), y	; b1 e6
B0_037e:		and #$f0		; 29 f0
B0_0380:		ora $ee			; 05 ee
B0_0382:		sta ($e6), y	; 91 e6
B0_0384:		lda $e9			; a5 e9
B0_0386:		lsr a			; 4a
B0_0387:		bcs B0_0390 ; b0 07

B0_0389:		lda #$0c		; a9 0c
B0_038b:		sta $ef			; 85 ef
B0_038d:		jmp B0_0397		; 4c 97 83

B0_0390:		lda #$09		; a9 09
B0_0392:		sta $ef			; 85 ef
B0_0394:		jmp B0_0406		; 4c 06 84


func_0_0397:
B0_0397:		ldy #$16		; a0 16
B0_0399:		lda ($e6), y	; b1 e6
B0_039b:		and #$7f		; 29 7f
B0_039d:		beq B0_03dd ; f0 3e

B0_039f:		ldy #$1d		; a0 1d
B0_03a1:		cmp ($e6), y	; d1 e6
B0_03a3:		beq B0_03a8 ; f0 03

B0_03a5:		jmp B0_03d3		; 4c d3 83

B0_03a8:		lda #$00		; a9 00
B0_03aa:		sta ($e6), y	; 91 e6
B0_03ac:		ldy #$17		; a0 17
B0_03ae:		lda ($e6), y	; b1 e6
B0_03b0:		ldy #$1e		; a0 1e
B0_03b2:		clc				; 18 
B0_03b3:		adc ($e6), y	; 71 e6
B0_03b5:		beq B0_03b9 ; f0 02

B0_03b7:		bpl B0_03c0 ; 10 07

B0_03b9:		lda #$01		; a9 01
B0_03bb:		sta ($e6), y	; 91 e6
B0_03bd:		jmp B0_03ca		; 4c ca 83

B0_03c0:		sta ($e6), y	; 91 e6
B0_03c2:		cmp #$10		; c9 10
B0_03c4:		bcc B0_03d3 ; 90 0d

B0_03c6:		lda #$0f		; a9 0f
B0_03c8:		sta ($e6), y	; 91 e6

B0_03ca:		lda #$00		; a9 00
B0_03cc:		ldy #$17		; a0 17
B0_03ce:		sec				; 38 
B0_03cf:		sbc ($e6), y	; f1 e6
B0_03d1:		sta ($e6), y	; 91 e6

B0_03d3:		ldy #$1e		; a0 1e
B0_03d5:		lda ($e6), y	; b1 e6
B0_03d7:		cmp $ee			; c5 ee
B0_03d9:		bcs B0_03dd ; b0 02

B0_03db:		sta $ee			; 85 ee
; jump if tri
B0_03dd:		ldy #$02		; a0 02
B0_03df:		cpy wCurrSoundChnIdxReversed			; c4 e8
B0_03e1:		beq B0_03f0 ; f0 0d

B0_03e3:		lda $ef			; a5 ef
B0_03e5:		and #$7f		; 29 7f
B0_03e7:		tay				; a8 
B0_03e8:		lda ($e6), y	; b1 e6
B0_03ea:		and #$f0		; 29 f0
B0_03ec:		ora $ee			; 05 ee
B0_03ee:		sta $ee			; 85 ee

; all sounds
B0_03f0:		ldx wCurrSoundChnRegOffset			; a6 e5
B0_03f2:		lda $ee			; a5 ee
B0_03f4:		sta CHN_VOL.w, x	; 9d 00 40 - vol
B0_03f7:		lda $ef			; a5 ef
B0_03f9:		bpl B0_0402 ; 10 07

B0_03fb:		lda #$90		; a9 90
B0_03fd:		sta $ef			; 85 ef
B0_03ff:		jmp B0_0406		; 4c 06 84

B0_0402:		lda #$09		; a9 09
B0_0404:		sta $ef			; 85 ef

B0_0406:		lda $ef			; a5 ef
B0_0408:		and #$7f		; 29 7f
B0_040a:		tay				; a8 
B0_040b:		ldx #$00		; a2 00
B0_040d:		lda ($e6), y	; b1 e6
B0_040f:		beq B0_0420 ; f0 0f

B0_0411:		bpl B0_0414 ; 10 01

; store 2 bytes for frequency
B0_0413:		dex				; ca 

B0_0414:		iny				; c8 
B0_0415:		clc				; 18 
B0_0416:		adc (wCurrSoundChannelStructPtr), y	; 71 e6
B0_0418:		sta (wCurrSoundChannelStructPtr), y	; 91 e6
B0_041a:		txa				; 8a 
B0_041b:		iny				; c8 
B0_041c:		adc (wCurrSoundChannelStructPtr), y	; 71 e6
B0_041e:		sta (wCurrSoundChannelStructPtr), y	; 91 e6
B0_0420:		lda $ef			; a5 ef
B0_0422:		bmi B0_042a ; 30 06

B0_0424:		lda $e9			; a5 e9
B0_0426:		lsr a			; 4a
B0_0427:		bcc B0_042a ; 90 01

B0_0429:		rts				; 60 

B0_042a:		ldy #$14		; a0 14
B0_042c:		lda ($e6), y	; b1 e6
B0_042e:		and #$7f		; 29 7f
B0_0430:		bne B0_0435 ; d0 03

B0_0432:		jmp B0_04b1		; 4c b1 84

B0_0435:		ldy #$18		; a0 18
B0_0437:		cmp ($e6), y	; d1 e6
B0_0439:		beq B0_043e ; f0 03

B0_043b:		jmp B0_04b1		; 4c b1 84

B0_043e:		lda #$00		; a9 00
B0_0440:		sta ($e6), y	; 91 e6
B0_0442:		tax				; aa 
B0_0443:		ldy #$15		; a0 15
B0_0445:		lda ($e6), y	; b1 e6
B0_0447:		rol a			; 2a
B0_0448:		rol a			; 2a
B0_0449:		rol a			; 2a
B0_044a:		rol a			; 2a
B0_044b:		and #$07		; 29 07
B0_044d:		sta $ee			; 85 ee
B0_044f:		ldy #$19		; a0 19
B0_0451:		lda ($e6), y	; b1 e6
B0_0453:		asl a			; 0a
B0_0454:		bcc B0_045e ; 90 08

B0_0456:		lda #$00		; a9 00
B0_0458:		sec				; 38 
B0_0459:		sbc $ee			; e5 ee
B0_045b:		sta $ee			; 85 ee
B0_045d:		dex				; ca 
B0_045e:		lda $ee			; a5 ee
B0_0460:		clc				; 18 
B0_0461:		ldy #$1a		; a0 1a
B0_0463:		adc ($e6), y	; 71 e6
B0_0465:		sta ($e6), y	; 91 e6
B0_0467:		iny				; c8 
B0_0468:		txa				; 8a 
B0_0469:		adc ($e6), y	; 71 e6
B0_046b:		sta ($e6), y	; 91 e6
B0_046d:		ldy #$15		; a0 15
B0_046f:		lda ($e6), y	; b1 e6
B0_0471:		and #$1f		; 29 1f
B0_0473:		sta $ee			; 85 ee
B0_0475:		ldy #$19		; a0 19
B0_0477:		lda ($e6), y	; b1 e6
B0_0479:		clc				; 18 
B0_047a:		adc #$01		; 69 01
B0_047c:		sta ($e6), y	; 91 e6
B0_047e:		and #$7f		; 29 7f
B0_0480:		cmp $ee			; c5 ee
B0_0482:		bne B0_04b1 ; d0 2d

B0_0484:		lda ($e6), y	; b1 e6
B0_0486:		and #$80		; 29 80
B0_0488:		sta ($e6), y	; 91 e6
B0_048a:		ldy #$14		; a0 14
B0_048c:		lda ($e6), y	; b1 e6
B0_048e:		asl a			; 0a
B0_048f:		bcs B0_04ab ; b0 1a

B0_0491:		lda ($e6), y	; b1 e6
B0_0493:		ora #$80		; 09 80
B0_0495:		sta ($e6), y	; 91 e6
B0_0497:		ldy #$19		; a0 19
B0_0499:		lda ($e6), y	; b1 e6
B0_049b:		bpl B0_04a4 ; 10 07

B0_049d:		and #$7f		; 29 7f
B0_049f:		sta ($e6), y	; 91 e6
B0_04a1:		jmp B0_04b1		; 4c b1 84

B0_04a4:		ora #$80		; 09 80
B0_04a6:		sta ($e6), y	; 91 e6
B0_04a8:		jmp B0_04b1		; 4c b1 84

B0_04ab:		lda ($e6), y	; b1 e6
B0_04ad:		and #$7f		; 29 7f
B0_04af:		sta ($e6), y	; 91 e6

; remove bit 7 of ef, then inc it (keep it positive)
B0_04b1:		lda $ef			; a5 ef
B0_04b3:		and #$7f		; 29 7f
B0_04b5:		sta $ef			; 85 ef
B0_04b7:		inc $ef			; e6 ef

B0_04b9:		ldy #$1a		; a0 1a
B0_04bb:		lda (wCurrSoundChannelStructPtr), y	; b1 e6
B0_04bd:		ldy $ef			; a4 ef
B0_04bf:		clc				; 18 
B0_04c0:		adc (wCurrSoundChannelStructPtr), y	; 71 e6
B0_04c2:		tax				; aa - this gets stored in LO

B0_04c3:		ldy #$1b		; a0 1b
B0_04c5:		lda (wCurrSoundChannelStructPtr), y	; b1 e6
B0_04c7:		inc $ef			; e6 ef
B0_04c9:		ldy $ef			; a4 ef
B0_04cb:		adc (wCurrSoundChannelStructPtr), y	; 71 e6
B0_04cd:		tay				; a8 
B0_04ce:		lda #$01		; a9 01
B0_04d0:		cmp wCurrSoundChnIdxReversed			; c5 e8
B0_04d2:		bne B0_04ed ; d0 19

; noise
B0_04d4:		lda #SNDENA_NOISE|SNDENA_TRI|SNDENA_SQ2|SNDENA_SQ1		; a9 0f
B0_04d6:		sta SND_CHN.w		; 8d 15 40
B0_04d9:		txa				; 8a 
B0_04da:		and #$0f		; 29 0f
B0_04dc:		tax				; aa 
B0_04dd:		inc $ef			; e6 ef
B0_04df:		ldy $ef			; a4 ef
B0_04e1:		lda ($e6), y	; b1 e6
B0_04e3:		and #$80		; 29 80
B0_04e5:		sta $ee			; 85 ee
B0_04e7:		txa				; 8a 
B0_04e8:		ora $ee			; 05 ee
B0_04ea:		tax				; aa 
B0_04eb:		ldy #$00		; a0 00

; all channels
B0_04ed:		txa				; 8a 
B0_04ee:		ldx wCurrSoundChnRegOffset			; a6 e5
B0_04f0:		inx				; e8 
B0_04f1:		inx				; e8 
B0_04f2:		sta CHN_LO.w-2, x	; 9d 00 40 - freq lo
B0_04f5:		tya				; 98 
B0_04f6:		ldy #$1c		; a0 1c
B0_04f8:		cmp (wCurrSoundChannelStructPtr), y	; d1 e6
B0_04fa:		bne B0_04fd ; d0 01

B0_04fc:		rts				; 60 

; length counter load to 1
B0_04fd:		sta ($e6), y	; 91 e6
B0_04ff:		ora #$08		; 09 08
B0_0501:		sta CHN_HI.w-2, x	; 9d 01 40 - freq hi
B0_0504:		rts				; 60 


func_0_0505:
B0_0505:		ldy #$01		; a0 01
B0_0507:		cpy wCurrSoundChnIdxReversed			; c4 e8
B0_0509:		bne B0_0511 ; d0 06

; noise
B0_050b:		lda #SNDENA_TRI|SNDENA_SQ2|SNDENA_SQ1		; a9 07
B0_050d:		sta SND_CHN.w		; 8d 15 40
B0_0510:		rts				; 60 

B0_0511:		lda #$00		; a9 00
B0_0513:		ldx wCurrSoundChnRegOffset			; a6 e5
B0_0515:		inx				; e8 
B0_0516:		inx				; e8 
B0_0517:		sta CHN_LO.w-2, x	; 9d 00 40 - clears freq
B0_051a:		sta CHN_HI.w-2, x	; 9d 01 40
B0_051d:		rts				; 60 


func_0_051e:
B0_051e:		ldy #$14		; a0 14
B0_0520:		lda ($e6), y	; b1 e6
B0_0522:		and #$7f		; 29 7f
B0_0524:		sta ($e6), y	; 91 e6
B0_0526:		ldy #$16		; a0 16
B0_0528:		lda ($e6), y	; b1 e6
B0_052a:		asl a			; 0a
B0_052b:		bcc B0_053d ; 90 10

B0_052d:		ldy $ee			; a4 ee
B0_052f:		lda ($e6), y	; b1 e6
; jump if tri
B0_0531:		ldx #$02		; a2 02
B0_0533:		cpx wCurrSoundChnIdxReversed			; e4 e8
B0_0535:		beq B0_0539 ; f0 02

B0_0537:		and #$0f		; 29 0f
B0_0539:		ldy #$1e		; a0 1e
B0_053b:		sta ($e6), y	; 91 e6
B0_053d:		ldx #$06		; a2 06
B0_053f:		lda #$00		; a9 00
B0_0541:		ldy #$18		; a0 18
B0_0543:		sta ($e6), y	; 91 e6
B0_0545:		iny				; c8 
B0_0546:		dex				; ca 
B0_0547:		bne B0_0543 ; d0 fa

B0_0549:		lda #$ff		; a9 ff
B0_054b:		ldy #$1c		; a0 1c
B0_054d:		sta ($e6), y	; 91 e6
B0_054f:		rts				; 60 


func_0_0550:
B0_0550:		ldy #$1c		; a0 1c
B0_0552:		lda ($e6), y	; b1 e6
B0_0554:		pha				; 48 
B0_0555:		jsr func_0_051e		; 20 1e 85
B0_0558:		pla				; 68 
B0_0559:		ldy #$1c		; a0 1c
B0_055b:		sta ($e6), y	; 91 e6
B0_055d:		rts				; 60 


b0_jumpTableIdxedX:
B0_055e:		txa				; 8a 
B0_055f:		asl a			; 0a
B0_0560:		tay				; a8 
B0_0561:		iny				; c8 
B0_0562:		pla				; 68 
B0_0563:		sta $ee			; 85 ee
B0_0565:		pla				; 68 
B0_0566:		sta $ef			; 85 ef
B0_0568:		lda ($ee), y	; b1 ee
B0_056a:		tax				; aa 
B0_056b:		iny				; c8 
B0_056c:		lda ($ee), y	; b1 ee
B0_056e:		sta $ef			; 85 ef
B0_0570:		stx $ee			; 86 ee
B0_0572:		jmp ($ee)


func_0_0575:
B0_0575:		lda $ec			; a5 ec
B0_0577:		bne B0_057c ; d0 03

B0_0579:		jmp func_0_059a		; 4c 9a 85

B0_057c:		ldy #$11		; a0 11
B0_057e:		lda ($e6), y	; b1 e6
B0_0580:		iny				; c8 
B0_0581:		ora ($e6), y	; 11 e6
B0_0583:		bne B0_0586 ; d0 01

B0_0585:		rts				; 60 

B0_0586:		iny				; c8 
B0_0587:		lda ($e6), y	; b1 e6
; jump if tri
B0_0589:		ldy #$02		; a0 02
B0_058b:		cpy wCurrSoundChnIdxReversed			; c4 e8
B0_058d:		beq B0_0591 ; f0 02

B0_058f:		and #$0f		; 29 0f
B0_0591:		sta $ee			; 85 ee
B0_0593:		lda #$93		; a9 93
B0_0595:		sta $ef			; 85 ef
B0_0597:		jmp func_0_0397		; 4c 97 83

func_0_059a:
B0_059a:		jsr getNextSoundDataByteAfter1st2Bytes_todo		; 20 a8 86
B0_059d:		asl a			; 0a
B0_059e:		bcs B0_05a3 ; b0 03

B0_05a0:		jmp B0_05ca		; 4c ca 85

; bit 7 set of sound data byte
B0_05a3:		txa				; 8a 
B0_05a4:		and #$0f		; 29 0f
B0_05a6:		cmp #$0f		; c9 0f
B0_05a8:		bne B0_05b0 ; d0 06

; low nybble is 0f
B0_05aa:		jsr getNextSoundDataByteAfter1st2Bytes_todo		; 20 a8 86
B0_05ad:		jmp func_0_0550		; 4c 50 85

; low nybble is not 0f
B0_05b0:		and #$07		; 29 07
B0_05b2:		sta $ee			; 85 ee
B0_05b4:		jsr getNextSoundDataByteAfter1st2Bytes_todo		; 20 a8 86
B0_05b7:		ldy #SoundChannel.freqLo		; a0 11
B0_05b9:		sta ($e6), y	; 91 e6
; SoundChannel.freqHi
B0_05bb:		iny				; c8 
B0_05bc:		lda $ee			; a5 ee
B0_05be:		sta ($e6), y	; 91 e6

B0_05c0:		lda #$13		; a9 13
B0_05c2:		sta $ee			; 85 ee
B0_05c4:		jsr func_0_051e		; 20 1e 85
B0_05c7:		jmp func_0_0505		; 4c 05 85

B0_05ca:		jsr b0_jumpTableIdxedX		; 20 5e 85
	.dw soundDataByte0
	.dw soundDataByte1
	.dw soundDataByte2
	.dw soundDataByte3
	.dw soundDataByte4
	.dw soundDataByte5
	.dw soundDataByte6

soundDataByte0:
	jsr getNextSoundDataByteAfter1st2Bytes_todo
	sta $ec
	jmp func_0_059a


soundDataByte1:
	jsr getNextSoundDataByteAfter1st2Bytes_todo
	ldy #SoundChannel.byte10
	sta (wCurrSoundChannelStructPtr), y
	jmp func_0_059a


soundDataByte2:
	jsr getNextSoundDataByteAfter1st2Bytes_todo
	sta $ee
	ldy #SoundChannel.byte13
B0_05f4:		lda (wCurrSoundChannelStructPtr), y	; b1 e6
B0_05f6:		and #$3f		; 29 3f
B0_05f8:		ora $ee			; 05 ee
B0_05fa:		jmp B0_0610		; 4c 10 86


soundDataByte3:
B0_05fd:		jsr getNextSoundDataByteAfter1st2Bytes_todo		; 20 a8 86
; jump if tri
B0_0600:		ldy #$02		; a0 02
B0_0602:		cpy wCurrSoundChnIdxReversed			; c4 e8
B0_0604:		beq B0_0610 ; f0 0a

B0_0606:		sta $ee			; 85 ee
B0_0608:		ldy #SoundChannel.byte13		; a0 13
B0_060a:		lda (wCurrSoundChannelStructPtr), y	; b1 e6
B0_060c:		and #$c0		; 29 c0
B0_060e:		ora $ee			; 05 ee

B0_0610:		ldy #SoundChannel.byte13		; a0 13
B0_0612:		sta (wCurrSoundChannelStructPtr), y	; 91 e6
B0_0614:		jmp func_0_059a		; 4c 9a 85


soundDataByte4:
B0_0617:		jsr getNextSoundDataByteAfter1st2Bytes_todo		; 20 a8 86
B0_061a:		txa				; 8a 
B0_061b:		beq B0_0623 ; f0 06

B0_061d:		cpx $ed			; e4 ed
B0_061f:		beq B0_0634 ; f0 13

B0_0621:		inc $ed			; e6 ed
B0_0623:		jsr getNextSoundDataByteAfter1st2Bytes_todo		; 20 a8 86
B0_0626:		sta $ee			; 85 ee
B0_0628:		jsr getNextSoundDataByteAfter1st2Bytes_todo		; 20 a8 86
B0_062b:		sta wTodoCurrSoundDataAddrAfter2Bytes+1			; 85 eb
B0_062d:		lda $ee			; a5 ee
B0_062f:		sta wTodoCurrSoundDataAddrAfter2Bytes			; 85 ea
B0_0631:		jmp func_0_059a		; 4c 9a 85

B0_0634:		lda #$00		; a9 00
B0_0636:		sta $ed			; 85 ed
B0_0638:		lda #$02		; a9 02
B0_063a:		clc				; 18 
B0_063b:		adc wTodoCurrSoundDataAddrAfter2Bytes			; 65 ea
B0_063d:		sta wTodoCurrSoundDataAddrAfter2Bytes			; 85 ea
B0_063f:		lda #$00		; a9 00
B0_0641:		adc wTodoCurrSoundDataAddrAfter2Bytes+1			; 65 eb
B0_0643:		sta wTodoCurrSoundDataAddrAfter2Bytes+1			; 85 eb
B0_0645:		jmp func_0_059a		; 4c 9a 85


soundDataByte5:
B0_0648:		lda #$14		; a9 14
B0_064a:		sta $ee			; 85 ee
B0_064c:		jsr getNextSoundDataByteAfter1st2Bytes_todo		; 20 a8 86
B0_064f:		ldy $ee			; a4 ee
B0_0651:		sta ($e6), y	; 91 e6
B0_0653:		inc $ee			; e6 ee
B0_0655:		ldy $ee			; a4 ee
B0_0657:		cpy #$18		; c0 18
B0_0659:		bne B0_064c ; d0 f1

B0_065b:		jmp func_0_059a		; 4c 9a 85


soundDataByte6:
B0_065e:		lda wTodoCurrSoundDataAddrAfter2Bytes			; a5 ea
B0_0660:		sec				; 38 
B0_0661:		sbc #$01		; e9 01
B0_0663:		sta wTodoCurrSoundDataAddrAfter2Bytes			; 85 ea
B0_0665:		lda wTodoCurrSoundDataAddrAfter2Bytes+1			; a5 eb
B0_0667:		sbc #$00		; e9 00
B0_0669:		sta wTodoCurrSoundDataAddrAfter2Bytes+1			; 85 eb
B0_066b:		lda $da			; a5 da
B0_066d:		and #$0f		; 29 0f
B0_066f:		sta $da			; 85 da
B0_0671:		lda #$00		; a9 00
B0_0673:		sta $db			; 85 db
B0_0675:		lda $e9			; a5 e9
B0_0677:		and #$fe		; 29 fe
B0_0679:		sta $e9			; 85 e9
B0_067b:		ldy #$0a		; a0 0a
B0_067d:		lda ($e6), y	; b1 e6
B0_067f:		iny				; c8 
B0_0680:		ora ($e6), y	; 11 e6
B0_0682:		bne B0_0697 ; d0 13

B0_0684:		ldx wCurrSoundChnRegOffset			; a6 e5
B0_0686:		inx				; e8 
B0_0687:		inx				; e8 
B0_0688:		ldy wCurrSoundChnIdxReversed			; a4 e8
B0_068a:		jsr clearChnYreversedFreq		; 20 22 82
B0_068d:		ldy #$00		; a0 00
B0_068f:		lda ($e6), y	; b1 e6
B0_0691:		iny				; c8 
B0_0692:		ora ($e6), y	; 11 e6
B0_0694:		bne B0_0697 ; d0 01

B0_0696:		rts				; 60 

B0_0697:		ldy #$06		; a0 06
B0_0699:		lda ($e6), y	; b1 e6
B0_069b:		and #$1f		; 29 1f
B0_069d:		tax				; aa 
B0_069e:		jsr func_0_08e9		; 20 e9 88
B0_06a1:		lda #$0c		; a9 0c
B0_06a3:		sta $ee			; 85 ee
B0_06a5:		jmp func_0_051e		; 4c 1e 85


getNextSoundDataByteAfter1st2Bytes_todo:
; get byte and store in AX at end
B0_06a8:		ldy #$00		; a0 00
B0_06aa:		lda (wTodoCurrSoundDataAddrAfter2Bytes), y	; b1 ea
B0_06ac:		tax				; aa 

; add 1 to pointer
B0_06ad:		lda #$01		; a9 01
B0_06af:		clc				; 18 
B0_06b0:		adc wTodoCurrSoundDataAddrAfter2Bytes			; 65 ea
B0_06b2:		sta wTodoCurrSoundDataAddrAfter2Bytes			; 85 ea
B0_06b4:		lda #$00		; a9 00
B0_06b6:		adc wTodoCurrSoundDataAddrAfter2Bytes+1			; 65 eb
B0_06b8:		sta wTodoCurrSoundDataAddrAfter2Bytes+1			; 85 eb

B0_06ba:		txa				; 8a 
B0_06bb:		rts				; 60 


func_0_06bc:
B0_06bc:		lda $e1			; a5 e1
B0_06be:		beq B0_06cb ; f0 0b

B0_06c0:		pha				; 48 
B0_06c1:		jsr func_0_06cb		; 20 cb 86
B0_06c4:		pla				; 68 
B0_06c5:		sec				; 38 
B0_06c6:		sbc #$01		; e9 01
B0_06c8:		bne B0_06c0 ; d0 f6

B0_06ca:		rts				; 60 

func_0_06cb:
B0_06cb:		ldy #$05		; a0 05
B0_06cd:		lda ($e6), y	; b1 e6
B0_06cf:		asl a			; 0a
B0_06d0:		bcc B0_06db ; 90 09

B0_06d2:		lda wUpdateSoundCounter			; a5 e4
B0_06d4:		and #$01		; 29 01
B0_06d6:		beq B0_06db ; f0 03

B0_06d8:		jsr $86db		; 20 db 86
B0_06db:		ldy #$02		; a0 02
B0_06dd:		lda ($e6), y	; b1 e6
B0_06df:		iny				; c8 
B0_06e0:		ora ($e6), y	; 11 e6
B0_06e2:		beq B0_0706 ; f0 22

B0_06e4:		ldx #$ff		; a2 ff
B0_06e6:		dey				; 88 
B0_06e7:		lda ($e6), y	; b1 e6
B0_06e9:		sec				; 38 
B0_06ea:		sbc #$04		; e9 04
B0_06ec:		sta ($e6), y	; 91 e6
B0_06ee:		txa				; 8a 
B0_06ef:		iny				; c8 
B0_06f0:		adc ($e6), y	; 71 e6
B0_06f2:		sta ($e6), y	; 91 e6
B0_06f4:		dey				; 88 
B0_06f5:		ora ($e6), y	; 11 e6
B0_06f7:		beq B0_0706 ; f0 0d

B0_06f9:		ldy #$0a		; a0 0a
B0_06fb:		lda ($e6), y	; b1 e6
B0_06fd:		iny				; c8 
B0_06fe:		ora ($e6), y	; 11 e6
B0_0700:		bne B0_0703 ; d0 01

B0_0702:		rts				; 60 

B0_0703:		jmp func_0_02f4		; 4c f4 82

B0_0706:		ldy #$05		; a0 05
B0_0708:		lda ($e6), y	; b1 e6
B0_070a:		and #$7f		; 29 7f
B0_070c:		sta ($e6), y	; 91 e6

func_0_070e:
B0_070e:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_0711:		and #$f0		; 29 f0
B0_0713:		bne B0_0718 ; d0 03

B0_0715:		jmp processSoundChnByte0x		; 4c c8 87

B0_0718:		cmp #$20		; c9 20
B0_071a:		bne B0_0727 ; d0 0b

B0_071c:		txa				; 8a 
B0_071d:		and #$07		; 29 07
B0_071f:		pha				; 48 
B0_0720:		jsr func_0_070e		; 20 0e 87
B0_0723:		pla				; 68 
B0_0724:		jmp func_0_07aa		; 4c aa 87

B0_0727:		cmp #$30		; c9 30
B0_0729:		bne B0_072e ; d0 03

B0_072b:		jmp func_0_07bd		; 4c bd 87

B0_072e:		txa				; 8a 
B0_072f:		rol a			; 2a
B0_0730:		rol a			; 2a
B0_0731:		rol a			; 2a
B0_0732:		rol a			; 2a
B0_0733:		and #$07		; 29 07
B0_0735:		tay				; a8 
B0_0736:		lda data_0_097d.w, y	; b9 7d 89
B0_0739:		jsr func_0_095c		; 20 5c 89
B0_073c:		ldy #$06		; a0 06
B0_073e:		lda ($e6), y	; b1 e6
B0_0740:		and #$e0		; 29 e0
B0_0742:		beq B0_075a ; f0 16

B0_0744:		sec				; 38 
B0_0745:		sbc #$20		; e9 20
B0_0747:		sta $ee			; 85 ee
B0_0749:		lda ($e6), y	; b1 e6
B0_074b:		and #$1f		; 29 1f
B0_074d:		ora $ee			; 05 ee
B0_074f:		sta ($e6), y	; 91 e6
B0_0751:		lda $e9			; a5 e9
B0_0753:		lsr a			; 4a
B0_0754:		bcc B0_0757 ; 90 01

B0_0756:		rts				; 60 

B0_0757:		jmp func_0_0550		; 4c 50 85

B0_075a:		txa				; 8a 
B0_075b:		and #$1f		; 29 1f
B0_075d:		bne B0_0763 ; d0 04

B0_075f:		tax				; aa 
B0_0760:		jmp B0_0785		; 4c 85 87

B0_0763:		ldy #$01		; a0 01
B0_0765:		cpy wCurrSoundChnIdxReversed			; c4 e8
B0_0767:		bne B0_076e ; d0 05

; noise
B0_0769:		ldx #$00		; a2 00
B0_076b:		jmp B0_0785		; 4c 85 87

B0_076e:		asl a			; 0a
B0_076f:		ldy #$07		; a0 07
B0_0771:		clc				; 18 
B0_0772:		adc ($e6), y	; 71 e6
B0_0774:		sta $ee			; 85 ee
B0_0776:		lda #$00		; a9 00
B0_0778:		iny				; c8 
B0_0779:		adc ($e6), y	; 71 e6
B0_077b:		sta $ef			; 85 ef

B0_077d:		ldy #$01		; a0 01
B0_077f:		lda ($ee), y	; b1 ee
B0_0781:		tax				; aa 
B0_0782:		dey				; 88 
B0_0783:		lda ($ee), y	; b1 ee

B0_0785:		ldy #$0a		; a0 0a
B0_0787:		sta ($e6), y	; 91 e6
B0_0789:		iny				; c8 
B0_078a:		txa				; 8a 
B0_078b:		sta ($e6), y	; 91 e6
B0_078d:		ldy #$0d		; a0 0d
B0_078f:		lda ($e6), y	; b1 e6
B0_0791:		sta $ee			; 85 ee
B0_0793:		and #$7f		; 29 7f
B0_0795:		beq B0_079a ; f0 03

B0_0797:		jsr func_0_08b1		; 20 b1 88
B0_079a:		lda $e9			; a5 e9
B0_079c:		lsr a			; 4a
B0_079d:		bcc B0_07a0 ; 90 01

B0_079f:		rts				; 60 

B0_07a0:		lda #$0c		; a9 0c
B0_07a2:		sta $ee			; 85 ee
B0_07a4:		jsr func_0_051e		; 20 1e 85
B0_07a7:		jmp func_0_0505		; 4c 05 85


func_0_07aa:
B0_07aa:		ror a			; 6a
B0_07ab:		ror a			; 6a
B0_07ac:		ror a			; 6a
B0_07ad:		ror a			; 6a
B0_07ae:		and #$e0		; 29 e0
B0_07b0:		sta $ee			; 85 ee
B0_07b2:		ldy #$06		; a0 06
B0_07b4:		lda ($e6), y	; b1 e6
B0_07b6:		and #$1f		; 29 1f
B0_07b8:		ora $ee			; 05 ee
B0_07ba:		sta ($e6), y	; 91 e6
B0_07bc:		rts				; 60 


func_0_07bd:
B0_07bd:		lda #$80		; a9 80
B0_07bf:		ldy #$05		; a0 05
B0_07c1:		ora ($e6), y	; 11 e6
B0_07c3:		sta ($e6), y	; 91 e6
B0_07c5:		jmp func_0_070e		; 4c 0e 87


processSoundChnByte0x:
B0_07c8:		jsr b0_jumpTableIdxedX		; 20 5e 85
	.dw soundChnByte0
	.dw soundChnByte1
	.dw soundChnByte2
	.dw soundChnByte3
	.dw soundChnByte4
	.dw soundChnByte5
	.dw soundChnByte6
	.dw soundChnByte7
	.dw soundChnByte8
	.dw soundChnByte9

soundChnByte0:
B0_07df:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_07e2:		ldy #$04		; a0 04
B0_07e4:		sta ($e6), y	; 91 e6
B0_07e6:		jmp func_0_070e		; 4c 0e 87


soundChnByte1:
B0_07e9:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_07ec:		ldy #$09		; a0 09
B0_07ee:		sta ($e6), y	; 91 e6
B0_07f0:		jmp func_0_070e		; 4c 0e 87


soundChnByte2:
B0_07f3:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_07f6:		sta $ee			; 85 ee
B0_07f8:		ldy #$0c		; a0 0c
B0_07fa:		lda ($e6), y	; b1 e6
B0_07fc:		and #$3f		; 29 3f
B0_07fe:		ora $ee			; 05 ee
B0_0800:		jmp B0_0816		; 4c 16 88


soundChnByte3:
B0_0803:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
; jump if tri
B0_0806:		ldy #$02		; a0 02
B0_0808:		cpy wCurrSoundChnIdxReversed			; c4 e8
B0_080a:		beq B0_0816 ; f0 0a

B0_080c:		sta $ee			; 85 ee
B0_080e:		ldy #$0c		; a0 0c
B0_0810:		lda ($e6), y	; b1 e6
B0_0812:		and #$c0		; 29 c0
B0_0814:		ora $ee			; 05 ee

B0_0816:		ldy #$0c		; a0 0c
B0_0818:		sta ($e6), y	; 91 e6
B0_081a:		jmp func_0_070e		; 4c 0e 87


soundChnByte4:
B0_081d:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_0820:		txa				; 8a 
B0_0821:		beq B0_0839 ; f0 16

B0_0823:		ldy #$05		; a0 05
B0_0825:		lda ($e6), y	; b1 e6
B0_0827:		and #$7f		; 29 7f
B0_0829:		sta $ee			; 85 ee
B0_082b:		cpx $ee			; e4 ee
B0_082d:		beq B0_084c ; f0 1d

B0_082f:		inc $ee			; e6 ee
B0_0831:		lda ($e6), y	; b1 e6
B0_0833:		and #$80		; 29 80
B0_0835:		ora $ee			; 05 ee
B0_0837:		sta ($e6), y	; 91 e6
B0_0839:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_083c:		pha				; 48 
B0_083d:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_0840:		pla				; 68 
B0_0841:		ldy #$00		; a0 00
B0_0843:		sta ($e6), y	; 91 e6
B0_0845:		iny				; c8 
B0_0846:		txa				; 8a 
B0_0847:		sta ($e6), y	; 91 e6
B0_0849:		jmp func_0_070e		; 4c 0e 87

B0_084c:		lda ($e6), y	; b1 e6
B0_084e:		and #$80		; 29 80
B0_0850:		sta ($e6), y	; 91 e6
B0_0852:		ldy #$00		; a0 00
B0_0854:		lda #$02		; a9 02
B0_0856:		clc				; 18 
B0_0857:		adc ($e6), y	; 71 e6
B0_0859:		sta ($e6), y	; 91 e6
B0_085b:		iny				; c8 
B0_085c:		lda #$00		; a9 00
B0_085e:		adc ($e6), y	; 71 e6
B0_0860:		sta ($e6), y	; 91 e6
B0_0862:		jmp func_0_070e		; 4c 0e 87


soundChnByte5:
B0_0865:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_0868:		ldx #<data_0_098d		; a2 8d
B0_086a:		ldy #>data_0_098d		; a0 89
B0_086c:		stx $ee			; 86 ee
B0_086e:		sty $ef			; 84 ef
B0_0870:		asl a			; 0a
B0_0871:		ldy #$07		; a0 07
B0_0873:		clc				; 18 
B0_0874:		adc $ee			; 65 ee
B0_0876:		sta ($e6), y	; 91 e6
B0_0878:		lda #$00		; a9 00
B0_087a:		adc $ef			; 65 ef
B0_087c:		iny				; c8 
B0_087d:		sta ($e6), y	; 91 e6
B0_087f:		jmp func_0_070e		; 4c 0e 87


soundChnByte6:
B0_0882:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_0885:		rol a			; 2a
B0_0886:		rol a			; 2a
B0_0887:		rol a			; 2a
B0_0888:		rol a			; 2a
B0_0889:		and #$07		; 29 07
B0_088b:		tay				; a8 
B0_088c:		lda $8985, y	; b9 85 89
B0_088f:		jsr func_0_095c		; 20 5c 89
B0_0892:		jmp $873c		; 4c 3c 87


soundChnByte7:
B0_0895:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_0898:		ldy #$0d		; a0 0d
B0_089a:		sta ($e6), y	; 91 e6
B0_089c:		pha				; 48 
B0_089d:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_08a0:		ldy #$0f		; a0 0f
B0_08a2:		sta ($e6), y	; 91 e6
B0_08a4:		pla				; 68 
B0_08a5:		sta $ee			; 85 ee
B0_08a7:		and #$7f		; 29 7f
B0_08a9:		beq B0_08ae ; f0 03

B0_08ab:		jsr func_0_08b1		; 20 b1 88
B0_08ae:		jmp func_0_070e		; 4c 0e 87


func_0_08b1:
B0_08b1:		lda #$00		; a9 00
B0_08b3:		ldy #$0e		; a0 0e
B0_08b5:		sta ($e6), y	; 91 e6
B0_08b7:		lda $ee			; a5 ee
B0_08b9:		bpl B0_08c0 ; 10 05

B0_08bb:		lda #$0f		; a9 0f
B0_08bd:		jmp B0_08c2		; 4c c2 88

B0_08c0:		lda #$00		; a9 00

B0_08c2:		sta $ee			; 85 ee
B0_08c4:		ldy #$0f		; a0 0f
B0_08c6:		lda ($e6), y	; b1 e6
B0_08c8:		and #$f0		; 29 f0
B0_08ca:		ora $ee			; 05 ee
B0_08cc:		sta ($e6), y	; 91 e6
B0_08ce:		rts				; 60 


soundChnByte8:
B0_08cf:		jsr getNextSoundChnStructByteIntoAX_todo		; 20 3d 89
B0_08d2:		sta $ee			; 85 ee
B0_08d4:		ldy #$06		; a0 06
B0_08d6:		lda ($e6), y	; b1 e6
B0_08d8:		and #$e0		; 29 e0
B0_08da:		ora $ee			; 05 ee
B0_08dc:		sta ($e6), y	; 91 e6
B0_08de:		lda $e9			; a5 e9
B0_08e0:		lsr a			; 4a
B0_08e1:		bcs B0_08e6 ; b0 03

B0_08e3:		jsr func_0_08e9		; 20 e9 88
B0_08e6:		jmp func_0_070e		; 4c 0e 87


func_0_08e9:
B0_08e9:		txa				; 8a 
B0_08ea:		beq B0_08f4 ; f0 08

B0_08ec:		lda #$00		; a9 00
B0_08ee:		clc				; 18 
B0_08ef:		adc #$04		; 69 04
B0_08f1:		dex				; ca 
B0_08f2:		bne B0_08ee ; d0 fa

B0_08f4:		clc				; 18 
B0_08f5:		adc $07fc		; 6d fc 07
B0_08f8:		sta $ee			; 85 ee
B0_08fa:		lda #$00		; a9 00
B0_08fc:		adc $07fd		; 6d fd 07
B0_08ff:		sta $ef			; 85 ef
B0_0901:		ldx #$00		; a2 00
B0_0903:		ldy #$14		; a0 14
B0_0905:		lda ($ee, x)	; a1 ee
B0_0907:		sta ($e6), y	; 91 e6
B0_0909:		iny				; c8 
B0_090a:		cpy #$18		; c0 18
B0_090c:		bne B0_090f ; d0 01

B0_090e:		rts				; 60 

B0_090f:		lda #$01		; a9 01
B0_0911:		clc				; 18 
B0_0912:		adc $ee			; 65 ee
B0_0914:		sta $ee			; 85 ee
B0_0916:		lda #$00		; a9 00
B0_0918:		adc $ef			; 65 ef
B0_091a:		sta $ef			; 85 ef
B0_091c:		jmp $8905		; 4c 05 89


soundChnByte9:
B0_091f:		ldy #$00		; a0 00
B0_0921:		lda #$00		; a9 00
B0_0923:		sta ($e6), y	; 91 e6
B0_0925:		iny				; c8 
B0_0926:		sta ($e6), y	; 91 e6
B0_0928:		lda $da			; a5 da
B0_092a:		and #$f0		; 29 f0
B0_092c:		sta $da			; 85 da
B0_092e:		lda $e9			; a5 e9
B0_0930:		lsr a			; 4a
B0_0931:		bcc B0_0934 ; 90 01

B0_0933:		rts				; 60 

B0_0934:		ldx wCurrSoundChnRegOffset			; a6 e5
B0_0936:		inx				; e8 
B0_0937:		inx				; e8 
B0_0938:		ldy wCurrSoundChnIdxReversed			; a4 e8
B0_093a:		jmp clearChnYreversedFreq		; 4c 22 82


getNextSoundChnStructByteIntoAX_todo:
; store 1st 2 vals in ee/ef
B0_093d:		ldy #$00		; a0 00
B0_093f:		lda (wCurrSoundChannelStructPtr), y	; b1 e6
B0_0941:		sta $ee			; 85 ee
B0_0943:		iny				; c8 
B0_0944:		lda (wCurrSoundChannelStructPtr), y	; b1 e6
B0_0946:		sta $ef			; 85 ef

; get 1st val in ee, and restore at func end
B0_0948:		dey				; 88 
B0_0949:		lda ($ee), y	; b1 ee
B0_094b:		tax				; aa 

; word at e6 to point to byte after above val
B0_094c:		lda #$01		; a9 01
B0_094e:		clc				; 18 
B0_094f:		adc $ee			; 65 ee
B0_0951:		sta (wCurrSoundChannelStructPtr), y	; 91 e6
B0_0953:		lda #$00		; a9 00
B0_0955:		adc $ef			; 65 ef
B0_0957:		iny				; c8 
B0_0958:		sta (wCurrSoundChannelStructPtr), y	; 91 e6

B0_095a:		txa				; 8a 
B0_095b:		rts				; 60 


func_0_095c:
B0_095c:		sta $ee			; 85 ee
B0_095e:		lda #$00		; a9 00
B0_0960:		sta $ef			; 85 ef
B0_0962:		ldy #$04		; a0 04
B0_0964:		lda ($e6), y	; b1 e6
B0_0966:		tay				; a8 
B0_0967:		lda #$00		; a9 00
B0_0969:		clc				; 18 
B0_096a:		adc $ee			; 65 ee
B0_096c:		bcc B0_0970 ; 90 02

B0_096e:		inc $ef			; e6 ef
B0_0970:		dey				; 88 
B0_0971:		bne B0_0969 ; d0 f6

B0_0973:		ldy #$02		; a0 02
B0_0975:		sta ($e6), y	; 91 e6
B0_0977:		iny				; c8 
B0_0978:		lda $ef			; a5 ef
B0_097a:		sta ($e6), y	; 91 e6
B0_097c:		rts				; 60 