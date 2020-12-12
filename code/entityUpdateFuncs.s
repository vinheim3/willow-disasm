
updateMagicEntities_body:
	ldx #FIRST_SCREEN_ENTITY_IDX-1
-	lda wEntitiesControlByte.w, x
	bpl +

	jsr updateMagicEntity
+	dex
	bpl -
	rts


updateScreenEntities_body:
	ldx #MAX_ENTITIES-1

; update entity if bit 7 set
-	lda wEntitiesControlByte.w, x
	bpl +

	jsr updateEntityX_todo

+	dex
	cpx #FIRST_SCREEN_ENTITY_IDX
	bcs -

	rts


updateEntityX_todo:
	lda wEntitiesY.w, x
	sta wEntitiesTempY.w, x
	lda wEntitiesX.w, x
	sta wEntitiesTempX.w, x

B5_0d78:		lda wEntities_3c0.w, x	; bd c0 03
B5_0d7b:		and #$10		; 29 10
B5_0d7d:		bne B5_0d98 ; d0 19

B5_0d7f:		lda wEntities_3c0.w, x	; bd c0 03
B5_0d82:		and #$08		; 29 08
B5_0d84:		bne B5_0d99 ; d0 13

B5_0d86:		lda wEntities_420.w, x	; bd 20 04
B5_0d89:		beq B5_0db9 ; f0 2e

B5_0d8b:		lda wEntities_3c0.w, x	; bd c0 03
B5_0d8e:		and #$60		; 29 60
B5_0d90:		bne B5_0db5 ; d0 23

B5_0d92:		ldy wEntities_3d8.w, x	; bc d8 03
B5_0d95:		jsr func_5_306a		; 20 6a b0
B5_0d98:		rts				; 60 

B5_0d99:		lda wEntities_3c0.w, x	; bd c0 03
B5_0d9c:		and #$f7		; 29 f7
B5_0d9e:		ora #$04		; 09 04
B5_0da0:		sta wEntities_3c0.w, x	; 9d c0 03
B5_0da3:		jsr $b0d0		; 20 d0 b0
B5_0da6:		eor #$10		; 49 10
B5_0da8:		sta wEntities_408.w, x	; 9d 08 04
B5_0dab:		rts				; 60 

B5_0dac:		jsr func_5_3067		; 20 67 b0
B5_0daf:		bcc B5_0d98 ; 90 e7

B5_0db1:		lsr wEntitiesControlByte.w, x	; 5e 00 03
B5_0db4:		rts				; 60 

B5_0db5:		and #$20		; 29 20
B5_0db7:		bne B5_0d98 ; d0 df

updateMagicEntity:
B5_0db9:		lda wEntities_3c0.w, x	; bd c0 03
B5_0dbc:		and #$04		; 29 04
B5_0dbe:		bne B5_0dac ; d0 ec

	ldy wEntitiesId.w, x
	lda entityUpdateFuncs_lo.w, y
	sta wGenericWord
	lda entityUpdateFuncs_hi.w, y
	sta wGenericWord+1
	jmp (wGenericWord)


entityUpdateFuncs_lo:
	.db <enUpdateStub
	.db <entityUpdate01
	.db <entityUpdate02
	.db <entityUpdate03
	.db <entityUpdate04
	.db <entityUpdate05
	.db <enUpdateStub
	.db <entityUpdate07
	.db <entityUpdate08
	.db <entityUpdate09
	.db <entityUpdate0a
	.db <entityUpdate0b
	.db <entityUpdate0c
	.db <entityUpdate0d
	.db <entityUpdate0e
	.db <entityUpdate0f
	.db <entityUpdate10
	.db <entityUpdate11
	.db <entityUpdate12
	.db <entityUpdate13
	.db <entityUpdate14
	.db <entityUpdate15
	.db <entityUpdate16
	.db <entityUpdate17
	.db <entityUpdate18
	.db <entityUpdate19
	.db <entityUpdate1a
	.db <entityUpdate1b
	.db <entityUpdate1c
	.db <entityUpdate1d
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <entityUpdate21
	.db <entityUpdate22
	.db <entityUpdate23
	.db <enUpdateStub
	.db <entityUpdate25
	.db <enUpdateStub
	.db <entityUpdate27
	.db <entityUpdate28
	.db <entityUpdate29
	.db <entityUpdate2a
	.db <entityUpdate2b
	.db <entityUpdate2c
	.db <entityUpdate2d
	.db <enUpdateStub
	.db <entityUpdate2f
	.db <entityUpdate30
	.db <entityUpdate31
	.db <entityUpdate32
	.db <entityUpdate33
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <entityUpdate37
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <entityUpdate57
	.db <entityUpdate58
	.db <entityUpdate59
	.db <entityUpdate5a
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <entityUpdate5f
	.db <enUpdateStub
	.db <entityUpdate61
	.db <entityUpdate62
	.db <entityUpdate63
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub
	.db <entityUpdate68
	.db <entityUpdate69
	.db <entityUpdate6a
	.db <entityUpdate6b
	.db <entityUpdate6c
	.db <entityUpdate6d
	.db <entityUpdate6e
	.db <entityUpdate6f
	.db <entityUpdate70
	.db <entityUpdate71
	.db <entityUpdate72
	.db <entityUpdate73
	.db <entityUpdate74
	.db <enUpdateStub
	.db <entityUpdate76
	.db <entityUpdate77
	.db <entityUpdate78
	.db <entityUpdate79
	.db <entityUpdate7a
	.db <entityUpdate7b
	.db <enUpdateStub
	.db <entityUpdate7d
	.db <entityUpdate7e
	.db <entityUpdate7f
	.db <entityUpdate80
	.db <enUpdateStub
	.db <entityUpdate82
	.db <entityUpdate83
	.db <entityUpdate84
	.db <entityUpdate85
	.db <enUpdateStub
	.db <entityUpdate87
	.db <enUpdateStub
	.db <entityUpdate89
	.db <entityUpdate8a
	.db <enUpdateStub2
	.db <entityUpdate8c
	.db <entityUpdate8d
	.db <enUpdateStub
	.db <enUpdateStub
	.db <entityUpdate90
	.db <entityUpdate91
	.db <entityUpdate92
	.db <entityUpdate93
	.db <enUpdateStub
	.db <enUpdateStub
	.db <entityUpdate96
	.db <entityUpdate97
	.db <entityUpdate98
	.db <entityUpdate99
	.db <entityUpdate9a
	.db <entityUpdate9b
	.db <enUpdateStub
	.db <entityUpdate9d
	.db <entityUpdate9e
	.db <enUpdateStub
	.db <enUpdateStub
	.db <enUpdateStub

.rept 14
	.db <enUpdateStub
.endr


entityUpdateFuncs_hi:
	.db >enUpdateStub
	.db >entityUpdate01
	.db >entityUpdate02
	.db >entityUpdate03
	.db >entityUpdate04
	.db >entityUpdate05
	.db >enUpdateStub
	.db >entityUpdate07
	.db >entityUpdate08
	.db >entityUpdate09
	.db >entityUpdate0a
	.db >entityUpdate0b
	.db >entityUpdate0c
	.db >entityUpdate0d
	.db >entityUpdate0e
	.db >entityUpdate0f
	.db >entityUpdate10
	.db >entityUpdate11
	.db >entityUpdate12
	.db >entityUpdate13
	.db >entityUpdate14
	.db >entityUpdate15
	.db >entityUpdate16
	.db >entityUpdate17
	.db >entityUpdate18
	.db >entityUpdate19
	.db >entityUpdate1a
	.db >entityUpdate1b
	.db >entityUpdate1c
	.db >entityUpdate1d
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >entityUpdate21
	.db >entityUpdate22
	.db >entityUpdate23
	.db >enUpdateStub
	.db >entityUpdate25
	.db >enUpdateStub
	.db >entityUpdate27
	.db >entityUpdate28
	.db >entityUpdate29
	.db >entityUpdate2a
	.db >entityUpdate2b
	.db >entityUpdate2c
	.db >entityUpdate2d
	.db >enUpdateStub
	.db >entityUpdate2f
	.db >entityUpdate30
	.db >entityUpdate31
	.db >entityUpdate32
	.db >entityUpdate33
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >entityUpdate37
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >entityUpdate57
	.db >entityUpdate58
	.db >entityUpdate59
	.db >entityUpdate5a
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >entityUpdate5f
	.db >enUpdateStub
	.db >entityUpdate61
	.db >entityUpdate62
	.db >entityUpdate63
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub
	.db >entityUpdate68
	.db >entityUpdate69
	.db >entityUpdate6a
	.db >entityUpdate6b
	.db >entityUpdate6c
	.db >entityUpdate6d
	.db >entityUpdate6e
	.db >entityUpdate6f
	.db >entityUpdate70
	.db >entityUpdate71
	.db >entityUpdate72
	.db >entityUpdate73
	.db >entityUpdate74
	.db >enUpdateStub
	.db >entityUpdate76
	.db >entityUpdate77
	.db >entityUpdate78
	.db >entityUpdate79
	.db >entityUpdate7a
	.db >entityUpdate7b
	.db >enUpdateStub
	.db >entityUpdate7d
	.db >entityUpdate7e
	.db >entityUpdate7f
	.db >entityUpdate80
	.db >enUpdateStub
	.db >entityUpdate82
	.db >entityUpdate83
	.db >entityUpdate84
	.db >entityUpdate85
	.db >enUpdateStub
	.db >entityUpdate87
	.db >enUpdateStub
	.db >entityUpdate89
	.db >entityUpdate8a
	.db >enUpdateStub2
	.db >entityUpdate8c
	.db >entityUpdate8d
	.db >enUpdateStub
	.db >enUpdateStub
	.db >entityUpdate90
	.db >entityUpdate91
	.db >entityUpdate92
	.db >entityUpdate93
	.db >enUpdateStub
	.db >enUpdateStub
	.db >entityUpdate96
	.db >entityUpdate97
	.db >entityUpdate98
	.db >entityUpdate99
	.db >entityUpdate9a
	.db >entityUpdate9b
	.db >enUpdateStub
	.db >entityUpdate9d
	.db >entityUpdate9e
	.db >enUpdateStub
	.db >enUpdateStub
	.db >enUpdateStub


enUpdateStub:
	rts


entityUpdate04:
entityUpdate05:
B5_0f23:		lda wEntitiesState.w, x	; bd f0 03
B5_0f26:		jsr jumpTable		; 20 3d c2
	.dw $8f33
	.dw $8f54
	.dw $8f78
	.dw $8f78
	.dw $8f78

B5_0f33:		dec wEntities_378.w, x	; de 78 03
B5_0f36:		bne B5_0f82 ; d0 4a

B5_0f38:		lda #$05		; a9 05
B5_0f3a:		jsr $b052		; 20 52 b0
B5_0f3d:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_0f40:		ora #$05		; 09 05
B5_0f42:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_0f45:		inc wEntitiesState.w, x	; fe f0 03
B5_0f48:		jsr getNewRandomVal		; 20 8a c4
B5_0f4b:		and #$03		; 29 03
B5_0f4d:		tay				; a8 
B5_0f4e:		lda $8f99, y	; b9 99 8f
B5_0f51:		sta wEntities_378.w, x	; 9d 78 03
B5_0f54:		dec wEntities_378.w, x	; de 78 03
B5_0f57:		bne B5_0f82 ; d0 29

B5_0f59:		jsr $b0d0		; 20 d0 b0
B5_0f5c:		jsr $b038		; 20 38 b0
B5_0f5f:		lda wEntitiesState.w, x	; bd f0 03
B5_0f62:		cmp #$04		; c9 04
B5_0f64:		beq B5_0f92 ; f0 2c

B5_0f66:		inc wEntitiesState.w, x	; fe f0 03
B5_0f69:		ldy wEntitiesState.w, x	; bc f0 03
B5_0f6c:		lda $8f9b, y	; b9 9b 8f
B5_0f6f:		sta wEntities_378.w, x	; 9d 78 03
B5_0f72:		lda $8f9e, y	; b9 9e 8f
B5_0f75:		jsr $b045		; 20 45 b0
B5_0f78:		dec wEntities_378.w, x	; de 78 03
B5_0f7b:		beq B5_0f5f ; f0 e2

B5_0f7d:		jsr func_5_3067		; 20 67 b0
B5_0f80:		bcs B5_0f92 ; b0 10

B5_0f82:		lda wEntities_438.w, x	; bd 38 04
B5_0f85:		tay				; a8 
B5_0f86:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_0f89:		and #$bf		; 29 bf
B5_0f8b:		ora $8fa3, y	; 19 a3 8f
B5_0f8e:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_0f91:		rts				; 60 


B5_0f92:		lda #$01		; a9 01
B5_0f94:		sta wEntitiesState.w, x	; 9d f0 03
B5_0f97:		bne B5_0f48 ; d0 af

B5_0f99:	.db $1f
B5_0f9a:		eor $1f9b, x	; 5d 9b 1f
B5_0f9d:	.db $1f
B5_0f9e:	.db $0f
B5_0f9f:	.db $54
B5_0fa0:		cpx #$c0		; e0 c0
B5_0fa2:	.db $80
B5_0fa3:		.db $00				; 00
B5_0fa4:		.db $00				; 00
B5_0fa5:		.db $00				; 00
B5_0fa6:		.db $00				; 00
B5_0fa7:		.db $00				; 00
B5_0fa8:		rti				; 40 


B5_0fa9:		rti				; 40 


B5_0faa:		rti				; 40 


entityUpdate0f:
entityUpdate10:
entityUpdate11:
B5_0fab:		lda wEntitiesState.w, x	; bd f0 03
B5_0fae:		bne B5_0fcb ; d0 1b

B5_0fb0:		lda wEntities_3a8.w, x	; bd a8 03
B5_0fb3:		cmp #$04		; c9 04
B5_0fb5:		bcc B5_0fe6 ; 90 2f

B5_0fb7:		cmp #$18		; c9 18
B5_0fb9:		bcc B5_0fbf ; 90 04

B5_0fbb:		cmp #$1e		; c9 1e
B5_0fbd:		bcc B5_0fe6 ; 90 27

B5_0fbf:		lda #$00		; a9 00
B5_0fc1:		sta $72			; 85 72
B5_0fc3:		lda #$29		; a9 29
B5_0fc5:		jsr queueSoundAtoPlay		; 20 ad c4
B5_0fc8:		inc wEntitiesState.w, x	; fe f0 03
B5_0fcb:		lda wEntitiesState.w, x	; bd f0 03
B5_0fce:		cmp #$01		; c9 01
B5_0fd0:		bne B5_0fe5 ; d0 13

B5_0fd2:		lda wEntities_438.w, x	; bd 38 04
B5_0fd5:		cmp #$03		; c9 03
B5_0fd7:		bne B5_0fe5 ; d0 0c

B5_0fd9:		lda wEntitiesY.w, x	; bd 80 04
B5_0fdc:		sec				; 38 
B5_0fdd:		sbc #$08		; e9 08
B5_0fdf:		sta wEntitiesY.w, x	; 9d 80 04
B5_0fe2:		inc wEntitiesState.w, x	; fe f0 03
B5_0fe5:		rts				; 60 


B5_0fe6:		lda wEntities_390.w, x	; bd 90 03
B5_0fe9:		and #$1f		; 29 1f
B5_0feb:		tay				; a8 
B5_0fec:		lda #$00		; a9 00
B5_0fee:		sta wEntitiesControlByte.w, y	; 99 00 03
B5_0ff1:		beq B5_0fbf ; f0 cc

entityUpdate13:
entityUpdate14:
entityUpdate15:
entityUpdate16:
B5_0ff3:		lda wEntitiesState.w, x	; bd f0 03
B5_0ff6:		jsr jumpTable		; 20 3d c2
	.dw $8fff
	.dw $901d
	.dw $903b

B5_0fff:		lda wEntitiesX.w, x
B5_1002:		cmp #$b8		; c9 b8
B5_1004:		bcs B5_104c ; b0 46

B5_1006:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1009:		ora #$08		; 09 08
B5_100b:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_100e:		lda #$02		; a9 02
B5_1010:		sta wEntities_438.w, x	; 9d 38 04
B5_1013:		lda $6c			; a5 6c
B5_1015:		ora #$80		; 09 80
B5_1017:		sta $6c			; 85 6c
B5_1019:		inc wEntitiesState.w, x	; fe f0 03
B5_101c:		rts				; 60 


B5_101d:		lda $6c			; a5 6c
B5_101f:		and #$40		; 29 40
B5_1021:		bne B5_1024 ; d0 01

B5_1023:		rts				; 60 


B5_1024:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1027:		ora #$40		; 09 40
B5_1029:		and #$f7		; 29 f7
B5_102b:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_102e:		lda #$08		; a9 08
B5_1030:		jsr $b038		; 20 38 b0
B5_1033:		lda #$1f		; a9 1f
B5_1035:		sta wEntities_378.w, x	; 9d 78 03
B5_1038:		inc wEntitiesState.w, x	; fe f0 03
B5_103b:		lda wEntitiesX.w, x	; bd b0 04
B5_103e:		cmp #$d8		; c9 d8
B5_1040:		bcc B5_104c ; 90 0a

B5_1042:		lda $6c			; a5 6c
B5_1044:		ora #$20		; 09 20
B5_1046:		sta $6c			; 85 6c
B5_1048:		lsr wEntitiesControlByte.w, x	; 5e 00 03
B5_104b:		rts				; 60 


B5_104c:		jsr func_5_3067		; 20 67 b0
B5_104f:		rts				; 60 


entityUpdate5f:
B5_1050:		lda $6c			; a5 6c
B5_1052:		bpl B5_1059 ; 10 05

B5_1054:		lda #$01		; a9 01
B5_1056:		sta wEntities_438.w, x	; 9d 38 04
B5_1059:		rts				; 60 


entityUpdate0c:
entityUpdate0d:
B5_105a:		lda wEntitiesState.w, x	; bd f0 03
B5_105d:		jsr jumpTable		; 20 3d c2
	.dw $9066
	.dw $90b2
	.dw $90c5
B5_1066:		jsr $b13e
B5_1069:		beq B5_109d
B5_106b:		lda wEntities_390.w, x	; bd 90 03
B5_106e:		and #$40		; 29 40
B5_1070:		bne B5_107f ; d0 0d

B5_1072:		ldy #$02		; a0 02
B5_1074:		jsr getNewRandomVal		; 20 8a c4
B5_1077:		and #$01		; 29 01
B5_1079:		beq B5_108a ; f0 0f

B5_107b:		ldy #$1e		; a0 1e
B5_107d:		bne B5_108a ; d0 0b

B5_107f:		ldy #$0e		; a0 0e
B5_1081:		jsr getNewRandomVal		; 20 8a c4
B5_1084:		and #$01		; 29 01
B5_1086:		beq B5_108a ; f0 02

B5_1088:		ldy #$12		; a0 12
B5_108a:		tya				; 98 
B5_108b:		jsr $b038		; 20 38 b0
B5_108e:		lda #$40		; a9 40
B5_1090:		jsr $b045		; 20 45 b0
B5_1093:		lda #$1f		; a9 1f
B5_1095:		sta wEntities_378.w, x	; 9d 78 03
B5_1098:		lda #$01		; a9 01
B5_109a:		sta wEntitiesState.w, x	; 9d f0 03
B5_109d:		ldy #$0c		; a0 0c
B5_109f:		lda wPlayerY			; a5 cc
B5_10a1:		cmp wEntitiesY.w, x	; dd 80 04
B5_10a4:		bcs B5_10a8 ; b0 02

B5_10a6:		ldy #$0d		; a0 0d
B5_10a8:		tya				; 98 
B5_10a9:		sta wEntitiesId.w, x	; 9d 18 03
B5_10ac:		jsr func_5_3067		; 20 67 b0
B5_10af:		bcs B5_10b7 ; b0 06

B5_10b1:		rts				; 60 


B5_10b2:		dec wEntities_378.w, x	; de 78 03
B5_10b5:		bne B5_109d ; d0 e6

B5_10b7:		lda #$60		; a9 60
B5_10b9:		jsr $b045		; 20 45 b0
B5_10bc:		jsr $b107		; 20 07 b1
B5_10bf:		lda #$00		; a9 00
B5_10c1:		sta wEntitiesState.w, x	; 9d f0 03
B5_10c4:		rts				; 60 


B5_10c5:		jsr $90bc		; 20 bc 90
B5_10c8:		jsr $906b		; 20 6b 90
B5_10cb:		rts				; 60 


entityUpdate0e:
B5_10cc:		lda wEntitiesState.w, x	; bd f0 03
B5_10cf:		bne B5_10d8 ; d0 07

B5_10d1:		lda #$00		; a9 00
B5_10d3:		sta $87			; 85 87
B5_10d5:		inc wEntitiesState.w, x	; fe f0 03
B5_10d8:		lda wEntitiesState.w, x	; bd f0 03
B5_10db:		cmp #$02		; c9 02
B5_10dd:		beq B5_111a ; f0 3b

B5_10df:		lda $87			; a5 87
B5_10e1:		cmp #$ff		; c9 ff
B5_10e3:		beq B5_1122 ; f0 3d

B5_10e5:		lda #$0c		; a9 0c
B5_10e7:		jsr $b0e6		; 20 e6 b0
B5_10ea:		bcs B5_1122 ; b0 36

B5_10ec:		lda #$0d		; a9 0d
B5_10ee:		jsr $b0e6		; 20 e6 b0
B5_10f1:		bcs B5_1122 ; b0 2f

B5_10f3:		lda wEntities_378.w, x	; bd 78 03
B5_10f6:		bne B5_110c ; d0 14

B5_10f8:		jsr getNewRandomVal		; 20 8a c4
B5_10fb:		and #$03		; 29 03
B5_10fd:		beq B5_10f8 ; f0 f9

B5_10ff:		tay				; a8 
B5_1100:		lda $9122, y	; b9 22 91
B5_1103:		sta wEntities_378.w, x	; 9d 78 03
B5_1106:		jsr $b0d0		; 20 d0 b0
B5_1109:		jsr $b038		; 20 38 b0
B5_110c:		dec wEntities_378.w, x	; de 78 03
B5_110f:		jsr func_5_3067		; 20 67 b0
B5_1112:		lda wPlayerX			; a5 ce
B5_1114:		cmp wEntitiesX.w, x	; dd b0 04
B5_1117:		beq B5_1126 ; f0 0d

B5_1119:		rts				; 60 


B5_111a:		dec wEntities_378.w, x	; de 78 03
B5_111d:		beq B5_117c ; f0 5d

B5_111f:		jsr func_5_3067		; 20 67 b0
B5_1122:		rts				; 60 


B5_1123:	.db $3c
B5_1124:	.db $14
B5_1125:		php				; 08 
B5_1126:		lda #$00		; a9 00
B5_1128:		sta $f1			; 85 f1
B5_112a:		sta $89			; 85 89
B5_112c:		lda #$ff		; a9 ff
B5_112e:		sta $87			; 85 87
B5_1130:		lda wEntityDataByte1			; a5 51
B5_1132:		and #$18		; 29 18
B5_1134:		lsr a			; 4a
B5_1135:		lsr a			; 4a
B5_1136:		lsr a			; 4a
B5_1137:		clc				; 18 
B5_1138:		adc #$6f		; 69 6f
B5_113a:		jsr $b268		; 20 68 b2
B5_113d:		ldy $f0			; a4 f0
B5_113f:		lda wEntitiesY.w, x	; bd 80 04
B5_1142:		sta wEntities_390.w, y	; 99 90 03
B5_1145:		lda wEntitiesX.w, x	; bd b0 04
B5_1148:		sta wEntities_3a8.w, y	; 99 a8 03
B5_114b:		txa				; 8a 
B5_114c:		pha				; 48 
B5_114d:		ldx $f1			; a6 f1
B5_114f:		lda $91f7, x	; bd f7 91
B5_1152:		sta wEntities_408.w, y	; 99 08 04
B5_1155:		lda #$02		; a9 02
B5_1157:		sta wEntitiesState.w, y	; 99 f0 03
B5_115a:		lda #$3f		; a9 3f
B5_115c:		sta wEntities_378.w, y	; 99 78 03
B5_115f:		lda wEntitiesControlByte.w, y	; b9 00 03
B5_1162:		and #$f0		; 29 f0
B5_1164:		sta wEntitiesControlByte.w, y	; 99 00 03
B5_1167:		lda #$ff		; a9 ff
B5_1169:		sta wEntities_330.w, y	; 99 30 03
B5_116c:		pla				; 68 
B5_116d:		tax				; aa 
B5_116e:		lda $f1			; a5 f1
B5_1170:		inc $f1			; e6 f1
B5_1172:		cmp #$03		; c9 03
B5_1174:		bne B5_1130 ; d0 ba

B5_1176:		lda #$00		; a9 00
B5_1178:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_117b:		rts				; 60 


B5_117c:		lda #$00		; a9 00
B5_117e:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1181:		inc $89			; e6 89
B5_1183:		lda $89			; a5 89
B5_1185:		cmp #$04		; c9 04
B5_1187:		bne B5_11f6 ; d0 6d

B5_1189:		lda #$00		; a9 00
B5_118b:		sta $87			; 85 87
B5_118d:		lda wEntities_390.w, x	; bd 90 03
B5_1190:		sta wEntitiesY.w, x	; 9d 80 04
B5_1193:		lda wEntities_3a8.w, x	; bd a8 03
B5_1196:		sta wEntitiesX.w, x	; 9d b0 04
B5_1199:		lda wEntityDataByte1			; a5 51
B5_119b:		and #$18		; 29 18
B5_119d:		lsr a			; 4a
B5_119e:		lsr a			; 4a
B5_119f:		lsr a			; 4a
B5_11a0:		clc				; 18 
B5_11a1:		adc #$72		; 69 72
B5_11a3:		jsr initNpcSpecAIdxX		; 20 ec c3
B5_11a6:		lda #$60		; a9 60
B5_11a8:		jsr $b045		; 20 45 b0
B5_11ab:		jsr $b107		; 20 07 b1
B5_11ae:		lda wPlayerY			; a5 cc
B5_11b0:		cmp wEntitiesY.w, x	; dd 80 04
B5_11b3:		bcs B5_11b8 ; b0 03

B5_11b5:		inc wEntitiesId.w, x	; fe 18 03
B5_11b8:		lda #$13		; a9 13
B5_11ba:		sta $f2			; 85 f2
B5_11bc:		lda #$00		; a9 00
B5_11be:		sta $f1			; 85 f1
B5_11c0:		lda $f2			; a5 f2
B5_11c2:		jsr $b268		; 20 68 b2
B5_11c5:		txa				; 8a 
B5_11c6:		pha				; 48 
B5_11c7:		ldx $f1			; a6 f1
B5_11c9:		ldy $f0			; a4 f0
B5_11cb:		lda $91fb, x	; bd fb 91
B5_11ce:		sta wEntities_408.w, y	; 99 08 04
B5_11d1:		lda wEntitiesY.w, y	; b9 80 04
B5_11d4:		clc				; 18 
B5_11d5:		adc $91ff, x	; 7d ff 91
B5_11d8:		sta wEntitiesY.w, y	; 99 80 04
B5_11db:		lda wEntitiesX.w, y	; b9 b0 04
B5_11de:		clc				; 18 
B5_11df:		adc $9203, x	; 7d 03 92
B5_11e2:		sta wEntitiesX.w, y	; 99 b0 04
B5_11e5:		lda #$08		; a9 08
B5_11e7:		sta wEntities_378.w, y	; 99 78 03
B5_11ea:		pla				; 68 
B5_11eb:		tax				; aa 
B5_11ec:		lda $f1			; a5 f1
B5_11ee:		inc $f1			; e6 f1
B5_11f0:		inc $f2			; e6 f2
B5_11f2:		cmp #$03		; c9 03
B5_11f4:		bne B5_11c0 ; d0 ca

B5_11f6:		rts				; 60 


B5_11f7:		cpx $ec			; e4 ec
B5_11f9:	.db $f4
B5_11fa:	.db $fc
B5_11fb:	.db $3c
B5_11fc:	.db $34
B5_11fd:		bit $2c			; 24 2c
B5_11ff:	.db $fc
B5_1200:	.db $04
B5_1201:	.db $fc
B5_1202:	.db $04
B5_1203:	.db $fc
B5_1204:	.db $fc
B5_1205:	.db $04
B5_1206:	.db $04


entityUpdate07:
entityUpdate08:
entityUpdate17:
B5_1207:		lda $6c			; a5 6c
B5_1209:		bpl B5_123a ; 10 2f

B5_120b:		lda $68			; a5 68
B5_120d:		bmi B5_123b ; 30 2c

B5_120f:		cmp #$02		; c9 02
B5_1211:		beq B5_1232 ; f0 1f

B5_1213:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1216:		and #$ef		; 29 ef
B5_1218:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_121b:		lda wEntities_438.w, x	; bd 38 04
B5_121e:		and #$01		; 29 01
B5_1220:		bne B5_123a ; d0 18

B5_1222:		inc wEntities_450.w, x	; fe 50 04
B5_1225:		lda wEntities_450.w, x	; bd 50 04
B5_1228:		and #$07		; 29 07
B5_122a:		sta wEntities_450.w, x	; 9d 50 04
B5_122d:		bne B5_1232 ; d0 03

B5_122f:		inc wEntities_438.w, x	; fe 38 04
B5_1232:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1235:		ora #$10		; 09 10
B5_1237:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_123a:		rts				; 60 


B5_123b:		lsr wEntitiesControlByte.w, x	; 5e 00 03
B5_123e:		rts				; 60 


entityUpdate21:
entityUpdate22:
entityUpdate23:
B5_123f:		jsr func_5_323f		; 20 3f b2
B5_1242:		beq B5_1245 ; f0 01

B5_1244:		rts				; 60 


B5_1245:		lda wEntitiesState.w, x	; bd f0 03
B5_1248:		jsr jumpTable		; 20 3d c2
	.dw $9257
	.dw $928c
	.dw $92a5
	.dw $92c5
	.dw $930e
	.dw $931f
B5_1257:		lda wEntities_3c0.w, x	; bd c0 03
B5_125a:		ora #$c0		; 09 c0
B5_125c:		sta wEntities_3c0.w, x	; 9d c0 03
B5_125f:		lda wEntitiesY.w, x	; bd 80 04
B5_1262:		sec				; 38 
B5_1263:		sbc $cc			; e5 cc
B5_1265:		bcs B5_126c ; b0 05

B5_1267:		eor #$ff		; 49 ff
B5_1269:		clc				; 18 
B5_126a:		adc #$01		; 69 01
B5_126c:		cmp #$20		; c9 20
B5_126e:		bcc B5_1271 ; 90 01

B5_1270:		rts				; 60 


B5_1271:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1274:		and #$ef		; 29 ef
B5_1276:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1279:		lda #$d5		; a9 d5
B5_127b:		sta wEntities_330.w, x	; 9d 30 03
B5_127e:		jsr $b12e		; 20 2e b1
B5_1281:		jsr $9361		; 20 61 93
B5_1284:		inc wEntitiesState.w, x	; fe f0 03
B5_1287:		lda #$0d		; a9 0d
B5_1289:		jsr $b268		; 20 68 b2
B5_128c:		jsr $b13e		; 20 3e b1
B5_128f:		bne B5_1295 ; d0 04

B5_1291:		jsr func_5_3067		; 20 67 b0
B5_1294:		rts				; 60 


