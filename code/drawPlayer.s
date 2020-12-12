
drawPlayer_body:
; alternate lower and upper regions of oam to use
	ldx #$b4
	ldy #$00

	lda wDrawEntitiesCounter
	lsr a
	bcs +

	ldx #$04
	ldy #$50

+	stx	 wEntityOamLowerBound
	sty wEntityOamUpperBound

; clear wOam until d3
	lda #$f8
-	sta wOam.w, x
	inx
	inx
	inx
	inx
	cpx wEntityOamUpperBound
	bne -

;
B4_0024:		lda $c0			; a5 c0
	bmi +

B4_0028:		rts				; 60 

+	ldy wNewPlayerAnimationIdx
	cpy wCurrPlayerAnimationIdx
	beq @afterNewAnimationCheck

; get new animation data Y
	lda playerAnimationData_lo.w, y
	sta wPlayerAnimationAddr
	lda playerAnimationData_hi.w, y
	sta wPlayerAnimationAddr+1

	sty wCurrPlayerAnimationIdx

; 2nd byte of animation data is default delay speed
	ldy #$01
	lda (wPlayerAnimationAddr), y
	sta wPlayerAnimationDelaySpeed
	jsr getSwordSwingSpeed

; reset some vars
	lda #$00
	sta wPlayerAnimationDataOffset
	sta wPlayerAnimationFramesCounter

@afterNewAnimationCheck:
B4_004a:		lda $c0			; a5 c0
B4_004c:		and #$10		; 29 10
	beq +

B4_0050:		rts				; 60 

+	ldy wNewPlayerAnimationIdx			; a4 c1

; get animation data Y
	lda playerAnimationData_hi.w, y
	sta wPlayerAnimationAddr+1
	lda playerAnimationData_lo.w, y
	sta wPlayerAnimationAddr

B4_005d:		lda $c0			; a5 c0
B4_005f:		and #$08		; 29 08
B4_0061:		bne @next

; inc counter, jumping if delay not hit yet
	lda wPlayerAnimationFramesCounter
	inc wPlayerAnimationFramesCounter
	cmp wPlayerAnimationDelaySpeed
	bcc @next

; next animation
	lda #$00
	sta wPlayerAnimationFramesCounter
	inc wPlayerAnimationDataOffset

; 1st byte is number of frames-1
	ldy #$00
	lda (wPlayerAnimationAddr), y
	cmp wPlayerAnimationDataOffset
	bcs @next

; once past it, loop back to 1st oam spec
	lda #$00
	sta wPlayerAnimationDataOffset

@next:
; past 1st 2 bytes for oam spec idxes
	lda wPlayerAnimationDataOffset
	clc
	adc #$02
	tay

	lda wPlayerY
	sta wTempEntityY
	lda wPlayerX
	sta wTempEntityX

B4_008b:		lda (wPlayerAnimationAddr), y	; b1 00
	bne +

B4_008f:		sta $c0			; 85 c0
B4_0091:		rts				; 60 

+	tay				; a8 

; if player being knocked back, flash every frame
	lda wPlayerKnockbackCounter
	beq @getDetailsToSendSpec

	dec wPlayerKnockbackCounter
	and #$02
	beq @getDetailsToSendSpec

	rts

@getDetailsToSendSpec:
B4_009e:		lda $c0			; a5 c0
B4_00a0:		and #$60		; 29 60
B4_00a2:		sta wEntityAttrHorizOrBehindBG			; 85 05

; get spec address idx Y
	lda playerOamSpecs_lo.w, y
	sta wCurrOamSpecAddr
	lda playerOamSpecs_hi.w, y
	sta wCurrOamSpecAddr+1

; 1st spec byte is number of tiles-1
	ldy #$00
	lda (wCurrOamSpecAddr), y
	sta wNumEntityTiles

; next spec byte decides the layout for group of tiles
	iny
	lda (wCurrOamSpecAddr), y
	tay
	lda entityTileLayouts_lo.w, y
	sec
	sbc #$02
	sta wEntityLayoutAddr
	lda entityTileLayouts_hi.w, y
	sbc #$00
	sta wEntityLayoutAddr+1

; Y=1, tile idx for 1st is Y=2
	ldx wEntityOamLowerBound
	ldy #$01

playerSendSpriteSpecTo_wOam:
	jmp sendSpriteSpecTo_wOam
