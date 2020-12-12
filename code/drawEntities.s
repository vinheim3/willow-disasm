
drawEntities_body:
	inc wDrawEntitiesCounter
	jsr func_7_17d5
B4_108f:		lda wDrawEntitiesCounter			; a5 d1
B4_1091:		lsr a			; 4a
B4_1092:		bcs B4_10ba ; b0 26

B4_1094:		ldx #$50		; a2 50
B4_1096:		stx wEntityOamLowerBound			; 86 d0
B4_1098:		lda #$f8		; a9 f8
B4_109a:		sta wOam.w, x	; 9d 00 02
B4_109d:		inx				; e8 
B4_109e:		inx				; e8 
B4_109f:		inx				; e8 
B4_10a0:		inx				; e8 
B4_10a1:		bne B4_109a ; d0 f7

B4_10a3:		stx wEntityOamUpperBound			; 86 d3
B4_10a5:		ldx #$00		; a2 00
B4_10a7:		stx $d2			; 86 d2
B4_10a9:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_10ac:		bpl B4_10b1 ; 10 03

B4_10ae:		jsr func_4_10e0		; 20 e0 90
B4_10b1:		inc $d2			; e6 d2
B4_10b3:		ldx $d2			; a6 d2
B4_10b5:		cpx #$18		; e0 18
B4_10b7:		bne B4_10a9 ; d0 f0

B4_10b9:		rts				; 60 

B4_10ba:		ldx #$04		; a2 04
B4_10bc:		stx wEntityOamLowerBound			; 86 d0
B4_10be:		lda #$f8		; a9 f8
B4_10c0:		sta wOam.w, x	; 9d 00 02
B4_10c3:		inx				; e8 
B4_10c4:		inx				; e8 
B4_10c5:		inx				; e8 
B4_10c6:		inx				; e8 
B4_10c7:		cpx #$b4		; e0 b4
B4_10c9:		bne B4_10c0 ; d0 f5
; loops through $17+1 entities
B4_10cb:		stx wEntityOamUpperBound			; 86 d3
B4_10cd:		ldx #$17		; a2 17
B4_10cf:		stx $d2			; 86 d2
B4_10d1:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_10d4:		bpl B4_10d9 ; 10 03

B4_10d6:		jsr func_4_10e0		; 20 e0 90
B4_10d9:		dec $d2			; c6 d2
B4_10db:		ldx $d2			; a6 d2
B4_10dd:		bpl B4_10d1 ; 10 f2

B4_10df:		rts				; 60 


func_4_10e0:
B4_10e0:		ldy wEntitiesId.w, x	; bc 18 03
B4_10e3:		lda data_4_3f39.w, y	; b9 39 bf
B4_10e6:		tay				; a8 
B4_10e7:		lda data_4_3f1f.w, y	; b9 1f bf
B4_10ea:		sta $00			; 85 00
B4_10ec:		lda data_4_3f2c.w, y	; b9 2c bf
B4_10ef:		sta $01			; 85 01

B4_10f1:		lda wEntities_420.w, x	; bd 20 04
B4_10f4:		bne B4_116f ; d0 79

B4_10f6:		lda wPlayerKnockbackCounter			; a5 c7
B4_10f8:		bne B4_1110 ; d0 16

B4_10fa:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_10fd:		and #$04		; 29 04
B4_10ff:		beq B4_1110 ; f0 0f

B4_1101:		lda $c0			; a5 c0
B4_1103:		and #$04		; 29 04
B4_1105:		bne B4_116f ; d0 68

B4_1107:		jsr func_7_13ad		; 20 ad d3
B4_110a:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_110d:		bmi B4_1110 ; 30 01

B4_110f:		rts				; 60 

B4_1110:		lda wEntitiesId.w, x	; bd 18 03
B4_1113:		beq B4_116f ; f0 5a

B4_1115:		lda $bf			; a5 bf
B4_1117:		cmp #$04		; c9 04
B4_1119:		bcc B4_1135 ; 90 1a

B4_111b:		cmp #$08		; c9 08
B4_111d:		bcs B4_1135 ; b0 16

B4_111f:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_1122:		and #$01		; 29 01
B4_1124:		beq B4_1135 ; f0 0f

B4_1126:		lda $c0			; a5 c0
B4_1128:		and #$04		; 29 04
B4_112a:		bne B4_116f ; d0 43

B4_112c:		jsr $d4d7		; 20 d7 d4
B4_112f:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_1132:		bmi B4_1135 ; 30 01

B4_1134:		rts				; 60 

B4_1135:		cpx #$08		; e0 08
B4_1137:		bcc B4_116f ; 90 36

B4_1139:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_113c:		and #$10		; 29 10
B4_113e:		bne B4_116f ; d0 2f

B4_1140:		lda wEntitiesId.w, x	; bd 18 03
B4_1143:		cmp #$a0		; c9 a0
B4_1145:		bcs B4_116f ; b0 28

B4_1147:		lda wEquippedMagic			; a5 b8
B4_1149:		beq B4_116f ; f0 24

B4_114b:		lda wEquippedMagic			; a5 b8
B4_114d:		bpl B4_116f ; 10 20

B4_114f:		cmp #$81		; c9 81
B4_1151:		beq B4_1160 ; f0 0d

B4_1153:		cmp #$86		; c9 86
B4_1155:		beq B4_1160 ; f0 09

