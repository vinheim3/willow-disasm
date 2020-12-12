
initNPC_body:
; A is NPC ID, X is structs' idx
; preserve Y
	lda wNewNpcSpecID
	ldx wNewNpcIdx
	sty wNewNpcPreservedY

	tay
	lda entityLoadStructs_lo.w, y
	sta wEntityLoadStructAddr
	lda entityLoadStructs_hi.w, y
	sta wEntityLoadStructAddr+1

B5_35b6:		lda #$00		; a9 00
B5_35b8:		sta wEntities_438.w, x	; 9d 38 04
B5_35bb:		sta wEntities_450.w, x	; 9d 50 04
B5_35be:		sta wEntities_330.w, x	; 9d 30 03
	sta wEntitiesState.w, x
B5_35c4:		sta wEntities_378.w, x	; 9d 78 03
B5_35c7:		sta wEntities_3c0.w, x	; 9d c0 03
B5_35ca:		sta wEntities_420.w, x	; 9d 20 04

; 1st byte is num bytes to load
	tay
	lda (wEntityLoadStructAddr), y
	sta wEntityLoadStructBytes

; also wEntitiesId, wEntities_330 vals
-	iny
	lda (wEntityLoadStructAddr), y
	sta wEntitiesControlByte.w, x

	txa
	clc
	adc #MAX_ENTITIES
	tax

	dec wEntityLoadStructBytes
	bne -

	rts