B5_1295:		lda #$9b		; a9 9b
B5_1297:		sta wEntities_378.w, x	; 9d 78 03
B5_129a:		lda wEntities_3c0.w, x	; bd c0 03
B5_129d:		ora #$80		; 09 80
B5_129f:		sta wEntities_3c0.w, x	; 9d c0 03
B5_12a2:		inc wEntitiesState.w, x	; fe f0 03
B5_12a5:		dec wEntities_378.w, x	; de 78 03
B5_12a8:		beq B5_12ab ; f0 01

B5_12aa:		rts				; 60 


B5_12ab:		lda #$80		; a9 80
B5_12ad:		jsr $b045		; 20 45 b0
B5_12b0:		lda #$f8		; a9 f8
B5_12b2:		sta wEntities_378.w, x	; 9d 78 03
B5_12b5:		lda wEntities_3c0.w, x	; bd c0 03
B5_12b8:		and #$7f		; 29 7f
B5_12ba:		sta wEntities_3c0.w, x	; 9d c0 03
B5_12bd:		lda #$00		; a9 00
B5_12bf:		sta wEntities_438.w, x	; 9d 38 04
B5_12c2:		inc wEntitiesState.w, x	; fe f0 03
B5_12c5:		ldy #$22		; a0 22
B5_12c7:		lda wPlayerY			; a5 cc
B5_12c9:		cmp wEntitiesY.w, x	; dd 80 04
B5_12cc:		bcs B5_12d0 ; b0 02

B5_12ce:		ldy #$23		; a0 23
B5_12d0:		tya				; 98 
B5_12d1:		sta wEntitiesId.w, x	; 9d 18 03
B5_12d4:		dec wEntities_378.w, x	; de 78 03
B5_12d7:		beq B5_12f9 ; f0 20

B5_12d9:		lda wEntities_378.w, x	; bd 78 03
B5_12dc:		cmp #$7a		; c9 7a
B5_12de:		bne B5_1338 ; d0 58

B5_12e0:		lda #$b2		; a9 b2
B5_12e2:		jsr $b268		; 20 68 b2
B5_12e5:		txa				; 8a 
B5_12e6:		pha				; 48 
B5_12e7:		ldx $f0			; a6 f0
B5_12e9:		jsr $b0d0		; 20 d0 b0
B5_12ec:		jsr $b038		; 20 38 b0
B5_12ef:		lda #$a0		; a9 a0
B5_12f1:		jsr $b045		; 20 45 b0
B5_12f4:		pla				; 68 
B5_12f5:		tax				; aa 
B5_12f6:		jmp $9338		; 4c 38 93


B5_12f9:		lda #$7c		; a9 7c
B5_12fb:		sta wEntities_378.w, x	; 9d 78 03
B5_12fe:		lda #$21		; a9 21
B5_1300:		jsr $b052		; 20 52 b0
B5_1303:		lda wEntities_3c0.w, x	; bd c0 03
B5_1306:		ora #$80		; 09 80
B5_1308:		sta wEntities_3c0.w, x	; 9d c0 03
B5_130b:		inc wEntitiesState.w, x	; fe f0 03
B5_130e:		dec wEntities_378.w, x	; de 78 03
B5_1311:		beq B5_1314 ; f0 01

B5_1313:		rts				; 60 


B5_1314:		jsr $b107		; 20 07 b1
B5_1317:		lda #$20		; a9 20
B5_1319:		jsr $b045		; 20 45 b0
B5_131c:		inc wEntitiesState.w, x	; fe f0 03
B5_131f:		jsr $b13e		; 20 3e b1
B5_1322:		beq B5_1338 ; f0 14

B5_1324:		jsr $9361		; 20 61 93
B5_1327:		lda wEntities_3c0.w, x	; bd c0 03
B5_132a:		and #$7f		; 29 7f
B5_132c:		sta wEntities_3c0.w, x	; 9d c0 03
B5_132f:		lda #$02		; a9 02
B5_1331:		sta wEntitiesState.w, x	; 9d f0 03
B5_1334:		jsr $92ab		; 20 ab 92
B5_1337:		rts				; 60 


B5_1338:		jsr $b1a6		; 20 a6 b1
B5_133b:		bcs B5_1345 ; b0 08

B5_133d:		jsr storeCoordsOfTileUnderEntity		; 20 18 b2
B5_1340:		jsr $b1b4		; 20 b4 b1
B5_1343:		beq B5_1360 ; f0 1b

B5_1345:		lda wEntities_408.w, x	; bd 08 04
B5_1348:		eor #$10		; 49 10
B5_134a:		and #$f0		; 29 f0
B5_134c:		ora #$08		; 09 08
B5_134e:		jsr $b038		; 20 38 b0
B5_1351:		lda wEntitiesId.w, x	; bd 18 03
B5_1354:		cmp #$21		; c9 21
B5_1356:		bne B5_1360 ; d0 08

B5_1358:		lda #$02		; a9 02
B5_135a:		sta wEntitiesState.w, x	; 9d f0 03
B5_135d:		jmp $92ab		; 4c ab 92


B5_1360:		rts				; 60 


B5_1361:		ldy #$08		; a0 08
B5_1363:		lda wPlayerX			; a5 ce
B5_1365:		cmp wEntitiesX.w, x	; dd b0 04
B5_1368:		bcs B5_136c ; b0 02

B5_136a:		ldy #$18		; a0 18
B5_136c:		tya				; 98 
B5_136d:		jsr $b038		; 20 38 b0
B5_1370:		rts				; 60 


entityUpdate89:
B5_1371:		jsr func_5_31cb		; 20 cb b1
B5_1374:		jsr func_5_3067		; 20 67 b0
B5_1377:		bcc B5_137e ; 90 05

B5_1379:		lda #$00		; a9 00
B5_137b:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_137e:		rts				; 60 


entityUpdate25:
B5_137f:		jsr func_5_323f		; 20 3f b2
B5_1382:		beq B5_1385 ; f0 01

B5_1384:		rts				; 60 


B5_1385:		lda wEntitiesState.w, x	; bd f0 03
B5_1388:		jsr jumpTable		; 20 3d c2
	.dw $9393
	.dw $93a0
	.dw $93f8
	.dw $9412
B5_1393:		lda wEntities_3c0.w, x
B5_1396:		ora #$40		; 09 40
B5_1398:		sta wEntities_3c0.w, x	; 9d c0 03
B5_139b:		lda #$01		; a9 01
B5_139d:		sta wEntitiesState.w, x	; 9d f0 03
B5_13a0:		jsr $b12e		; 20 2e b1
B5_13a3:		ldy #$18		; a0 18
B5_13a5:		lda wPlayerX			; a5 ce
B5_13a7:		cmp wEntitiesX.w, x	; dd b0 04
B5_13aa:		bcc B5_13ae ; 90 02

B5_13ac:		ldy #$08		; a0 08
B5_13ae:		tya				; 98 
B5_13af:		jsr $b038		; 20 38 b0
B5_13b2:		jsr $9451		; 20 51 94
B5_13b5:		lda wEntitiesY.w, x	; bd 80 04
B5_13b8:		sec				; 38 
B5_13b9:		sbc $cc			; e5 cc
B5_13bb:		bcs B5_13c2 ; b0 05

B5_13bd:		eor #$ff		; 49 ff
B5_13bf:		clc				; 18 
B5_13c0:		adc #$01		; 69 01
B5_13c2:		cmp #$54		; c9 54
B5_13c4:		bcc B5_13e9 ; 90 23

B5_13c6:		jsr $945b		; 20 5b 94
B5_13c9:		lda wEntities_390.w, x	; bd 90 03
B5_13cc:		and #$c0		; 29 c0
B5_13ce:		cmp #$80		; c9 80
B5_13d0:		beq B5_13db ; f0 09

B5_13d2:		lda wPlayerX			; a5 ce
B5_13d4:		cmp wEntitiesX.w, x	; dd b0 04
B5_13d7:		bcs B5_13e2 ; b0 09

B5_13d9:		bcc B5_1441 ; 90 66

B5_13db:		lda wPlayerX			; a5 ce
B5_13dd:		cmp wEntitiesX.w, x	; dd b0 04
B5_13e0:		bcs B5_1441 ; b0 5f

B5_13e2:		lda wPlayerX			; a5 ce
B5_13e4:		sta wEntitiesX.w, x	; 9d b0 04
B5_13e7:		bne B5_1441 ; d0 58

B5_13e9:		lda #$1e		; a9 1e
B5_13eb:		sta wEntities_378.w, x	; 9d 78 03
B5_13ee:		lda #$20		; a9 20
B5_13f0:		jsr $b045		; 20 45 b0
B5_13f3:		lda #$02		; a9 02
B5_13f5:		sta wEntitiesState.w, x	; 9d f0 03
B5_13f8:		jsr $b0d0		; 20 d0 b0
B5_13fb:		jsr $b038		; 20 38 b0
B5_13fe:		dec wEntities_378.w, x	; de 78 03
B5_1401:		bne B5_143e ; d0 3b

B5_1403:		lda #$28		; a9 28
B5_1405:		sta wEntities_378.w, x	; 9d 78 03
B5_1408:		lda #$40		; a9 40
B5_140a:		jsr $b045		; 20 45 b0
B5_140d:		lda #$03		; a9 03
B5_140f:		sta wEntitiesState.w, x	; 9d f0 03
B5_1412:		jsr $b0d0		; 20 d0 b0
B5_1415:		cmp #$18		; c9 18
B5_1417:		bcs B5_142a ; b0 11

B5_1419:		cmp #$08		; c9 08
B5_141b:		bcc B5_142a ; 90 0d

B5_141d:		lda $f3			; a5 f3
B5_141f:		eor #$0f		; 49 0f
B5_1421:		clc				; 18 
B5_1422:		adc #$01		; 69 01
B5_1424:		bne B5_142a ; d0 04

B5_1426:		lda $f3			; a5 f3
B5_1428:		eor #$10		; 49 10
B5_142a:		jsr $b038		; 20 38 b0
B5_142d:		dec wEntities_378.w, x	; de 78 03
B5_1430:		bne B5_143e ; d0 0c

B5_1432:		lda #$60		; a9 60
B5_1434:		jsr $b045		; 20 45 b0
B5_1437:		lda #$01		; a9 01
B5_1439:		sta wEntitiesState.w, x	; 9d f0 03
B5_143c:		bne B5_1441 ; d0 03

B5_143e:		jsr $9451		; 20 51 94
B5_1441:		lda wEntitiesY.w, x	; bd 80 04
B5_1444:		cmp #$28		; c9 28
B5_1446:		bcs B5_144d ; b0 05

B5_1448:		lda #$28		; a9 28
B5_144a:		sta wEntitiesY.w, x	; 9d 80 04
B5_144d:		jsr func_5_31cb		; 20 cb b1
B5_1450:		rts				; 60 


B5_1451:		jsr $b1a6		; 20 a6 b1
B5_1454:		jsr storeCoordsOfTileUnderEntity		; 20 18 b2
B5_1457:		jsr $b1b4		; 20 b4 b1
B5_145a:		rts				; 60 


B5_145b:		lda $88			; a5 88
B5_145d:		beq B5_1463 ; f0 04

B5_145f:		dec $88			; c6 88
B5_1461:		bne B5_149d ; d0 3a

B5_1463:		inc wEntities_378.w, x	; fe 78 03
B5_1466:		lda wEntities_378.w, x	; bd 78 03
B5_1469:		and #$3f		; 29 3f
B5_146b:		sta wEntities_378.w, x	; 9d 78 03
B5_146e:		beq B5_149e ; f0 2e

B5_1470:		lda wEntities_378.w, x	; bd 78 03
B5_1473:		and #$0f		; 29 0f
B5_1475:		bne B5_149d ; d0 26

B5_1477:		lda wEntityDataByte1			; a5 51
B5_1479:		and #$18		; 29 18
B5_147b:		lsr a			; 4a
B5_147c:		lsr a			; 4a
B5_147d:		lsr a			; 4a
B5_147e:		clc				; 18 
B5_147f:		lda #$c6		; a9 c6
B5_1481:		jsr $b268		; 20 68 b2
B5_1484:		lda $f0			; a5 f0
B5_1486:		pha				; 48 
B5_1487:		jsr $b0d0		; 20 d0 b0
B5_148a:		pla				; 68 
B5_148b:		tay				; a8 
B5_148c:		lda #$00		; a9 00
B5_148e:		sta wEntities_408.w, y	; 99 08 04
B5_1491:		ora $f3			; 05 f3
B5_1493:		ora #$20		; 09 20
B5_1495:		sta wEntities_408.w, y	; 99 08 04
B5_1498:		lda #$04		; a9 04
B5_149a:		sta wEntities_3c0.w, y	; 99 c0 03
B5_149d:		rts				; 60 


B5_149e:		lda #$7e		; a9 7e
B5_14a0:		sta $88			; 85 88
B5_14a2:		rts				; 60 


entityUpdate63:
B5_14a3:		jsr func_5_323f		; 20 3f b2
B5_14a6:		beq B5_14b3 ; f0 0b

B5_14a8:		lda wEntities_420.w, x	; bd 20 04
B5_14ab:		cmp #$01		; c9 01
B5_14ad:		bne B5_14b2 ; d0 03

B5_14af:		jsr $94f2		; 20 f2 94
B5_14b2:		rts				; 60 


B5_14b3:		lda wEntitiesState.w, x	; bd f0 03
B5_14b6:		jsr jumpTable		; 20 3d c2
	.dw $94c1
	.dw $94cc
	.dw $93f8
	.dw $9412
B5_14c1:		lda wEntities_3c0.w, x
B5_14c4:		ora #$40		; 09 40
B5_14c6:		sta wEntities_3c0.w, x	; 9d c0 03
B5_14c9:		inc wEntitiesState.w, x	; fe f0 03
B5_14cc:		lda #$e0		; a9 e0
B5_14ce:		jsr $b045		; 20 45 b0
B5_14d1:		jsr $b0d0		; 20 d0 b0
B5_14d4:		jsr $b038		; 20 38 b0
B5_14d7:		jsr $9451		; 20 51 94
B5_14da:		lda wEntitiesY.w, x	; bd 80 04
B5_14dd:		sec				; 38 
B5_14de:		sbc $cc			; e5 cc
B5_14e0:		bcs B5_14e7 ; b0 05

B5_14e2:		eor #$ff		; 49 ff
B5_14e4:		clc				; 18 
B5_14e5:		adc #$01		; 69 01
B5_14e7:		cmp #$54		; c9 54
B5_14e9:		bcs B5_14ee ; b0 03

B5_14eb:		jmp $93e9		; 4c e9 93


B5_14ee:		jsr func_5_31cb		; 20 cb b1
B5_14f1:		rts				; 60 


B5_14f2:		jsr $9511		; 20 11 95
B5_14f5:		bcc B5_1510 ; 90 19

B5_14f7:		lda #$92		; a9 92
B5_14f9:		sta wEntities_408.w, y	; 99 08 04
B5_14fc:		jsr $9511		; 20 11 95
B5_14ff:		bcc B5_1510 ; 90 0f

B5_1501:		lda #$90		; a9 90
B5_1503:		sta wEntities_408.w, y	; 99 08 04
B5_1506:		jsr $9511		; 20 11 95
B5_1509:		bcc B5_1510 ; 90 05

B5_150b:		lda #$8e		; a9 8e
B5_150d:		sta wEntities_408.w, y	; 99 08 04
B5_1510:		rts				; 60 


B5_1511:		lda wEntityDataByte1			; a5 51
B5_1513:		and #$18		; 29 18
B5_1515:		lsr a			; 4a
B5_1516:		lsr a			; 4a
B5_1517:		lsr a			; 4a
B5_1518:		clc				; 18 
B5_1519:		adc #$7e		; 69 7e
B5_151b:		jsr $b268		; 20 68 b2
B5_151e:		bcc B5_1529 ; 90 09

B5_1520:		ldy $f0			; a4 f0
B5_1522:		lda #$04		; a9 04
B5_1524:		sta wEntities_3c0.w, y	; 99 c0 03
B5_1527:		sec				; 38 
B5_1528:		rts				; 60 


B5_1529:		clc				; 18 
B5_152a:		rts				; 60 


entityUpdate27:
B5_152b:		lda wEntitiesState.w, x	; bd f0 03
B5_152e:		jsr jumpTable		; 20 3d c2
	.dw $9539
	.dw $9551
	.dw $9569
	.dw $9588
B5_1539:		lda #$01
B5_153b:		sta wEntities_450.w, x

B5_153e:		lda $6c			; a5 6c
B5_1540:		and #$40		; 29 40
B5_1542:		beq B5_15b7 ; f0 73

B5_1544:		lda #$7c		; a9 7c
B5_1546:		sta wEntities_378.w, x	; 9d 78 03
B5_1549:		lda #$01		; a9 01
B5_154b:		sta wEntities_438.w, x	; 9d 38 04
B5_154e:		inc wEntitiesState.w, x	; fe f0 03
B5_1551:		lda #$08		; a9 08
B5_1553:		sta $f0			; 85 f0
B5_1555:		lda #$02		; a9 02
B5_1557:		ldy #$00		; a0 00
B5_1559:		jsr $b1e1		; 20 e1 b1
B5_155c:		dec wEntities_378.w, x	; de 78 03
B5_155f:		bne B5_15c4 ; d0 63

B5_1561:		lda #$e6		; a9 e6
B5_1563:		sta wEntities_408.w, x	; 9d 08 04
B5_1566:		inc wEntitiesState.w, x	; fe f0 03
B5_1569:		lda #$08		; a9 08
B5_156b:		sta $f0			; 85 f0
B5_156d:		lda #$02		; a9 02
B5_156f:		ldy #$00		; a0 00
B5_1571:		jsr $b1e1		; 20 e1 b1
B5_1574:		jsr func_5_3067		; 20 67 b0
B5_1577:		cmp #$b8		; c9 b8
B5_1579:		bcc B5_15c4 ; 90 49

B5_157b:		lda #$03		; a9 03
B5_157d:		sta wEntities_438.w, x	; 9d 38 04
B5_1580:		lda #$a0		; a9 a0
B5_1582:		sta wEntities_408.w, x	; 9d 08 04
B5_1585:		inc wEntitiesState.w, x	; fe f0 03
B5_1588:		lda #$04		; a9 04
B5_158a:		sta $f0			; 85 f0
B5_158c:		lda #$04		; a9 04
B5_158e:		ldy #$02		; a0 02
B5_1590:		jsr $b1e1		; 20 e1 b1
B5_1593:		jsr func_5_3067		; 20 67 b0
B5_1596:		bcs B5_15b8 ; b0 20

B5_1598:		lda wEntitiesY.w, x	; bd 80 04
B5_159b:		clc				; 18 
B5_159c:		adc #$10		; 69 10
B5_159e:		sta wEntitiesY.w		; 8d 80 04
B5_15a1:		lda wEntitiesX.w, x	; bd b0 04
B5_15a4:		clc				; 18 
B5_15a5:		adc #$04		; 69 04
B5_15a7:		sta wEntitiesX.w		; 8d b0 04
B5_15aa:		lda wEntitiesX.w, x	; bd b0 04
B5_15ad:		lda wEntitiesControlByte.w		; ad 00 03
B5_15b0:		ora #$40		; 09 40
B5_15b2:		and #$f7		; 29 f7
B5_15b4:		sta wEntitiesControlByte.w		; 8d 00 03
B5_15b7:		rts				; 60 


B5_15b8:		lda $6c			; a5 6c
B5_15ba:		ora #$20		; 09 20
B5_15bc:		sta $6c			; 85 6c
B5_15be:		lsr wEntitiesControlByte.w, x	; 5e 00 03
B5_15c1:		lsr wEntitiesControlByte.w		; 4e 00 03
B5_15c4:		rts				; 60 


entityUpdate29:
entityUpdate2a:
B5_15c5:		lda wEntitiesState.w, x	; bd f0 03
B5_15c8:		bne B5_15de ; d0 14

B5_15ca:		dec wEntities_378.w, x	; de 78 03
B5_15cd:		beq B5_15d3 ; f0 04

B5_15cf:		jsr func_5_3067		; 20 67 b0
B5_15d2:		rts				; 60 


B5_15d3:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_15d6:		and #$f7		; 29 f7
B5_15d8:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_15db:		inc wEntitiesState.w, x	; fe f0 03
B5_15de:		rts				; 60 


entityUpdate28:
B5_15df:		lda wEntitiesState.w, x	; bd f0 03
B5_15e2:		jsr jumpTable		; 20 3d c2
	.dw $95ef
	.dw $95f4
	.dw $95fc
	.dw $961f
	.dw $962c
B5_15ef:		stx $83
B5_15f1:		inc wEntitiesState.w, x	; fe f0 03
B5_15f4:		dec wEntities_378.w, x	; de 78 03
B5_15f7:		bne B5_1640 ; d0 47

B5_15f9:		inc wEntitiesState.w, x	; fe f0 03
B5_15fc:		dec wEntities_408.w, x	; de 08 04
B5_15ff:		bne B5_1640 ; d0 3f

B5_1601:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1604:		and #$ef		; 29 ef
B5_1606:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1609:		lda #$00		; a9 00
B5_160b:		sta wEntities_408.w, x	; 9d 08 04
B5_160e:		jsr $b107		; 20 07 b1
B5_1611:		inc wEntitiesState.w, x	; fe f0 03
B5_1614:		cpx $83			; e4 83
B5_1616:		bne B5_161f ; d0 07

B5_1618:		txa				; 8a 
B5_1619:		pha				; 48 
B5_161a:		jsr loadScreenEntities_body		; 20 0f 88
B5_161d:		pla				; 68 
B5_161e:		tax				; aa 
B5_161f:		jsr $b13e		; 20 3e b1
B5_1622:		beq B5_163b ; f0 17

B5_1624:		lda #$3f		; a9 3f
B5_1626:		sta wEntities_378.w, x	; 9d 78 03
B5_1629:		inc wEntitiesState.w, x	; fe f0 03
B5_162c:		jsr $b0d0		; 20 d0 b0
B5_162f:		jsr $b038		; 20 38 b0
B5_1632:		dec wEntities_378.w, x	; de 78 03
B5_1635:		bne B5_1640 ; d0 09

B5_1637:		lsr wEntitiesControlByte.w, x	; 5e 00 03
B5_163a:		rts				; 60 


B5_163b:		jsr func_5_3067		; 20 67 b0
B5_163e:		bcs B5_1624 ; b0 e4

B5_1640:		jsr func_5_31cb		; 20 cb b1
B5_1643:		rts				; 60 


entityUpdate2b:
B5_1644:		jsr $b0d0		; 20 d0 b0
B5_1647:		jsr $b038		; 20 38 b0
B5_164a:		rts				; 60 


entityUpdate2f:
entityUpdate30:
B5_164b:		jsr $978c		; 20 8c 97
B5_164e:		beq B5_1651 ; f0 01

B5_1650:		rts				; 60 


B5_1651:		lda wEntitiesState.w, x	; bd f0 03
B5_1654:		jsr jumpTable		; 20 3d c2
	.dw $9665
	.dw $96c6
	.dw $9742
	.dw $96e8
	.dw $9719
	.dw $972d
	.dw $96dd
B5_1665:		lda $c9
B5_1667:		and #$02
B5_1669:		beq B5_167d ; f0 12

B5_166b:		lda #$11		; a9 11
B5_166d:		sta wEntitiesX.w, x	; 9d b0 04
B5_1670:		lda wPlayerY			; a5 cc
B5_1672:		sta wEntitiesY.w, x	; 9d 80 04
B5_1675:		lda #$48		; a9 48
B5_1677:		sta wEntities_408.w, x	; 9d 08 04
B5_167a:		jmp $968c		; 4c 8c 96


B5_167d:		lda #$ef		; a9 ef
B5_167f:		sta wEntitiesX.w, x	; 9d b0 04
B5_1682:		lda wPlayerY			; a5 cc
B5_1684:		sta wEntitiesY.w, x	; 9d 80 04
B5_1687:		lda #$58		; a9 58
B5_1689:		sta wEntities_408.w, x	; 9d 08 04
B5_168c:		ldy #$04		; a0 04
B5_168e:		jsr func_5_321a		; 20 1a b2
B5_1691:		jsr func_5_318c		; 20 8c b1
B5_1694:		and #$01		; 29 01
B5_1696:		beq B5_1699 ; f0 01

B5_1698:		rts				; 60 


B5_1699:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_169c:		and #$ef		; 29 ef
B5_169e:		ora #$05		; 09 05
B5_16a0:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_16a3:		lda wEntities_3c0.w, x	; bd c0 03
B5_16a6:		ora #$40		; 09 40
B5_16a8:		sta wEntities_3c0.w, x	; 9d c0 03
B5_16ab:		lda #$c0		; a9 c0
B5_16ad:		sta wEntities_330.w, x	; 9d 30 03
B5_16b0:		jsr $b250		; 20 50 b2
B5_16b3:		jsr getNewRandomVal		; 20 8a c4
B5_16b6:		and #$03		; 29 03
B5_16b8:		beq B5_16b0 ; f0 f6

B5_16ba:		tay				; a8 
B5_16bb:		lda $979e, y	; b9 9e 97
B5_16be:		sta wEntities_378.w, x	; 9d 78 03
B5_16c1:		lda #$01		; a9 01
B5_16c3:		sta wEntitiesState.w, x	; 9d f0 03
B5_16c6:		dec wEntities_378.w, x	; de 78 03
B5_16c9:		beq B5_16ce ; f0 03

B5_16cb:		jmp $9769		; 4c 69 97


B5_16ce:		lda #$7c		; a9 7c
B5_16d0:		sta wEntities_378.w, x	; 9d 78 03
B5_16d3:		lda #$30		; a9 30
B5_16d5:		jsr $b052		; 20 52 b0
B5_16d8:		lda #$06		; a9 06
B5_16da:		sta wEntitiesState.w, x	; 9d f0 03
B5_16dd:		jsr $b250		; 20 50 b2
B5_16e0:		dec wEntities_378.w, x	; de 78 03
B5_16e3:		beq B5_16e8 ; f0 03

B5_16e5:		jmp $978b		; 4c 8b 97


B5_16e8:		lda wEntitiesX.w, x	; bd b0 04
B5_16eb:		sec				; 38 
B5_16ec:		sbc $ce			; e5 ce
B5_16ee:		bcs B5_16f5 ; b0 05

B5_16f0:		eor #$ff		; 49 ff
B5_16f2:		clc				; 18 
B5_16f3:		adc #$01		; 69 01
B5_16f5:		cmp #$38		; c9 38
B5_16f7:		bcc B5_16ff ; 90 06

B5_16f9:		lda #$03		; a9 03
B5_16fb:		sta wEntitiesState.w, x	; 9d f0 03
B5_16fe:		rts				; 60 


B5_16ff:		jsr $b107		; 20 07 b1
B5_1702:		jsr $b250		; 20 50 b2
B5_1705:		lda wEntities_3a8.w, x	; bd a8 03
B5_1708:		clc				; 18 
B5_1709:		adc #$08		; 69 08
B5_170b:		sta wEntities_3a8.w, x	; 9d a8 03
B5_170e:		lda #$2f		; a9 2f
B5_1710:		jsr $b052		; 20 52 b0
B5_1713:		lda #$04		; a9 04
B5_1715:		sta wEntitiesState.w, x	; 9d f0 03
B5_1718:		rts				; 60 


B5_1719:		jsr $b13e		; 20 3e b1
B5_171c:		beq B5_1769 ; f0 4b

B5_171e:		lda #$7c		; a9 7c
B5_1720:		sta wEntities_378.w, x	; 9d 78 03
B5_1723:		lda #$30		; a9 30
B5_1725:		jsr $b052		; 20 52 b0
B5_1728:		lda #$05		; a9 05
B5_172a:		sta wEntitiesState.w, x	; 9d f0 03
B5_172d:		jsr $b250		; 20 50 b2
B5_1730:		dec wEntities_378.w, x	; de 78 03
B5_1733:		bne B5_178b ; d0 56

B5_1735:		jsr $b0d0		; 20 d0 b0
B5_1738:		and #$10		; 29 10
B5_173a:		ora #$08		; 09 08
B5_173c:		jsr $b038		; 20 38 b0
B5_173f:		jmp $96b0		; 4c b0 96


B5_1742:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1745:		and #$bf		; 29 bf
B5_1747:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_174a:		lda wEntities_408.w, x	; bd 08 04
B5_174d:		and #$10		; 29 10
B5_174f:		pha				; 48 
B5_1750:		ora #$08		; 09 08
B5_1752:		jsr $b038		; 20 38 b0
B5_1755:		pla				; 68 
B5_1756:		beq B5_1760 ; f0 08

B5_1758:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_175b:		ora #$40		; 09 40
B5_175d:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1760:		jsr func_5_3067		; 20 67 b0
B5_1763:		bcc B5_178b ; 90 26

B5_1765:		lsr wEntitiesControlByte.w, x	; 5e 00 03
B5_1768:		rts				; 60 


B5_1769:		jsr $b1a6		; 20 a6 b1
B5_176c:		bcs B5_177b ; b0 0d

B5_176e:		ldy #$04		; a0 04
B5_1770:		jsr func_5_321a		; 20 1a b2
B5_1773:		jsr $b1b4		; 20 b4 b1
B5_1776:		beq B5_178b ; f0 13

B5_1778:		jmp $96ff		; 4c ff 96


B5_177b:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_177e:		eor #$40		; 49 40
B5_1780:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1783:		lda wEntities_408.w, x	; bd 08 04
B5_1786:		eor #$10		; 49 10
B5_1788:		sta wEntities_408.w, x	; 9d 08 04
B5_178b:		rts				; 60 


B5_178c:		lda wEntities_420.w, x	; bd 20 04
B5_178f:		beq B5_179e ; f0 0d

B5_1791:		jsr func_5_31f2		; 20 f2 b1
B5_1794:		ldy #$04		; a0 04
B5_1796:		jsr func_5_321a		; 20 1a b2
B5_1799:		jsr func_5_3205		; 20 05 b2
B5_179c:		lda #$01		; a9 01
B5_179e:		rts				; 60 


B5_179f:	.db $0b
B5_17a0:		ora $1a, x		; 15 1a


; first slimes
entityUpdate31:
entityUpdate32:
entityUpdate33:
B5_17a2:		jsr func_5_323f		; 20 3f b2
B5_17a5:		beq B5_17a8 ; f0 01

B5_17a7:		rts				; 60 

B5_17a8:		lda wEntitiesState.w, x	; bd f0 03
B5_17ab:		jsr jumpTable		; 20 3d c2
	.dw @state0
	.dw $97df
	.dw $97fe

@state0:
B5_17b4:		lda wEntities_3c0.w, x
B5_17b7:		ora #$40		; 09 40
B5_17b9:		sta wEntities_3c0.w, x	; 9d c0 03
B5_17bc:		dec wEntities_378.w, x	; de 78 03
B5_17bf:		bne B5_181a ; d0 59

B5_17c1:		ldy #$00		; a0 00
B5_17c3:		jsr getNewRandomVal		; 20 8a c4
B5_17c6:		and #$07		; 29 07
B5_17c8:		cmp #$06		; c9 06
B5_17ca:		bcs B5_17c1 ; b0 f5

B5_17cc:		beq B5_17d4 ; f0 06

B5_17ce:		iny				; c8 
B5_17cf:		and #$01		; 29 01
B5_17d1:		beq B5_17d4 ; f0 01

B5_17d3:		iny				; c8 
B5_17d4:		lda $981b, y	; b9 1b 98
B5_17d7:		sta wEntities_378.w, x	; 9d 78 03
B5_17da:		lda #$01		; a9 01
B5_17dc:		sta wEntitiesState.w, x	; 9d f0 03

