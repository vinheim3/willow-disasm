
sendSpriteSpecTo_wOam:
@nextTile:
; 1st spec byte for tile is idx
	iny
	lda (wCurrOamSpecAddr), y
	sta wOam.tile.w, x

; 1st layout byte for tile is y offset
	lda wTempEntityY
	clc
	adc (wEntityLayoutAddr), y
	sta wOam.Y.w, x

; hide if it would wrap vertically
	lda (wEntityLayoutAddr), y
	bmi +

	bcc @yIsOK

	bcs @hideTileDueToY

+	bcc @hideTileDueToY

@yIsOK:
; from 2nd spec byte, flip bits if x reversed, or if behind BG
	iny
	lda (wCurrOamSpecAddr), y
	eor wEntityAttrHorizOrBehindBG
	sta wOam.attr.w, x

; 2nd layout byte is for x offset
	lda (wEntityLayoutAddr), y
	sta wEntityTileXOffset
	bit wEntityAttrHorizOrBehindBG
	bvc +

; if reversed horizontally, place tiles' X accordingly
	eor #$ff
	sec
	sbc #$07
	sta wEntityTileXOffset

+	
; set X byte
	clc
	adc wTempEntityX
	sta wOam.X.w, x

; hide if it would wrap horizontally
	lda wEntityTileXOffset
	bmi +

	bcc @xIsOK

	bcs @hideTileDueToX

+	bcc @hideTileDueToX

@xIsOK:
	inx
	inx
	inx
	inx
	stx wEntityOamLowerBound
	cpx wEntityOamUpperBound
	beq @done

@toNextTile:
	dec wNumEntityTiles
	bpl @nextTile

@done:
	rts

@hideTileDueToY:
	iny

@hideTileDueToX:
	lda #$f8
	sta wOam.Y.w, x
	bne @toNextTile