B4_1157:		lda wEntities_330.w, x	; bd 30 03
B4_115a:		eor #$ff		; 49 ff
B4_115c:		and $b9			; 25 b9
B4_115e:		beq B4_116f ; f0 0f

B4_1160:		lda $c0			; a5 c0
B4_1162:		and #$04		; 29 04
B4_1164:		bne B4_116f ; d0 09

B4_1166:		jsr $d62e		; 20 2e d6
B4_1169:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_116c:		bmi B4_116f ; 30 01

B4_116e:		rts				; 60 

B4_116f:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_1172:		and #$10		; 29 10
B4_1174:		beq B4_1177 ; f0 01

B4_1176:		rts				; 60 

B4_1177:		ldy wEntitiesId.w, x	; bc 18 03
B4_117a:		lda data_4_1470.w, y	; b9 70 94
B4_117d:		sta $00			; 85 00
B4_117f:		lda data_4_1510.w, y	; b9 10 95
B4_1182:		sta $01			; 85 01
B4_1184:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_1187:		and #$08		; 29 08
B4_1189:		bne B4_11b5 ; d0 2a

B4_118b:		lda wEntities_450.w, x	; bd 50 04
B4_118e:		inc wEntities_450.w, x	; fe 50 04
B4_1191:		ldy #$01		; a0 01
B4_1193:		cmp ($00), y	; d1 00
B4_1195:		bne B4_11b5 ; d0 1e

B4_1197:		lda #$00		; a9 00
B4_1199:		sta wEntities_450.w, x	; 9d 50 04
B4_119c:		inc wEntities_438.w, x	; fe 38 04
B4_119f:		dey				; 88 
B4_11a0:		lda ($00), y	; b1 00
B4_11a2:		cmp wEntities_438.w, x	; dd 38 04
B4_11a5:		bcs B4_11b5 ; b0 0e

B4_11a7:		lda #$00		; a9 00
B4_11a9:		sta wEntities_438.w, x	; 9d 38 04
B4_11ac:		beq B4_11b5 ; f0 07

B4_11ae:		tay				; a8 
B4_11af:		lda #$00		; a9 00
B4_11b1:		sta $05			; 85 05
B4_11b3:		beq B4_11ef ; f0 3a

B4_11b5:		lda wEntities_438.w, x	; bd 38 04
B4_11b8:		clc				; 18 
B4_11b9:		adc #$02		; 69 02
B4_11bb:		tay				; a8 
B4_11bc:		lda wEntitiesY.w, x	; bd 80 04
B4_11bf:		sta wTempEntityY			; 85 02
B4_11c1:		lda wEntitiesX.w, x	; bd b0 04
B4_11c4:		sta wTempEntityX			; 85 03
B4_11c6:		lda ($00), y	; b1 00
B4_11c8:		bne B4_11ce ; d0 04

B4_11ca:		sta wEntitiesControlByte.w, x	; 9d 00 03
B4_11cd:		rts				; 60 

B4_11ce:		tay				; a8 becomes de
B4_11cf:		lda wEntities_420.w, x	; bd 20 04
B4_11d2:		beq B4_11e8 ; f0 14

B4_11d4:		dec wEntities_420.w, x	; de 20 04
B4_11d7:		bne B4_11e3 ; d0 0a

B4_11d9:		pha				; 48 
B4_11da:		lda wEntities_3c0.w, x	; bd c0 03
B4_11dd:		and #$df		; 29 df
B4_11df:		sta wEntities_3c0.w, x	; 9d c0 03
B4_11e2:		pla				; 68 
B4_11e3:		and #$02		; 29 02
B4_11e5:		bne B4_11e8 ; d0 01

B4_11e7:		rts				; 60 

B4_11e8:		lda wEntitiesControlByte.w, x	; bd 00 03
B4_11eb:		and #$60		; 29 60
B4_11ed:		sta wEntityAttrHorizOrBehindBG			; 85 05
B4_11ef:		lda entitySpritesData_lo.w, y	; b9 70 92
B4_11f2:		sta wCurrOamSpecAddr			; 85 00
B4_11f4:		lda entitySpritesData_hi.w, y	; b9 70 93
B4_11f7:		sta wCurrOamSpecAddr+1			; 85 01
; $04 is number of times to run the below loop for sending to oam
B4_11f9:		ldy #$00		; a0 00
B4_11fb:		lda (wCurrOamSpecAddr), y	; b1 00
B4_11fd:		sta wNumEntityTiles			; 85 04
; 2nd byte... eg $a6(then -2) for man up-left from start
B4_11ff:		iny				; c8 
B4_1200:		lda (wCurrOamSpecAddr), y	; b1 00
B4_1202:		tay				; a8 
B4_1203:		lda entityTileLayouts_lo.w, y	; b9 b0 95
B4_1206:		sec				; 38 
B4_1207:		sbc #$02		; e9 02
B4_1209:		sta wEntityLayoutAddr			; 85 06
; eg $b4 for man up-left from start
B4_120b:		lda entityTileLayouts_hi.w, y	; b9 48 96
B4_120e:		sbc #$00		; e9 00
B4_1210:		sta wEntityLayoutAddr+1			; 85 07

B4_1212:		ldx wEntityOamLowerBound			; a6 d0
B4_1214:		cpx wEntityOamUpperBound			; e4 d3
B4_1216:		beq sendSpriteSpecTo_wOam@done

B4_1218:		ldy #$01		; a0 01
; loop based on val in $04