@state1:
B5_17df:		dec wEntities_378.w, x	; de 78 03
B5_17e2:		bne B5_181a ; d0 36

B5_17e4:		jsr getNewRandomVal		; 20 8a c4
B5_17e7:		and #$07		; 29 07
B5_17e9:		cmp #$06		; c9 06
B5_17eb:		bcs B5_17e4 ; b0 f7

B5_17ed:		tay				; a8 
B5_17ee:		lda $981e, y	; b9 1e 98
B5_17f1:		sta wEntities_408.w, x	; 9d 08 04
B5_17f4:		lda #$15		; a9 15
B5_17f6:		sta wEntities_378.w, x	; 9d 78 03
B5_17f9:		lda #$02		; a9 02
B5_17fb:		sta wEntitiesState.w, x	; 9d f0 03

@state2:
B5_17fe:		dec wEntities_378.w, x	; de 78 03
B5_1801:		beq B5_17c1 ; f0 be

B5_1803:		jsr $b1a6		; 20 a6 b1
B5_1806:		bcc B5_180d ; 90 05

B5_1808:		lda #$00		; a9 00
B5_180a:		sta wEntities_378.w, x	; 9d 78 03
B5_180d:		jsr storeCoordsOfTileUnderEntity		; 20 18 b2
B5_1810:		jsr $b1b4		; 20 b4 b1
B5_1813:		bne B5_17c1 ; d0 ac

B5_1815:		lda wEntities_378.w, x	; bd 78 03
B5_1818:		beq B5_17c1 ; f0 a7

B5_181a:		rts				; 60 


B5_181b:	.db $3f
B5_181c:	.db $9b
B5_181d:	.db $1f
B5_181e:	.db $43
B5_181f:		pha				; 48 
B5_1820:		eor $5853		; 4d 53 58
B5_1823:		.db $5d


entityUpdate12:
	lda wEntitiesState.w, x
B5_1827:		jsr jumpTable		; 20 3d c2
	.dw $9830
	.dw $9838
	.dw $984c
B5_1830:		lda #$29
B5_1832:		jsr $c4ad
B5_1835:		inc wEntitiesState.w, x
B5_1838:		lda wEntities_438.w, x	; bd 38 04
B5_183b:		cmp #$03		; c9 03
B5_183d:		bne B5_184b ; d0 0c

B5_183f:		lda wEntitiesY.w, x	; bd 80 04
B5_1842:		sec				; 38 
B5_1843:		sbc #$08		; e9 08
B5_1845:		sta wEntitiesY.w, x	; 9d 80 04
B5_1848:		inc wEntitiesState.w, x	; fe f0 03
B5_184b:		rts				; 60 


B5_184c:		lda wEntities_450.w, x	; bd 50 04
B5_184f:		cmp #$05		; c9 05
B5_1851:		bne B5_184b ; d0 f8

B5_1853:		lda #$00		; a9 00
B5_1855:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1858:		lda wEntitiesY.w, x	; bd 80 04
B5_185b:		clc				; 18 
B5_185c:		adc #$08		; 69 08
B5_185e:		sta $00			; 85 00
B5_1860:		lda wEntitiesX.w, x	; bd b0 04
B5_1863:		sta $01			; 85 01
B5_1865:		txa				; 8a 
B5_1866:		pha				; 48 
B5_1867:		ldy #$00		; a0 00
B5_1869:		jsr getOffsetOfLastScreenEntity_secIfFound		; 20 86 c3
B5_186c:		bcc B5_189f ; 90 31

B5_186e:		lda $00			; a5 00
B5_1870:		sta wEntitiesY.w, x	; 9d 80 04
B5_1873:		lda $01			; a5 01
B5_1875:		sta wEntitiesX.w, x	; 9d b0 04
B5_1878:		lda #$1f		; a9 1f
B5_187a:		jsr initNpcSpecAIdxX		; 20 ec c3
B5_187d:		lda $98a2, y	; b9 a2 98
B5_1880:		sta wEntities_408.w, x	; 9d 08 04
B5_1883:		lda #$02		; a9 02
B5_1885:		sta wEntitiesState.w, x	; 9d f0 03
B5_1888:		lda #$0f		; a9 0f
B5_188a:		sta wEntities_378.w, x	; 9d 78 03
B5_188d:		lda wEntities_3c0.w, x	; bd c0 03
B5_1890:		ora #$40		; 09 40
B5_1892:		sta wEntities_3c0.w, x	; 9d c0 03
B5_1895:		lda #$00		; a9 00
B5_1897:		sta wEntities_390.w, x	; 9d 90 03
B5_189a:		iny				; c8 
B5_189b:		cpy #$04		; c0 04
B5_189d:		bne B5_1869 ; d0 ca

B5_189f:		pla				; 68 
B5_18a0:		tax				; aa 
B5_18a1:		rts				; 60 


B5_18a2:	.db $44
B5_18a3:		jmp $5c54		; 4c 54 5c


entityUpdate57:
entityUpdate58:
B5_18a6:		jsr $99c0		; 20 c0 99
B5_18a9:		beq B5_18ac ; f0 01

B5_18ab:		rts				; 60 


B5_18ac:		lda wEntitiesState.w, x	; bd f0 03
B5_18af:		jsr jumpTable		; 20 3d c2
	.dw $98bc
	.dw $98c5
	.dw $9902
	.dw $9960
	.dw $9981
B5_18bc:		jsr $b0d0		; 20 d0 b0
B5_18bf:		jsr $b038		; 20 38 b0
B5_18c2:		inc wEntitiesState.w, x	; fe f0 03
B5_18c5:		jsr storeCoordsOfTileUnderEntity		; 20 18 b2
B5_18c8:		jsr func_5_318c		; 20 8c b1
B5_18cb:		and #$01		; 29 01
B5_18cd:		bne B5_18db ; d0 0c

B5_18cf:		ldy #$03		; a0 03
B5_18d1:		jsr func_5_321a		; 20 1a b2
B5_18d4:		jsr func_5_318c		; 20 8c b1
B5_18d7:		and #$01		; 29 01
B5_18d9:		beq B5_18eb ; f0 10

B5_18db:		lda #$58		; a9 58
B5_18dd:		sta wEntitiesId.w, x	; 9d 18 03
B5_18e0:		lda #$40		; a9 40
B5_18e2:		jsr $b045		; 20 45 b0
B5_18e5:		jsr func_5_31cb		; 20 cb b1
B5_18e8:		jmp $9905		; 4c 05 99


B5_18eb:		lda #$57		; a9 57
B5_18ed:		sta wEntitiesId.w, x	; 9d 18 03
B5_18f0:		lda #$c0		; a9 c0
B5_18f2:		jsr $b045		; 20 45 b0
B5_18f5:		lda wEntities_3c0.w, x	; bd c0 03
B5_18f8:		ora #$40		; 09 40
B5_18fa:		sta wEntities_3c0.w, x	; 9d c0 03
B5_18fd:		lda #$02		; a9 02
B5_18ff:		sta wEntitiesState.w, x	; 9d f0 03
B5_1902:		jsr $b250		; 20 50 b2
B5_1905:		lda wMajorNMIUpdatesCounter			; a5 23
B5_1907:		and #$07		; 29 07
B5_1909:		bne B5_1911 ; d0 06

B5_190b:		jsr $b0d0		; 20 d0 b0
B5_190e:		jsr $b038		; 20 38 b0
B5_1911:		lda wEntitiesX.w, x	; bd b0 04
B5_1914:		sec				; 38 
B5_1915:		sbc $ce			; e5 ce
B5_1917:		bcs B5_191e ; b0 05

B5_1919:		eor #$ff		; 49 ff
B5_191b:		clc				; 18 
B5_191c:		adc #$01		; 69 01
B5_191e:		cmp #$20		; c9 20
B5_1920:		bcs B5_1931 ; b0 0f

B5_1922:		lda wEntitiesY.w, x	; bd 80 04
B5_1925:		sec				; 38 
B5_1926:		sbc $cc			; e5 cc
B5_1928:		bcs B5_192f ; b0 05

B5_192a:		eor #$ff		; 49 ff
B5_192c:		clc				; 18 
B5_192d:		adc #$01		; 69 01
B5_192f:		cmp #$20		; c9 20
B5_1931:		bcs B5_198b ; b0 58

B5_1933:		lda #$18		; a9 18
B5_1935:		sta wEntities_378.w, x	; 9d 78 03
B5_1938:		lda #$20		; a9 20
B5_193a:		jsr $b045		; 20 45 b0
B5_193d:		jsr $b0d0		; 20 d0 b0
B5_1940:		jsr $b038		; 20 38 b0
B5_1943:		lda wEntities_3c0.w, x	; bd c0 03
B5_1946:		ora #$40		; 09 40
B5_1948:		sta wEntities_3c0.w, x	; 9d c0 03
B5_194b:		lda #$02		; a9 02
B5_194d:		sta wEntities_438.w, x	; 9d 38 04
B5_1950:		jsr $b250		; 20 50 b2
B5_1953:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1956:		eor #$40		; 49 40
B5_1958:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_195b:		lda #$03		; a9 03
B5_195d:		sta wEntitiesState.w, x	; 9d f0 03
B5_1960:		lda #$01		; a9 01
B5_1962:		sta wEntities_450.w, x	; 9d 50 04
B5_1965:		dec wEntities_378.w, x	; de 78 03
B5_1968:		bne B5_198b ; d0 21

B5_196a:		lda #$3f		; a9 3f
B5_196c:		sta wEntities_378.w, x	; 9d 78 03
B5_196f:		lda #$57		; a9 57
B5_1971:		sta wEntitiesId.w, x	; 9d 18 03
B5_1974:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1977:		eor #$40		; 49 40
B5_1979:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_197c:		lda #$04		; a9 04
B5_197e:		sta wEntitiesState.w, x	; 9d f0 03
B5_1981:		jsr $b250		; 20 50 b2
B5_1984:		dec wEntities_378.w, x	; de 78 03
B5_1987:		bne B5_199c ; d0 13

B5_1989:		beq B5_1997 ; f0 0c

B5_198b:		lda wEntitiesId.w, x	; bd 18 03
B5_198e:		cmp #$57		; c9 57
B5_1990:		beq B5_199d ; f0 0b

B5_1992:		jsr func_5_3067		; 20 67 b0
B5_1995:		bcc B5_199c ; 90 05

B5_1997:		lda #$02		; a9 02
B5_1999:		sta wEntitiesState.w, x	; 9d f0 03
B5_199c:		rts				; 60 


B5_199d:		jsr $b1a6		; 20 a6 b1
B5_19a0:		bcs B5_19b5 ; b0 13

B5_19a2:		ldy #$03		; a0 03
B5_19a4:		jsr func_5_321a		; 20 1a b2
B5_19a7:		jsr $b1b4		; 20 b4 b1
B5_19aa:		bne B5_19b5 ; d0 09

B5_19ac:		jsr storeCoordsOfTileUnderEntity		; 20 18 b2
B5_19af:		jsr $b1b4		; 20 b4 b1
B5_19b2:		bne B5_19b5 ; d0 01

B5_19b4:		rts				; 60 


B5_19b5:		lda #$57		; a9 57
B5_19b7:		sta wEntitiesId.w, x	; 9d 18 03
B5_19ba:		lda #$02		; a9 02
B5_19bc:		sta wEntitiesState.w, x	; 9d f0 03
B5_19bf:		rts				; 60 


B5_19c0:		lda wEntities_420.w, x	; bd 20 04
B5_19c3:		beq B5_19da ; f0 15

B5_19c5:		jsr func_5_31f2		; 20 f2 b1
B5_19c8:		bcs B5_19d8 ; b0 0e

B5_19ca:		jsr storeCoordsOfTileUnderEntity		; 20 18 b2
B5_19cd:		jsr func_5_3205		; 20 05 b2
B5_19d0:		ldy #$03		; a0 03
B5_19d2:		jsr func_5_321a		; 20 1a b2
B5_19d5:		jsr func_5_3205		; 20 05 b2
B5_19d8:		lda #$01		; a9 01
B5_19da:		rts				; 60 


entityUpdate59:
B5_19db:		lda wEntitiesState.w, x	; bd f0 03
B5_19de:		jsr jumpTable		; 20 3d c2
	.dw $99e7
	.dw $9a02
	.dw $9a47
B5_19e7:		lda wEntities_408.w, x	; bd 08 04
B5_19ea:		tay				; a8 
B5_19eb:		lda $9a6a, y	; b9 6a 9a
B5_19ee:		sta wEntities_378.w, x	; 9d 78 03
B5_19f1:		lda wPlayerX			; a5 ce
B5_19f3:		cmp #$80		; c9 80
B5_19f5:		bcc B5_19fd ; 90 06

B5_19f7:		lda $9a71, y	; b9 71 9a
B5_19fa:		sta wEntities_378.w, x	; 9d 78 03
B5_19fd:		lda #$01		; a9 01
B5_19ff:		sta wEntitiesState.w, x	; 9d f0 03
B5_1a02:		dec wEntities_378.w, x	; de 78 03
B5_1a05:		bne B5_1a69 ; d0 62

B5_1a07:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1a0a:		and #$ef		; 29 ef
B5_1a0c:		ora #$04		; 09 04
B5_1a0e:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1a11:		lda #$e5		; a9 e5
B5_1a13:		sta wEntities_330.w, x	; 9d 30 03
B5_1a16:		lda #$3c		; a9 3c
B5_1a18:		jsr queueSoundAtoPlay		; 20 ad c4
B5_1a1b:		lda #$0c		; a9 0c
B5_1a1d:		sta wEntities_378.w, x	; 9d 78 03
B5_1a20:		ldy #$10		; a0 10
B5_1a22:		jsr getNewRandomVal		; 20 8a c4
B5_1a25:		and #$07		; 29 07
B5_1a27:		beq B5_1a1b ; f0 f2

B5_1a29:		sta $00			; 85 00
B5_1a2b:		and #$01		; 29 01
B5_1a2d:		beq B5_1a3e ; f0 0f

B5_1a2f:		lda #$20		; a9 20
B5_1a31:		sta wEntities_378.w, x	; 9d 78 03
B5_1a34:		ldy #$4e		; a0 4e
B5_1a36:		lda $00			; a5 00
B5_1a38:		and #$02		; 29 02
B5_1a3a:		beq B5_1a3e ; f0 02

B5_1a3c:		ldy #$52		; a0 52
B5_1a3e:		tya				; 98 
B5_1a3f:		sta wEntities_408.w, x	; 9d 08 04
B5_1a42:		lda #$02		; a9 02
B5_1a44:		sta wEntitiesState.w, x	; 9d f0 03
B5_1a47:		jsr func_5_3067		; 20 67 b0
B5_1a4a:		bcs B5_1a66 ; b0 1a

B5_1a4c:		jsr storeCoordsOfTileUnderEntity		; 20 18 b2
B5_1a4f:		jsr func_5_318c		; 20 8c b1
B5_1a52:		bne B5_1a60 ; d0 0c

B5_1a54:		lda #$b0		; a9 b0
B5_1a56:		sta wEntities_408.w, x	; 9d 08 04
B5_1a59:		lda #$01		; a9 01
B5_1a5b:		sta wEntities_378.w, x	; 9d 78 03
B5_1a5e:		bne B5_1a69 ; d0 09

B5_1a60:		dec wEntities_378.w, x	; de 78 03
B5_1a63:		beq B5_1a1b ; f0 b6

B5_1a65:		rts				; 60 


B5_1a66:		lsr wEntitiesControlByte.w, x	; 5e 00 03
B5_1a69:		rts				; 60 


B5_1a6a:		sbc $a9d3, x	; fd d3 a9
B5_1a6d:	.db $7f
B5_1a6e:		eor $2b, x		; 55 2b
B5_1a70:		ora ($01, x)	; 01 01
B5_1a72:	.db $2b
B5_1a73:		eor $7f, x		; 55 7f
B5_1a75:		lda #$d3		; a9 d3
B5_1a77:		.db $fd


entityUpdate37:
	lda wEntitiesState.w, x
B5_1a7b:		jsr jumpTable		; 20 3d c2
	.dw $9a84
	.dw $9a95
	.dw $9ab8
B5_1a84:		lda wEntitiesX.w, x	; bd b0 04
B5_1a87:		cmp #$b8		; c9 b8
B5_1a89:		bcs B5_1ac9 ; b0 3e

B5_1a8b:		lda $6c			; a5 6c
B5_1a8d:		ora #$80		; 09 80
B5_1a8f:		sta $6c			; 85 6c
B5_1a91:		inc wEntitiesState.w, x	; fe f0 03
B5_1a94:		rts				; 60 


B5_1a95:		lda $6c			; a5 6c
B5_1a97:		and #$40		; 29 40
B5_1a99:		bne B5_1a9c ; d0 01

B5_1a9b:		rts				; 60 


B5_1a9c:		lda wEntitiesId.w, x	; bd 18 03
B5_1a9f:		cmp #$36		; c9 36
B5_1aa1:		bne B5_1aab ; d0 08

B5_1aa3:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1aa6:		ora #$40		; 09 40
B5_1aa8:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1aab:		lda #$08		; a9 08
B5_1aad:		jsr $b038		; 20 38 b0
B5_1ab0:		lda #$1f		; a9 1f
B5_1ab2:		sta wEntities_378.w, x	; 9d 78 03
B5_1ab5:		inc wEntitiesState.w, x	; fe f0 03
B5_1ab8:		lda wEntitiesX.w, x	; bd b0 04
B5_1abb:		cmp #$d8		; c9 d8
B5_1abd:		bcc B5_1ac9 ; 90 0a

B5_1abf:		lda $6c			; a5 6c
B5_1ac1:		ora #$20		; 09 20
B5_1ac3:		sta $6c			; 85 6c
B5_1ac5:		lsr wEntitiesControlByte.w, x	; 5e 00 03
B5_1ac8:		rts				; 60 


B5_1ac9:		jsr func_5_3067		; 20 67 b0
B5_1acc:		rts				; 60 


entityUpdate18:
entityUpdate19:
entityUpdate1a:
entityUpdate1b:
entityUpdate1c:
entityUpdate1d:
B5_1acd:		jsr $9bcb		; 20 cb 9b
B5_1ad0:		beq B5_1ad6 ; f0 04

B5_1ad2:		jsr $9bec		; 20 ec 9b
B5_1ad5:		rts				; 60 


B5_1ad6:		lda wEntitiesState.w, x	; bd f0 03
B5_1ad9:		jsr jumpTable		; 20 3d c2
	.dw $9c93
	.dw $9ae6
	.dw $9af0
	.dw $9b1a
	.dw $9b32
B5_1ae6:		dec wEntities_378.w, x	; de 78 03
B5_1ae9:		bne B5_1b5a ; d0 6f

B5_1aeb:		lda #$02		; a9 02
B5_1aed:		sta wEntitiesState.w, x	; 9d f0 03
B5_1af0:		lda wEntitiesX.w, x	; bd b0 04
B5_1af3:		sec				; 38 
B5_1af4:		sbc $ce			; e5 ce
B5_1af6:		bcs B5_1afd ; b0 05

B5_1af8:		eor #$ff		; 49 ff
B5_1afa:		clc				; 18 
B5_1afb:		adc #$01		; 69 01
B5_1afd:		cmp #$30		; c9 30
B5_1aff:		bcs B5_1b53 ; b0 52

B5_1b01:		lda wEntitiesY.w, x	; bd 80 04
B5_1b04:		sec				; 38 
B5_1b05:		sbc $cc			; e5 cc
B5_1b07:		bcs B5_1b0e ; b0 05

B5_1b09:		eor #$ff		; 49 ff
B5_1b0b:		clc				; 18 
B5_1b0c:		adc #$01		; 69 01
B5_1b0e:		cmp #$30		; c9 30
B5_1b10:		bcs B5_1b53 ; b0 41

B5_1b12:		jsr $9b61		; 20 61 9b
B5_1b15:		lda #$03		; a9 03
B5_1b17:		sta wEntitiesState.w, x	; 9d f0 03
B5_1b1a:		dec wEntities_378.w, x	; de 78 03
B5_1b1d:		bne B5_1b4a ; d0 2b

B5_1b1f:		lda wEntitiesId.w, x	; bd 18 03
B5_1b22:		clc				; 18 
B5_1b23:		adc #$03		; 69 03
B5_1b25:		jsr $b052		; 20 52 b0
B5_1b28:		lda #$30		; a9 30
B5_1b2a:		sta wEntities_378.w, x	; 9d 78 03
B5_1b2d:		lda #$04		; a9 04
B5_1b2f:		sta wEntitiesState.w, x	; 9d f0 03
B5_1b32:		dec wEntities_378.w, x	; de 78 03
B5_1b35:		bne B5_1b56 ; d0 1f

B5_1b37:		jsr $9b61		; 20 61 9b
B5_1b3a:		lda wEntitiesId.w, x	; bd 18 03
B5_1b3d:		sec				; 38 
B5_1b3e:		sbc #$03		; e9 03
B5_1b40:		jsr $b052		; 20 52 b0
B5_1b43:		lda #$03		; a9 03
B5_1b45:		sta wEntitiesState.w, x	; 9d f0 03
B5_1b48:		bne B5_1b56 ; d0 0c

B5_1b4a:		jsr $b0d0		; 20 d0 b0
B5_1b4d:		jsr $b038		; 20 38 b0
B5_1b50:		jsr $9bb5		; 20 b5 9b
B5_1b53:		jsr $9b7b		; 20 7b 9b
B5_1b56:		jsr $9bec		; 20 ec 9b
B5_1b59:		rts				; 60 


B5_1b5a:		jsr $9bb5		; 20 b5 9b
B5_1b5d:		jsr $9bec		; 20 ec 9b
B5_1b60:		rts				; 60 


B5_1b61:		ldy #$00		; a0 00
B5_1b63:		jsr getNewRandomVal		; 20 8a c4
B5_1b66:		and #$07		; 29 07
B5_1b68:		cmp #$06		; c9 06
B5_1b6a:		bcs B5_1b61 ; b0 f5

B5_1b6c:		beq B5_1b74 ; f0 06

B5_1b6e:		iny				; c8 
B5_1b6f:		and #$01		; 29 01
B5_1b71:		beq B5_1b74 ; f0 01

B5_1b73:		iny				; c8 
B5_1b74:		lda $9be9, y	; b9 e9 9b
B5_1b77:		sta wEntities_378.w, x	; 9d 78 03
B5_1b7a:		rts				; 60 


B5_1b7b:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1b7e:		and #$bf		; 29 bf
B5_1b80:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1b83:		jsr $b0d0		; 20 d0 b0
B5_1b86:		ldy #$19		; a0 19
B5_1b88:		cmp #$04		; c9 04
B5_1b8a:		bcc B5_1ba4 ; 90 18

B5_1b8c:		ldy #$18		; a0 18
B5_1b8e:		cmp #$0c		; c9 0c
B5_1b90:		bcs B5_1b9e ; b0 0c

B5_1b92:		ldy #$1a		; a0 1a
B5_1b94:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1b97:		ora #$40		; 09 40
B5_1b99:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1b9c:		bne B5_1ba4 ; d0 06

B5_1b9e:		cmp #$14		; c9 14
B5_1ba0:		bcc B5_1ba4 ; 90 02

B5_1ba2:		ldy #$1a		; a0 1a
B5_1ba4:		lda wEntitiesId.w, x	; bd 18 03
B5_1ba7:		cmp #$04		; c9 04
B5_1ba9:		bcs B5_1bb0 ; b0 05

B5_1bab:		tya				; 98 
B5_1bac:		sec				; 38 
B5_1bad:		sbc #$17		; e9 17
B5_1baf:		tay				; a8 
B5_1bb0:		tya				; 98 
B5_1bb1:		jsr $b052		; 20 52 b0
B5_1bb4:		rts				; 60 


B5_1bb5:		jsr $b1a6		; 20 a6 b1
B5_1bb8:		ldy #$05		; a0 05
B5_1bba:		jsr func_5_321a		; 20 1a b2
B5_1bbd:		jsr $b1b4		; 20 b4 b1
B5_1bc0:		bne B5_1bca ; d0 08

B5_1bc2:		ldy #$06		; a0 06
B5_1bc4:		jsr func_5_321a		; 20 1a b2
B5_1bc7:		jsr $b1b4		; 20 b4 b1
B5_1bca:		rts				; 60 


B5_1bcb:		lda wEntities_420.w, x	; bd 20 04
B5_1bce:		beq B5_1bca ; f0 fa

B5_1bd0:		jsr func_5_31f2		; 20 f2 b1
B5_1bd3:		ldy #$05		; a0 05
B5_1bd5:		jsr func_5_321a		; 20 1a b2
B5_1bd8:		jsr func_5_3205		; 20 05 b2
B5_1bdb:		bcs B5_1be5 ; b0 08

B5_1bdd:		ldy #$06		; a0 06
B5_1bdf:		jsr func_5_321a		; 20 1a b2
B5_1be2:		jsr func_5_3205		; 20 05 b2
B5_1be5:		lda #$01		; a9 01
B5_1be7:		bne B5_1bca ; d0 e1

B5_1be9:	.db $9b
B5_1bea:	.db $3f
B5_1beb:	.db $1f
B5_1bec:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1bef:		and #$10		; 29 10
B5_1bf1:		beq B5_1c02 ; f0 0f

B5_1bf3:		lda wEntities_390.w, x	; bd 90 03
B5_1bf6:		and #$1f		; 29 1f
B5_1bf8:		tay				; a8 
B5_1bf9:		lda wEntitiesControlByte.w, y	; b9 00 03
B5_1bfc:		ora #$10		; 09 10
B5_1bfe:		sta wEntitiesControlByte.w, y	; 99 00 03
B5_1c01:		rts				; 60 


B5_1c02:		lda #$08		; a9 08
B5_1c04:		sta $00			; 85 00
B5_1c06:		lda wEntitiesId.w, x	; bd 18 03
B5_1c09:		cmp #$1b		; c9 1b
B5_1c0b:		bcc B5_1c11 ; 90 04

B5_1c0d:		lda #$10		; a9 10
B5_1c0f:		sta $00			; 85 00
B5_1c11:		lda wEntities_450.w, x	; bd 50 04
B5_1c14:		cmp $00			; c5 00
B5_1c16:		bcc B5_1c43 ; 90 2b

B5_1c18:		ldy wEntities_438.w, x	; bc 38 04
B5_1c1b:		iny				; c8 
B5_1c1c:		lda wEntitiesId.w, x	; bd 18 03
B5_1c1f:		cmp #$1b		; c9 1b
B5_1c21:		bcs B5_1c2b ; b0 08

B5_1c23:		cpy #$04		; c0 04
B5_1c25:		bcc B5_1c33 ; 90 0c

B5_1c27:		ldy #$00		; a0 00
B5_1c29:		bne B5_1c33 ; d0 08

B5_1c2b:		cpy #$03		; c0 03
B5_1c2d:		bcc B5_1c33 ; 90 04

B5_1c2f:		ldy #$00		; a0 00
B5_1c31:		bne B5_1c33 ; d0 00

B5_1c33:		sty $00			; 84 00
B5_1c35:		lda wEntitiesId.w, x	; bd 18 03
B5_1c38:		and #$07		; 29 07
B5_1c3a:		asl a			; 0a
B5_1c3b:		asl a			; 0a
B5_1c3c:		clc				; 18 
B5_1c3d:		adc $00			; 65 00
B5_1c3f:		tay				; a8 
B5_1c40:		jmp $9c4f		; 4c 4f 9c


B5_1c43:		lda wEntitiesId.w, x	; bd 18 03
B5_1c46:		and #$07		; 29 07
B5_1c48:		asl a			; 0a
B5_1c49:		asl a			; 0a
B5_1c4a:		clc				; 18 
B5_1c4b:		adc wEntities_438.w, x	; 7d 38 04
B5_1c4e:		tay				; a8 
B5_1c4f:		lda $9cf2, y	; b9 f2 9c
B5_1c52:		sta $00			; 85 00
B5_1c54:		lda $9d0a, y	; b9 0a 9d
B5_1c57:		sta $01			; 85 01
B5_1c59:		lda $9d22, y	; b9 22 9d
B5_1c5c:		sta $02			; 85 02
B5_1c5e:		lda $9d3a, y	; b9 3a 9d
B5_1c61:		sta $03			; 85 03
B5_1c63:		jsr $9c9f		; 20 9f 9c
B5_1c66:		lda wEntitiesId.w, x	; bd 18 03
B5_1c69:		cmp #$1c		; c9 1c
B5_1c6b:		bcc B5_1c88 ; 90 1b

B5_1c6d:		cmp #$1e		; c9 1e
B5_1c6f:		bcs B5_1c88 ; b0 17

B5_1c71:		lda wEntitiesState.w, y	; b9 f0 03
B5_1c74:		bne B5_1c7b ; d0 05

B5_1c76:		lda wEntitiesControlByte.w, y	; b9 00 03
B5_1c79:		bne B5_1c88 ; d0 0d

B5_1c7b:		lda $02			; a5 02
B5_1c7d:		and #$fb		; 29 fb
B5_1c7f:		sta wEntitiesControlByte.w, y	; 99 00 03
B5_1c82:		lda #$01		; a9 01
B5_1c84:		sta wEntitiesState.w, y	; 99 f0 03
B5_1c87:		rts				; 60 


B5_1c88:		lda $02			; a5 02
B5_1c8a:		sta wEntitiesControlByte.w, y	; 99 00 03
B5_1c8d:		lda #$00		; a9 00
B5_1c8f:		sta wEntitiesState.w, y	; 99 f0 03
B5_1c92:		rts				; 60 


B5_1c93:		jsr $9cd9		; 20 d9 9c
B5_1c96:		lda #$01		; a9 01
B5_1c98:		sta wEntitiesState.w, x	; 9d f0 03
B5_1c9b:		jsr $9bec		; 20 ec 9b
B5_1c9e:		rts				; 60 


B5_1c9f:		lda wEntities_390.w, x	; bd 90 03
B5_1ca2:		and #$1f		; 29 1f
B5_1ca4:		tay				; a8 
B5_1ca5:		lda wEntitiesY.w, x	; bd 80 04
B5_1ca8:		clc				; 18 
B5_1ca9:		adc $00			; 65 00
B5_1cab:		sta wEntitiesY.w, y	; 99 80 04
B5_1cae:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1cb1:		and #$40		; 29 40
B5_1cb3:		beq B5_1cc4 ; f0 0f

B5_1cb5:		lda $01			; a5 01
B5_1cb7:		eor #$ff		; 49 ff
B5_1cb9:		clc				; 18 
B5_1cba:		adc #$01		; 69 01
B5_1cbc:		sta $01			; 85 01
B5_1cbe:		lda $02			; a5 02
B5_1cc0:		eor #$40		; 49 40
B5_1cc2:		sta $02			; 85 02
B5_1cc4:		lda wEntitiesX.w, x	; bd b0 04
B5_1cc7:		clc				; 18 
B5_1cc8:		adc $01			; 65 01
B5_1cca:		sta wEntitiesX.w, y	; 99 b0 04
B5_1ccd:		lda $03			; a5 03
B5_1ccf:		sta wEntitiesId.w, y	; 99 18 03
B5_1cd2:		lda wEntities_408.w, x	; bd 08 04
B5_1cd5:		sta wEntities_408.w, y	; 99 08 04
B5_1cd8:		rts				; 60 


