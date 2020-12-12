
loadScreenEntities_body:
; low 7 bits of byte 2 is screen entity specs
; detailing subid data, position data, npc spec id, etc
	lda wEntityDataByte2
	and #$7f
	asl a
	tay
	lda screenEntitiesSpecs.w, y
	sta wScreenEntitiesSpecAddr
	lda screenEntitiesSpecs.w+1, y
	sta wScreenEntitiesSpecAddr+1

; eg e0 for 1st man (1st table)
; middle 2 bits, into $07 low 2 bits (npc subid??)
B5_081f:		lda wEntityDataByte1			; a5 51
B5_0821:		and #$18		; 29 18
B5_0823:		lsr a			; 4a
B5_0824:		lsr a			; 4a
B5_0825:		lsr a			; 4a
B5_0826:		sta $07			; 85 07
B5_0828:		tay				; a8 

; store idx of $ff after above offset
-	iny
	sty wScreenEntitiesSpecOffset
	lda (wScreenEntitiesSpecAddr), y
	cmp #$ff
	bne -

; low 3 bits is formation index
	lda wEntityDataByte1
	and #$07
	asl a
	clc
	adc wScreenEntitiesSpecOffset
	tay

; iny to get the 1st actual byte of the formation data
; use low 7 bits of 1st byte to get num entities
; 2nd byte as idx to get their positions
	iny
	lda (wScreenEntitiesSpecAddr), y
	and #$7f
	sta wScreenNumEntities
	iny
	lda (wScreenEntitiesSpecAddr), y
	asl a
	tax
; eg 8c1c for man1 (78 88), 8c24 (60 78) for similar man 2
	lda screenEntitiesYXPositions.w, x
	sta wScreenEntitiesPositionsAddr
	lda screenEntitiesYXPositions.w+1, x
	sta wScreenEntitiesPositionsAddr+1
	iny

; skip past subids
-	lda (wScreenEntitiesSpecAddr), y
	cmp #$ff
	beq +

	iny
	iny
	jmp -

; offset pointing to bytes after subid
; todo: detailing npc spec id, and 408
+	iny				; c8 
B5_085e:		sty wScreenEntitiesSpecId_408_offset			; 84 05

; entities are loaded from idx $08 to $17
	lda #$00
	sta wScreenEntitiesCurrPositionsOffset
	ldx #MAX_ENTITIES-1

-	lda wEntitiesControlByte.w, x	; bd 00 03
	bmi +

	jsr loadScreenEntity		; 20 78 88
	dec wScreenNumEntities			; c6 00
	beq @done

+	dex
	cpx #FIRST_SCREEN_ENTITY_IDX
	bcs -

@done:
	rts


loadScreenEntity:
; 2 bytes for Y, X
	ldy wScreenEntitiesCurrPositionsOffset
	lda (wScreenEntitiesPositionsAddr), y
	sta wEntitiesY.w, x
	iny
	lda (wScreenEntitiesPositionsAddr), y
	sta wEntitiesX.w, x

; store offset for next entity
	iny
	sty wScreenEntitiesCurrPositionsOffset

; 1st byte after subids data
; + another type of subid?
B5_0888:		ldy wScreenEntitiesSpecId_408_offset			; a4 05
B5_088a:		lda (wScreenEntitiesSpecAddr), y	; b1 01 - 8ac7 for 1st man
B5_088c:		clc				; 18 
B5_088d:		adc $07			; 65 07
B5_088f:		jsr initNpcSpecAIdxX		; 20 ec c3

B5_0892:		iny				; c8 
B5_0893:		lda (wScreenEntitiesSpecAddr), y	; b1 01
B5_0895:		sta wEntities_408.w, x	; 9d 08 04
B5_0898:		iny				; c8 
B5_0899:		sty wScreenEntitiesSpecId_408_offset			; 84 05
B5_089b:		rts				; 60 