B5_1cd9:		txa				; 8a 
B5_1cda:		tay				; a8 
B5_1cdb:		jsr getOffsetOfLastScreenEntity_secIfFound		; 20 86 c3
B5_1cde:		txa				; 8a 
B5_1cdf:		sta wEntities_390.w, y	; 99 90 03
B5_1ce2:		lda #$bb		; a9 bb
B5_1ce4:		sta wEntities_330.w, x	; 9d 30 03
B5_1ce7:		tya				; 98 
B5_1ce8:		tax				; aa 
B5_1ce9:		lda wEntities_3c0.w, x	; bd c0 03
B5_1cec:		ora #$40		; 09 40
B5_1cee:		sta wEntities_3c0.w, x	; 9d c0 03
B5_1cf1:		rts				; 60 


B5_1cf2:	.db $f4
B5_1cf3:	.db $f3
B5_1cf4:	.db $f4
B5_1cf5:	.db $f3
B5_1cf6:	.db $f2
B5_1cf7:		sbc ($f2), y	; f1 f2
B5_1cf9:		sbc ($f3), y	; f1 f3
B5_1cfb:	.db $f2
B5_1cfc:	.db $f3
B5_1cfd:	.db $f2
B5_1cfe:	.db $f4
B5_1cff:		nop				; ea 
B5_1d00:		ora $f200, y	; 19 00 f2
B5_1d03:		sbc ($de), y	; f1 de
B5_1d05:		.db $00				; 00
B5_1d06:	.db $f2
B5_1d07:		;removed
	.db $f0 $05

B5_1d09:		.db $00				; 00
B5_1d0a:		inc $eeee		; ee ee ee
B5_1d0d:		inc $1010		; ee 10 10
B5_1d10:		bpl B5_1d22 ; 10 10

B5_1d12:	.db $0c
B5_1d13:	.db $0c
B5_1d14:	.db $0c
B5_1d15:	.db $0c
B5_1d16:		inc $faee		; ee ee fa
B5_1d19:		.db $00				; 00
B5_1d1a:		bpl B5_1d2e ; 10 12

B5_1d1c:		inc $0c00, x	; fe 00 0c
B5_1d1f:	.db $0f
B5_1d20:		beq B5_1d22 ; f0 00

B5_1d22:	.db $80
B5_1d23:	.db $80
B5_1d24:	.db $80
B5_1d25:	.db $80
B5_1d26:		cpy #$c0		; c0 c0
B5_1d28:		cpy #$c0		; c0 c0
B5_1d2a:		cpy #$c0		; c0 c0
B5_1d2c:		cpy #$c0		; c0 c0
B5_1d2e:	.db $80
B5_1d2f:	.db $80
B5_1d30:		stx $80			; 86 80
B5_1d32:		cpy #$c0		; c0 c0
B5_1d34:		stx $80			; 86 80
B5_1d36:		cpy #$c0		; c0 c0
B5_1d38:		stx $80			; 86 80
B5_1d3a:		asl $1e1e, x	; 1e 1e 1e
B5_1d3d:		asl $1e1e, x	; 1e 1e 1e
B5_1d40:		asl $1e1e, x	; 1e 1e 1e
B5_1d43:		asl $1e1e, x	; 1e 1e 1e
B5_1d46:		asl $201e, x	; 1e 1e 20
B5_1d49:		asl $1e1e, x	; 1e 1e 1e
B5_1d4c:		asl $1e1e, x	; 1e 1e 1e
B5_1d4f:		asl $1e1f, x	; 1e 1f 1e


entityUpdate61:
entityUpdate62:
B5_1d52:		lda wEntitiesState.w, x	; bd f0 03
B5_1d55:		jsr jumpTable		; 20 3d c2
	.dw func_5_1d5c
	.dw func_5_1d86

func_5_1d5c:
B5_1d5c:		lda wEntities_408.w, x	; bd 08 04
B5_1d5f:		and #$10		; 29 10
B5_1d61:		beq B5_1d73 ; f0 10

B5_1d63:		lda wEntitiesX.w, x	; bd b0 04
B5_1d66:		cmp #$68		; c9 68
B5_1d68:		bcs B5_1d83 ; b0 19

B5_1d6a:		lda #$68		; a9 68
B5_1d6c:		sta wEntitiesX.w, x	; 9d b0 04
B5_1d6f:		inc wEntitiesState.w, x	; fe f0 03
B5_1d72:		rts				; 60 

B5_1d73:		lda wEntitiesX.w, x	; bd b0 04
B5_1d76:		cmp #$98		; c9 98
B5_1d78:		bcc B5_1d83 ; 90 09

B5_1d7a:		lda #$98		; a9 98
B5_1d7c:		sta wEntitiesX.w, x	; 9d b0 04
B5_1d7f:		inc wEntitiesState.w, x	; fe f0 03
B5_1d82:		rts				; 60 

B5_1d83:		jsr func_5_3067		; 20 67 b0

func_5_1d86:
B5_1d86:		rts				; 60 


entityUpdate01:
entityUpdate02:
entityUpdate03:
B5_1d87:		jsr $9e4a		; 20 4a 9e
B5_1d8a:		beq B5_1d90 ; f0 04

B5_1d8c:		jsr $9e67		; 20 67 9e
B5_1d8f:		rts				; 60 

B5_1d90:		lda wEntitiesState.w, x	; bd f0 03
B5_1d93:		jsr jumpTable		; 20 3d c2
	.dw $9ea4
	.dw $9da2
	.dw $9db2
	.dw $9ddc
	.dw $9e0c
	.dw $9df0

B5_1da2:		jsr $9e98		; 20 98 9e
B5_1da5:		dec wEntities_378.w, x	; de 78 03
B5_1da8:		beq B5_1dad ; f0 03

B5_1daa:		jmp $9e30		; 4c 30 9e


B5_1dad:		lda #$02		; a9 02
B5_1daf:		sta wEntitiesState.w, x	; 9d f0 03
B5_1db2:		lda wEntitiesX.w, x	; bd b0 04
B5_1db5:		sec				; 38 
B5_1db6:		sbc $ce			; e5 ce
B5_1db8:		bcs B5_1dbf ; b0 05

B5_1dba:		eor #$ff		; 49 ff
B5_1dbc:		clc				; 18 
B5_1dbd:		adc #$01		; 69 01
B5_1dbf:		cmp #$30		; c9 30
B5_1dc1:		bcs B5_1e2c ; b0 69

B5_1dc3:		lda wEntitiesY.w, x	; bd 80 04
B5_1dc6:		sec				; 38 
B5_1dc7:		sbc $cc			; e5 cc
B5_1dc9:		bcs B5_1dd0 ; b0 05

B5_1dcb:		eor #$ff		; 49 ff
B5_1dcd:		clc				; 18 
B5_1dce:		adc #$01		; 69 01
B5_1dd0:		cmp #$30		; c9 30
B5_1dd2:		bcs B5_1e2c ; b0 58

B5_1dd4:		jsr $9b61		; 20 61 9b
B5_1dd7:		lda #$03		; a9 03
B5_1dd9:		sta wEntitiesState.w, x	; 9d f0 03
B5_1ddc:		dec wEntities_378.w, x	; de 78 03
B5_1ddf:		bne B5_1e23 ; d0 42

B5_1de1:		lda #$16		; a9 16
B5_1de3:		sta wEntities_378.w, x	; 9d 78 03
B5_1de6:		lda #$03		; a9 03
B5_1de8:		sta wEntities_438.w, x	; 9d 38 04
B5_1deb:		lda #$05		; a9 05
B5_1ded:		sta wEntitiesState.w, x	; 9d f0 03
B5_1df0:		lda #$01		; a9 01
B5_1df2:		sta wEntities_450.w, x	; 9d 50 04
B5_1df5:		dec wEntities_378.w, x	; de 78 03
B5_1df8:		bne B5_1e2f ; d0 35

B5_1dfa:		lda #$16		; a9 16
B5_1dfc:		sta wEntities_378.w, x	; 9d 78 03
B5_1dff:		lda #$04		; a9 04
B5_1e01:		sta wEntities_438.w, x	; 9d 38 04
B5_1e04:		lda #$04		; a9 04
B5_1e06:		sta wEntitiesState.w, x	; 9d f0 03
B5_1e09:		jsr $9e89		; 20 89 9e
B5_1e0c:		lda #$00		; a9 00
B5_1e0e:		sta wEntities_450.w, x	; 9d 50 04
B5_1e11:		dec wEntities_378.w, x	; de 78 03
B5_1e14:		bne B5_1e2f ; d0 19

B5_1e16:		jsr $9e98		; 20 98 9e
B5_1e19:		jsr $9b61		; 20 61 9b
B5_1e1c:		lda #$03		; a9 03
B5_1e1e:		sta wEntitiesState.w, x	; 9d f0 03
B5_1e21:		bne B5_1e2f ; d0 0c

B5_1e23:		jsr $b0d0		; 20 d0 b0
B5_1e26:		jsr $b038		; 20 38 b0
B5_1e29:		jsr $9e34		; 20 34 9e
B5_1e2c:		jsr $9b7b		; 20 7b 9b
B5_1e2f:		rts				; 60 


B5_1e30:		jsr $9e34		; 20 34 9e
B5_1e33:		rts				; 60 


B5_1e34:		jsr $b1a6		; 20 a6 b1
B5_1e37:		ldy #$07		; a0 07
B5_1e39:		jsr func_5_321a		; 20 1a b2
B5_1e3c:		jsr $b1b4		; 20 b4 b1
B5_1e3f:		bne B5_1e49 ; d0 08

B5_1e41:		ldy #$08		; a0 08
B5_1e43:		jsr func_5_321a		; 20 1a b2
B5_1e46:		jsr $b1b4		; 20 b4 b1
B5_1e49:		rts				; 60 


B5_1e4a:		lda wEntities_420.w, x	; bd 20 04
B5_1e4d:		beq B5_1e49 ; f0 fa

B5_1e4f:		jsr func_5_31f2		; 20 f2 b1
B5_1e52:		ldy #$07		; a0 07
B5_1e54:		jsr func_5_321a		; 20 1a b2
B5_1e57:		jsr func_5_3205		; 20 05 b2
B5_1e5a:		bcs B5_1e64 ; b0 08

B5_1e5c:		ldy #$08		; a0 08
B5_1e5e:		jsr func_5_321a		; 20 1a b2
B5_1e61:		jsr func_5_3205		; 20 05 b2
B5_1e64:		lda #$01		; a9 01
B5_1e66:		rts				; 60 


B5_1e67:		lda wEntities_438.w, x	; bd 38 04
B5_1e6a:		cmp #$04		; c9 04
B5_1e6c:		bne B5_1e88 ; d0 1a

B5_1e6e:		ldy wEntitiesId.w, x	; bc 18 03
B5_1e71:		lda $9ec1, y	; b9 c1 9e
B5_1e74:		sta $00			; 85 00
B5_1e76:		lda $9ec4, y	; b9 c4 9e
B5_1e79:		sta $01			; 85 01
B5_1e7b:		lda $9ec7, y	; b9 c7 9e
B5_1e7e:		sta $03			; 85 03
B5_1e80:		jsr $9c9f		; 20 9f 9c
B5_1e83:		lda #$96		; a9 96
B5_1e85:		sta wEntitiesControlByte.w, y	; 99 00 03
B5_1e88:		rts				; 60 


B5_1e89:		lda wEntities_390.w, x	; bd 90 03
B5_1e8c:		and #$3f		; 29 3f
B5_1e8e:		tay				; a8 
B5_1e8f:		lda #$fb		; a9 fb
B5_1e91:		sta wEntities_330.w, y	; 99 30 03
B5_1e94:		jsr $9e67		; 20 67 9e
B5_1e97:		rts				; 60 


B5_1e98:		lda wEntities_390.w, x	; bd 90 03
B5_1e9b:		and #$3f		; 29 3f
B5_1e9d:		tay				; a8 
B5_1e9e:		lda #$00		; a9 00
B5_1ea0:		sta wEntitiesControlByte.w, y	; 99 00 03
B5_1ea3:		rts				; 60 


B5_1ea4:		txa				; 8a 
B5_1ea5:		tay				; a8 
B5_1ea6:		jsr getOffsetOfLastScreenEntity_secIfFound		; 20 86 c3
B5_1ea9:		txa				; 8a 
B5_1eaa:		sta wEntities_390.w, y	; 99 90 03
B5_1ead:		lda #$90		; a9 90
B5_1eaf:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1eb2:		tya				; 98 
B5_1eb3:		tax				; aa 
B5_1eb4:		lda wEntities_3c0.w, x	; bd c0 03
B5_1eb7:		ora #$40		; 09 40
B5_1eb9:		sta wEntities_3c0.w, x	; 9d c0 03
B5_1ebc:		lda #$01		; a9 01
B5_1ebe:		sta wEntitiesState.w, x	; 9d f0 03
B5_1ec1:		rts				; 60 


B5_1ec2:		asl a			; 0a
B5_1ec3:		;removed
	.db $f0 $fa

B5_1ec5:		sed				; f8 
B5_1ec6:	.db $07
B5_1ec7:		sbc ($65), y	; f1 65
B5_1ec9:		adc $66			; 65 66


entityUpdate6f:
entityUpdate70:
entityUpdate71:
B5_1ecb:		lda wEntities_408.w, x	; bd 08 04
B5_1ece:		beq B5_1edd ; f0 0d

B5_1ed0:		dec wEntities_408.w, x	; de 08 04
B5_1ed3:		bne B5_1edd ; d0 08

B5_1ed5:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_1ed8:		and #$ef		; 29 ef
B5_1eda:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_1edd:		jsr func_5_31cb		; 20 cb b1
B5_1ee0:		rts				; 60 


hideNPCifGlobalFlagSet:
	jsr checkGlobalFlag		; 20 6c c4
	beq dontHideNPC

hideNPC:
B5_1ee6:		ldx $01			; a6 01
B5_1ee8:		lda #$00		; a9 00
B5_1eea:		sta wEntitiesControlByte.w, x	; 9d 00 03

dontHideNPC:
	ldx $01			; a6 01
B5_1eef:		rts				; 60 


entityUpdate9d:
B5_1ef0:		stx $01			; 86 01
B5_1ef2:		lda #GF_HANDED_GOLD_STATUE		; a9 13
B5_1ef4:		bne hideNPCifGlobalFlagSet ; d0 eb

entityUpdate92:
B5_1ef6:		stx $01			; 86 01
B5_1ef8:		lda wRoomY			; a5 43
B5_1efa:		cmp #$17		; c9 17
B5_1efc:		bne B5_1f08 ; d0 0a

B5_1efe:		lda wRoomX			; a5 42
B5_1f00:		cmp #$06		; c9 06
B5_1f02:		bne B5_1f08 ; d0 04

B5_1f04:		lda #GF_BRACELET_ITEM		; a9 3c
B5_1f06:		bne hideNPCifGlobalFlagSet ; d0 d9

B5_1f08:		lda wRoomY			; a5 43
B5_1f0a:		cmp #$11		; c9 11
B5_1f0c:		bne dontHideNPC ; d0 df

B5_1f0e:		lda wRoomX			; a5 42
B5_1f10:		cmp #$0a		; c9 0a
B5_1f12:		bne dontHideNPC ; d0 d9

B5_1f14:		lda #GF_TRADED_NECKLACE_FOR_WAKKA		; a9 11
B5_1f16:		jsr checkGlobalFlag		; 20 6c c4
B5_1f19:		beq hideNPC ; f0 cb

B5_1f1b:		lda #GF_WAKKA_ITEM		; a9 42
B5_1f1d:		bne hideNPCifGlobalFlagSet ; d0 c2


entityUpdate96:
B5_1f1f:		stx $01			; 86 01
B5_1f21:		lda wRoomY			; a5 43
B5_1f23:		cmp #$16		; c9 16
B5_1f25:		bne B5_1f32 ; d0 0b

B5_1f27:		lda wRoomX			; a5 42
B5_1f29:		cmp #$02		; c9 02
B5_1f2b:		bne B5_1f32 ; d0 05

B5_1f2d:		lda #GF_BRACELET_ITEM		; a9 3c
B5_1f2f:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


B5_1f32:		lda wRoomY			; a5 43
B5_1f34:		cmp #$0a		; c9 0a
B5_1f36:		bne B5_1f78 ; d0 40

B5_1f38:		lda wRoomX			; a5 42
B5_1f3a:		cmp #$1a		; c9 1a
B5_1f3c:		bne B5_1f78 ; d0 3a

B5_1f3e:		lda #GF_POWDER_ITEM		; a9 45
B5_1f40:		jsr checkGlobalFlag		; 20 6c c4
B5_1f43:		beq hideNPC ; f0 a1

B5_1f45:		lda #GF_UPGRADED_WING_SWORD		; a9 03
B5_1f47:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


entityUpdate97:
B5_1f4a:		stx $01			; 86 01
B5_1f4c:		lda wRoomY			; a5 43
B5_1f4e:		cmp #$0d		; c9 0d
B5_1f50:		bne B5_1f5d ; d0 0b

B5_1f52:		lda wRoomX			; a5 42
B5_1f54:		cmp #$07		; c9 07
B5_1f56:		bne B5_1f5d ; d0 05

B5_1f58:		lda #GF_NECKLACE_ITEM		; a9 44
B5_1f5a:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


B5_1f5d:		lda wRoomY			; a5 43
B5_1f5f:		cmp #$11		; c9 11
B5_1f61:		bne B5_1f78 ; d0 15

B5_1f63:		lda wRoomX			; a5 42
B5_1f65:		cmp #$1d		; c9 1d
B5_1f67:		bne B5_1f78 ; d0 0f

B5_1f69:		lda #GF_NOCKMAAR_KEY_ITEM		; a9 43
B5_1f6b:		jsr checkGlobalFlag		; 20 6c c4
B5_1f6e:		bne B5_1f73 ; d0 03

B5_1f70:		jmp hideNPC		; 4c e6 9e

B5_1f73:		lda #GF_USED_POWDER_ON_MADMARTIGAN		; a9 10
B5_1f75:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e

B5_1f78:		ldx $01			; a6 01
B5_1f7a:		rts				; 60 


entityUpdate98:
B5_1f7b:		stx $01			; 86 01
B5_1f7d:		lda wRoomY			; a5 43
B5_1f7f:		cmp #$19		; c9 19
B5_1f81:		bne B5_1f8e ; d0 0b

B5_1f83:		lda wRoomX			; a5 42
B5_1f85:		cmp #$11		; c9 11
B5_1f87:		bne B5_1f8e ; d0 05

B5_1f89:		lda #GF_KAISER_SWORD		; a9 1e
B5_1f8b:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


B5_1f8e:		lda wRoomY			; a5 43
B5_1f90:		cmp #$09		; c9 09
B5_1f92:		bne B5_1f78 ; d0 e4

B5_1f94:		lda wRoomX			; a5 42
B5_1f96:		cmp #$06		; c9 06
B5_1f98:		bne B5_1f78 ; d0 de

B5_1f9a:		lda #GF_TALKED_TO_KAEL_IN_PRISON		; a9 0b
B5_1f9c:		jsr hideNPCifGlobalFlagSet		; 20 e1 9e
B5_1f9f:		lda #GF_CREST_ITEM		; a9 41
B5_1fa1:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


entityUpdate91:
B5_1fa4:		stx $01			; 86 01
B5_1fa6:		lda wRoomY			; a5 43
B5_1fa8:		cmp #$0b		; c9 0b
B5_1faa:		bne B5_1fb7 ; d0 0b

B5_1fac:		lda wRoomX			; a5 42
B5_1fae:		cmp #$10		; c9 10
B5_1fb0:		bne B5_1fb7 ; d0 05

B5_1fb2:		lda #GF_POWDER_ITEM		; a9 45
B5_1fb4:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


B5_1fb7:		lda wRoomY			; a5 43
B5_1fb9:		cmp #$07		; c9 07
B5_1fbb:		bne B5_1f78 ; d0 bb

B5_1fbd:		lda wRoomX			; a5 42
B5_1fbf:		cmp #$1e		; c9 1e
B5_1fc1:		bne B5_1f78 ; d0 b5

B5_1fc3:		lda #GF_POWDER_ITEM		; a9 45
B5_1fc5:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


entityUpdate90:
B5_1fc8:		stx $01			; 86 01
B5_1fca:		lda wRoomY			; a5 43
B5_1fcc:		cmp #$00		; c9 00
B5_1fce:		bne B5_1f78 ; d0 a8

B5_1fd0:		lda wRoomX			; a5 42
B5_1fd2:		cmp #$1b		; c9 1b
B5_1fd4:		bne B5_1f78 ; d0 a2

B5_1fd6:		lda #GF_UPGRADED_WING_SWORD		; a9 03
B5_1fd8:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


entityUpdate99:
B5_1fdb:		stx $01			; 86 01
B5_1fdd:		lda wRoomY			; a5 43
B5_1fdf:		cmp #$11		; c9 11
B5_1fe1:		bne B5_1f8e ; d0 ab

B5_1fe3:		lda wRoomX			; a5 42
B5_1fe5:		cmp #$1d		; c9 1d
B5_1fe7:		bne B5_1f8e ; d0 a5

B5_1fe9:		lda #GF_NOCKMAAR_KEY_ITEM		; a9 43
B5_1feb:		jsr checkGlobalFlag		; 20 6c c4
B5_1fee:		bne B5_1ff3 ; d0 03

B5_1ff0:		jmp hideNPC		; 4c e6 9e


B5_1ff3:		lda #GF_USED_POWDER_ON_MADMARTIGAN		; a9 10
B5_1ff5:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


entityUpdate9a:
B5_1ff8:		stx $01			; 86 01
B5_1ffa:		lda wRoomY			; a5 43
B5_1ffc:		cmp #$00		; c9 00
B5_1ffe:		bne B5_2015 ; d0 15

B5_2000:		lda wRoomX			; a5 42
B5_2002:		cmp #$0d		; c9 0d
B5_2004:		bne B5_2015 ; d0 0f

B5_2006:		lda #GF_HERBS_ITEM		; a9 3a
B5_2008:		jsr checkGlobalFlag		; 20 6c c4
B5_200b:		bne B5_2010 ; d0 03

B5_200d:		jmp hideNPC		; 4c e6 9e


B5_2010:		lda #GF_OCARINA_MAGIC		; a9 31
B5_2012:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


B5_2015:		ldx $01			; a6 01
B5_2017:		rts				; 60 


entityUpdate9b:
B5_2018:		stx $01			; 86 01
B5_201a:		lda wRoomY			; a5 43
B5_201c:		cmp #$00		; c9 00
B5_201e:		bne B5_202b ; d0 0b

B5_2020:		lda wRoomX			; a5 42
B5_2022:		cmp #$1f		; c9 1f
B5_2024:		bne B5_202b ; d0 05

B5_2026:		lda #GF_WING_SWORD		; a9 1c
B5_2028:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


B5_202b:		lda wRoomY			; a5 43
B5_202d:		cmp #$18		; c9 18
B5_202f:		bne B5_2015 ; d0 e4

B5_2031:		lda wRoomX			; a5 42
B5_2033:		cmp #$1b		; c9 1b
B5_2035:		bne B5_2015 ; d0 de

B5_2037:		lda #GF_WING_SWORD		; a9 1c
B5_2039:		jsr checkGlobalFlag		; 20 6c c4
B5_203c:		bne B5_2041 ; d0 03

B5_203e:		jmp hideNPC		; 4c e6 9e


B5_2041:		lda #GF_UPGRADED_WING_SWORD		; a9 03
B5_2043:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


entityUpdate9e:
B5_2046:		lda wEntitiesState.w, x	; bd f0 03
B5_2049:		bne B5_2074 ; d0 29

B5_204b:		ldy wEntities_390.w, x	; bc 90 03
B5_204e:		lda wEntitiesY.w, x	; bd 80 04
B5_2051:		sec				; 38 
B5_2052:		sbc #$0d		; e9 0d
B5_2054:		sta $047f, x	; 9d 7f 04
B5_2057:		lda wEntitiesX.w, x	; bd b0 04
B5_205a:		sec				; 38 
B5_205b:		sbc #$12		; e9 12
B5_205d:		sta $04af, x	; 9d af 04
B5_2060:		lda #$ff		; a9 ff
B5_2062:		sta $032f, x	; 9d 2f 03
B5_2065:		lda #$1e		; a9 1e
B5_2067:		sta $0317, x	; 9d 17 03
B5_206a:		lda #$80		; a9 80
B5_206c:		sta $02ff, x	; 9d ff 02
B5_206f:		lda #$01		; a9 01
B5_2071:		sta wEntitiesState.w, x	; 9d f0 03
B5_2074:		stx $01			; 86 01
B5_2076:		lda #GF_UNBLOCKED_FINAL_DUNGEON		; a9 12
B5_2078:		jsr checkGlobalFlag		; 20 6c c4
B5_207b:		beq B5_2087 ; f0 0a

B5_207d:		ldx $01			; a6 01
B5_207f:		lda #$00		; a9 00
B5_2081:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2084:		sta $02ff, x	; 9d ff 02
B5_2087:		ldx $01			; a6 01
B5_2089:		rts				; 60 


entityUpdate93:
B5_208a:		stx $01			; 86 01
B5_208c:		lda wRoomY			; a5 43
B5_208e:		cmp #$19		; c9 19
B5_2090:		bne B5_209d ; d0 0b

B5_2092:		lda wRoomX			; a5 42
B5_2094:		cmp #$10		; c9 10
B5_2096:		bne B5_209d ; d0 05

B5_2098:		lda #GF_BLUE_CRYSTAL_ITEM		; a9 40
B5_209a:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


B5_209d:		lda wRoomY			; a5 43
B5_209f:		cmp #$12		; c9 12
B5_20a1:		bne B5_20ae ; d0 0b

B5_20a3:		lda wRoomX			; a5 42
B5_20a5:		cmp #$02		; c9 02
B5_20a7:		bne B5_20ae ; d0 05

B5_20a9:		lda #GF_RED_CRYSTAL_ITEM		; a9 3f
B5_20ab:		jmp hideNPCifGlobalFlagSet		; 4c e1 9e


B5_20ae:		ldx $01			; a6 01
B5_20b0:		rts				; 60 


entityUpdate82:
B5_20b1:		lda wEntitiesState.w, x	; bd f0 03
B5_20b4:		jsr jumpTable		; 20 3d c2
	.dw $a0c1
	.dw $a0da
	.dw $a13e
	.dw $a1bc
	.dw $a1fa
B5_20c1:		lda #$03
B5_20c3:		sta $d4			; 85 d4
B5_20c5:		lda #$01		; a9 01
B5_20c7:		sta $f9			; 85 f9
B5_20c9:		lda #$00		; a9 00
B5_20cb:		sta wEntities_3a8.w, x	; 9d a8 03
B5_20ce:		sta $fc			; 85 fc
B5_20d0:		sta $fd			; 85 fd
B5_20d2:		sta $fe			; 85 fe
B5_20d4:		lda #$0e		; a9 0e
B5_20d6:		sta wEntities_390.w, x	; 9d 90 03
B5_20d9:		rts				; 60 


B5_20da:		dec wEntities_378.w, x	; de 78 03
B5_20dd:		beq B5_20e2 ; f0 03

B5_20df:		jmp $a1a1		; 4c a1 a1


B5_20e2:		lda wEntities_390.w, x	; bd 90 03
B5_20e5:		cmp #$17		; c9 17
B5_20e7:		bne B5_20fc ; d0 13

B5_20e9:		lda #$a8		; a9 a8
B5_20eb:		sta wEntities_408.w, x	; 9d 08 04
B5_20ee:		lda #$06		; a9 06
B5_20f0:		sta $fd			; 85 fd
B5_20f2:		lda #$3f		; a9 3f
B5_20f4:		sta $fc			; 85 fc
B5_20f6:		inc $fe			; e6 fe
B5_20f8:		inc wEntitiesState.w, x	; fe f0 03
B5_20fb:		rts				; 60 


B5_20fc:		txa				; 8a 
B5_20fd:		tay				; a8 
B5_20fe:		lda wEntities_390.w, x	; bd 90 03
B5_2101:		tax				; aa 
B5_2102:		lda #$b9		; a9 b9
B5_2104:		jsr initNpcSpecAIdxX		; 20 ec c3
B5_2107:		lda wEntitiesY.w, y	; b9 80 04
B5_210a:		sta wEntitiesY.w, x	; 9d 80 04
B5_210d:		lda wEntitiesX.w, y	; b9 b0 04
B5_2110:		sta wEntitiesX.w, x	; 9d b0 04
B5_2113:		lda #$a8		; a9 a8
B5_2115:		sta wEntities_408.w, x	; 9d 08 04
B5_2118:		tya				; 98 
B5_2119:		tax				; aa 
B5_211a:		inc wEntities_390.w, x	; fe 90 03
B5_211d:		lda wEntities_390.w, x	; bd 90 03
B5_2120:		cmp #$17		; c9 17
B5_2122:		beq B5_2137 ; f0 13

B5_2124:		cmp #$15		; c9 15
B5_2126:		bne B5_2130 ; d0 08

B5_2128:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_212b:		and #$f7		; 29 f7
B5_212d:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2130:		lda #$07		; a9 07
B5_2132:		sta wEntities_378.w, x	; 9d 78 03
B5_2135:		bne B5_2178 ; d0 41

B5_2137:		lda #$0c		; a9 0c
B5_2139:		sta wEntities_378.w, x	; 9d 78 03
B5_213c:		bne B5_2178 ; d0 3a

B5_213e:		dec $fc			; c6 fc
B5_2140:		bne B5_2178 ; d0 36

B5_2142:		lda wEntities_408.w, x	; bd 08 04
B5_2145:		eor #$10		; 49 10
B5_2147:		sta wEntities_408.w, x	; 9d 08 04
B5_214a:		lda $fe			; a5 fe
B5_214c:		eor #$03		; 49 03
B5_214e:		sta $fe			; 85 fe
B5_2150:		lda #$7e		; a9 7e
B5_2152:		sta $fc			; 85 fc
B5_2154:		dec $fd			; c6 fd
B5_2156:		bne B5_2178 ; d0 20

B5_2158:		inc wEntitiesState.w, x	; fe f0 03
B5_215b:		lda #$40		; a9 40
B5_215d:		sta wEntities_408.w, x	; 9d 08 04
B5_2160:		lda #$0c		; a9 0c
B5_2162:		sta wEntities_378.w, x	; 9d 78 03
B5_2165:		lda #$16		; a9 16
B5_2167:		sta wEntities_390.w, x	; 9d 90 03
B5_216a:		lda #$00		; a9 00
B5_216c:		sta wEntities_438.w, x	; 9d 38 04
B5_216f:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2172:		ora #$08		; 09 08
B5_2174:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2177:		rts				; 60 


B5_2178:		lda wMajorNMIUpdatesCounter			; a5 23
B5_217a:		and #$7f		; 29 7f
B5_217c:		bne B5_21a1 ; d0 23

B5_217e:		lda #$c0		; a9 c0
B5_2180:		jsr $b268		; 20 68 b2
B5_2183:		pha				; 48 
B5_2184:		ldx $f0			; a6 f0
B5_2186:		jsr $b0d0		; 20 d0 b0
B5_2189:		ora #$c0		; 09 c0
B5_218b:		sta wEntities_408.w, x	; 9d 08 04
B5_218e:		lda wEntities_3c0.w, x	; bd c0 03
B5_2191:		ora #$04		; 09 04
B5_2193:		sta wEntities_3c0.w, x	; 9d c0 03
B5_2196:		lda wEntitiesY.w, x	; bd 80 04
B5_2199:		clc				; 18 
B5_219a:		adc #$08		; 69 08
B5_219c:		sta wEntitiesY.w, x	; 9d 80 04
B5_219f:		pla				; 68 
B5_21a0:		tax				; aa 
B5_21a1:		jsr func_5_3067		; 20 67 b0
B5_21a4:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_21a7:		and #$bf		; 29 bf
B5_21a9:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_21ac:		lda wEntities_438.w, x	; bd 38 04
B5_21af:		and #$04		; 29 04
B5_21b1:		beq B5_21bb ; f0 08

B5_21b3:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_21b6:		ora #$40		; 09 40
B5_21b8:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_21bb:		rts				; 60 


B5_21bc:		lda #$10		; a9 10
B5_21be:		sta $06			; 85 06
B5_21c0:		lda $04be		; ad be 04
B5_21c3:		cmp #$6c		; c9 6c
B5_21c5:		beq B5_21c9 ; f0 02

B5_21c7:		lda #$c0		; a9 c0
B5_21c9:		sta $07			; 85 07
B5_21cb:		jsr $b0d8		; 20 d8 b0
B5_21ce:		jsr $b038		; 20 38 b0
B5_21d1:		jsr func_5_3067		; 20 67 b0
B5_21d4:		dec wEntities_378.w, x	; de 78 03
B5_21d7:		bne B5_21f0 ; d0 17

B5_21d9:		lda #$07		; a9 07
B5_21db:		sta wEntities_378.w, x	; 9d 78 03
B5_21de:		ldy wEntities_390.w, x	; bc 90 03
B5_21e1:		lda #$00		; a9 00
B5_21e3:		sta wEntitiesControlByte.w, y	; 99 00 03
B5_21e6:		dec wEntities_390.w, x	; de 90 03
B5_21e9:		lda wEntities_390.w, x	; bd 90 03
B5_21ec:		cmp #$0d		; c9 0d
B5_21ee:		beq B5_21f1 ; f0 01

B5_21f0:		rts				; 60 


B5_21f1:		inc wEntitiesState.w, x	; fe f0 03
B5_21f4:		lda #$01		; a9 01
B5_21f6:		sta wEntities_378.w, x	; 9d 78 03
B5_21f9:		rts				; 60 


B5_21fa:		ldy #$c0		; a0 c0
B5_21fc:		lda $04be		; ad be 04
B5_21ff:		cmp #$6c		; c9 6c
B5_2201:		beq B5_2205 ; f0 02

B5_2203:		ldy #$6c		; a0 6c
B5_2205:		tya				; 98 
B5_2206:		sta wEntitiesX.w, x	; 9d b0 04
B5_2209:		lda #$10		; a9 10
B5_220b:		sta wEntitiesY.w, x	; 9d 80 04
B5_220e:		lda #$10		; a9 10
B5_2210:		jsr $b038		; 20 38 b0
B5_2213:		lda #$01		; a9 01
B5_2215:		sta wEntitiesState.w, x	; 9d f0 03
B5_2218:		lda #$00		; a9 00
B5_221a:		sta wEntities_3a8.w, x	; 9d a8 03
B5_221d:		sta $fc			; 85 fc
B5_221f:		sta $fd			; 85 fd
B5_2221:		sta $fe			; 85 fe
B5_2223:		lda #$07		; a9 07
B5_2225:		sta wEntities_378.w, x	; 9d 78 03
B5_2228:		lda #$0e		; a9 0e
B5_222a:		sta wEntities_390.w, x	; 9d 90 03
B5_222d:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2230:		and #$ef		; 29 ef
B5_2232:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2235:		rts				; 60 


entityUpdate83:
B5_2236:		lda $fe			; a5 fe
B5_2238:		jsr jumpTable		; 20 3d c2
	.dw $a241
	.dw $a242
	.dw $a258
B5_2241:		rts
B5_2242:		cpx #$0e		; e0 0e
B5_2244:		bne B5_2247 ; d0 01

B5_2246:		rts				; 60 


B5_2247:		lda #$a8		; a9 a8
B5_2249:		sta wEntities_408.w, x	; 9d 08 04
B5_224c:		lda $04b1, x	; bd b1 04
B5_224f:		sec				; 38 
B5_2250:		sbc #$06		; e9 06
B5_2252:		cmp wEntitiesX.w, x	; dd b0 04
B5_2255:		bcs B5_226e ; b0 17

B5_2257:		rts				; 60 


B5_2258:		cpx #$0e		; e0 0e
B5_225a:		bne B5_225d ; d0 01

B5_225c:		rts				; 60 


B5_225d:		lda #$b8		; a9 b8
B5_225f:		sta wEntities_408.w, x	; 9d 08 04
B5_2262:		lda wEntitiesX.w, x	; bd b0 04
B5_2265:		sec				; 38 
B5_2266:		sbc #$06		; e9 06
B5_2268:		cmp $04b1, x	; dd b1 04
B5_226b:		bcs B5_226e ; b0 01

B5_226d:		rts				; 60 


B5_226e:		jsr func_5_3067		; 20 67 b0

enUpdateStub2:
B5_2271:		rts				; 60 


entityUpdate7b:
B5_2272:		jsr func_5_323f		; 20 3f b2
B5_2275:		beq B5_2278 ; f0 01

B5_2277:		rts				; 60 


B5_2278:		lda wEntitiesState.w, x	; bd f0 03
B5_227b:		jsr jumpTable		; 20 3d c2
	.dw $a286
	.dw $a29e
	.dw $a2f9
	.dw $a322
B5_2286:		lda #$01		; a9 01
B5_2288:		sta $d4			; 85 d4
B5_228a:		lda #$00		; a9 00
B5_228c:		sta $f9			; 85 f9
B5_228e:		lda #$00		; a9 00
B5_2290:		sta wEntities_3a8.w, x	; 9d a8 03
B5_2293:		lda #$40		; a9 40
B5_2295:		sta wEntities_3c0.w, x	; 9d c0 03
B5_2298:		lda #$60		; a9 60
B5_229a:		sta wEntities_378.w, x	; 9d 78 03
B5_229d:		rts				; 60 


B5_229e:		ldy #$00		; a0 00
B5_22a0:		lda wMajorNMIUpdatesCounter			; a5 23
B5_22a2:		and #$08		; 29 08
B5_22a4:		bne B5_22a7 ; d0 01

B5_22a6:		iny				; c8 
B5_22a7:		tya				; 98 
B5_22a8:		sta wEntities_438.w, x	; 9d 38 04
B5_22ab:		dec wEntities_378.w, x	; de 78 03
B5_22ae:		beq B5_22eb ; f0 3b

B5_22b0:		lda wEntities_3a8.w, x	; bd a8 03
B5_22b3:		bne B5_22e6 ; d0 31

B5_22b5:		lda wPlayerY			; a5 cc
B5_22b7:		sec				; 38 
B5_22b8:		sbc #$58		; e9 58
B5_22ba:		bcc B5_22c0 ; 90 04

B5_22bc:		cmp #$11		; c9 11
B5_22be:		bcs B5_22c2 ; b0 02

B5_22c0:		lda wPlayerY			; a5 cc
B5_22c2:		sta $06			; 85 06
B5_22c4:		lda wPlayerX			; a5 ce
B5_22c6:		sta $07			; 85 07
B5_22c8:		jsr $b0d8		; 20 d8 b0
B5_22cb:		jsr $b038		; 20 38 b0
B5_22ce:		jsr func_5_3067		; 20 67 b0
B5_22d1:		jsr storeCoordsOfTileUnderEntity		; 20 18 b2
B5_22d4:		jsr func_5_318c		; 20 8c b1
B5_22d7:		beq B5_22e5 ; f0 0c

B5_22d9:		lda wEntitiesTempY.w, x	; bd c8 04
B5_22dc:		sta wEntitiesY.w, x	; 9d 80 04
B5_22df:		lda wEntitiesTempX.w, x	; bd e0 04
B5_22e2:		sta wEntitiesX.w, x	; 9d b0 04
B5_22e5:		rts				; 60 


B5_22e6:		lda #$00		; a9 00
B5_22e8:		sta wEntities_3a8.w, x	; 9d a8 03
B5_22eb:		inc wEntitiesState.w, x	; fe f0 03
B5_22ee:		lda #$1e		; a9 1e
B5_22f0:		sta wEntities_378.w, x	; 9d 78 03
B5_22f3:		lda #$02		; a9 02
B5_22f5:		sta wEntities_438.w, x	; 9d 38 04
B5_22f8:		rts				; 60 


B5_22f9:		dec wEntities_378.w, x	; de 78 03
B5_22fc:		beq B5_2309 ; f0 0b

B5_22fe:		lda wEntities_378.w, x	; bd 78 03
B5_2301:		cmp #$02		; c9 02
B5_2303:		bne B5_2308 ; d0 03

B5_2305:		inc wEntities_438.w, x	; fe 38 04
B5_2308:		rts				; 60 


B5_2309:		lda #$b5		; a9 b5
B5_230b:		jsr $b268		; 20 68 b2
B5_230e:		pha				; 48 
B5_230f:		ldx $f0			; a6 f0
B5_2311:		jsr $b0d0		; 20 d0 b0
B5_2314:		sta wEntities_408.w, x	; 9d 08 04
B5_2317:		lda #$19		; a9 19
B5_2319:		sta wEntities_378.w, x	; 9d 78 03
B5_231c:		pla				; 68 
B5_231d:		tax				; aa 
B5_231e:		inc wEntitiesState.w, x	; fe f0 03
B5_2321:		rts				; 60 


B5_2322:		lda $0316		; ad 16 03
B5_2325:		bmi B5_2321 ; 30 fa

B5_2327:		lda #$01		; a9 01
B5_2329:		sta wEntitiesState.w, x	; 9d f0 03
B5_232c:		lda #$60		; a9 60
B5_232e:		sta wEntities_378.w, x	; 9d 78 03
B5_2331:		rts				; 60 


entityUpdate7d:
B5_2332:		lda wMajorNMIUpdatesCounter			; a5 23
B5_2334:		and #$0c		; 29 0c
B5_2336:		lsr a			; 4a
B5_2337:		lsr a			; 4a
B5_2338:		tay				; a8 
B5_2339:		lda wEntitiesY.w, x	; bd 80 04
B5_233c:		clc				; 18 
B5_233d:		adc $a3b0, y	; 79 b0 a3
B5_2340:		sta wEntitiesY.w, x	; 9d 80 04
B5_2343:		lda wEntitiesX.w, x	; bd b0 04
B5_2346:		clc				; 18 
B5_2347:		adc $a3b4, y	; 79 b4 a3
B5_234a:		sta wEntitiesX.w, x	; 9d b0 04
B5_234d:		tya				; 98 
B5_234e:		sta wEntities_438.w, x	; 9d 38 04
B5_2351:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2354:		and #$bf		; 29 bf
B5_2356:		cpy #$02		; c0 02
B5_2358:		bcc B5_235c ; 90 02

B5_235a:		ora #$40		; 09 40
B5_235c:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_235f:		lda wEntitiesState.w, x	; bd f0 03
B5_2362:		jsr jumpTable		; 20 3d c2
	.dw $a36b
	.dw $a390
	.dw $a3a1
B5_236b:		dec wEntities_378.w, x	; de 78 03
B5_236e:		bne B5_237e ; d0 0e

B5_2370:		lda #$3f		; a9 3f
B5_2372:		sta wEntities_390.w, x	; 9d 90 03
B5_2375:		lda #$19		; a9 19
B5_2377:		sta wEntities_378.w, x	; 9d 78 03
B5_237a:		inc wEntitiesState.w, x	; fe f0 03
B5_237d:		rts				; 60 


B5_237e:		jsr func_5_3067		; 20 67 b0
B5_2381:		bcs B5_2384 ; b0 01

B5_2383:		rts				; 60 


B5_2384:		lda #$19		; a9 19
B5_2386:		sec				; 38 
B5_2387:		sbc wEntities_378.w, x	; fd 78 03
B5_238a:		sta wEntities_390.w, x	; 9d 90 03
B5_238d:		jmp $a37a		; 4c 7a a3


B5_2390:		dec wEntities_390.w, x	; de 90 03
B5_2393:		bne B5_23a0 ; d0 0b

B5_2395:		lda wEntities_408.w, x	; bd 08 04
B5_2398:		eor #$10		; 49 10
B5_239a:		sta wEntities_408.w, x	; 9d 08 04
B5_239d:		inc wEntitiesState.w, x	; fe f0 03
B5_23a0:		rts				; 60 


B5_23a1:		dec wEntities_378.w, x	; de 78 03
B5_23a4:		bne B5_23ac ; d0 06

B5_23a6:		lda #$00		; a9 00
B5_23a8:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_23ab:		rts				; 60 


B5_23ac:		jsr func_5_3067		; 20 67 b0
B5_23af:		rts				; 60 


B5_23b0:		ora ($01, x)	; 01 01
B5_23b2:	.db $ff
B5_23b3:	.db $ff
B5_23b4:	.db $ff
B5_23b5:		ora ($01, x)	; 01 01
B5_23b7:	.db $ff


entityUpdate84:
entityUpdate85:
B5_23b8:		jsr func_5_323f		; 20 3f b2
B5_23bb:		beq B5_23be ; f0 01

B5_23bd:		rts				; 60 


B5_23be:		lda wEntitiesState.w, x	; bd f0 03
B5_23c1:		jsr jumpTable		; 20 3d c2
	.dw $a3ce
	.dw $a3e1
	.dw $a3fd
	.dw $a415
	.dw $a44d
B5_23ce:		lda #$02
B5_23d0:		sta $d4			; 85 d4
B5_23d2:		lda #$00		; a9 00
B5_23d4:		sta $f9			; 85 f9
B5_23d6:		lda #$00		; a9 00
B5_23d8:		sta wEntities_3a8.w, x	; 9d a8 03
B5_23db:		lda #$40		; a9 40
B5_23dd:		sta wEntities_3c0.w, x	; 9d c0 03
B5_23e0:		rts				; 60 


B5_23e1:		lda wEntities_3a8.w, x	; bd a8 03
B5_23e4:		bne B5_23ef ; d0 09

B5_23e6:		jsr $b0d0		; 20 d0 b0
B5_23e9:		jsr $b038		; 20 38 b0
B5_23ec:		jmp $a2ce		; 4c ce a2


B5_23ef:		lda #$00		; a9 00
B5_23f1:		sta wEntities_3a8.w, x	; 9d a8 03
B5_23f4:		inc wEntitiesState.w, x	; fe f0 03
B5_23f7:		lda #$1e		; a9 1e
B5_23f9:		sta wEntities_378.w, x	; 9d 78 03
B5_23fc:		rts				; 60 


B5_23fd:		dec wEntities_378.w, x	; de 78 03
B5_2400:		bne B5_23fc ; d0 fa

B5_2402:		inc wEntitiesState.w, x	; fe f0 03
B5_2405:		lda #$01		; a9 01
B5_2407:		sta wEntities_378.w, x	; 9d 78 03
B5_240a:		lda #$07		; a9 07
B5_240c:		sta wEntities_390.w, x	; 9d 90 03
B5_240f:		lda #$85		; a9 85
B5_2411:		sta wEntitiesId.w, x	; 9d 18 03
B5_2414:		rts				; 60 


B5_2415:		dec wEntities_378.w, x	; de 78 03
B5_2418:		bne B5_23fc ; d0 e2

B5_241a:		lda #$12		; a9 12
B5_241c:		sta wEntities_378.w, x	; 9d 78 03
B5_241f:		lda #$bb		; a9 bb
B5_2421:		jsr $b268		; 20 68 b2
B5_2424:		pha				; 48 
B5_2425:		ldx $f0			; a6 f0
B5_2427:		jsr $b0d0		; 20 d0 b0
B5_242a:		sta wEntities_408.w, x	; 9d 08 04
B5_242d:		lda wEntities_3c0.w, x	; bd c0 03
B5_2430:		ora #$04		; 09 04
B5_2432:		sta wEntities_3c0.w, x	; 9d c0 03
B5_2435:		pla				; 68 
B5_2436:		tax				; aa 
B5_2437:		dec wEntities_390.w, x	; de 90 03
B5_243a:		bne B5_244c ; d0 10

B5_243c:		lda #$1e		; a9 1e
B5_243e:		sta wEntities_378.w, x	; 9d 78 03
B5_2441:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2444:		and #$fe		; 29 fe
B5_2446:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2449:		inc wEntitiesState.w, x	; fe f0 03
B5_244c:		rts				; 60 


B5_244d:		txa				; 8a 
B5_244e:		pha				; 48 
B5_244f:		dec wEntities_378.w, x	; de 78 03
B5_2452:		beq B5_2465 ; f0 11

B5_2454:		ldy #$16		; a0 16
B5_2456:		lda wMajorNMIUpdatesCounter			; a5 23
B5_2458:		and #$02		; 29 02
B5_245a:		bne B5_245e ; d0 02

B5_245c:		ldy #$94		; a0 94
B5_245e:		tya				; 98 
B5_245f:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B5_2462:		pla				; 68 
B5_2463:		tax				; aa 
B5_2464:		rts				; 60 


B5_2465:		lda #$16		; a9 16
B5_2467:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B5_246a:		pla				; 68 
B5_246b:		tax				; aa 
B5_246c:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_246f:		ora #$01		; 09 01
B5_2471:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2474:		lda #$84		; a9 84
B5_2476:		sta wEntitiesId.w, x	; 9d 18 03
B5_2479:		lda #$01		; a9 01
B5_247b:		sta wEntitiesState.w, x	; 9d f0 03
B5_247e:		rts				; 60 


entityUpdate7f:
entityUpdate80:
B5_247f:		jsr func_5_323f		; 20 3f b2
B5_2482:		beq B5_2485 ; f0 01

B5_2484:		rts				; 60 


B5_2485:		lda wEntitiesState.w, x	; bd f0 03
B5_2488:		jsr jumpTable		; 20 3d c2
	.dw $a495
	.dw $a4a8
	.dw $a4e2
	.dw $a500
	.dw $a536
B5_2495:		lda #$07
B5_2497:		sta $d4			; 85 d4
B5_2499:		lda #$03		; a9 03
B5_249b:		sta $f9			; 85 f9
B5_249d:		lda #$00		; a9 00
B5_249f:		sta wEntities_3a8.w, x	; 9d a8 03
B5_24a2:		lda #$40		; a9 40
B5_24a4:		sta wEntities_3c0.w, x	; 9d c0 03
B5_24a7:		rts				; 60 


B5_24a8:		lda wEntitiesX.w, x	; bd b0 04
B5_24ab:		sec				; 38 
B5_24ac:		sbc $ce			; e5 ce
B5_24ae:		bcs B5_24b4 ; b0 04

B5_24b0:		eor #$ff		; 49 ff
B5_24b2:		adc #$01		; 69 01
B5_24b4:		cmp #$10		; c9 10
B5_24b6:		bcs B5_24cb ; b0 13

B5_24b8:		inc wEntitiesState.w, x	; fe f0 03
B5_24bb:		ldy #$06		; a0 06
B5_24bd:		jsr getNewRandomVal		; 20 8a c4
B5_24c0:		and #$01		; 29 01
B5_24c2:		bne B5_24c6 ; d0 02

B5_24c4:		ldy #$3f		; a0 3f
B5_24c6:		tya				; 98 
B5_24c7:		sta wEntities_378.w, x	; 9d 78 03
B5_24ca:		rts				; 60 


B5_24cb:		ldy #$00		; a0 00
B5_24cd:		lda wPlayerY			; a5 cc
B5_24cf:		sec				; 38 
B5_24d0:		sbc #$10		; e9 10
B5_24d2:		bcc B5_24db ; 90 07

B5_24d4:		sbc wEntitiesY.w, x	; fd 80 04
B5_24d7:		bcc B5_24db ; 90 02

B5_24d9:		ldy #$e0		; a0 e0
B5_24db:		tya				; 98 
B5_24dc:		sta wEntities_408.w, x	; 9d 08 04
B5_24df:		jmp $a3e6		; 4c e6 a3


B5_24e2:		dec wEntities_378.w, x	; de 78 03
B5_24e5:		beq B5_24ea ; f0 03

B5_24e7:		jmp $a4cb		; 4c cb a4


B5_24ea:		inc wEntitiesState.w, x	; fe f0 03
B5_24ed:		lda #$80		; a9 80
B5_24ef:		sta wEntitiesId.w, x	; 9d 18 03
B5_24f2:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_24f5:		ora #$08		; 09 08
B5_24f7:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_24fa:		lda #$02		; a9 02
B5_24fc:		sta wEntities_390.w, x	; 9d 90 03
B5_24ff:		rts				; 60 


B5_2500:		inc wEntities_378.w, x	; fe 78 03
B5_2503:		lda wEntities_378.w, x	; bd 78 03
B5_2506:		and #$01		; 29 01
B5_2508:		bne B5_250d ; d0 03

B5_250a:		inc wEntities_438.w, x	; fe 38 04
B5_250d:		lda wEntities_438.w, x	; bd 38 04
B5_2510:		cmp #$04		; c9 04
B5_2512:		beq B5_2515 ; f0 01

B5_2514:		rts				; 60 


B5_2515:		inc wEntitiesState.w, x	; fe f0 03
B5_2518:		lda #$12		; a9 12
B5_251a:		sta wEntities_378.w, x	; 9d 78 03
B5_251d:		lda #$c1		; a9 c1
B5_251f:		jsr $b268		; 20 68 b2
B5_2522:		pha				; 48 
B5_2523:		ldx $f0			; a6 f0
B5_2525:		lda wEntitiesY.w, x	; bd 80 04
B5_2528:		clc				; 18 
B5_2529:		adc #$1c		; 69 1c
B5_252b:		sta wEntitiesY.w, x	; 9d 80 04
B5_252e:		lda #$10		; a9 10
B5_2530:		sta wEntities_408.w, x	; 9d 08 04
B5_2533:		pla				; 68 
B5_2534:		tax				; aa 
B5_2535:		rts				; 60 


B5_2536:		dec wEntities_378.w, x	; de 78 03
B5_2539:		bne B5_255d ; d0 22

B5_253b:		dec wEntities_390.w, x	; de 90 03
B5_253e:		bne B5_255e ; d0 1e

B5_2540:		lda #$01		; a9 01
B5_2542:		sta wEntitiesState.w, x	; 9d f0 03
B5_2545:		lda #$7f		; a9 7f
B5_2547:		sta wEntitiesId.w, x	; 9d 18 03
B5_254a:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_254d:		and #$f7		; 29 f7
B5_254f:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2552:		lda #$00		; a9 00
B5_2554:		sta wEntities_438.w, x	; 9d 38 04
B5_2557:		sta wEntities_450.w, x	; 9d 50 04
B5_255a:		sta $0316		; 8d 16 03
B5_255d:		rts				; 60 


B5_255e:		lda #$03		; a9 03
B5_2560:		sta wEntitiesState.w, x	; 9d f0 03
B5_2563:		bne B5_2552 ; d0 ed

entityUpdate7e:
B5_2565:		jsr func_5_31cb		; 20 cb b1
B5_2568:		lda wEntitiesState.w, x	; bd f0 03
B5_256b:		jsr jumpTable		; 20 3d c2
	.dw $a574
	.dw $a58e
	.dw $a5e3
B5_2574:		lda #$07
B5_2576:		sta $d4			; 85 d4
B5_2578:		lda #$00		; a9 00
B5_257a:		sta $f9			; 85 f9
B5_257c:		lda #$00		; a9 00
B5_257e:		sta wEntities_3a8.w, x	; 9d a8 03
B5_2581:		sta wEntities_378.w, x	; 9d 78 03
B5_2584:		sta $fa			; 85 fa
B5_2586:		sta $fb			; 85 fb
B5_2588:		lda #$1c		; a9 1c
B5_258a:		sta wEntities_360.w, x	; 9d 60 03
B5_258d:		rts				; 60 


B5_258e:		ldy #$00		; a0 00
B5_2590:		lda wEntities_378.w, x	; bd 78 03
B5_2593:		cmp $a683, y	; d9 83 a6
B5_2596:		beq B5_25ac ; f0 14

B5_2598:		iny				; c8 
B5_2599:		cpy #$04		; c0 04
B5_259b:		bcc B5_2590 ; 90 f3

B5_259d:		tay				; a8 
B5_259e:		lda $a673, y	; b9 73 a6
B5_25a1:		sta $fa			; 85 fa
B5_25a3:		lda $a67b, y	; b9 7b a6
B5_25a6:		sta $fb			; 85 fb
B5_25a8:		inc wEntitiesState.w, x	; fe f0 03
B5_25ab:		rts				; 60 


B5_25ac:		tay				; a8 
B5_25ad:		lda $a673, y	; b9 73 a6
B5_25b0:		bmi B5_25bb ; 30 09

B5_25b2:		clc				; 18 
B5_25b3:		adc wPlayerY			; 65 cc
B5_25b5:		cmp #$de		; c9 de
B5_25b7:		bcc B5_25c4 ; 90 0b

B5_25b9:		bcs B5_25c2 ; b0 07

B5_25bb:		clc				; 18 
B5_25bc:		adc wPlayerY			; 65 cc
B5_25be:		cmp #$12		; c9 12
B5_25c0:		bcs B5_25c4 ; b0 02

B5_25c2:		lda wPlayerY			; a5 cc
B5_25c4:		sta $fa			; 85 fa
B5_25c6:		lda $a67b, y	; b9 7b a6
B5_25c9:		bmi B5_25d4 ; 30 09

B5_25cb:		clc				; 18 
B5_25cc:		adc wPlayerX			; 65 ce
B5_25ce:		cmp #$ee		; c9 ee
B5_25d0:		bcc B5_25dd ; 90 0b

B5_25d2:		bcs B5_25db ; b0 07

B5_25d4:		clc				; 18 
B5_25d5:		adc wPlayerY			; 65 cc
B5_25d7:		cmp #$12		; c9 12
B5_25d9:		bcs B5_25dd ; b0 02

B5_25db:		lda wPlayerY			; a5 cc
B5_25dd:		sta $fb			; 85 fb
B5_25df:		inc wEntitiesState.w, x	; fe f0 03
B5_25e2:		rts				; 60 


B5_25e3:		lda $fa			; a5 fa
B5_25e5:		sta $06			; 85 06
B5_25e7:		lda $fb			; a5 fb
B5_25e9:		sta $07			; 85 07
B5_25eb:		jsr $b0d8		; 20 d8 b0
B5_25ee:		jsr $b038		; 20 38 b0
B5_25f1:		jsr func_5_3067		; 20 67 b0
B5_25f4:		jsr storeCoordsOfTileUnderEntity		; 20 18 b2
B5_25f7:		jsr func_5_318c		; 20 8c b1
B5_25fa:		lda $fa			; a5 fa
B5_25fc:		sec				; 38 
B5_25fd:		sbc wEntitiesY.w, x	; fd 80 04
B5_2600:		bcs B5_2606 ; b0 04

B5_2602:		eor #$ff		; 49 ff
B5_2604:		adc #$01		; 69 01
B5_2606:		cmp #$02		; c9 02
B5_2608:		bcs B5_262a ; b0 20

B5_260a:		lda $fb			; a5 fb
B5_260c:		sec				; 38 
B5_260d:		sbc wEntitiesX.w, x	; fd b0 04
B5_2610:		bcs B5_2616 ; b0 04

B5_2612:		eor #$ff		; 49 ff
B5_2614:		adc #$01		; 69 01
B5_2616:		cmp #$02		; c9 02
B5_2618:		bcs B5_262a ; b0 10

B5_261a:		lda #$01		; a9 01
B5_261c:		sta wEntitiesState.w, x	; 9d f0 03
B5_261f:		lda wEntities_378.w, x	; bd 78 03
B5_2622:		clc				; 18 
B5_2623:		adc #$01		; 69 01
B5_2625:		and #$07		; 29 07
B5_2627:		sta wEntities_378.w, x	; 9d 78 03
B5_262a:		dec wEntities_360.w, x	; de 60 03
B5_262d:		bne B5_2662 ; d0 33

B5_262f:		lda #$1c		; a9 1c
B5_2631:		sta wEntities_360.w, x	; 9d 60 03
B5_2634:		lda #$c2		; a9 c2
B5_2636:		jsr $b268		; 20 68 b2
B5_2639:		pha				; 48 
B5_263a:		ldx $f0			; a6 f0
B5_263c:		jsr getNewRandomVal		; 20 8a c4
B5_263f:		and #$07		; 29 07
B5_2641:		tay				; a8 
B5_2642:		lda wEntitiesY.w, x	; bd 80 04
B5_2645:		clc				; 18 
B5_2646:		adc $a687, y	; 79 87 a6
B5_2649:		sta wEntitiesY.w, x	; 9d 80 04
B5_264c:		lda wEntitiesX.w, x	; bd b0 04
B5_264f:		clc				; 18 
B5_2650:		adc $a68f, y	; 79 8f a6
B5_2653:		sta wEntitiesX.w, x	; 9d b0 04
B5_2656:		lda #$00		; a9 00
B5_2658:		sta wEntities_390.w, x	; 9d 90 03
B5_265b:		lda #$bd		; a9 bd
B5_265d:		sta wEntities_378.w, x	; 9d 78 03
B5_2660:		pla				; 68 
B5_2661:		tax				; aa 
B5_2662:		rts				; 60 


entityUpdate8c:
B5_2663:		dec wEntities_378.w, x	; de 78 03
B5_2666:		bne B5_2672 ; d0 0a

B5_2668:		dec wEntities_390.w, x	; de 90 03
B5_266b:		bpl B5_2672 ; 10 05

B5_266d:		lda #$00		; a9 00
B5_266f:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2672:		rts				; 60 


B5_2673:		.db $00				; 00
B5_2674:		bcs B5_2676 ; b0 00

B5_2676:		cpy #$30		; c0 30
B5_2678:		clc				; 18 
B5_2679:		bmi B5_2663 ; 30 e8

B5_267b:		inx				; e8 
B5_267c:		cpy #$18		; c0 18
B5_267e:		;removed
	.db $50 $c0

B5_2680:		.db $00				; 00
B5_2681:		bvc B5_2683 ; 50 00

B5_2683:		.db $00				; 00
B5_2684:	.db $02
B5_2685:		ora $07			; 05 07
B5_2687:		sed				; f8 
B5_2688:		sed				; f8 
B5_2689:		.db $00				; 00
B5_268a:		php				; 08 
B5_268b:		php				; 08 
B5_268c:		php				; 08 
B5_268d:		.db $00				; 00
B5_268e:		sed				; f8 
B5_268f:		.db $00				; 00
B5_2690:		php				; 08 
B5_2691:		php				; 08 
B5_2692:		php				; 08 
B5_2693:		.db $00				; 00
B5_2694:		sed				; f8 
B5_2695:		sed				; f8 
B5_2696:		sed				; f8 
B5_2697:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_269a:		and #$f7		; 29 f7
B5_269c:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_269f:		rts				; 60 


B5_26a0:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_26a3:		ora #$08		; 09 08
B5_26a5:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_26a8:		rts				; 60 


B5_26a9:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_26ac:		ora #$40		; 09 40
B5_26ae:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_26b1:		rts				; 60 


B5_26b2:		lda wEntities_3c0.w, x	; bd c0 03
B5_26b5:		ora #$04		; 09 04
B5_26b7:		sta wEntities_3c0.w, x	; 9d c0 03
B5_26ba:		rts				; 60 


B5_26bb:		cmp #$18		; c9 18
B5_26bd:		bcc B5_26c5 ; 90 06

B5_26bf:		cmp #$e8		; c9 e8
B5_26c1:		bcs B5_26c5 ; b0 02

B5_26c3:		clc				; 18 
B5_26c4:		rts				; 60 


B5_26c5:		sec				; 38 
B5_26c6:		rts				; 60 


B5_26c7:		cmp #$20		; c9 20
B5_26c9:		bcc B5_26d1 ; 90 06

B5_26cb:		cmp #$e0		; c9 e0
B5_26cd:		bcs B5_26d1 ; b0 02

B5_26cf:		clc				; 18 
B5_26d0:		rts				; 60 


B5_26d1:		sec				; 38 
B5_26d2:		rts				; 60 


B5_26d3:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_26d6:		and #$bf		; 29 bf
B5_26d8:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_26db:		lda wEntities_408.w, x	; bd 08 04
B5_26de:		and #$18		; 29 18
B5_26e0:		cmp #$08		; c9 08
B5_26e2:		beq B5_26a9 ; f0 c5

B5_26e4:		rts				; 60 


entityUpdate6a:
entityUpdate6b:
B5_26e5:		lda wEntitiesState.w, x	; bd f0 03
B5_26e8:		jsr jumpTable		; 20 3d c2
	.dw $a6f1
	.dw $a750
	.dw $a795
B5_26f1:		cpx #$17		; e0 17
B5_26f3:		bcs B5_2701 ; b0 0c

B5_26f5:		lda $0301, x	; bd 01 03
B5_26f8:		and #$10		; 29 10
B5_26fa:		bne B5_274f ; d0 53

B5_26fc:		dec wEntities_378.w, x	; de 78 03
B5_26ff:		bne B5_274f ; d0 4e

B5_2701:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2704:		and #$e0		; 29 e0
B5_2706:		ora #$05		; 09 05
B5_2708:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_270b:		lda #$c4		; a9 c4
B5_270d:		sta wEntities_330.w, x	; 9d 30 03
B5_2710:		lda wEntities_408.w, x	; bd 08 04
B5_2713:		and #$08		; 29 08
B5_2715:		beq B5_271c ; f0 05

B5_2717:		jsr $b12e		; 20 2e b1
B5_271a:		bne B5_271f ; d0 03

B5_271c:		jsr $b113		; 20 13 b1
B5_271f:		jsr getNewRandomVal		; 20 8a c4
B5_2722:		and #$03		; 29 03
B5_2724:		tay				; a8 
B5_2725:		lda $a7c3, y	; b9 c3 a7
B5_2728:		clc				; 18 
B5_2729:		adc wEntities_3a8.w, x	; 7d a8 03
B5_272c:		jsr $a6c7		; 20 c7 a6
B5_272f:		bcc B5_2739 ; 90 08

B5_2731:		lda #$01		; a9 01
B5_2733:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2736:		sta $0377, x	; 9d 77 03
B5_2739:		sta wEntities_3a8.w, x	; 9d a8 03
B5_273c:		jsr $a6d3		; 20 d3 a6
B5_273f:		lda #$01		; a9 01
B5_2741:		sta wEntities_378.w, x	; 9d 78 03
B5_2744:		lda wEntities_390.w, x	; bd 90 03
B5_2747:		and #$c0		; 29 c0
B5_2749:		sta wEntities_390.w, x	; 9d 90 03
B5_274c:		inc wEntitiesState.w, x	; fe f0 03
B5_274f:		rts				; 60 


B5_2750:		jsr $a799		; 20 99 a7
B5_2753:		jsr $b13e		; 20 3e b1
B5_2756:		beq B5_2794 ; f0 3c

B5_2758:		lda wEntities_390.w, x	; bd 90 03
B5_275b:		asl a			; 0a
B5_275c:		bcs B5_2767 ; b0 09

B5_275e:		jsr $b0d0		; 20 d0 b0
B5_2761:		and #$10		; 29 10
B5_2763:		ora #$08		; 09 08
B5_2765:		bne B5_2777 ; d0 10

B5_2767:		jsr $b0d0		; 20 d0 b0
B5_276a:		tay				; a8 
B5_276b:		lda #$00		; a9 00
B5_276d:		cpy #$08		; c0 08
B5_276f:		bcc B5_2777 ; 90 06

B5_2771:		cpy #$19		; c0 19
B5_2773:		bcs B5_2777 ; b0 02

B5_2775:		lda #$10		; a9 10
B5_2777:		jsr $b038		; 20 38 b0
B5_277a:		jsr $a6d3		; 20 d3 a6
B5_277d:		lda wEntitiesId.w, x	; bd 18 03
B5_2780:		eor #$01		; 49 01
B5_2782:		sta wEntitiesId.w, x	; 9d 18 03
B5_2785:		lda #$00		; a9 00
B5_2787:		sta wEntities_390.w, x	; 9d 90 03
B5_278a:		lda #$01		; a9 01
B5_278c:		sta wEntities_378.w, x	; 9d 78 03
B5_278f:		lda #$02		; a9 02
B5_2791:		sta wEntitiesState.w, x	; 9d f0 03
B5_2794:		rts				; 60 


B5_2795:		jsr $a799		; 20 99 a7
B5_2798:		rts				; 60 


B5_2799:		dec wEntities_378.w, x	; de 78 03
B5_279c:		bne B5_27b8 ; d0 1a

B5_279e:		lda wEntities_390.w, x	; bd 90 03
B5_27a1:		and #$03		; 29 03
B5_27a3:		tay				; a8 
B5_27a4:		lda $a7c6, y	; b9 c6 a7
B5_27a7:		sta wEntities_378.w, x	; 9d 78 03
B5_27aa:		lda $a7ca, y	; b9 ca a7
B5_27ad:		jsr $b045		; 20 45 b0
B5_27b0:		iny				; c8 
B5_27b1:		tya				; 98 
B5_27b2:		ora wEntities_390.w, x	; 1d 90 03
B5_27b5:		sta wEntities_390.w, x	; 9d 90 03
B5_27b8:		jsr func_5_3067		; 20 67 b0
B5_27bb:		bcc B5_27c2 ; 90 05

B5_27bd:		lda #$00		; a9 00
B5_27bf:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_27c2:		rts				; 60 


B5_27c3:		bne B5_27c5 ; d0 00

B5_27c5:		bmi B5_2803 ; 30 3c

B5_27c7:	.db $1e $1e $00
B5_27ca:		ldy #$80		; a0 80
B5_27cc:		rts				; 60 


B5_27cd:		.db $00				; 00


entityUpdate68:
B5_27ce:		dec wEntities_378.w, x	; de 78 03
B5_27d1:		bne B5_27f5 ; d0 22

B5_27d3:		lda wEntities_438.w, x	; bd 38 04
B5_27d6:		eor #$01		; 49 01
B5_27d8:		sta wEntities_438.w, x	; 9d 38 04
B5_27db:		ldy wEntitiesState.w, x	; bc f0 03
B5_27de:		lda $a7f6, y	; b9 f6 a7
B5_27e1:		sta wEntities_378.w, x	; 9d 78 03
B5_27e4:		lda wEntitiesY.w, x	; bd 80 04
B5_27e7:		clc				; 18 
B5_27e8:		adc $a7fa, y	; 79 fa a7
B5_27eb:		sta wEntitiesY.w, x	; 9d 80 04
B5_27ee:		iny				; c8 
B5_27ef:		tya				; 98 
B5_27f0:		and #$03		; 29 03
B5_27f2:		sta wEntitiesState.w, x	; 9d f0 03
B5_27f5:		rts				; 60 


B5_27f6:		php				; 08 
B5_27f7:		asl $08			; 06 08
B5_27f9:		sei				; 78 
B5_27fa:	.db $04
B5_27fb:	.db $fc
B5_27fc:	.db $04
B5_27fd:	.db $fc


entityUpdate69:
B5_27fe:		dec wEntities_378.w, x	; de 78 03
B5_2801:		bne B5_282a ; d0 27

B5_2803:		lda wEntities_438.w, x	; bd 38 04
B5_2806:		eor #$01		; 49 01
B5_2808:		sta wEntities_438.w, x	; 9d 38 04
B5_280b:		beq B5_2810 ; f0 03

B5_280d:		jsr $a82f		; 20 2f a8
B5_2810:		ldy wEntitiesState.w, x	; bc f0 03
B5_2813:		lda $a82b, y	; b9 2b a8
B5_2816:		sta wEntities_378.w, x	; 9d 78 03
B5_2819:		lda wEntitiesY.w, x	; bd 80 04
B5_281c:		clc				; 18 
B5_281d:		adc $a82d, y	; 79 2d a8
B5_2820:		sta wEntitiesY.w, x	; 9d 80 04
B5_2823:		iny				; c8 
B5_2824:		tya				; 98 
B5_2825:		and #$01		; 29 01
B5_2827:		sta wEntitiesState.w, x	; 9d f0 03
B5_282a:		rts				; 60 


B5_282b:		asl $041e, x	; 1e 1e 04
B5_282e:	.db $fc
B5_282f:		lda #$b3		; a9 b3
B5_2831:		jsr $b268		; 20 68 b2
B5_2834:		lda $f0			; a5 f0
B5_2836:		sta $00			; 85 00
B5_2838:		jsr getNewRandomVal		; 20 8a c4
B5_283b:		and #$03		; 29 03
B5_283d:		tay				; a8 
B5_283e:		lda wPlayerY			; a5 cc
B5_2840:		pha				; 48 
B5_2841:		clc				; 18 
B5_2842:		adc $a85d, y	; 79 5d a8
B5_2845:		sta wPlayerY			; 85 cc
B5_2847:		ldy $00			; a4 00
B5_2849:		sta wEntities_3a8.w, y	; 99 a8 03
B5_284c:		jsr $b0d0		; 20 d0 b0
B5_284f:		ldy $00			; a4 00
B5_2851:		sta wEntities_408.w, y	; 99 08 04
B5_2854:		pla				; 68 
B5_2855:		sta wPlayerY			; 85 cc
B5_2857:		lda wPlayerX			; a5 ce
B5_2859:		sta wEntities_390.w, y	; 99 90 03
B5_285c:		rts				; 60 


B5_285d:		cpx #$00		; e0 00
B5_285f:		.db $20 $00


entityUpdate8a:
	lda wEntitiesState.w, x

B5_2864:		jsr jumpTable		; 20 3d c2
	.dw $a86b
	.dw $a8c0
B5_286b:		lda wEntities_408.w, x	; bd 08 04
B5_286e:		beq B5_288f ; f0 1f

B5_2870:		cmp #$10		; c9 10
B5_2872:		beq B5_288f ; f0 1b

B5_2874:		lda wEntities_408.w, x	; bd 08 04
B5_2877:		and #$10		; 29 10
B5_2879:		bne B5_2885 ; d0 0a

B5_287b:		lda wEntities_390.w, x	; bd 90 03
B5_287e:		cmp wEntitiesX.w, x	; dd b0 04
B5_2881:		bcc B5_28b7 ; 90 34

B5_2883:		bcs B5_28ac ; b0 27

B5_2885:		lda wEntities_390.w, x	; bd 90 03
B5_2888:		cmp wEntitiesX.w, x	; dd b0 04
B5_288b:		bcs B5_28b7 ; b0 2a

B5_288d:		bcc B5_28ac ; 90 1d

B5_288f:		lda wEntities_408.w, x	; bd 08 04
B5_2892:		cmp #$08		; c9 08
B5_2894:		bcc B5_28a4 ; 90 0e

B5_2896:		cmp #$18		; c9 18
B5_2898:		bcs B5_28a4 ; b0 0a

B5_289a:		lda wEntities_3a8.w, x	; bd a8 03
B5_289d:		cmp wEntitiesY.w, x	; dd 80 04
B5_28a0:		bcc B5_28b7 ; 90 15

B5_28a2:		bcs B5_28ac ; b0 08

B5_28a4:		lda wEntitiesY.w, x	; bd 80 04
B5_28a7:		cmp wEntities_3a8.w, x	; dd a8 03
B5_28aa:		bcc B5_28b7 ; 90 0b

B5_28ac:		jsr func_5_3067		; 20 67 b0
B5_28af:		bcc B5_28b6 ; 90 05

B5_28b1:		lda #$00		; a9 00
B5_28b3:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_28b6:		rts				; 60 


B5_28b7:		lda #$78		; a9 78
B5_28b9:		sta wEntities_378.w, x	; 9d 78 03
B5_28bc:		inc wEntitiesState.w, x	; fe f0 03
B5_28bf:		rts				; 60 


B5_28c0:		jsr $b0d0		; 20 d0 b0
B5_28c3:		jsr $b038		; 20 38 b0
B5_28c6:		dec wEntities_378.w, x	; de 78 03
B5_28c9:		bne B5_28d0 ; d0 05

B5_28cb:		lda #$00		; a9 00
B5_28cd:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_28d0:		rts				; 60 


entityUpdate6c:
B5_28d1:		lda wEntitiesState.w, x	; bd f0 03
B5_28d4:		jsr jumpTable		; 20 3d c2
	.dw $a8df
	.dw $a8f0
	.dw $a91d
	.dw $a93c
B5_28df:		lda #$b4
B5_28e1:		sta wEntities_3a8.w, x
B5_28e4:		jsr $a965		; 20 65 a9
B5_28e7:		bcc B5_28ec ; 90 03

B5_28e9:		inc wEntitiesState.w, x	; fe f0 03
B5_28ec:		inc wEntitiesState.w, x	; fe f0 03
B5_28ef:		rts				; 60 


B5_28f0:		dec wEntities_378.w, x	; de 78 03
B5_28f3:		bne B5_28fa ; d0 05

B5_28f5:		jsr $a965		; 20 65 a9
B5_28f8:		bcs B5_290e ; b0 14

B5_28fa:		dec wEntities_3a8.w, x	; de a8 03
B5_28fd:		beq B5_2912 ; f0 13

B5_28ff:		lda #$01		; a9 01
B5_2901:		sta wEntities_438.w, x	; 9d 38 04
B5_2904:		jsr func_5_3067		; 20 67 b0
B5_2907:		bcc B5_2911 ; 90 08

B5_2909:		jsr $a965		; 20 65 a9
B5_290c:		bcc B5_2911 ; 90 03

B5_290e:		inc wEntitiesState.w, x	; fe f0 03
B5_2911:		rts				; 60 


B5_2912:		lda #$7c		; a9 7c
B5_2914:		sta wEntities_378.w, x	; 9d 78 03
B5_2917:		lda #$03		; a9 03
B5_2919:		sta wEntitiesState.w, x	; 9d f0 03
B5_291c:		rts				; 60 


B5_291d:		dec wEntities_378.w, x	; de 78 03
B5_2920:		lda wEntities_378.w, x	; bd 78 03
B5_2923:		cmp #$64		; c9 64
B5_2925:		bcc B5_2936 ; 90 0f

B5_2927:		lda #$00		; a9 00
B5_2929:		sta wEntities_438.w, x	; 9d 38 04
B5_292c:		jsr func_5_3067		; 20 67 b0
B5_292f:		bcc B5_293b ; 90 0a

B5_2931:		jsr $a965		; 20 65 a9
B5_2934:		bcs B5_293b ; b0 05

B5_2936:		lda #$01		; a9 01
B5_2938:		sta wEntitiesState.w, x	; 9d f0 03
B5_293b:		rts				; 60 


B5_293c:		dec wEntities_378.w, x	; de 78 03
B5_293f:		bne B5_2954 ; d0 13

B5_2941:		lda #$00		; a9 00
B5_2943:		sta wEntitiesState.w, x	; 9d f0 03
B5_2946:		jsr getNewRandomVal		; 20 8a c4
B5_2949:		lsr a			; 4a
B5_294a:		bcs B5_2951 ; b0 05

B5_294c:		jsr $a9a0		; 20 a0 a9
B5_294f:		bcc B5_2954 ; 90 03

B5_2951:		jsr $a82f		; 20 2f a8
B5_2954:		lda wEntities_378.w, x	; bd 78 03
B5_2957:		and #$01		; 29 01
B5_2959:		tay				; a8 
B5_295a:		lda wEntitiesX.w, x	; bd b0 04
B5_295d:		clc				; 18 
B5_295e:		adc $a99e, y	; 79 9e a9
B5_2961:		sta wEntitiesX.w, x	; 9d b0 04
B5_2964:		rts				; 60 


B5_2965:		lda #$78		; a9 78
B5_2967:		sta wEntities_378.w, x	; 9d 78 03
B5_296a:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_296d:		and #$40		; 29 40
B5_296f:		sta $00			; 85 00
B5_2971:		jsr getNewRandomVal		; 20 8a c4
B5_2974:		and #$1c		; 29 1c
B5_2976:		jsr $b038		; 20 38 b0
B5_2979:		and #$1f		; 29 1f
B5_297b:		beq B5_299c ; f0 1f

B5_297d:		cmp #$10		; c9 10
B5_297f:		beq B5_299c ; f0 1b

B5_2981:		bcs B5_298a ; b0 07

B5_2983:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2986:		ora #$40		; 09 40
B5_2988:		bne B5_298f ; d0 05

B5_298a:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_298d:		and #$bf		; 29 bf
B5_298f:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2992:		eor #$40		; 49 40
B5_2994:		and #$40		; 29 40
B5_2996:		cmp $00			; c5 00
B5_2998:		bne B5_299c ; d0 02

B5_299a:		sec				; 38 
B5_299b:		rts				; 60 


B5_299c:		clc				; 18 
B5_299d:		rts				; 60 


B5_299e:		inc $ad02, x	; fe 02 ad
B5_29a1:		php				; 08 
B5_29a2:	.db $03
B5_29a3:		bpl B5_29a7 ; 10 02

B5_29a5:		sec				; 38 
B5_29a6:		rts				; 60 


B5_29a7:		lda #$08		; a9 08
B5_29a9:		sta wEntities_390.w, x	; 9d 90 03
B5_29ac:		lda #$30		; a9 30
B5_29ae:		jsr queueSoundAtoPlay		; 20 ad c4
B5_29b1:		txa				; 8a 
B5_29b2:		ldy #$07		; a0 07
B5_29b4:		pha				; 48 
B5_29b5:		tax				; aa 
B5_29b6:		clc				; 18 
B5_29b7:		lda $aa1c, y	; b9 1c aa
B5_29ba:		bmi B5_29c3 ; 30 07

B5_29bc:		adc wEntitiesX.w, x	; 7d b0 04
B5_29bf:		bcs B5_2a0d ; b0 4c

B5_29c1:		bcc B5_29c8 ; 90 05

B5_29c3:		adc wEntitiesX.w, x	; 7d b0 04
B5_29c6:		bcc B5_2a0d ; 90 45

B5_29c8:		sta $00			; 85 00
B5_29ca:		clc				; 18 
B5_29cb:		lda $aa14, y	; b9 14 aa
B5_29ce:		bmi B5_29d7 ; 30 07

B5_29d0:		adc wEntitiesY.w, x	; 7d 80 04
B5_29d3:		bcs B5_2a0d ; b0 38

B5_29d5:		bcc B5_29dc ; 90 05

B5_29d7:		adc wEntitiesY.w, x	; 7d 80 04
B5_29da:		bcc B5_2a0d ; 90 31

B5_29dc:		sta $01			; 85 01
B5_29de:		tya				; 98 
B5_29df:		pha				; 48 
B5_29e0:		lda wEntities_390.w, x	; bd 90 03
B5_29e3:		inc wEntities_390.w, x	; fe 90 03
B5_29e6:		tax				; aa 
B5_29e7:		lda $00			; a5 00
B5_29e9:		sta wEntitiesX.w, x	; 9d b0 04
B5_29ec:		lda $01			; a5 01
B5_29ee:		sta wEntitiesY.w, x	; 9d 80 04
B5_29f1:		lda #$c3		; a9 c3
B5_29f3:		jsr initNpcSpecAIdxX		; 20 ec c3
B5_29f6:		lda #$01		; a9 01
B5_29f8:		sta wEntities_390.w, x	; 9d 90 03
B5_29fb:		lda #$2c		; a9 2c
B5_29fd:		sta wEntities_378.w, x	; 9d 78 03
B5_2a00:		jsr drawEntities		; 20 03 c4
B5_2a03:		jsr drawPlayer		; 20 dd c3
B5_2a06:		lda #$04		; a9 04
B5_2a08:		jsr waitForAnumberOfMajorityOfNMIFuncsDone		; 20 3f c1
B5_2a0b:		pla				; 68 
B5_2a0c:		tay				; a8 
B5_2a0d:		pla				; 68 
B5_2a0e:		dey				; 88 
B5_2a0f:		bpl B5_29b4 ; 10 a3

B5_2a11:		tax				; aa 
B5_2a12:		clc				; 18 
B5_2a13:		rts				; 60 


B5_2a14:		cpx #$00		; e0 00
B5_2a16:		jsr $2028		; 20 28 20
B5_2a19:		.db $00				; 00
B5_2a1a:		cpx #$d8		; e0 d8
B5_2a1c:		jsr $2028		; 20 28 20
B5_2a1f:		.db $00				; 00
B5_2a20:		cpx #$d8		; e0 d8
B5_2a22:		cpx #$00		; e0 00


entityUpdate8d:
B5_2a24:		jsr $b0d0		; 20 d0 b0
B5_2a27:		jsr $b038		; 20 38 b0
B5_2a2a:		dec wEntities_378.w, x	; de 78 03
B5_2a2d:		bne B5_2a39 ; d0 0a

B5_2a2f:		dec wEntities_390.w, x	; de 90 03
B5_2a32:		bpl B5_2a39 ; 10 05

B5_2a34:		lda #$00		; a9 00
B5_2a36:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2a39:		rts				; 60 


entityUpdate6d:
entityUpdate6e:
B5_2a3a:		lda wEntitiesState.w, x	; bd f0 03
B5_2a3d:		jsr jumpTable		; 20 3d c2
	.dw $aa46
	.dw $aa66
	.dw $aa89
B5_2a46:		dec wEntities_378.w, x	; de 78 03
B5_2a49:		bne B5_2a5b ; d0 10

B5_2a4b:		lda #$04		; a9 04
B5_2a4d:		sta wEntities_378.w, x	; 9d 78 03
B5_2a50:		jsr getNewRandomVal		; 20 8a c4
B5_2a53:		and #$1c		; 29 1c
B5_2a55:		jsr $b038		; 20 38 b0
B5_2a58:		inc wEntitiesState.w, x	; fe f0 03
B5_2a5b:		jsr $aaf0		; 20 f0 aa
B5_2a5e:		rts				; 60 


B5_2a5f:		.db $00				; 00
B5_2a60:		sei				; 78 
B5_2a61:		asl $783c, x	; 1e 3c 78
B5_2a64:	.db $3c
B5_2a65:		sei				; 78 
B5_2a66:		clc				; 18 
B5_2a67:		jsr $aaa6		; 20 a6 aa
B5_2a6a:		jsr func_5_3067		; 20 67 b0
B5_2a6d:		dec wEntities_378.w, x	; de 78 03
B5_2a70:		bne B5_2a85 ; d0 13

B5_2a72:		jsr getNewRandomVal		; 20 8a c4
B5_2a75:		and #$07		; 29 07
B5_2a77:		beq B5_2a72 ; f0 f9

B5_2a79:		tay				; a8 
B5_2a7a:		lda $aa5f, y	; b9 5f aa
B5_2a7d:		sta wEntities_378.w, x	; 9d 78 03
B5_2a80:		lda #$00		; a9 00
B5_2a82:		sta wEntitiesState.w, x	; 9d f0 03
B5_2a85:		jsr $aaf0		; 20 f0 aa
B5_2a88:		rts				; 60 


B5_2a89:		sec				; 38 
B5_2a8a:		jsr $aaa6		; 20 a6 aa
B5_2a8d:		dec wEntities_378.w, x	; de 78 03
B5_2a90:		beq B5_2a9d ; f0 0b

B5_2a92:		jsr func_5_3067		; 20 67 b0
B5_2a95:		bcc B5_2a9c ; 90 05

B5_2a97:		lda #$00		; a9 00
B5_2a99:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2a9c:		rts				; 60 


B5_2a9d:		lda #$00		; a9 00
B5_2a9f:		sta wEntitiesState.w, x	; 9d f0 03
B5_2aa2:		jsr $b045		; 20 45 b0
B5_2aa5:		rts				; 60 


B5_2aa6:		ldy #$6d		; a0 6d
B5_2aa8:		lda #$00		; a9 00
B5_2aaa:		rol a			; 2a
B5_2aab:		sta $00			; 85 00
B5_2aad:		bne B5_2abd ; d0 0e

B5_2aaf:		lda wEntities_408.w, x	; bd 08 04
B5_2ab2:		cmp #$18		; c9 18
B5_2ab4:		bcs B5_2aba ; b0 04

B5_2ab6:		and #$18		; 29 18
B5_2ab8:		bne B5_2ac5 ; d0 0b

B5_2aba:		iny				; c8 
B5_2abb:		bne B5_2ac5 ; d0 08

B5_2abd:		lda wPlayerY			; a5 cc
B5_2abf:		cmp wEntitiesY.w, x	; dd 80 04
B5_2ac2:		bcs B5_2ac5 ; b0 01

B5_2ac4:		iny				; c8 
B5_2ac5:		tya				; 98 
B5_2ac6:		sta wEntitiesId.w, x	; 9d 18 03
B5_2ac9:		lda $00			; a5 00
B5_2acb:		bne B5_2ae4 ; d0 17

B5_2acd:		lda wEntities_408.w, x	; bd 08 04
B5_2ad0:		and #$10		; 29 10
B5_2ad2:		bne B5_2adb ; d0 07

B5_2ad4:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2ad7:		ora #$40		; 09 40
B5_2ad9:		bne B5_2ae0 ; d0 05

B5_2adb:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2ade:		and #$bf		; 29 bf
B5_2ae0:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2ae3:		rts				; 60 


B5_2ae4:		jsr $b250		; 20 50 b2
B5_2ae7:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2aea:		eor #$40		; 49 40
B5_2aec:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2aef:		rts				; 60 


B5_2af0:		lda wEntitiesX.w, x	; bd b0 04
B5_2af3:		sec				; 38 
B5_2af4:		sbc $ce			; e5 ce
B5_2af6:		cmp #$32		; c9 32
B5_2af8:		bcc B5_2afe ; 90 04

B5_2afa:		cmp #$ce		; c9 ce
B5_2afc:		bcc B5_2b23 ; 90 25

B5_2afe:		lda wEntitiesY.w, x	; bd 80 04
B5_2b01:		sec				; 38 
B5_2b02:		sbc $cc			; e5 cc
B5_2b04:		cmp #$32		; c9 32
B5_2b06:		bcc B5_2b0c ; 90 04

B5_2b08:		cmp #$ce		; c9 ce
B5_2b0a:		bcc B5_2b23 ; 90 17

B5_2b0c:		lda #$02		; a9 02
B5_2b0e:		sta wEntitiesState.w, x	; 9d f0 03
B5_2b11:		lda #$3c		; a9 3c
B5_2b13:		sta wEntities_378.w, x	; 9d 78 03
B5_2b16:		lda #$60		; a9 60
B5_2b18:		jsr $b045		; 20 45 b0
B5_2b1b:		jsr $b0d0		; 20 d0 b0
B5_2b1e:		and #$1c		; 29 1c
B5_2b20:		jsr $b038		; 20 38 b0
B5_2b23:		rts				; 60 


entityUpdate72:
entityUpdate73:
B5_2b24:		lda wEntitiesState.w, x	; bd f0 03
B5_2b27:		jsr jumpTable		; 20 3d c2
	.dw $ab34
	.dw $ab97
	.dw $abb7
	.dw $abf4
	.dw $ac36
B5_2b34:		dec wEntities_378.w, x	; de 78 03
B5_2b37:		bne B5_2b80 ; d0 47

B5_2b39:		jsr getNewRandomVal		; 20 8a c4
B5_2b3c:		and #$07		; 29 07
B5_2b3e:		cmp #$06		; c9 06
B5_2b40:		bcs B5_2b39 ; b0 f7

B5_2b42:		tay				; a8 
B5_2b43:		lda $ab81, y	; b9 81 ab
B5_2b46:		tay				; a8 
B5_2b47:		lda $ab87, y	; b9 87 ab
B5_2b4a:		sta wEntitiesX.w, x	; 9d b0 04
B5_2b4d:		lda $ab8b, y	; b9 8b ab
B5_2b50:		sta wEntitiesY.w, x	; 9d 80 04
B5_2b53:		lda $ab8f, y	; b9 8f ab
B5_2b56:		sta wEntities_3a8.w, x	; 9d a8 03
B5_2b59:		lda $ab93, y	; b9 93 ab
B5_2b5c:		sta wEntities_408.w, x	; 9d 08 04
B5_2b5f:		ldy #$80		; a0 80
B5_2b61:		and #$10		; 29 10
B5_2b63:		beq B5_2b67 ; f0 02

B5_2b65:		ldy #$c0		; a0 c0
B5_2b67:		tya				; 98 
B5_2b68:		sta wEntities_390.w, x	; 9d 90 03
B5_2b6b:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2b6e:		and #$c0		; 29 c0
B5_2b70:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2b73:		lda #$72		; a9 72
B5_2b75:		sta wEntitiesId.w, x	; 9d 18 03
B5_2b78:		lda #$00		; a9 00
B5_2b7a:		sta wEntities_438.w, x	; 9d 38 04
B5_2b7d:		inc wEntitiesState.w, x	; fe f0 03
B5_2b80:		rts				; 60 


B5_2b81:	.db $03
B5_2b82:		.db $00				; 00
B5_2b83:		ora ($02, x)	; 01 02
B5_2b85:	.db $03
B5_2b86:		.db $00				; 00
B5_2b87:		cpy #$20		; c0 20
B5_2b89:		bvc B5_2b6b ; 50 e0

B5_2b8b:		;removed
	.db $30 $60

B5_2b8d:		bcc B5_2b47 ; 90 b8

B5_2b8f:		rts				; 60 


B5_2b90:	.db $80
B5_2b91:		bcs B5_2b13 ; b0 80

B5_2b93:		tya				; 98 
B5_2b94:		dey				; 88 
B5_2b95:		dey				; 88 
B5_2b96:		tya				; 98 
B5_2b97:		lda wEntities_438.w, x	; bd 38 04
B5_2b9a:		cmp #$02		; c9 02
B5_2b9c:		bne B5_2ba6 ; d0 08

B5_2b9e:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2ba1:		ora #$0d		; 09 0d
B5_2ba3:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2ba6:		jsr func_5_3067		; 20 67 b0
B5_2ba9:		jsr $b13e		; 20 3e b1
B5_2bac:		beq B5_2bb6 ; f0 08

B5_2bae:		lda #$3c		; a9 3c
B5_2bb0:		sta wEntities_378.w, x	; 9d 78 03
B5_2bb3:		inc wEntitiesState.w, x	; fe f0 03
B5_2bb6:		rts				; 60 


B5_2bb7:		dec wEntities_378.w, x	; de 78 03
B5_2bba:		bne B5_2be0 ; d0 24

B5_2bbc:		jsr getNewRandomVal		; 20 8a c4
B5_2bbf:		and #$03		; 29 03
B5_2bc1:		beq B5_2be1 ; f0 1e

B5_2bc3:		lda #$72		; a9 72
B5_2bc5:		sta wEntitiesId.w, x	; 9d 18 03
B5_2bc8:		jsr $a6a0		; 20 a0 a6
B5_2bcb:		jsr $b0d0		; 20 d0 b0
B5_2bce:		jsr $b038		; 20 38 b0
B5_2bd1:		lda #$00		; a9 00
B5_2bd3:		jsr $b045		; 20 45 b0
B5_2bd6:		lda #$1e		; a9 1e
B5_2bd8:		sta wEntities_378.w, x	; 9d 78 03
B5_2bdb:		lda #$03		; a9 03
B5_2bdd:		sta wEntitiesState.w, x	; 9d f0 03
B5_2be0:		rts				; 60 


B5_2be1:		jsr $a697		; 20 97 a6
B5_2be4:		lda #$73		; a9 73
B5_2be6:		sta wEntitiesId.w, x	; 9d 18 03
B5_2be9:		lda #$00		; a9 00
B5_2beb:		sta wEntities_438.w, x	; 9d 38 04
B5_2bee:		lda #$04		; a9 04
B5_2bf0:		sta wEntitiesState.w, x	; 9d f0 03
B5_2bf3:		rts				; 60 


B5_2bf4:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2bf7:		and #$f8		; 29 f8
B5_2bf9:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2bfc:		dec wEntities_378.w, x	; de 78 03
B5_2bff:		beq B5_2c21 ; f0 20

B5_2c01:		ldy #$00		; a0 00
B5_2c03:		lda wEntities_378.w, x	; bd 78 03
B5_2c06:		cmp #$0a		; c9 0a
B5_2c08:		bcc B5_2c18 ; 90 0e

B5_2c0a:		iny				; c8 
B5_2c0b:		cmp #$14		; c9 14
B5_2c0d:		bcc B5_2c18 ; 90 09

B5_2c0f:		iny				; c8 
B5_2c10:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2c13:		ora #$05		; 09 05
B5_2c15:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2c18:		tya				; 98 
B5_2c19:		sta wEntities_438.w, x	; 9d 38 04
B5_2c1c:		jsr func_5_3067		; 20 67 b0
B5_2c1f:		bcc B5_2c35 ; 90 14

B5_2c21:		lda #$3c		; a9 3c
B5_2c23:		sta wEntities_378.w, x	; 9d 78 03
B5_2c26:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2c29:		and #$80		; 29 80
B5_2c2b:		ora #$10		; 09 10
B5_2c2d:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2c30:		lda #$00		; a9 00
B5_2c32:		sta wEntitiesState.w, x	; 9d f0 03
B5_2c35:		rts				; 60 


B5_2c36:		lda wEntities_438.w, x	; bd 38 04
B5_2c39:		cmp #$08		; c9 08
B5_2c3b:		beq B5_2c3e ; f0 01

B5_2c3d:		rts				; 60 


B5_2c3e:		jsr $a6a0		; 20 a0 a6
B5_2c41:		txa				; 8a 
B5_2c42:		pha				; 48 
B5_2c43:		ldy #$04		; a0 04
B5_2c45:		jsr palettesBGFadeOut		; 20 0e c6
B5_2c48:		lda #$2f		; a9 2f
B5_2c4a:		jsr queueSoundAtoPlay		; 20 ad c4
B5_2c4d:		lda #$00		; a9 00
B5_2c4f:		tay				; a8 
B5_2c50:		ldx #$08		; a2 08
B5_2c52:		lda $acd2, y	; b9 d2 ac
B5_2c55:		sta wEntitiesX.w, x	; 9d b0 04
B5_2c58:		lda $ace8, y	; b9 e8 ac
B5_2c5b:		sta wEntitiesY.w, x	; 9d 80 04
B5_2c5e:		lda $acfe, y	; b9 fe ac
B5_2c61:		jsr initNpcSpecAIdxX		; 20 ec c3
B5_2c64:		iny				; c8 
B5_2c65:		tya				; 98 
B5_2c66:		pha				; 48 
B5_2c67:		jsr drawEntities		; 20 03 c4
B5_2c6a:		jsr drawPlayer		; 20 dd c3
B5_2c6d:		ldx #$02		; a2 02
B5_2c6f:		lda wMajorNMIUpdatesCounter			; a5 23
B5_2c71:		and #$04		; 29 04
B5_2c73:		bne B5_2c77 ; d0 02

B5_2c75:		ldx #$0f		; a2 0f
.ifndef NO_FLASH
B5_2c77:		stx wInternalPalettesInvisColour.w		; 8e b0 06
.else
B5_2c77:	.db $ea $ea $ea
.endif
B5_2c7a:		stx $30			; 86 30
B5_2c7c:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B5_2c7f:		pla				; 68 
B5_2c80:		tax				; aa 
B5_2c81:		cmp #$16		; c9 16
B5_2c83:		bcs B5_2c91 ; b0 0c

B5_2c85:		cmp #$0b		; c9 0b
B5_2c87:		bne B5_2c8e ; d0 05

B5_2c89:		lda #$2f		; a9 2f
B5_2c8b:		jsr queueSoundAtoPlay		; 20 ad c4
B5_2c8e:		txa				; 8a 
B5_2c8f:		bpl B5_2c4f ; 10 be

B5_2c91:		lda #$00		; a9 00
B5_2c93:		sta $0308		; 8d 08 03
B5_2c96:		jsr drawEntities		; 20 03 c4
B5_2c99:		jsr drawPlayer		; 20 dd c3
B5_2c9c:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B5_2c9f:		lda #$20		; a9 20
B5_2ca1:		jsr queueSoundAtoPlay		; 20 ad c4
B5_2ca4:		lda #$24		; a9 24
B5_2ca6:		sta wPlayerKnockbackCounter			; 85 c7
B5_2ca8:		lda wPlayerDirection			; a5 c3
B5_2caa:		lsr a			; 4a
B5_2cab:		eor #$02		; 49 02
B5_2cad:		sta wPlayerDirection			; 85 c3
B5_2caf:		lda wEntityDataByte1			; a5 51
B5_2cb1:		and #$18		; 29 18
B5_2cb3:		lsr a			; 4a
B5_2cb4:		lsr a			; 4a
B5_2cb5:		lsr a			; 4a
B5_2cb6:		tay				; a8 
B5_2cb7:		lda $ad14, y	; b9 14 ad
B5_2cba:		clc				; 18 
B5_2cbb:		adc wHealthTaken			; 65 79
B5_2cbd:		sta wHealthTaken			; 85 79
B5_2cbf:		ldx #$0f		; a2 0f
B5_2cc1:		sta wInternalPalettesInvisColour.w		; 8d b0 06
B5_2cc4:		stx $30			; 86 30
B5_2cc6:		ldy #$04		; a0 04
B5_2cc8:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B5_2cca:		jsr palettesBGFadeOut_saveSpecADelayY		; 20 ff c5
B5_2ccd:		pla				; 68 
B5_2cce:		tax				; aa 
B5_2ccf:		jmp $abc3		; 4c c3 ab


B5_2cd2:		ldy $ae			; a4 ae
B5_2cd4:		clv				; b8 
B5_2cd5:	.db $c2
B5_2cd6:	.db $a3
B5_2cd7:	.db $9e
B5_2cd8:		cpy $ee94		; cc 94 ee
B5_2cdb:		txa				; 8a 
B5_2cdc:	.db $80
B5_2cdd:	.db $34
B5_2cde:		rol a			; 2a
B5_2cdf:		jsr $5353		; 20 53 53
B5_2ce2:		ror $3153		; 6e 53 31
B5_2ce5:		bit $4727		; 2c 27 47
B5_2ce8:	.db $04
B5_2ce9:	.db $1f
B5_2cea:	.db $3c
B5_2ceb:	.db $57
B5_2cec:	.db $62
B5_2ced:		ror a			; 6a
B5_2cee:	.db $72
B5_2cef:		sty $87			; 84 87
B5_2cf1:	.db $9f
B5_2cf2:		tsx				; ba 
B5_2cf3:	.db $04
B5_2cf4:	.db $1f
B5_2cf5:	.db $3a
B5_2cf6:	.db $3f
B5_2cf7:	.db $47
B5_2cf8:	.db $54
B5_2cf9:	.db $5f
B5_2cfa:	.db $74
B5_2cfb:	.db $7c
B5_2cfc:		sty $87			; 84 87
B5_2cfe:	.db $47
B5_2cff:	.db $47
B5_2d00:	.db $47
B5_2d01:	.db $47
B5_2d02:		pha				; 48 
B5_2d03:		lsr $47			; 46 47
B5_2d05:		lsr $49			; 46 49
B5_2d07:		lsr $4a			; 46 4a
B5_2d09:		lsr $46			; 46 46
B5_2d0b:		lsr a			; 4a
B5_2d0c:		eor #$4a		; 49 4a
B5_2d0e:	.db $4b
B5_2d0f:		lsr $48			; 46 48
B5_2d11:		lsr a			; 4a
B5_2d12:		lsr $47			; 46 47
B5_2d14:	.db $14
B5_2d15:		plp				; 28 
B5_2d16:	.db $3c


entityUpdate76:
entityUpdate77:
entityUpdate78:
entityUpdate79:
B5_2d17:		lda wEntitiesState.w, x	; bd f0 03
B5_2d1a:		jsr jumpTable		; 20 3d c2
	.dw $ad23
	.dw $ad7b
	.dw $adc9
B5_2d23:		jsr $ae0f		; 20 0f ae
B5_2d26:		jsr $b052		; 20 52 b0
B5_2d29:		jsr func_5_3067		; 20 67 b0
B5_2d2c:		dec wEntities_378.w, x	; de 78 03
B5_2d2f:		bne B5_2d4e ; d0 1d

B5_2d31:		jsr getNewRandomVal		; 20 8a c4
B5_2d34:		and #$03		; 29 03
B5_2d36:		beq B5_2d31 ; f0 f9

B5_2d38:		and #$01		; 29 01
B5_2d3a:		beq B5_2d4f ; f0 13

B5_2d3c:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2d3f:		and #$f8		; 29 f8
B5_2d41:		ora #$10		; 09 10
B5_2d43:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2d46:		lda #$78		; a9 78
B5_2d48:		sta wEntities_378.w, x	; 9d 78 03
B5_2d4b:		inc wEntitiesState.w, x	; fe f0 03
B5_2d4e:		rts				; 60 


B5_2d4f:		jsr $ae24		; 20 24 ae
B5_2d52:		lda wEntityDataByte1			; a5 51
B5_2d54:		and #$18		; 29 18
B5_2d56:		lsr a			; 4a
B5_2d57:		lsr a			; 4a
B5_2d58:		lsr a			; 4a
B5_2d59:		tay				; a8 
B5_2d5a:		lda $ad75, y	; b9 75 ad
B5_2d5d:		sta wEntities_378.w, x	; 9d 78 03
B5_2d60:		sta $a4			; 85 a4
B5_2d62:		lda $ad78, y	; b9 78 ad
B5_2d65:		sta wEntities_390.w, x	; 9d 90 03
B5_2d68:		sta $a5			; 85 a5
B5_2d6a:		lda #$78		; a9 78
B5_2d6c:		sta wEntities_3a8.w, x	; 9d a8 03
B5_2d6f:		lda #$02		; a9 02
B5_2d71:		sta wEntitiesState.w, x	; 9d f0 03
B5_2d74:		rts				; 60 


B5_2d75:		cli				; 58 
B5_2d76:		bcs B5_2d80 ; b0 08

B5_2d78:	.db $02
B5_2d79:	.db $04
B5_2d7a:	.db $07
B5_2d7b:		dec wEntities_378.w, x	; de 78 03
B5_2d7e:		bne B5_2db8 ; d0 38

B5_2d80:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2d83:		and #$ef		; 29 ef
B5_2d85:		ora #$05		; 09 05
B5_2d87:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_2d8a:		jsr getNewRandomVal		; 20 8a c4
B5_2d8d:		and #$07		; 29 07
B5_2d8f:		tay				; a8 
B5_2d90:		lda wEntitiesX.w, x	; bd b0 04
B5_2d93:		clc				; 18 
B5_2d94:		adc $adb9, y	; 79 b9 ad
B5_2d97:		jsr $a6bb		; 20 bb a6
B5_2d9a:		bcs B5_2d8a ; b0 ee

B5_2d9c:		sta wEntitiesX.w, x	; 9d b0 04
B5_2d9f:		lda wEntitiesY.w, x	; bd 80 04
B5_2da2:		clc				; 18 
B5_2da3:		adc $adc1, y	; 79 c1 ad
B5_2da6:		jsr $a6bb		; 20 bb a6
B5_2da9:		bcs B5_2d8a ; b0 df

B5_2dab:		sta wEntitiesY.w, x	; 9d 80 04
B5_2dae:		lda #$78		; a9 78
B5_2db0:		sta wEntities_378.w, x	; 9d 78 03
B5_2db3:		lda #$00		; a9 00
B5_2db5:		sta wEntitiesState.w, x	; 9d f0 03
B5_2db8:		rts				; 60 


B5_2db9:		inx				; e8 
B5_2dba:		.db $00				; 00
B5_2dbb:		clc				; 18 
B5_2dbc:		clc				; 18 
B5_2dbd:		clc				; 18 
B5_2dbe:		.db $00				; 00
B5_2dbf:		inx				; e8 
B5_2dc0:		inx				; e8 
B5_2dc1:		inx				; e8 
B5_2dc2:		inx				; e8 
B5_2dc3:		inx				; e8 
B5_2dc4:		.db $00				; 00
B5_2dc5:		clc				; 18 
B5_2dc6:		clc				; 18 
B5_2dc7:		clc				; 18 
B5_2dc8:		.db $00				; 00
B5_2dc9:		jsr $ae0f		; 20 0f ae
B5_2dcc:		lda wEntities_3a8.w, x	; bd a8 03
B5_2dcf:		cmp #$08		; c9 08
B5_2dd1:		bcc B5_2dd5 ; 90 02

B5_2dd3:		iny				; c8 
B5_2dd4:		iny				; c8 
B5_2dd5:		tya				; 98 
B5_2dd6:		jsr $b052		; 20 52 b0
B5_2dd9:		dec wEntities_3a8.w, x	; de a8 03
B5_2ddc:		bne B5_2dfa ; d0 1c

B5_2dde:		lda #$b2		; a9 b2
B5_2de0:		jsr $b268		; 20 68 b2
B5_2de3:		ldy $f0			; a4 f0
B5_2de5:		lda wEntities_3c0.w, y	; b9 c0 03
B5_2de8:		ora #$04		; 09 04
B5_2dea:		sta wEntities_3c0.w, y	; 99 c0 03
B5_2ded:		lda wEntities_408.w, x	; bd 08 04
B5_2df0:		and #$1f		; 29 1f
B5_2df2:		sta wEntities_408.w, y	; 99 08 04
B5_2df5:		lda #$78		; a9 78
B5_2df7:		sta wEntities_3a8.w, x	; 9d a8 03
B5_2dfa:		dec wEntities_378.w, x	; de 78 03
B5_2dfd:		bne B5_2e0e ; d0 0f

B5_2dff:		dec wEntities_390.w, x	; de 90 03
B5_2e02:		bpl B5_2e0e ; 10 0a

B5_2e04:		lda #$3c		; a9 3c
B5_2e06:		sta wEntities_378.w, x	; 9d 78 03
B5_2e09:		lda #$00		; a9 00
B5_2e0b:		sta wEntitiesState.w, x	; 9d f0 03
B5_2e0e:		rts				; 60 


B5_2e0f:		jsr $b0d0		; 20 d0 b0
B5_2e12:		jsr $b038		; 20 38 b0
B5_2e15:		ldy #$76		; a0 76
B5_2e17:		and #$1f		; 29 1f
B5_2e19:		cmp #$08		; c9 08
B5_2e1b:		bcc B5_2e21 ; 90 04

B5_2e1d:		cmp #$18		; c9 18
B5_2e1f:		bcc B5_2e22 ; 90 01

B5_2e21:		iny				; c8 
B5_2e22:		tya				; 98 
B5_2e23:		rts				; 60 


B5_2e24:		txa				; 8a 
B5_2e25:		pha				; 48 
B5_2e26:		lda wEntitiesId.w, x	; bd 18 03
B5_2e29:		clc				; 18 
B5_2e2a:		adc #$02		; 69 02
B5_2e2c:		jsr $b052		; 20 52 b0
B5_2e2f:		lda #$38		; a9 38
B5_2e31:		jsr queueSoundAtoPlay		; 20 ad c4
B5_2e34:		ldy #$04		; a0 04
B5_2e36:		jsr palettesBGFadeOut		; 20 0e c6
B5_2e39:		lda #$ff		; a9 ff
B5_2e3b:		sta $0388		; 8d 88 03
B5_2e3e:		lda #$ba		; a9 ba
B5_2e40:		sta $03a0		; 8d a0 03
B5_2e43:		jsr $aead		; 20 ad ae
B5_2e46:		jsr $ae98		; 20 98 ae
B5_2e49:		lda #$3e		; a9 3e
B5_2e4b:		sta $03a0		; 8d a0 03
B5_2e4e:		lda #$30		; a9 30
B5_2e50:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B5_2e53:		jsr $ae98		; 20 98 ae
B5_2e56:		lda #$3e		; a9 3e
B5_2e58:		sta $03a0		; 8d a0 03
B5_2e5b:		lda $c0			; a5 c0
B5_2e5d:		and #$f7		; 29 f7
B5_2e5f:		sta $c0			; 85 c0
B5_2e61:		lda $bf			; a5 bf
B5_2e63:		cmp #$09		; c9 09
B5_2e65:		bne B5_2e6d ; d0 06

B5_2e67:		lda wEquippedMagic			; a5 b8
B5_2e69:		and #$7f		; 29 7f
B5_2e6b:		sta wEquippedMagic			; 85 b8
B5_2e6d:		lda #$08		; a9 08
B5_2e6f:		sta $bf			; 85 bf
B5_2e71:		lda #$3e		; a9 3e
B5_2e73:		sta $03a0		; 8d a0 03
B5_2e76:		lda wEntityDataByte1			; a5 51
B5_2e78:		and #$18		; 29 18
B5_2e7a:		lsr a			; 4a
B5_2e7b:		lsr a			; 4a
B5_2e7c:		lsr a			; 4a
B5_2e7d:		tay				; a8 
B5_2e7e:		lda $aeaa, y	; b9 aa ae
B5_2e81:		jsr update_wInternalPalettesFromSpecA		; 20 b2 c6
B5_2e84:		ldx #$07		; a2 07
B5_2e86:		lda #$00		; a9 00
B5_2e88:		sta $0308, x	; 9d 08 03
B5_2e8b:		dex				; ca 
B5_2e8c:		bpl B5_2e86 ; 10 f8

B5_2e8e:		ldy #$04		; a0 04
B5_2e90:		lda wSavedInternalPalettesSpecIdx			; a5 2f
B5_2e92:		jsr palettesBGFadeOut_saveSpecADelayY		; 20 ff c5
B5_2e95:		pla				; 68 
B5_2e96:		tax				; aa 
B5_2e97:		rts				; 60 


B5_2e98:		jsr $aeb9		; 20 b9 ae
B5_2e9b:		jsr drawEntities		; 20 03 c4
B5_2e9e:		jsr drawPlayer		; 20 dd c3
B5_2ea1:		jsr waitForMajorityOfNMIFuncsDone		; 20 2d c1
B5_2ea4:		dec $03a0		; ce a0 03
B5_2ea7:		bne B5_2e98 ; d0 ef

B5_2ea9:		rts				; 60 


B5_2eaa:		;removed
	.db $10 $1b

B5_2eac:	.db $14
B5_2ead:		ldx #$08		; a2 08
B5_2eaf:		lda #$1a		; a9 1a
B5_2eb1:		jsr initNpcSpecAIdxX		; 20 ec c3
B5_2eb4:		inx				; e8 
B5_2eb5:		cpx #$10		; e0 10
B5_2eb7:		bcc B5_2eaf ; 90 f6

B5_2eb9:		inc $0388		; ee 88 03
B5_2ebc:		lda $0388		; ad 88 03
B5_2ebf:		cmp #$03		; c9 03
B5_2ec1:		bcc B5_2ec8 ; 90 05

B5_2ec3:		lda #$00		; a9 00
B5_2ec5:		sta $0388		; 8d 88 03
B5_2ec8:		lda $0388		; ad 88 03
B5_2ecb:		asl a			; 0a
B5_2ecc:		asl a			; 0a
B5_2ecd:		asl a			; 0a
B5_2ece:		tax				; aa 
B5_2ecf:		ldy #$07		; a0 07
B5_2ed1:		lda $aee2, x	; bd e2 ae
B5_2ed4:		sta $0488, y	; 99 88 04
B5_2ed7:		lda $aefa, x	; bd fa ae
B5_2eda:		sta $04b8, y	; 99 b8 04
B5_2edd:		inx				; e8 
B5_2ede:		dey				; 88 
B5_2edf:		bpl B5_2ed1 ; 10 f0

B5_2ee1:		rts				; 60 


B5_2ee2:	.db $14
B5_2ee3:	.db $14
B5_2ee4:	.db $34
B5_2ee5:		jmp ($9c7c)		; 6c 7c 9c


B5_2ee8:		cpy $14e4		; cc e4 14
B5_2eeb:	.db $34
B5_2eec:	.db $44
B5_2eed:	.db $64
B5_2eee:		sty $d4b4		; 8c b4 d4
B5_2ef1:		cpx $1c			; e4 1c
B5_2ef3:		jmp $7454		; 4c 54 74


B5_2ef6:		sty $b4ac		; 8c ac b4
B5_2ef9:		cpy $f434		; cc 34 f4
B5_2efc:		ldy $dc			; a4 dc
B5_2efe:		jmp $246c		; 4c 6c 24


B5_2f01:		cpy $e4c4		; cc c4 e4
B5_2f04:	.db $5c
B5_2f05:		sty $14			; 84 14
B5_2f07:		ldy $44, x		; b4 44
B5_2f09:	.db $9c
B5_2f0a:	.db $74
B5_2f0b:		ldy $2c, x		; b4 2c
B5_2f0d:	.db $74
B5_2f0e:	.db $9c
B5_2f0f:	.db $d4
B5_2f10:	.db $54
B5_2f11:		.db $ec


; called on room transitions
loadScreenEntitiesOnRoomTransition_body:
; entity spec id in low 7 bits
	lda wEntityDataByte2
B5_2f14:		and #$7f		; 29 7f
B5_2f16:		asl a			; 0a
B5_2f17:		tay				; a8 
B5_2f18:		lda screenEntitiesSpecs.w, y	; b9 72 8b
B5_2f1b:		sta wScreenEntitiesSpecAddr			; 85 01
B5_2f1d:		lda screenEntitiesSpecs.w+1, y	; b9 73 8b
B5_2f20:		sta wScreenEntitiesSpecAddr+1			; 85 02

;
B5_2f22:		lda wEntityDataByte1			; a5 51
B5_2f24:		and #$18		; 29 18
B5_2f26:		lsr a			; 4a
B5_2f27:		lsr a			; 4a
B5_2f28:		lsr a			; 4a
B5_2f29:		tay				; a8 
B5_2f2a:		lda (wScreenEntitiesSpecAddr), y	; b1 01
B5_2f2c:		sta wSprPaletteSpecAndChrBank			; 85 50
-	iny				; c8 
B5_2f2f:		sty $00			; 84 00
B5_2f31:		lda (wScreenEntitiesSpecAddr), y	; b1 01
B5_2f33:		cmp #$ff		; c9 ff
	bne -

B5_2f37:		lda wEntityDataByte1			; a5 51
B5_2f39:		and #$07		; 29 07
B5_2f3b:		asl a			; 0a
B5_2f3c:		clc				; 18 
B5_2f3d:		adc $00			; 65 00
B5_2f3f:		tay				; a8 
B5_2f40:		iny				; c8 
B5_2f41:		lda (wScreenEntitiesSpecAddr), y	; b1 01
B5_2f43:		bpl B5_2f4c ; 10 07

B5_2f45:		lda wMajorNMIUpdatesCounter			; a5 23
B5_2f47:		and #$01		; 29 01
B5_2f49:		bne B5_2f4c ; d0 01

B5_2f4b:		rts				; 60 

B5_2f4c:		lda #$00		; a9 00
B5_2f4e:		sta $01			; 85 01
B5_2f50:		lda wEntityDataByte1			; a5 51
B5_2f52:		asl a			; 0a
B5_2f53:		rol $01			; 26 01
B5_2f55:		asl a			; 0a
B5_2f56:		rol $01			; 26 01
B5_2f58:		asl a			; 0a
B5_2f59:		rol $01			; 26 01
B5_2f5b:		lda $01			; a5 01
B5_2f5d:		asl a			; 0a
B5_2f5e:		tay				; a8 
B5_2f5f:		lda data_5_3028.w, y	; b9 28 b0
B5_2f62:		sta $01			; 85 01
B5_2f64:		lda data_5_3028.w+1, y	; b9 29 b0
B5_2f67:		sta $02			; 85 02
B5_2f69:		ldy #$00		; a0 00
B5_2f6b:		lda ($01), y	; b1 01
B5_2f6d:		sta $00			; 85 00
B5_2f6f:		ldx #$17		; a2 17
B5_2f71:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_2f74:		bmi B5_2f8c ; 30 16

B5_2f76:		iny				; c8 
B5_2f77:		lda ($01), y	; b1 01
B5_2f79:		sta wEntitiesY.w, x	; 9d 80 04
B5_2f7c:		iny				; c8 
B5_2f7d:		lda ($01), y	; b1 01
B5_2f7f:		sta wEntitiesX.w, x	; 9d b0 04
B5_2f82:		lda #$00		; a9 00
B5_2f84:		jsr initNpcSpecAIdxX		; 20 ec c3
B5_2f87:		dec $00			; c6 00
B5_2f89:		bne B5_2f8c ; d0 01

B5_2f8b:		rts				; 60 

B5_2f8c:		dex				; ca 
B5_2f8d:		cpx #$08		; e0 08
B5_2f8f:		bcs B5_2f71 ; b0 e0

B5_2f91:		rts				; 60 


data_5_2f92:
	.db $08
	.db $58 $68
	.db $58 $88
	.db $58 $a8
	.db $78 $68
	.db $78 $a8
	.db $98 $68
	.db $98 $88
	.db $98 $a8

data_5_2fa3:
	.db $0d
	.db $18 $60
	.db $18 $78
	.db $18 $90
	.db $18 $a8
	.db $18 $c0
	.db $18 $d8
	.db $d8 $48
	.db $d8 $60
	.db $d8 $78
	.db $d8 $90
	.db $d8 $a8
	.db $d8 $c0
	.db $d8 $d8

data_5_2fbe:
	.db $0c
	.db $58 $10
	.db $58 $f0
	.db $70 $10
	.db $70 $f0
	.db $88 $10
	.db $88 $f0
	.db $a0 $10
	.db $a0 $f0
	.db $b8 $10
	.db $b8 $f0
	.db $d0 $10
	.db $d0 $f0

data_5_2fd7:
	.db $05
	.db $58 $78
	.db $58 $90
	.db $58 $a8
	.db $58 $c0
	.db $58 $d8

data_5_2fe2:
	.db $06
	.db $48 $d8
	.db $60 $c8
	.db $78 $b8
	.db $90 $b8
	.db $a8 $c8
	.db $c8 $d0

data_5_2fef:
	.db $05
	.db $58 $38
	.db $70 $38
	.db $88 $38
	.db $a0 $38
	.db $b8 $38

data_5_2ffa:
	.db $06
	.db $b0 $68
	.db $b0 $80
	.db $b0 $98
	.db $b0 $b0
	.db $b0 $c8
	.db $b0 $e0

data_5_3007:
	.db $0f
	.db $18 $78
	.db $18 $98
	.db $18 $b8
	.db $18 $d8
	.db $d8 $70
	.db $d8 $90
	.db $d8 $b0
	.db $d8 $d0
	.db $68 $10
	.db $88 $10
	.db $a8 $10
	.db $c8 $10
	.db $68 $f0
	.db $88 $f0
	.db $a8 $f0
; 1 extra row here
	.db $c8 $f0


data_5_3028:
	.dw data_5_2f92
	.dw data_5_2fa3
	.dw data_5_2fbe
	.dw data_5_2fd7
	.dw data_5_2fe2
	.dw data_5_2fef
	.dw data_5_2ffa
	.dw data_5_3007


B5_3038:		sta $f0
B5_303a:		lda wEntities_408.w, x
B5_303d:		and #$e0		; 29 e0
B5_303f:		ora $f0			; 05 f0
B5_3041:		sta wEntities_408.w, x	; 9d 08 04
B5_3044:		rts				; 60 


B5_3045:		sta $f0			; 85 f0
B5_3047:		lda wEntities_408.w, x	; bd 08 04
B5_304a:		and #$1f		; 29 1f
B5_304c:		ora $f0			; 05 f0
B5_304e:		sta wEntities_408.w, x	; 9d 08 04
B5_3051:		rts				; 60 


B5_3052:		cmp wEntitiesId.w, x	; dd 18 03
B5_3055:		beq B5_3063 ; f0 0c

B5_3057:		sta wEntitiesId.w, x	; 9d 18 03
B5_305a:		lda #$00		; a9 00
B5_305c:		sta wEntities_438.w, x	; 9d 38 04
B5_305f:		sta wEntities_450.w, x	; 9d 50 04
B5_3062:		rts				; 60 

B5_3063:		sta wEntitiesId.w, x	; 9d 18 03
B5_3066:		rts				; 60 


func_5_3067:
B5_3067:		ldy wEntities_408.w, x	; bc 08 04

func_5_306a:
B5_306a:		lda wEntities_468.w, x	; bd 68 04
B5_306d:		clc				; 18 
B5_306e:		adc data_7_3b00.w, y	; 79 00 fb
B5_3071:		sta wEntities_468.w, x	; 9d 68 04

B5_3074:		lda wEntitiesY.w, x	; bd 80 04
B5_3077:		adc data_7_3c00.w, y	; 79 00 fc
B5_307a:		sta wEntitiesY.w, x	; 9d 80 04

B5_307d:		cmp #$10		; c9 10
B5_307f:		bcs B5_3085 ; b0 04

B5_3081:		lda #$10		; a9 10
B5_3083:		bne B5_308b ; d0 06

B5_3085:		cmp #$e0		; c9 e0
B5_3087:		bcc B5_3091 ; 90 08

B5_3089:		lda #$e0		; a9 e0
B5_308b:		sta wEntitiesY.w, x	; 9d 80 04
B5_308e:		jmp B5_30c6		; 4c c6 b0

B5_3091:		lda wEntities_498.w, x	; bd 98 04
B5_3094:		clc				; 18 
B5_3095:		adc data_7_3d00.w, y	; 79 00 fd
B5_3098:		sta wEntities_498.w, x	; 9d 98 04

B5_309b:		lda wEntitiesX.w, x	; bd b0 04
B5_309e:		adc data_7_3e00.w, y	; 79 00 fe
B5_30a1:		sta wEntitiesX.w, x	; 9d b0 04

B5_30a4:		cmp #$10		; c9 10
B5_30a6:		bcs B5_30ac ; b0 04

B5_30a8:		lda #$10		; a9 10
B5_30aa:		bne B5_30b2 ; d0 06

B5_30ac:		cmp #$f0		; c9 f0
B5_30ae:		bcc B5_30cf ; @done

B5_30b0:		lda #$f0		; a9 f0
B5_30b2:		sta wEntitiesX.w, x	; 9d b0 04
B5_30b5:		lda wEntities_468.w, x	; bd 68 04
B5_30b8:		sec				; 38 
B5_30b9:		sbc data_7_3b00.w, y	; f9 00 fb
B5_30bc:		sta wEntities_468.w, x	; 9d 68 04
B5_30bf:		lda wEntitiesY.w, x	; bd 80 04
B5_30c2:		sec				; 38 
B5_30c3:		sta wEntitiesY.w, x	; 9d 80 04

B5_30c6:		lda #$00		; a9 00
B5_30c8:		sta wEntities_468.w, x	; 9d 68 04
B5_30cb:		sta wEntities_498.w, x	; 9d 98 04
B5_30ce:		sec				; 38 
B5_30cf:		rts				; 60 


B5_30d0:		lda wPlayerY			; a5 cc
B5_30d2:		sta $06			; 85 06
B5_30d4:		lda wPlayerX			; a5 ce
B5_30d6:		sta $07			; 85 07
B5_30d8:		lda wEntitiesY.w, x	; bd 80 04
B5_30db:		sta $08			; 85 08
B5_30dd:		lda wEntitiesX.w, x	; bd b0 04
B5_30e0:		sta $09			; 85 09
B5_30e2:		jsr $b288		; 20 88 b2
B5_30e5:		rts				; 60 


B5_30e6:		sta $f0			; 85 f0
B5_30e8:		txa				; 8a 
B5_30e9:		pha				; 48 
B5_30ea:		ldx #$17		; a2 17
B5_30ec:		lda wEntitiesId.w, x	; bd 18 03
B5_30ef:		cmp $f0			; c5 f0
B5_30f1:		beq B5_30fc ; f0 09

B5_30f3:		dex				; ca 
B5_30f4:		cpx #$08		; e0 08
B5_30f6:		bcs B5_30ec ; b0 f4

B5_30f8:		clc				; 18 
B5_30f9:		pla				; 68 
B5_30fa:		tax				; aa 
B5_30fb:		rts				; 60 


B5_30fc:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_30ff:		bpl B5_30f3 ; 10 f2

B5_3101:		stx $f0			; 86 f0
B5_3103:		sec				; 38 
B5_3104:		pla				; 68 
B5_3105:		tax				; aa 
B5_3106:		rts				; 60 


B5_3107:		jsr $b0d0		; 20 d0 b0
B5_310a:		jsr $b038		; 20 38 b0
B5_310d:		and #$0f		; 29 0f
B5_310f:		cmp #$08		; c9 08
B5_3111:		beq B5_312e ; f0 1b

B5_3113:		ldy #$00		; a0 00
B5_3115:		lda wPlayerY			; a5 cc
B5_3117:		sta wEntities_3a8.w, x	; 9d a8 03
B5_311a:		cmp wEntitiesY.w, x	; dd 80 04
B5_311d:		bcs B5_3121 ; b0 02

B5_311f:		ldy #$40		; a0 40
B5_3121:		sty $f0			; 84 f0
B5_3123:		lda wEntities_390.w, x	; bd 90 03
B5_3126:		and #$3f		; 29 3f
B5_3128:		ora $f0			; 05 f0
B5_312a:		sta wEntities_390.w, x	; 9d 90 03
B5_312d:		rts				; 60 


B5_312e:		ldy #$80		; a0 80
B5_3130:		lda wPlayerX			; a5 ce
B5_3132:		sta wEntities_3a8.w, x	; 9d a8 03
B5_3135:		cmp wEntitiesX.w, x	; dd b0 04
B5_3138:		bcs B5_3121 ; b0 e7

B5_313a:		ldy #$c0		; a0 c0
B5_313c:		bne B5_3121 ; d0 e3

B5_313e:		lda wEntities_390.w, x	; bd 90 03
B5_3141:		and #$c0		; 29 c0
B5_3143:		cmp #$80		; c9 80
B5_3145:		bcc B5_3167 ; 90 20

B5_3147:		bne B5_3159 ; d0 10

B5_3149:		ldy #$00		; a0 00
B5_314b:		lda wEntities_3a8.w, x	; bd a8 03
B5_314e:		cmp wEntitiesX.w, x	; dd b0 04
B5_3151:		bcc B5_3155 ; 90 02

B5_3153:		bne B5_3157 ; d0 02

B5_3155:		ldy #$01		; a0 01
B5_3157:		tya				; 98 
B5_3158:		rts				; 60 


B5_3159:		ldy #$00		; a0 00
B5_315b:		lda wEntities_3a8.w, x	; bd a8 03
B5_315e:		cmp wEntitiesX.w, x	; dd b0 04
B5_3161:		bcc B5_3165 ; 90 02

B5_3163:		ldy #$01		; a0 01
B5_3165:		tya				; 98 
B5_3166:		rts				; 60 


B5_3167:		lda wEntities_390.w, x	; bd 90 03
B5_316a:		and #$c0		; 29 c0
B5_316c:		bne B5_317e ; d0 10

B5_316e:		ldy #$00		; a0 00
B5_3170:		lda wEntities_3a8.w, x	; bd a8 03
B5_3173:		cmp wEntitiesY.w, x	; dd 80 04
B5_3176:		bcc B5_317a ; 90 02

B5_3178:		bne B5_317c ; d0 02

B5_317a:		ldy #$01		; a0 01
B5_317c:		tya				; 98 
B5_317d:		rts				; 60 


B5_317e:		ldy #$00		; a0 00
B5_3180:		lda wEntities_3a8.w, x	; bd a8 03
B5_3183:		cmp wEntitiesY.w, x	; dd 80 04
B5_3186:		bcc B5_318a ; 90 02

B5_3188:		ldy #$01		; a0 01
B5_318a:		tya				; 98 
B5_318b:		rts				; 60 


func_5_318c:
; 00, 01 is Y,X coords of tile under entity
B5_318c:		txa				; 8a 
B5_318d:		pha				; 48 
B5_318e:		lda $00			; a5 00
B5_3190:		lsr a			; 4a
B5_3191:		lsr a			; 4a
B5_3192:		lsr a			; 4a
B5_3193:		lsr a			; 4a
B5_3194:		sta $0c			; 85 0c
B5_3196:		lda $01			; a5 01
B5_3198:		lsr a			; 4a
B5_3199:		lsr a			; 4a
B5_319a:		lsr a			; 4a
B5_319b:		lsr a			; 4a
B5_319c:		sta $0e			; 85 0e
B5_319e:		jsr getCollisionValOfRoomTileY		; 20 39 c4
B5_31a1:		pla				; 68 
B5_31a2:		tax				; aa 
B5_31a3:		lda $04			; a5 04
B5_31a5:		rts				; 60 


B5_31a6:		lda wEntitiesY.w, x	; bd 80 04
B5_31a9:		sta $84			; 85 84
B5_31ab:		lda wEntitiesX.w, x	; bd b0 04
B5_31ae:		sta $85			; 85 85
B5_31b0:		jsr func_5_3067		; 20 67 b0
B5_31b3:		rts				; 60 


B5_31b4:		jsr func_5_318c		; 20 8c b1
B5_31b7:		beq B5_31c8 ; f0 0f

B5_31b9:		lda wEntitiesTempX.w, x	; bd e0 04
B5_31bc:		sta wEntitiesX.w, x	; 9d b0 04
B5_31bf:		lda wEntitiesTempY.w, x	; bd c8 04
B5_31c2:		sta wEntitiesY.w, x	; 9d 80 04
B5_31c5:		lda #$01		; a9 01
B5_31c7:		rts				; 60 


B5_31c8:		lda #$00		; a9 00
B5_31ca:		rts				; 60 


func_5_31cb:
B5_31cb:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_31ce:		and #$bf		; 29 bf
B5_31d0:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_31d3:		lda wEntities_438.w, x	; bd 38 04
B5_31d6:		beq B5_31e0 ; f0 08

B5_31d8:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_31db:		ora #$40		; 09 40
B5_31dd:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_31e0:		rts				; 60 


B5_31e1:		cmp wEntities_438.w, x	; dd 38 04
B5_31e4:		bne B5_31f1 ; d0 0b

B5_31e6:		lda wEntities_450.w, x	; bd 50 04
B5_31e9:		cmp $f0			; c5 f0
B5_31eb:		bcc B5_31f1 ; 90 04

B5_31ed:		tya				; 98 
B5_31ee:		sta wEntities_438.w, x	; 9d 38 04
B5_31f1:		rts				; 60 


func_5_31f2:
B5_31f2:		lda wEntitiesY.w, x	; bd 80 04
B5_31f5:		sta $84			; 85 84
B5_31f7:		lda wEntitiesX.w, x	; bd b0 04
B5_31fa:		sta $85			; 85 85
B5_31fc:		ldy wEntities_3d8.w, x	; bc d8 03
; if carry set here, couldn't move
B5_31ff:		jsr func_5_306a		; 20 6a b0
B5_3202:		bcs B5_3214 ; b0 10

B5_3204:		rts				; 60 


func_5_3205:
; sec if restored original X, Y, ie couldn't move
B5_3205:		jsr func_5_318c		; 20 8c b1
B5_3208:		beq B5_3216 ; f0 0c

B5_320a:		lda $85			; a5 85
B5_320c:		sta wEntitiesX.w, x	; 9d b0 04
B5_320f:		lda $84			; a5 84
B5_3211:		sta wEntitiesY.w, x	; 9d 80 04

B5_3214:		sec				; 38 
B5_3215:		rts				; 60 

B5_3216:		clc				; 18 
B5_3217:		rts				; 60 


storeCoordsOfTileUnderEntity:
B5_3218:		ldy #$00		; a0 00

func_5_321a:
B5_321a:		lda wEntitiesY.w, x	; bd 80 04
B5_321d:		clc				; 18 
B5_321e:		adc data_5_322d.w, y	; 79 2d b2
B5_3221:		sta $00			; 85 00

B5_3223:		lda wEntitiesX.w, x	; bd b0 04
B5_3226:		clc				; 18 
B5_3227:		adc data_5_3236.w, y	; 79 36 b2
B5_322a:		sta $01			; 85 01
B5_322c:		rts				; 60 

data_5_322d:
B5_322d:		.db $00				; 00
B5_322e:		clc				; 18 
B5_322f:		clc				; 18 
B5_3230:		bpl B5_323a ; 10 08

B5_3232:		bpl B5_3244 ; 10 10

B5_3234:	.db $0c
B5_3235:	.db $0c

data_5_3236:
B5_3236:		.db $00				; 00
B5_3237:		;removed
	.db $f0 $10

B5_3239:		.db $00				; 00
B5_323a:		.db $00				; 00
B5_323b:		beq B5_324d ; f0 10

B5_323d:	.db $fa
B5_323e:		.db $06


func_5_323f:
	lda wEntities_420.w, x
	beq B5_324f
B5_3244:		jsr func_5_31f2		; 20 f2 b1
B5_3247:		jsr storeCoordsOfTileUnderEntity		; 20 18 b2
B5_324a:		jsr func_5_3205		; 20 05 b2
B5_324d:		lda #$01		; a9 01
B5_324f:		rts				; 60 


;
B5_3250:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_3253:		and #$bf		; 29 bf
B5_3255:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_3258:		lda wPlayerX			; a5 ce
B5_325a:		cmp wEntitiesX.w, x	; dd b0 04
B5_325d:		bcs B5_3267 ; b0 08

B5_325f:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_3262:		ora #$40		; 09 40
B5_3264:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_3267:		rts				; 60 


B5_3268:		sta $f0			; 85 f0
B5_326a:		txa				; 8a 
B5_326b:		tay				; a8 
B5_326c:		jsr getOffsetOfLastScreenEntity_secIfFound		; 20 86 c3
B5_326f:		bcc B5_3285 ; 90 14

B5_3271:		lda $f0			; a5 f0
B5_3273:		jsr initNpcSpecAIdxX		; 20 ec c3
B5_3276:		lda wEntitiesY.w, y	; b9 80 04
B5_3279:		sta wEntitiesY.w, x	; 9d 80 04
B5_327c:		lda wEntitiesX.w, y	; b9 b0 04
B5_327f:		sta wEntitiesX.w, x	; 9d b0 04
B5_3282:		stx $f0			; 86 f0
B5_3284:		sec				; 38 
B5_3285:		tya				; 98 
B5_3286:		tax				; aa 
B5_3287:		rts				; 60 


B5_3288:		ldy #$00		; a0 00
B5_328a:		lda $06			; a5 06
B5_328c:		sec				; 38 
B5_328d:		sbc $08			; e5 08
B5_328f:		bcs B5_3297 ; b0 06

B5_3291:		eor #$ff		; 49 ff
B5_3293:		adc #$01		; 69 01
B5_3295:		ldy #$04		; a0 04
B5_3297:		sta $f0			; 85 f0
B5_3299:		lda $07			; a5 07
B5_329b:		sec				; 38 
B5_329c:		sbc $09			; e5 09
B5_329e:		bcs B5_32a6 ; b0 06

B5_32a0:		eor #$ff		; 49 ff
B5_32a2:		adc #$01		; 69 01
B5_32a4:		iny				; c8 
B5_32a5:		iny				; c8 
B5_32a6:		sta $f1			; 85 f1
B5_32a8:		cmp $f0			; c5 f0
B5_32aa:		bcs B5_32be ; b0 12

B5_32ac:		pha				; 48 
B5_32ad:		lda $f0			; a5 f0
B5_32af:		sta $f1			; 85 f1
B5_32b1:		pla				; 68 
B5_32b2:		sta $f0			; 85 f0
B5_32b4:		tya				; 98 
B5_32b5:		beq B5_32bb ; f0 04

B5_32b7:		cpy #$04		; c0 04
B5_32b9:		bne B5_32c7 ; d0 0c

B5_32bb:		iny				; c8 
B5_32bc:		bne B5_32c7 ; d0 09

B5_32be:		cpy #$02		; c0 02
B5_32c0:		beq B5_32c6 ; f0 04

B5_32c2:		cpy #$06		; c0 06
B5_32c4:		bne B5_32c7 ; d0 01

B5_32c6:		iny				; c8 
B5_32c7:		lda #$00		; a9 00
B5_32c9:		sta $f2			; 85 f2
B5_32cb:		lda $f1			; a5 f1
B5_32cd:		lsr a			; 4a
B5_32ce:		lsr a			; 4a
B5_32cf:		lsr a			; 4a
B5_32d0:		sta $f3			; 85 f3
B5_32d2:		cmp $f0			; c5 f0
B5_32d4:		bcs B5_32f6 ; b0 20

B5_32d6:		inc $f2			; e6 f2
B5_32d8:		adc $f3			; 65 f3
B5_32da:		adc $f3			; 65 f3
B5_32dc:		cmp $f0			; c5 f0
B5_32de:		bcs B5_32f6 ; b0 16

B5_32e0:		inc $f2			; e6 f2
B5_32e2:		adc $f3			; 65 f3
B5_32e4:		adc $f3			; 65 f3
B5_32e6:		cmp $f0			; c5 f0
B5_32e8:		bcs B5_32f6 ; b0 0c

B5_32ea:		inc $f2			; e6 f2
B5_32ec:		adc $f3			; 65 f3
B5_32ee:		adc $f3			; 65 f3
B5_32f0:		cmp $f0			; c5 f0
B5_32f2:		bcs B5_32f6 ; b0 02

B5_32f4:		inc $f2			; e6 f2
B5_32f6:		tya				; 98 
B5_32f7:		asl a			; 0a
B5_32f8:		asl a			; 0a
B5_32f9:		asl a			; 0a
B5_32fa:		ora $f2			; 05 f2
B5_32fc:		tay				; a8 
B5_32fd:		lda $b303, y	; b9 03 b3
B5_3300:		sta $f3			; 85 f3
B5_3302:		rts				; 60 


B5_3303:		php				; 08 
B5_3304:		ora #$0a		; 09 0a
B5_3306:	.db $0b
B5_3307:	.db $0c
B5_3308:		.db $00				; 00
B5_3309:		.db $00				; 00
B5_330a:		.db $00				; 00
B5_330b:		bpl B5_331c ; 10 0f

B5_330d:		asl $0c0d		; 0e 0d 0c
B5_3310:		.db $00				; 00
B5_3311:		.db $00				; 00
B5_3312:		.db $00				; 00
B5_3313:		;removed
	.db $10 $11

B5_3315:	.db $12
B5_3316:	.db $13
B5_3317:	.db $14
B5_3318:		.db $00				; 00
B5_3319:		.db $00				; 00
B5_331a:		.db $00				; 00
B5_331b:		clc				; 18 
B5_331c:	.db $17
B5_331d:		asl $15, x		; 16 15
B5_331f:	.db $14
B5_3320:		.db $00				; 00
B5_3321:		.db $00				; 00
B5_3322:		.db $00				; 00
B5_3323:		php				; 08 
B5_3324:	.db $07
B5_3325:		asl $05			; 06 05
B5_3327:	.db $04
B5_3328:		.db $00				; 00
B5_3329:		.db $00				; 00
B5_332a:		.db $00				; 00
B5_332b:		.db $00				; 00
B5_332c:		ora ($02, x)	; 01 02
B5_332e:	.db $03
B5_332f:	.db $04
B5_3330:		.db $00				; 00
B5_3331:		.db $00				; 00
B5_3332:		.db $00				; 00
B5_3333:		.db $00				; 00
B5_3334:	.db $1f
B5_3335:		asl $1c1d, x	; 1e 1d 1c
B5_3338:		.db $00				; 00
B5_3339:		.db $00				; 00
B5_333a:		.db $00				; 00
B5_333b:		clc				; 18 
B5_333c:		ora $1b1a, y	; 19 1a 1b
B5_333f:	.db $1c
B5_3340:		.db $00				; 00
B5_3341:		.db $00				; 00
B5_3342:		.db $00				; 00


entityUpdate7a:
B5_3343:		lda wEntitiesState.w, x	; bd f0 03
B5_3346:		bne B5_335d ; d0 15

B5_3348:		dec wEntities_360.w, x	; de 60 03
B5_334b:		bne B5_335d ; d0 10

B5_334d:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_3350:		ora #$01		; 09 01
B5_3352:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_3355:		inc wEntitiesState.w, x	; fe f0 03
B5_3358:		lda #$29		; a9 29
B5_335a:		jsr queueSoundAtoPlay		; 20 ad c4
B5_335d:		rts				; 60 


entityUpdate87:
B5_335e:		lda wEntitiesState.w, x	; bd f0 03
B5_3361:		cmp #$02		; c9 02
B5_3363:		beq B5_3390 ; f0 2b

B5_3365:		cmp #$01		; c9 01
B5_3367:		beq B5_337b ; f0 12

B5_3369:		lda wEntities_3a8.w, x	; bd a8 03
B5_336c:		cmp #$04		; c9 04
B5_336e:		bcc B5_3391 ; 90 21

B5_3370:		cmp #$18		; c9 18
B5_3372:		bcc B5_3378 ; 90 04

B5_3374:		cmp #$1e		; c9 1e
B5_3376:		bcc B5_3391 ; 90 19

B5_3378:		inc wEntitiesState.w, x	; fe f0 03
B5_337b:		dec wEntities_360.w, x	; de 60 03
B5_337e:		bne B5_3390 ; d0 10

B5_3380:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_3383:		ora #$01		; 09 01
B5_3385:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_3388:		inc wEntitiesState.w, x	; fe f0 03
B5_338b:		lda #$29		; a9 29
B5_338d:		jsr queueSoundAtoPlay		; 20 ad c4
B5_3390:		rts				; 60 


B5_3391:		lda wEntities_390.w, x	; bd 90 03
B5_3394:		and #$1f		; 29 1f
B5_3396:		tay				; a8 
B5_3397:		lda #$00		; a9 00
B5_3399:		sta wEntitiesControlByte.w, y	; 99 00 03
B5_339c:		beq B5_3378 ; f0 da

entityUpdate74:
B5_339e:		lda wEntitiesState.w, x	; bd f0 03
B5_33a1:		jsr jumpTable		; 20 3d c2
	.dw $b3ac
	.dw $b3da
	.dw $b436
	.dw $b4ab
B5_33ac:		dec wEntities_378.w, x
B5_33af:		bne B5_33d0 ; d0 1f

B5_33b1:		inc wEntitiesState.w, x	; fe f0 03
B5_33b4:		lda #$1e		; a9 1e
B5_33b6:		sta wEntities_378.w, x	; 9d 78 03
B5_33b9:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_33bc:		and #$f8		; 29 f8
B5_33be:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_33c1:		lda #$ff		; a9 ff
B5_33c3:		sta wEntities_330.w, x	; 9d 30 03
B5_33c6:		jsr $b4ce		; 20 ce b4
B5_33c9:		clc				; 18 
B5_33ca:		adc #$9c		; 69 9c
B5_33cc:		jsr $b268		; 20 68 b2
B5_33cf:		rts				; 60 


B5_33d0:		jsr $b0d0		; 20 d0 b0
B5_33d3:		jsr $b038		; 20 38 b0
B5_33d6:		jsr func_5_3067		; 20 67 b0
B5_33d9:		rts				; 60 


B5_33da:		dec wEntities_378.w, x	; de 78 03
B5_33dd:		beq B5_33f0 ; f0 11

B5_33df:		ldy #$20		; a0 20
B5_33e1:		lda wEntities_378.w, x	; bd 78 03
B5_33e4:		and #$04		; 29 04
B5_33e6:		bne B5_33ea ; d0 02

B5_33e8:		ldy #$0f		; a0 0f
.ifndef NO_FLASH
B5_33ea:		sty wInternalPalettesInvisColour.w		; 8c b0 06
.else
B5_33ea:	.db $ea $ea $ea
.endif
B5_33ed:		sty wShouldUpdateInternalPalettes			; 84 30
B5_33ef:		rts				; 60 

B5_33f0:		lda #$0a		; a9 0a
B5_33f2:		clc				; 18 
B5_33f3:		adc wMPUsed			; 65 78
B5_33f5:		sta wMPUsed			; 85 78
B5_33f7:		jsr $b4ce		; 20 ce b4
B5_33fa:		clc				; 18 
B5_33fb:		adc #$99		; 69 99
B5_33fd:		jsr $b268		; 20 68 b2
B5_3400:		pha				; 48 
B5_3401:		ldx $f0			; a6 f0
B5_3403:		lda #$f8		; a9 f8
B5_3405:		sta wEntities_408.w, x	; 9d 08 04
B5_3408:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_340b:		and #$f8		; 29 f8
B5_340d:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_3410:		lda #$ff		; a9 ff
B5_3412:		sta wEntities_330.w, x	; 9d 30 03
B5_3415:		lda #$64		; a9 64
B5_3417:		sta wEntities_378.w, x	; 9d 78 03
B5_341a:		lda #$02		; a9 02
B5_341c:		sta wEntitiesState.w, x	; 9d f0 03
B5_341f:		pla				; 68 
B5_3420:		tax				; aa 
B5_3421:		lda #$e8		; a9 e8
B5_3423:		sta wEntities_408.w, x	; 9d 08 04
B5_3426:		lda #$ff		; a9 ff
B5_3428:		sta wEntities_330.w, x	; 9d 30 03
B5_342b:		lda #$64		; a9 64
B5_342d:		sta wEntities_378.w, x	; 9d 78 03
B5_3430:		lda #$02		; a9 02
B5_3432:		sta wEntitiesState.w, x	; 9d f0 03
B5_3435:		rts				; 60 


B5_3436:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_3439:		and #$ef		; 29 ef
B5_343b:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_343e:		lda wMajorNMIUpdatesCounter			; a5 23
B5_3440:		and #$02		; 29 02
B5_3442:		bne B5_344c ; d0 08

B5_3444:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_3447:		ora #$10		; 09 10
B5_3449:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_344c:		dec wEntities_378.w, x	; de 78 03
B5_344f:		bne B5_33d6 ; d0 85

B5_3451:		lda #$00		; a9 00
B5_3453:		sta wEntities_378.w, x	; 9d 78 03
B5_3456:		ldy #$17		; a0 17
B5_3458:		lda wEntitiesControlByte.w, y	; b9 00 03
B5_345b:		bpl B5_346e ; 10 11

B5_345d:		lda wEntitiesId.w, y	; b9 18 03
B5_3460:		cmp #$74		; c9 74
B5_3462:		bne B5_346e ; d0 0a

B5_3464:		inc wEntities_378.w, x	; fe 78 03
B5_3467:		lda wEntities_378.w, x	; bd 78 03
B5_346a:		cmp #$06		; c9 06
B5_346c:		bcs B5_3492 ; b0 24

B5_346e:		dey				; 88 
B5_346f:		cpy #$08		; c0 08
B5_3471:		bcs B5_3458 ; b0 e5

B5_3473:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_3476:		and #$ef		; 29 ef
B5_3478:		ora #$05		; 09 05
B5_347a:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_347d:		lda #$c5		; a9 c5
B5_347f:		sta wEntities_330.w, x	; 9d 30 03
B5_3482:		lda #$00		; a9 00
B5_3484:		sta wEntitiesState.w, x	; 9d f0 03
B5_3487:		lda #$7e		; a9 7e
B5_3489:		sta wEntities_378.w, x	; 9d 78 03
B5_348c:		lda #$c0		; a9 c0
B5_348e:		jsr $b045		; 20 45 b0
B5_3491:		rts				; 60 


B5_3492:		ldy #$17		; a0 17
B5_3494:		lda wEntitiesControlByte.w, y	; b9 00 03
B5_3497:		bpl B5_34a5 ; 10 0c

B5_3499:		lda wEntitiesId.w, y	; b9 18 03
B5_349c:		cmp #$74		; c9 74
B5_349e:		bne B5_34a5 ; d0 05

B5_34a0:		lda #$03		; a9 03
B5_34a2:		sta wEntitiesState.w, y	; 99 f0 03
B5_34a5:		dey				; 88 
B5_34a6:		cpy #$08		; c0 08
B5_34a8:		bcs B5_3494 ; b0 ea

B5_34aa:		rts				; 60 


B5_34ab:		jsr $b0d0		; 20 d0 b0
B5_34ae:		jsr $b038		; 20 38 b0
B5_34b1:		lda #$20		; a9 20
B5_34b3:		jsr $b045		; 20 45 b0
B5_34b6:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_34b9:		and #$ef		; 29 ef
B5_34bb:		ora #$05		; 09 05
B5_34bd:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_34c0:		lda #$c5		; a9 c5
B5_34c2:		sta wEntities_330.w, x	; 9d 30 03
B5_34c5:		lda wEntities_3c0.w, x	; bd c0 03
B5_34c8:		ora #$04		; 09 04
B5_34ca:		sta wEntities_3c0.w, x	; 9d c0 03
B5_34cd:		rts				; 60 


B5_34ce:		lda wEntityDataByte1			; a5 51
B5_34d0:		and #$18		; 29 18
B5_34d2:		lsr a			; 4a
B5_34d3:		lsr a			; 4a
B5_34d4:		lsr a			; 4a
B5_34d5:		rts				; 60 


; acorn
entityUpdate2c:
entityUpdate2d:
B5_34d6:		jsr func_5_31cb		; 20 cb b1
B5_34d9:		jsr func_5_3067		; 20 67 b0
B5_34dc:		bcc B5_34e9 ; 90 0b

B5_34de:		lda #$00		; a9 00
B5_34e0:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_34e3:		lda wEquippedMagic			; a5 b8
B5_34e5:		and #$7f		; 29 7f
B5_34e7:		sta wEquippedMagic			; 85 b8
B5_34e9:		rts				; 60 


entityUpdate5a:
B5_34ea:		jsr func_5_3067		; 20 67 b0
B5_34ed:		bcc B5_34f4 ; 90 05

B5_34ef:		lda #$00		; a9 00
B5_34f1:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_34f4:		rts				; 60 


entityUpdate09:
entityUpdate0a:
B5_34f5:		lda wEntitiesState.w, x	; bd f0 03
B5_34f8:		jsr jumpTable		; 20 3d c2
	.dw $b503
	.dw $b518
	.dw $b548
	.dw $b56c
B5_3503:		txa
B5_3504:		sec				; 38 
B5_3505:		sbc #$0a		; e9 0a
B5_3507:		tay				; a8 
B5_3508:		lda $b577, y	; b9 77 b5
B5_350b:		sta wEntitiesY.w, x	; 9d 80 04
B5_350e:		lda $b57f, y	; b9 7f b5
B5_3511:		sta wEntitiesX.w, x	; 9d b0 04
B5_3514:		inc wEntitiesState.w, x	; fe f0 03
B5_3517:		rts				; 60 


B5_3518:		jsr getNewRandomVal		; 20 8a c4
B5_351b:		lda wRngVar1			; a5 31
B5_351d:		and #$1e		; 29 1e
B5_351f:		jsr $b038		; 20 38 b0
B5_3522:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_3525:		and #$bf		; 29 bf
B5_3527:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_352a:		lda wEntities_408.w, x	; bd 08 04
B5_352d:		and #$10		; 29 10
B5_352f:		bne B5_3539 ; d0 08

B5_3531:		lda wEntitiesControlByte.w, x	; bd 00 03
B5_3534:		ora #$40		; 09 40
B5_3536:		sta wEntitiesControlByte.w, x	; 9d 00 03
B5_3539:		lda #$49		; a9 49
B5_353b:		cpx #$0e		; e0 0e
B5_353d:		bcc B5_3541 ; 90 02

B5_353f:		lda #$7b		; a9 7b
B5_3541:		sta wEntities_378.w, x	; 9d 78 03
B5_3544:		inc wEntitiesState.w, x	; fe f0 03
B5_3547:		rts				; 60 


B5_3548:		dec wEntities_378.w, x	; de 78 03
B5_354b:		beq B5_3558 ; f0 0b

B5_354d:		jsr func_5_3067		; 20 67 b0
B5_3550:		bcc B5_356b ; 90 19

B5_3552:		lda #$00		; a9 00
B5_3554:		sta wEntitiesState.w, x	; 9d f0 03
B5_3557:		rts				; 60 


B5_3558:		lda #$00		; a9 00
B5_355a:		jsr $b038		; 20 38 b0
B5_355d:		lda #$0b		; a9 0b
B5_355f:		cpx #$0e		; e0 0e
B5_3561:		bcc B5_3565 ; 90 02

B5_3563:		lda #$1e		; a9 1e
B5_3565:		sta wEntities_378.w, x	; 9d 78 03
B5_3568:		inc wEntitiesState.w, x	; fe f0 03
B5_356b:		rts				; 60 


B5_356c:		dec wEntities_378.w, x	; de 78 03
B5_356f:		bne B5_354d ; d0 dc

B5_3571:		lda #$01		; a9 01
B5_3573:		sta wEntitiesState.w, x	; 9d f0 03
B5_3576:		rts				; 60 


B5_3577:		;removed
	.db $90 $40

B5_3579:	.db $80
B5_357a:		.db $90 $78

B5_357c:		;removed
	.db $30 $88

B5_357e:		;removed
	.db $30 $20

B5_3580:		rti				; 40 


B5_3581:		;removed
	.db $70 $c0

B5_3583:		;removed
	.db $30 $70

B5_3585:		ldy #$d0		; a0 d0


entityUpdate0b:
B5_3587:		lda wEntitiesState.w, x	; bd f0 03
B5_358a:		bne B5_3599 ; d0 0d

B5_358c:		lda #$f6		; a9 f6
B5_358e:		sta wEntities_408.w, x	; 9d 08 04
B5_3591:		lda #$40		; a9 40
B5_3593:		sta wEntities_378.w, x	; 9d 78 03
B5_3596:		inc wEntitiesState.w, x	; fe f0 03
B5_3599:		lda wEntities_378.w, x	; bd 78 03
B5_359c:		beq B5_35a4 ; f0 06

B5_359e:		dec wEntities_378.w, x	; de 78 03
B5_35a1:		jsr func_5_3067		; 20 67 b0
B5_35a4:		rts				; 60 
