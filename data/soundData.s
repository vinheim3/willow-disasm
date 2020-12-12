data_0_097d:
B0_097d:		.db $00				; 00
B0_097e:		.db $00				; 00
B0_097f:	.db $02
B0_0980:	.db $04
B0_0981:		php				; 08 
B0_0982:		bpl B0_09a4 ; 10 20

B0_0984:		rti				; 40 


B0_0985:		.db $00				; 00
B0_0986:		.db $00				; 00
B0_0987:	.db $03
B0_0988:		asl $0c			; 06 0c
B0_098a:		clc				; 18 
B0_098b:		bmi B0_09ed ; 30 60


data_0_098d:
B0_098d:		.db $00				; 00
B0_098e:		.db $00				; 00
B0_098f:		.db $00				; 00
B0_0990:		.db $00				; 00
B0_0991:		.db $00				; 00
B0_0992:		.db $00				; 00
B0_0993:		.db $00				; 00
B0_0994:		.db $00				; 00
B0_0995:		.db $00				; 00
B0_0996:		.db $00				; 00
B0_0997:		.db $00				; 00
B0_0998:		.db $00				; 00
B0_0999:		.db $00				; 00
B0_099a:		.db $00				; 00
B0_099b:		.db $00				; 00
B0_099c:		.db $00				; 00
B0_099d:		.db $00				; 00
B0_099e:		.db $00				; 00
B0_099f:	.db $f2
B0_09a0:	.db $07
B0_09a1:		dec $07, x		; d6 07
B0_09a3:	.db $14
B0_09a4:	.db $07
B0_09a5:		ldx $4e06		; ae 06 4e
B0_09a8:		asl $f3			; 06 f3
B0_09aa:		ora $94			; 05 94
B0_09ac:		ora $4d			; 05 4d
B0_09ae:		ora $01			; 05 01
B0_09b0:		ora $bb			; 05 bb
B0_09b2:	.db $04
B0_09b3:		adc $04, x		; 75 04
B0_09b5:		rol $04, x		; 36 04
B0_09b7:		sbc $bf03, y	; f9 03 bf
B0_09ba:	.db $03
B0_09bb:		txa				; 8a 
B0_09bc:	.db $03
B0_09bd:	.db $57
B0_09be:	.db $03
B0_09bf:	.db $27
B0_09c0:	.db $03
B0_09c1:	.db $fa
B0_09c2:	.db $02
B0_09c3:	.db $cf
B0_09c4:	.db $02
B0_09c5:	.db $a7
B0_09c6:	.db $02
B0_09c7:		sta ($02, x)	; 81 02
B0_09c9:		eor $3b02, x	; 5d 02 3b
B0_09cc:	.db $02
B0_09cd:	.db $1a
B0_09ce:	.db $02
B0_09cf:	.db $fc
B0_09d0:		ora ($e0, x)	; 01 e0
B0_09d2:		ora ($c5, x)	; 01 c5
B0_09d4:		ora ($ab, x)	; 01 ab
B0_09d6:		ora ($93, x)	; 01 93
B0_09d8:		ora ($7d, x)	; 01 7d
B0_09da:		ora ($67, x)	; 01 67
B0_09dc:		ora ($53, x)	; 01 53
B0_09de:		ora ($40, x)	; 01 40
B0_09e0:		ora ($2e, x)	; 01 2e
B0_09e2:		ora ($1d, x)	; 01 1d
B0_09e4:		ora ($0d, x)	; 01 0d
B0_09e6:		ora ($fe, x)	; 01 fe
B0_09e8:		.db $00				; 00
B0_09e9:		beq B0_09eb ; f0 00

B0_09eb:	.db $e2
B0_09ec:		.db $00				; 00
B0_09ed:		cmp $00, x		; d5 00
B0_09ef:		cmp #$00		; c9 00
B0_09f1:		ldx $b300, y	; be 00 b3
B0_09f4:		.db $00				; 00
B0_09f5:		lda #$00		; a9 00
B0_09f7:		ldy #$00		; a0 00
B0_09f9:	.db $97
B0_09fa:		.db $00				; 00
B0_09fb:		stx $8600		; 8e 00 86
B0_09fe:		.db $00				; 00
B0_09ff:	.db $7f
B0_0a00:		.db $00				; 00
B0_0a01:		sei				; 78 
B0_0a02:		.db $00				; 00
B0_0a03:		adc ($00), y	; 71 00
B0_0a05:		ror a			; 6a
B0_0a06:		.db $00				; 00
B0_0a07:	.db $64
B0_0a08:		.db $00				; 00
B0_0a09:	.db $5f
B0_0a0a:		.db $00				; 00
B0_0a0b:		eor $5400, y	; 59 00 54
B0_0a0e:		.db $00				; 00
B0_0a0f:		bvc B0_0a11 ; 50 00

B0_0a11:	.db $4b
B0_0a12:		.db $00				; 00
B0_0a13:	.db $47
B0_0a14:		.db $00				; 00
B0_0a15:	.db $43
B0_0a16:		.db $00				; 00
B0_0a17:	.db $3f
B0_0a18:		.db $00				; 00
B0_0a19:	.db $3c
B0_0a1a:		.db $00				; 00
B0_0a1b:		sec				; 38 
B0_0a1c:		.db $00				; 00
B0_0a1d:		and $00, x		; 35 00
B0_0a1f:	.db $32
B0_0a20:		.db $00				; 00
B0_0a21:	.db $2f
B0_0a22:		.db $00				; 00
B0_0a23:		bit $2a00		; 2c 00 2a
B0_0a26:		.db $00				; 00
B0_0a27:		plp				; 28 
B0_0a28:		.db $00				; 00
B0_0a29:		and $00			; 25 00
B0_0a2b:	.db $23
B0_0a2c:		.db $00				; 00
B0_0a2d:		and ($00, x)	; 21 00
B0_0a2f:	.db $1f
B0_0a30:		.db $00				; 00
B0_0a31:		asl $1c00, x	; 1e 00 1c
B0_0a34:		.db $00				; 00
B0_0a35:	.db $1a
B0_0a36:		.db $00				; 00
B0_0a37:		ora $1700, y	; 19 00 17
B0_0a3a:		.db $00				; 00
B0_0a3b:		asl $00, x		; 16 00
B0_0a3d:		ora $00, x		; 15 00
B0_0a3f:	.db $14
B0_0a40:		.db $00				; 00
B0_0a41:	.db $12
B0_0a42:		.db $00				; 00
B0_0a43:		ora ($00), y	; 11 00
B0_0a45:		bpl B0_0a47 ; 10 00

B0_0a47:	.db $0f
B0_0a48:		.db $00				; 00
B0_0a49:	.db $0f
B0_0a4a:		.db $00				; 00
B0_0a4b:		asl $ff00		; 0e 00 ff
B0_0a4e:	.db $ff
B0_0a4f:	.db $ff


data_0_0a50:
	.dw $8aca
	.dw $8c2d
	.dw $8d6e
	.dw $8f7b
	.dw $9162
	.dw data_0_1276
	.dw data_0_1343
	.dw $9424
	.dw $94df
	.dw $96b6
	.dw $97f7
	.dw $97f7
	.dw $9887
	.dw $9887
	.dw $99c5
	.dw $97f7
	.dw $9af3
	.dw $9f2e
	.dw $a5a1
	.dw $a6b9
	.dw $a898
	.dw $aa15
	.dw $aa15
	.dw $aa15
	.dw $aa15
	.dw $aa15
	.dw $aa15
	.dw $aa15
	.dw $aa15
	.dw $aa15
	.dw $aa15
	.dw $aa15
	.dw $aab7
	.dw $aae5
	.dw $ab28
	.dw $ab6f
	.dw sndPressStartAtMenu
	.dw data_0_2cbe
	.dw $acd9
	.dw $ad1c
	.dw $ad41
	.dw $ada4
	.dw $ae32
	.dw $aefc
	.dw $af26
	.dw $af57
	.dw $af6d
	.dw $afde
	.dw $b013
	.dw $b02e
	.dw $b10c
	.dw $b140
	.dw $b1d4
	.dw $b1f6
	.dw $b21d
	.dw $b245
	.dw $b270
	.dw $b2ed
	.dw $b30c
	.dw $b31b
	.dw $b3c9


B0_0aca:	.db $0f
B0_0acb:		cmp $8a, x		; d5 8a
B0_0acd:	.db $57
B0_0ace:	.db $8b
B0_0acf:	.db $ee $8b $00
B0_0ad2:		.db $00				; 00
B0_0ad3:		and $8c			; 25 8c
B0_0ad5:		.db $00				; 00
B0_0ad6:	.db $07
B0_0ad7:	.db $03
B0_0ad8:	.db $3f
B0_0ad9:		ora $1b			; 05 1b
B0_0adb:	.db $02
B0_0adc:		.db $00				; 00
B0_0add:	.db $07
B0_0ade:		stx $20			; 86 20
B0_0ae0:		lda $8d30		; ad 30 8d
B0_0ae3:		.db $30 $8c

B0_0ae5:		;removed
	.db $30 $8d

B0_0ae7:	.db $af
B0_0ae8:		tay				; a8 
B0_0ae9:	.db $b2
B0_0aea:		.db $30 $92

B0_0aec:		;removed
	.db $30 $91

B0_0aee:		;removed
	.db $30 $8f

B0_0af0:		lda ($ad), y	; b1 ad
B0_0af2:	.db $b2
B0_0af3:		;removed
	.db $30 $92

B0_0af5:		.db $30 $91

B0_0af7:		.db $30 $8f

B0_0af9:		lda ($b6), y	; b1 b6
B0_0afb:		lda $30, x		; b5 30
B0_0afd:		sta $30, x		; 95 30
B0_0aff:	.db $93
B0_0b00:		.db $30 $95

B0_0b02:	.db $07
B0_0b03:		ldy #$20		; a0 20
B0_0b05:		and ($b6, x)	; 21 b6
B0_0b07:		php				; 08 
B0_0b08:		ora ($b6, x)	; 01 b6
B0_0b0a:		php				; 08 
B0_0b0b:		.db $00				; 00
B0_0b0c:	.db $02
B0_0b0d:	.db $80
B0_0b0e:	.db $07
B0_0b0f:		ora ($40, x)	; 01 40
B0_0b11:		and ($d6, x)	; 21 d6
B0_0b13:		stx $92, y		; 96 92
B0_0b15:		sta ($8f), y	; 91 8f
B0_0b17:	.db $d4
B0_0b18:		lda ($ad), y	; b1 ad
B0_0b1a:		and ($d2, x)	; 21 d2
B0_0b1c:	.db $92
B0_0b1d:	.db $92
B0_0b1e:		sta ($8f), y	; 91 8f
B0_0b20:		and ($d4, x)	; 21 d4
B0_0b22:		php				; 08 
B0_0b23:		ora ($d4, x)	; 01 d4
B0_0b25:		php				; 08 
B0_0b26:		.db $00				; 00
B0_0b27:	.db $02
B0_0b28:		cpy #$21		; c0 21
B0_0b2a:		asl $b6			; 06 b6
B0_0b2c:		php				; 08 
B0_0b2d:		ora ($b6, x)	; 01 b6
B0_0b2f:		php				; 08 
B0_0b30:		.db $00				; 00
B0_0b31:	.db $9b
B0_0b32:		tya				; 98 
B0_0b33:		stx $b4, y		; 96 b4
B0_0b35:		lda ($b9), y	; b1 b9
B0_0b37:		clv				; b8 
B0_0b38:	.db $03
B0_0b39:		and $b9b6, x	; 3d b6 b9
B0_0b3c:	.db $bb
B0_0b3d:		lda $2705, x	; bd 05 27
B0_0b40:	.db $03
B0_0b41:		rol $b221, x	; 3e 21 b2
B0_0b44:		php				; 08 
B0_0b45:		ora ($b2, x)	; 01 b2
B0_0b47:		php				; 08 
B0_0b48:		.db $00				; 00
B0_0b49:	.db $03
B0_0b4a:	.db $3f
B0_0b4b:		and ($b4, x)	; 21 b4
B0_0b4d:		php				; 08 
B0_0b4e:		ora ($b4, x)	; 01 b4
B0_0b50:		php				; 08 
B0_0b51:		.db $00				; 00
B0_0b52:	.db $04
B0_0b53:		.db $00				; 00
B0_0b54:	.db $d7
B0_0b55:		txa				; 8a 
B0_0b56:		ora #$00		; 09 00
B0_0b58:	.db $07
B0_0b59:	.db $03
B0_0b5a:	.db $3c
B0_0b5b:		ora $1b			; 05 1b
B0_0b5d:		php				; 08 
B0_0b5e:		.db $00				; 00
B0_0b5f:	.db $02
B0_0b60:		.db $00				; 00
B0_0b61:	.db $07
B0_0b62:		stx $20			; 86 20
B0_0b64:		tay				; a8 
B0_0b65:		tay				; a8 
B0_0b66:		tay				; a8 
B0_0b67:	.db $a3
B0_0b68:		lda #$a9		; a9 a9
B0_0b6a:		tax				; aa 
B0_0b6b:		tax				; aa 
B0_0b6c:		tax				; aa 
B0_0b6d:		tax				; aa 
B0_0b6e:		lda $b1ad		; ad ad b1
B0_0b71:		bmi B0_0aff ; 30 8c

B0_0b73:		;removed
	.db $30 $8c

B0_0b75:		bmi B0_0b03 ; 30 8c

B0_0b77:	.db $07
B0_0b78:	.db $92
B0_0b79:		bpl B0_0b2a ; 10 af

B0_0b7b:		ldx $3a03		; ae 03 3a
B0_0b7e:	.db $02
B0_0b7f:		cpy #$07		; c0 07
B0_0b81:		ora ($80, x)	; 01 80
B0_0b83:		bmi B0_0b0f ; 30 8a

B0_0b85:		bmi B0_0b13 ; 30 8c

B0_0b87:		;removed
	.db $30 $8d

B0_0b89:	.db $04
B0_0b8a:	.db $03
B0_0b8b:	.db $83
B0_0b8c:	.db $8b
B0_0b8d:		;removed
	.db $30 $8c

B0_0b8f:		bmi B0_0b1e ; 30 8d

B0_0b91:		bmi B0_0b22 ; 30 8f

B0_0b93:	.db $04
B0_0b94:	.db $03
B0_0b95:		sta $308b		; 8d 8b 30
B0_0b98:	.db $92
B0_0b99:		bmi B0_0b2f ; 30 94

B0_0b9b:		bmi B0_0b33 ; 30 96

B0_0b9d:	.db $04
B0_0b9e:	.db $03
B0_0b9f:	.db $97
B0_0ba0:	.db $8b
B0_0ba1:		;removed
	.db $30 $91

B0_0ba3:		bmi B0_0b37 ; 30 92

B0_0ba5:		;removed
	.db $30 $94

B0_0ba7:		;removed
	.db $30 $91

B0_0ba9:		bmi B0_0b3d ; 30 92

B0_0bab:		bmi B0_0b41 ; 30 94

B0_0bad:		ldy $03, x		; b4 03
B0_0baf:	.db $3f
B0_0bb0:		bmi B0_0c1c ; 30 6a

B0_0bb2:		bmi B0_0c20 ; 30 6c

B0_0bb4:		bmi B0_0c23 ; 30 6d

B0_0bb6:		bmi B0_0c27 ; 30 6f

B0_0bb8:		;removed
	.db $30 $70

B0_0bba:		bmi B0_0c2d ; 30 71

B0_0bbc:	.db $03
B0_0bbd:		sec				; 38 
B0_0bbe:	.db $07
B0_0bbf:	.db $02
B0_0bc0:		rti				; 40 


B0_0bc1:		and ($d2, x)	; 21 d2
B0_0bc3:		php				; 08 
B0_0bc4:		ora ($d2, x)	; 01 d2
B0_0bc6:		php				; 08 
B0_0bc7:		.db $00				; 00
B0_0bc8:		and ($b1, x)	; 21 b1
B0_0bca:		php				; 08 
B0_0bcb:		ora ($b1, x)	; 01 b1
B0_0bcd:		php				; 08 
B0_0bce:		.db $00				; 00
B0_0bcf:		and ($ae, x)	; 21 ae
B0_0bd1:		php				; 08 
B0_0bd2:		ora ($ae, x)	; 01 ae
B0_0bd4:		php				; 08 
B0_0bd5:		.db $00				; 00
B0_0bd6:		and ($d2, x)	; 21 d2
B0_0bd8:		php				; 08 
B0_0bd9:		ora ($d2, x)	; 01 d2
B0_0bdb:		php				; 08 
B0_0bdc:		.db $00				; 00
B0_0bdd:		and ($b6, x)	; 21 b6
B0_0bdf:		php				; 08 
B0_0be0:		ora ($b6, x)	; 01 b6
B0_0be2:		php				; 08 
B0_0be3:		.db $00				; 00
B0_0be4:		and ($b6, x)	; 21 b6
B0_0be6:		php				; 08 
B0_0be7:		ora ($b6, x)	; 01 b6
B0_0be9:	.db $04
B0_0bea:		.db $00				; 00
B0_0beb:		eor $098b, y	; 59 8b 09
B0_0bee:		.db $00				; 00
B0_0bef:	.db $07
B0_0bf0:		ora $27			; 05 27
B0_0bf2:	.db $03
B0_0bf3:	.db $3f
B0_0bf4:		lda $acad		; ad ad ac
B0_0bf7:		ldy $abab		; ac ab ab
B0_0bfa:		tax				; aa 
B0_0bfb:		tax				; aa 
B0_0bfc:		ldx $a6			; a6 a6
B0_0bfe:		tay				; a8 
B0_0bff:	.db $a7
B0_0c00:		lda #$a5		; a9 a5
B0_0c02:		tax				; aa 
B0_0c03:		tax				; aa 
B0_0c04:	.db $03
B0_0c05:		sta ($c3, x)	; 81 c3
B0_0c07:		iny				; c8 
B0_0c08:		cmp $ca			; c5 ca
B0_0c0a:	.db $c3
B0_0c0b:		iny				; c8 
B0_0c0c:		cmp wCurrPlayerAnimationIdx			; c5 c4
B0_0c0e:	.db $03
B0_0c0f:	.db $6f
B0_0c10:	.db $a3
B0_0c11:	.db $a3
B0_0c12:		tay				; a8 
B0_0c13:		tay				; a8 
B0_0c14:		lda $a5			; a5 a5
B0_0c16:		tax				; aa 
B0_0c17:		tax				; aa 
B0_0c18:	.db $a3
B0_0c19:	.db $a3
B0_0c1a:	.db $a7
B0_0c1b:	.db $a7
B0_0c1c:	.db $a3
B0_0c1d:	.db $a3
B0_0c1e:		tay				; a8 
B0_0c1f:		tay				; a8 
B0_0c20:	.db $04
B0_0c21:		.db $00				; 00
B0_0c22:	.db $f2
B0_0c23:	.db $8b
B0_0c24:		ora #$00		; 09 00
B0_0c26:		.db $00				; 00
B0_0c27:	.db $80
B0_0c28:		.db $00				; 00
B0_0c29:		ora ($42, x)	; 01 42
B0_0c2b:	.db $80
B0_0c2c:		.db $00				; 00
B0_0c2d:	.db $0f
B0_0c2e:		sec				; 38 
B0_0c2f:		sty $8d02		; 8c 02 8d
B0_0c32:	.db $2b
B0_0c33:		sta $8d43		; 8d 43 8d
B0_0c36:	.db $5e $8d $00
B0_0c39:		asl $03			; 06 03
B0_0c3b:		rol $05, x		; 36 05
B0_0c3d:		asl $02, x		; 16 02
B0_0c3f:		.db $00				; 00
B0_0c40:	.db $07
B0_0c41:		dey				; 88 
B0_0c42:		bpl B0_0c4c ; 10 08

B0_0c44:	.db $02
B0_0c45:		rts				; 60 


B0_0c46:	.db $89
B0_0c47:		bcc B0_0bdc ; 90 93

B0_0c49:		sta $97, x		; 95 97
B0_0c4b:	.db $9e
B0_0c4c:	.db $97
B0_0c4d:		sta $04, x		; 95 04
B0_0c4f:		ora ($46, x)	; 01 46
B0_0c51:		sty $8f88		; 8c 88 8f
B0_0c54:	.db $92
B0_0c55:		sty $96, x		; 94 96
B0_0c57:		sta $9496, x	; 9d 96 94
B0_0c5a:		dey				; 88 
B0_0c5b:	.db $8f
B0_0c5c:	.db $92
B0_0c5d:		sty $76, x		; 94 76
B0_0c5f:		php				; 08 
B0_0c60:		.db $00				; 00
B0_0c61:	.db $03
B0_0c62:		rol $c002, x	; 3e 02 c0
B0_0c65:	.db $07
B0_0c66:		ora ($40, x)	; 01 40
B0_0c68:		ora ($e7, x)	; 01 e7
B0_0c6a:		and ($64, x)	; 21 64
B0_0c6c:		ora ($00, x)	; 01 00
B0_0c6e:	.db $64
B0_0c6f:		sty $86			; 84 86
B0_0c71:		php				; 08 
B0_0c72:		.db $00				; 00
B0_0c73:		ora ($e7, x)	; 01 e7
B0_0c75:	.db $22
B0_0c76:	.db $64
B0_0c77:		ora ($00, x)	; 01 00
B0_0c79:		asl $84			; 06 84
B0_0c7b:		ldy $c9			; a4 c9
B0_0c7d:		and ($cb, x)	; 21 cb
B0_0c7f:		php				; 08 
B0_0c80:		ora ($ab, x)	; 01 ab
B0_0c82:		php				; 08 
B0_0c83:		.db $00				; 00
B0_0c84:	.db $b2
B0_0c85:	.db $07
B0_0c86:	.db $02
B0_0c87:		bpl B0_0caa ; 10 21

B0_0c89:	.db $cf
B0_0c8a:		php				; 08 
B0_0c8b:		ora ($06, x)	; 01 06
B0_0c8d:	.db $cf
B0_0c8e:	.db $07
B0_0c8f:		ora ($40, x)	; 01 40
B0_0c91:		php				; 08 
B0_0c92:		.db $00				; 00
B0_0c93:	.db $8f
B0_0c94:		bcc B0_0c28 ; 90 92

B0_0c96:		bcc B0_0c27 ; 90 8f

B0_0c98:		sta $f001		; 8d 01 f0
B0_0c9b:	.db $22
B0_0c9c:	.db $6c $01 $00
B0_0c9f:		jmp ($ac06)		; 6c 06 ac


B0_0ca2:		cmp $cb21		; cd 21 cb
B0_0ca5:		php				; 08 
B0_0ca6:		ora ($ab, x)	; 01 ab
B0_0ca8:		php				; 08 
B0_0ca9:		.db $00				; 00
B0_0caa:		lda $0207		; ad 07 02
B0_0cad:		bpl B0_0cd1 ; 10 22

B0_0caf:		iny				; c8 
B0_0cb0:		php				; 08 
B0_0cb1:		ora ($c8, x)	; 01 c8
B0_0cb3:		asl $a8			; 06 a8
B0_0cb5:		php				; 08 
B0_0cb6:		.db $00				; 00
B0_0cb7:	.db $07
B0_0cb8:		ora ($40, x)	; 01 40
B0_0cba:		stx $88			; 86 88
B0_0cbc:		stx $83			; 86 83
B0_0cbe:		sta ($07, x)	; 81 07
B0_0cc0:	.db $02
B0_0cc1:		;removed
	.db $10 $21

B0_0cc3:	.db $e3
B0_0cc4:		php				; 08 
B0_0cc5:		ora ($c3, x)	; 01 c3
B0_0cc7:		php				; 08 
B0_0cc8:		.db $00				; 00
B0_0cc9:	.db $07
B0_0cca:		ora ($40, x)	; 01 40
B0_0ccc:		sty $83			; 84 83
B0_0cce:		sty $86			; 84 86
B0_0cd0:	.db $07
B0_0cd1:	.db $02
B0_0cd2:		bpl B0_0cf5 ; 10 21

B0_0cd4:		inx				; e8 
B0_0cd5:		php				; 08 
B0_0cd6:		ora ($c8, x)	; 01 c8
B0_0cd8:		php				; 08 
B0_0cd9:		.db $00				; 00
B0_0cda:	.db $07
B0_0cdb:		ora ($40, x)	; 01 40
B0_0cdd:		txa				; 8a 
B0_0cde:		dey				; 88 
B0_0cdf:		txa				; 8a 
B0_0ce0:	.db $8b
B0_0ce1:	.db $07
B0_0ce2:	.db $02
B0_0ce3:		bpl B0_0d06 ; 10 21

B0_0ce5:		sbc $0108		; ed08 01
B0_0ce8:	.db $cd $08 $00
B0_0ceb:	.db $07
B0_0cec:		ora ($40, x)	; 01 40
B0_0cee:	.db $8f
B0_0cef:		sta $928f		; 8d 8f 92
B0_0cf2:		and ($d4, x)	; 21 d4
B0_0cf4:		php				; 08 
B0_0cf5:	.db $03
B0_0cf6:	.db $d4
B0_0cf7:		php				; 08 
B0_0cf8:		.db $00				; 00
B0_0cf9:		and ($c8, x)	; 21 c8
B0_0cfb:		php				; 08 
B0_0cfc:		ora ($c8, x)	; 01 c8
B0_0cfe:	.db $04
B0_0cff:		.db $00				; 00
B0_0d00:		adc ($8c), y	; 71 8c
B0_0d02:		.db $00				; 00
B0_0d03:		asl $03			; 06 03
B0_0d05:	.db $3c
B0_0d06:		ora $16			; 05 16
B0_0d08:	.db $02
B0_0d09:		.db $00				; 00
B0_0d0a:	.db $07
B0_0d0b:		txa				; 8a 
B0_0d0c:		bpl B0_0d16 ; 10 08

B0_0d0e:	.db $02
B0_0d0f:	.db $89
B0_0d10:		bcc B0_0ca5 ; 90 93

B0_0d12:		sta $97, x		; 95 97
B0_0d14:	.db $9e
B0_0d15:	.db $97
B0_0d16:		sta $04, x		; 95 04
B0_0d18:		ora ($0f, x)	; 01 0f
B0_0d1a:		sta $8f88		; 8d 88 8f
B0_0d1d:	.db $92
B0_0d1e:		sty $96, x		; 94 96
B0_0d20:		sta $9496, x	; 9d 96 94
B0_0d23:	.db $04
B0_0d24:		ora ($1b, x)	; 01 1b
B0_0d26:	.db $8d $04 $00
B0_0d29:	.db $0f
B0_0d2a:		sta $0600		; 8d 00 06
B0_0d2d:	.db $03
B0_0d2e:		sta ($05, x)	; 81 05
B0_0d30:	.db $22
B0_0d31:		php				; 08 
B0_0d32:		.db $00				; 00
B0_0d33:		and ($e9, x)	; 21 e9
B0_0d35:		php				; 08 
B0_0d36:		ora ($e9, x)	; 01 e9
B0_0d38:		php				; 08 
B0_0d39:		.db $00				; 00
B0_0d3a:		and ($e8, x)	; 21 e8
B0_0d3c:		php				; 08 
B0_0d3d:		ora ($e8, x)	; 01 e8
B0_0d3f:	.db $04
B0_0d40:		.db $00				; 00
B0_0d41:		and ($8d), y	; 31 8d
B0_0d43:		.db $00				; 00
B0_0d44:		asl $07			; 06 07
B0_0d46:		sta ($40, x)	; 81 40
B0_0d48:	.db $03
B0_0d49:	.db $3f
B0_0d4a:	.db $07
B0_0d4b:		sta ($30, x)	; 81 30
B0_0d4d:		sta $8d80		; 8d 80 8d
B0_0d50:	.db $80
B0_0d51:	.db $80
B0_0d52:		sta $03a0		; 8d a0 03
B0_0d55:	.db $3a
B0_0d56:	.db $07
B0_0d57:	.db $92
B0_0d58:		rti				; 40 


B0_0d59:		sbc #$04		; e9 04
B0_0d5b:		.db $00				; 00
B0_0d5c:		pha				; 48 
B0_0d5d:		sta $4401		; 8d 01 44
B0_0d60:	.db $80
B0_0d61:		.db $00				; 00
B0_0d62:		ora ($84, x)	; 01 84
B0_0d64:	.db $80
B0_0d65:		.db $00				; 00
B0_0d66:		.db $00				; 00
B0_0d67:		.db $00				; 00
B0_0d68:	.db $82
B0_0d69:		php				; 08 
B0_0d6a:		ora ($63, x)	; 01 63
B0_0d6c:	.db $80
B0_0d6d:		.db $00				; 00
B0_0d6e:	.db $0f
B0_0d6f:		adc $508d, y	; 79 8d 50
B0_0d72:		stx $8f26		; 8e 26 8f
B0_0d75:		.db $00				; 00
B0_0d76:		.db $00				; 00
B0_0d77:	.db $6f
B0_0d78:	.db $8f
B0_0d79:		.db $00				; 00
B0_0d7a:	.db $07
B0_0d7b:	.db $02
B0_0d7c:		cpy #$05		; c0 05
B0_0d7e:	.db $1b
B0_0d7f:	.db $07
B0_0d80:		ora ($40, x)	; 01 40
B0_0d82:	.db $03
B0_0d83:	.db $33
B0_0d84:		tax				; aa 
B0_0d85:		txa				; 8a 
B0_0d86:		sty $8fad		; 8c ad 8f
B0_0d89:		sta $3503		; 8d 03 35
B0_0d8c:		ldy $888a		; ac 8a 88
B0_0d8f:		tax				; aa 
B0_0d90:	.db $03
B0_0d91:	.db $37
B0_0d92:		lda $8f8d		; ad 8d 8f
B0_0d95:		lda ($92), y	; b1 92
B0_0d97:		sta ($03), y	; 91 03
B0_0d99:		and $8daf, y	; 39 af 8d
B0_0d9c:		sty $03ad		; 8c ad 03
B0_0d9f:	.db $3a
B0_0da0:		lda ($91), y	; b1 91
B0_0da2:	.db $92
B0_0da3:		ldy $96, x		; b4 96
B0_0da5:		sty $03, x		; 94 03
B0_0da7:	.db $3c
B0_0da8:	.db $b2
B0_0da9:		sta ($8f), y	; 91 8f
B0_0dab:		lda ($03), y	; b1 03
B0_0dad:		and $8aaa, x	; 3d aa 8a
B0_0db0:		sty $8fad		; 8c ad 8f
B0_0db3:		sta $3e03		; 8d 03 3e
B0_0db6:		ldy $888a		; ac 8a 88
B0_0db9:		tax				; aa 
B0_0dba:	.db $03
B0_0dbb:	.db $3f
B0_0dbc:		tax				; aa 
B0_0dbd:		lda ($af), y	; b1 af
B0_0dbf:		ldx $b4, y		; b6 b4
B0_0dc1:	.db $af
B0_0dc2:		lda ($b1), y	; b1 b1
B0_0dc4:		clv				; b8 
B0_0dc5:		ldx $bb, y		; b6 bb
B0_0dc7:		lda $9498, y	; b9 98 94
B0_0dca:	.db $22
B0_0dcb:		ldx $d6, y		; b6 d6
B0_0dcd:		php				; 08 
B0_0dce:		ora ($f6, x)	; 01 f6
B0_0dd0:	.db $03
B0_0dd1:	.db $3c
B0_0dd2:		php				; 08 
B0_0dd3:	.db $02
B0_0dd4:	.db $07
B0_0dd5:		ora ($20, x)	; 01 20
B0_0dd7:	.db $80
B0_0dd8:		sta ($90), y	; 91 90
B0_0dda:		sta ($07), y	; 91 07
B0_0ddc:		ora ($20, x)	; 01 20
B0_0dde:		php				; 08 
B0_0ddf:	.db $02
B0_0de0:		stx $91, y		; 96 91
B0_0de2:		tya				; 98 
B0_0de3:		sta ($99), y	; 91 99
B0_0de5:		sei				; 78 
B0_0de6:		ror $98, x		; 76 98
B0_0de8:		sta ($96), y	; 91 96
B0_0dea:		sta $989c, x	; 9d 9c 98
B0_0ded:	.db $9b
B0_0dee:		tya				; 98 
B0_0def:		sta $2705, y	; 99 05 27
B0_0df2:		stx $96, y		; 96 96
B0_0df4:		sta ($92), y	; 91 92
B0_0df6:	.db $8f
B0_0df7:		sty $8f, x		; 94 8f
B0_0df9:		sta ($8d), y	; 91 8d
B0_0dfb:		tax				; aa 
B0_0dfc:		sty $af85		; 8c 85 af
B0_0dff:		sta $088c		; 8d 8c 08
B0_0e02:		.db $00				; 00
B0_0e03:	.db $07
B0_0e04:		ora ($40, x)	; 01 40
B0_0e06:		ora $1b			; 05 1b
B0_0e08:		ror $72, x		; 76 72
B0_0e0a:		adc ($6d), y	; 71 6d
B0_0e0c:		sei				; 78 
B0_0e0d:		ror $71, x		; 76 71
B0_0e0f:	.db $6f
B0_0e10:		adc $7871, y	; 79 71 78
B0_0e13:		ror $78, x		; 76 78
B0_0e15:		adc wCurrLevel, x		; 75 71
B0_0e17:		sei				; 78 
B0_0e18:		ror $71, x		; 76 71
B0_0e1a:		adc $7c76, x	; 7d 76 7c
B0_0e1d:		ror $78, x		; 76 78
B0_0e1f:		adc ($7b), y	; 71 7b
B0_0e21:		sei				; 78 
B0_0e22:		adc ($7b), y	; 71 7b
B0_0e24:		adc $7976, y	; 79 76 79
B0_0e27:		adc $2705, x	; 7d 05 27
B0_0e2a:		ror $71, x		; 76 71
B0_0e2c:		adc $7271		; 6d 71 72
B0_0e2f:	.db $6f
B0_0e30:		pla				; 68 
B0_0e31:	.db $6f
B0_0e32:	.db $74
B0_0e33:	.db $6f
B0_0e34:		pla				; 68 
B0_0e35:	.db $6f
B0_0e36:		adc ($6d), y	; 71 6d
B0_0e38:		pla				; 68 
B0_0e39:		adc ($05), y	; 71 05
B0_0e3b:	.db $1b
B0_0e3c:		ror $71, x		; 76 71
B0_0e3e:		bvs B0_0eb1 ; 70 71

B0_0e40:		sei				; 78 
B0_0e41:		adc ($6f), y	; 71 6f
B0_0e43:		adc ($7b), y	; 71 7b
B0_0e45:		adc ($6f), y	; 71 6f
B0_0e47:		adc ($79), y	; 71 79
B0_0e49:		adc ($78), y	; 71 78
B0_0e4b:		adc ($04), y	; 71 04
B0_0e4d:		.db $00				; 00
B0_0e4e:	.db $db
B0_0e4f:		sta $0700		; 8d 00 07
B0_0e52:		php				; 08 
B0_0e53:		ora ($03, x)	; 01 03
B0_0e55:	.db $34
B0_0e56:	.db $02
B0_0e57:		cpy #$05		; c0 05
B0_0e59:	.db $1b
B0_0e5a:		bmi B0_0dfc ; 30 a0

B0_0e5c:	.db $07
B0_0e5d:		ora ($40, x)	; 01 40
B0_0e5f:	.db $03
B0_0e60:		and ($aa), y	; 31 aa
B0_0e62:		txa				; 8a 
B0_0e63:		sty $8fad		; 8c ad 8f
B0_0e66:		sta $8aac		; 8d ac 8a
B0_0e69:		dey				; 88 
B0_0e6a:		tax				; aa 
B0_0e6b:	.db $03
B0_0e6c:	.db $32
B0_0e6d:		lda $8f8d		; ad 8d 8f
B0_0e70:		lda ($92), y	; b1 92
B0_0e72:		sta ($03), y	; 91 03
B0_0e74:	.db $34
B0_0e75:	.db $af
B0_0e76:		sta $ad8c		; 8d 8c ad
B0_0e79:	.db $03
B0_0e7a:		rol $b1, x		; 36 b1
B0_0e7c:		sta ($92), y	; 91 92
B0_0e7e:		ldy $96, x		; b4 96
B0_0e80:		sty $03, x		; 94 03
B0_0e82:	.db $37
B0_0e83:	.db $b2
B0_0e84:		sta ($8f), y	; 91 8f
B0_0e86:		lda ($03), y	; b1 03
B0_0e88:		sec				; 38 
B0_0e89:		tax				; aa 
B0_0e8a:		txa				; 8a 
B0_0e8b:		sty $8fad		; 8c ad 8f
B0_0e8e:		sta $3903		; 8d 03 39
B0_0e91:		ldy $888a		; ac 8a 88
B0_0e94:		;removed
	.db $30 $8a

B0_0e96:	.db $03
B0_0e97:	.db $3c
B0_0e98:		lda $aa			; a5 aa
B0_0e9a:		tay				; a8 
B0_0e9b:	.db $af
B0_0e9c:		lda $aaa8		; ad a8 aa
B0_0e9f:		tax				; aa 
B0_0ea0:		lda ($af), y	; b1 af
B0_0ea2:		ldy $b2, x		; b4 b2
B0_0ea4:	.db $8f
B0_0ea5:		sta $af22		; 8d 22 af
B0_0ea8:	.db $cf
B0_0ea9:		php				; 08 
B0_0eaa:		ora ($ef, x)	; 01 ef
B0_0eac:		cpy #$07		; c0 07
B0_0eae:		ora ($20, x)	; 01 20
B0_0eb0:		php				; 08 
B0_0eb1:	.db $02
B0_0eb2:		sta $9580		; 8d 80 95
B0_0eb5:	.db $80
B0_0eb6:		stx $74, y		; 96 74
B0_0eb8:		adc ($95), y	; 71 95
B0_0eba:		sty $9691		; 8c 91 96
B0_0ebd:		sta $94, x		; 95 94
B0_0ebf:	.db $8f
B0_0ec0:		sta $96, x		; 95 96
B0_0ec2:		sta $2705, x	; 9d 05 27
B0_0ec5:		sta ($8d), y	; 91 8d
B0_0ec7:		sty $8d89		; 8c 89 8d
B0_0eca:		dey				; 88 
B0_0ecb:		sty $a485		; 8c 85 a4
B0_0ece:		sty $83			; 84 83
B0_0ed0:		ora $1b			; 05 1b
B0_0ed2:		ldy $8589		; ac 89 85
B0_0ed5:		php				; 08 
B0_0ed6:		.db $00				; 00
B0_0ed7:	.db $07
B0_0ed8:		ora ($40, x)	; 01 40
B0_0eda:	.db $03
B0_0edb:		and $05, x		; 35 05
B0_0edd:	.db $1b
B0_0ede:		bmi B0_0e80 ; 30 a0

B0_0ee0:		ror $72, x		; 76 72
B0_0ee2:		adc ($6d), y	; 71 6d
B0_0ee4:		sei				; 78 
B0_0ee5:		ror $71, x		; 76 71
B0_0ee7:	.db $6f
B0_0ee8:		adc $7871, y	; 79 71 78
B0_0eeb:		ror $78, x		; 76 78
B0_0eed:		adc wCurrLevel, x		; 75 71
B0_0eef:		sei				; 78 
B0_0ef0:		ror $71, x		; 76 71
B0_0ef2:		adc $7c76, x	; 7d 76 7c
B0_0ef5:		ror $78, x		; 76 78
B0_0ef7:		adc ($7b), y	; 71 7b
B0_0ef9:		sei				; 78 
B0_0efa:		adc ($7b), y	; 71 7b
B0_0efc:		adc $7976, y	; 79 76 79
B0_0eff:		adc $2705, x	; 7d 05 27
B0_0f02:		ror $71, x		; 76 71
B0_0f04:		adc $7271		; 6d 71 72
B0_0f07:	.db $6f
B0_0f08:		pla				; 68 
B0_0f09:	.db $6f
B0_0f0a:	.db $74
B0_0f0b:	.db $6f
B0_0f0c:		pla				; 68 
B0_0f0d:	.db $6f
B0_0f0e:		adc ($6d), y	; 71 6d
B0_0f10:		pla				; 68 
B0_0f11:		adc ($05), y	; 71 05
B0_0f13:	.db $1b
B0_0f14:		ror $71, x		; 76 71
B0_0f16:		bvs B0_0f89 ; 70 71

B0_0f18:		sei				; 78 
B0_0f19:		adc ($6f), y	; 71 6f
B0_0f1b:		adc ($7b), y	; 71 7b
B0_0f1d:		adc ($6f), y	; 71 6f
B0_0f1f:		adc ($30), y	; 71 30
B0_0f21:	.db $89
B0_0f22:	.db $04
B0_0f23:		.db $00				; 00
B0_0f24:	.db $ad $8e $00
B0_0f27:	.db $07
B0_0f28:		cpx #$e0		; e0 e0
B0_0f2a:		cpx #$c0		; e0 c0
B0_0f2c:		php				; 08 
B0_0f2d:	.db $02
B0_0f2e:	.db $03
B0_0f2f:		sta ($05, x)	; 81 05
B0_0f31:	.db $27
B0_0f32:		lda $8f8d		; ad 8d 8f
B0_0f35:		lda ($92), y	; b1 92
B0_0f37:		sta ($af), y	; 91 af
B0_0f39:		sta $ad8c		; 8d 8c ad
B0_0f3c:		tax				; aa 
B0_0f3d:		txa				; 8a 
B0_0f3e:		sty $8fad		; 8c ad 8f
B0_0f41:		sta $8aac		; 8d ac 8a
B0_0f44:		dey				; 88 
B0_0f45:		tax				; aa 
B0_0f46:		php				; 08 
B0_0f47:		.db $00				; 00
B0_0f48:		tax				; aa 
B0_0f49:	.db $04
B0_0f4a:		asl $48			; 06 48
B0_0f4c:	.db $8f
B0_0f4d:	.db $23
B0_0f4e:		asl $ca			; 06 ca
B0_0f50:		dex				; ca 
B0_0f51:		php				; 08 
B0_0f52:		ora ($ea, x)	; 01 ea
B0_0f54:		nop				; ea 
B0_0f55:		cpy #$08		; c0 08
B0_0f57:		.db $00				; 00
B0_0f58:		ora $27			; 05 27
B0_0f5a:		tax				; aa 
B0_0f5b:		lda #$a8		; a9 a8
B0_0f5d:	.db $a7
B0_0f5e:		ldx $a4			; a6 a4
B0_0f60:	.db $83
B0_0f61:		ora $1b			; 05 1b
B0_0f63:		sty $b1aa		; 8c aa b1
B0_0f66:	.db $af
B0_0f67:		ldy $c5aa		; ac aa c5
B0_0f6a:		cmp #$04		; c9 04
B0_0f6c:		.db $00				; 00
B0_0f6d:		lsr $8f, x		; 56 8f
B0_0f6f:		.db $00				; 00
B0_0f70:		.db $00				; 00
B0_0f71:	.db $80
B0_0f72:		.db $00				; 00
B0_0f73:		ora ($43, x)	; 01 43
B0_0f75:	.db $80
B0_0f76:		.db $00				; 00
B0_0f77:		ora ($42, x)	; 01 42
B0_0f79:	.db $80
B0_0f7a:		.db $00				; 00
B0_0f7b:	.db $0f
B0_0f7c:		stx $8f			; 86 8f
B0_0f7e:		and ($90), y	; 31 90
B0_0f80:	.db $12
B0_0f81:		sta ($00), y	; 91 00
B0_0f83:		.db $00				; 00
B0_0f84:		lsr $91, x		; 56 91
B0_0f86:		.db $00				; 00
B0_0f87:		ora #$05		; 09 05
B0_0f89:	.db $1a
B0_0f8a:	.db $02
B0_0f8b:	.db $80
B0_0f8c:	.db $03
B0_0f8d:	.db $3c
B0_0f8e:	.db $07
B0_0f8f:		ora ($c0, x)	; 01 c0
B0_0f91:		dey				; 88 
B0_0f92:	.db $8f
B0_0f93:		sty $9e, x		; 94 9e
B0_0f95:		;removed
	.db $30 $7d

B0_0f97:		bmi B0_1017 ; 30 7e

B0_0f99:		;removed
	.db $30 $7d

B0_0f9b:	.db $7b
B0_0f9c:		adc $949b, y	; 79 9b 94
B0_0f9f:	.db $04
B0_0fa0:		ora ($91, x)	; 01 91
B0_0fa2:	.db $8f
B0_0fa3:		ora $1a			; 05 1a
B0_0fa5:	.db $89
B0_0fa6:		bcc B0_0f3d ; 90 95

B0_0fa8:		ora $26			; 05 26
B0_0faa:		sty $30, x		; 94 30
B0_0fac:	.db $73
B0_0fad:		;removed
	.db $30 $74

B0_0faf:		bmi B0_1024 ; 30 73

B0_0fb1:		bvs B0_1022 ; 70 6f

B0_0fb3:		bcc B0_0f3e ; 90 89

B0_0fb5:	.db $04
B0_0fb6:		ora ($a3, x)	; 01 a3
B0_0fb8:	.db $8f
B0_0fb9:		ora $1a			; 05 1a
B0_0fbb:		php				; 08 
B0_0fbc:	.db $02
B0_0fbd:	.db $03
B0_0fbe:	.db $34
B0_0fbf:		;removed
	.db $90 $6f

B0_0fc1:		rts				; 60 


B0_0fc2:	.db $03
B0_0fc3:		and $7495, y	; 39 95 74
B0_0fc6:		rts				; 60 


B0_0fc7:	.db $03
B0_0fc8:	.db $3c
B0_0fc9:		stx $75, y		; 96 75
B0_0fcb:		rts				; 60 


B0_0fcc:	.db $03
B0_0fcd:		rol $799a, x	; 3e 9a 79
B0_0fd0:		rts				; 60 


B0_0fd1:	.db $03
B0_0fd2:	.db $3f
B0_0fd3:		bmi B0_1051 ; 30 7c

B0_0fd5:		bmi B0_1055 ; 30 7e

B0_0fd7:		bmi B0_1055 ; 30 7c

B0_0fd9:		;removed
	.db $30 $7e

B0_0fdb:		;removed
	.db $30 $7c

B0_0fdd:		;removed
	.db $30 $7e

B0_0fdf:	.db $9c
B0_0fe0:		ror $217c, x	; 7e 7c 21
B0_0fe3:	.db $9b
B0_0fe4:		;removed
	.db $30 $7b

B0_0fe6:		;removed
	.db $30 $7c

B0_0fe8:		bmi B0_1065 ; 30 7b

B0_0fea:		;removed
	.db $30 $7c

B0_0fec:		bmi B0_1069 ; 30 7b

B0_0fee:		bmi B0_106c ; 30 7c

B0_0ff0:	.db $04
B0_0ff1:	.db $02
B0_0ff2:		cpx $8f			; e4 8f
B0_0ff4:	.db $03
B0_0ff5:	.db $3c
B0_0ff6:	.db $02
B0_0ff7:		.db $00				; 00
B0_0ff8:		php				; 08 
B0_0ff9:		.db $00				; 00
B0_0ffa:	.db $92
B0_0ffb:		bmi B0_106e ; 30 71

B0_0ffd:		;removed
	.db $30 $72

B0_0fff:		bmi B0_1072 ; 30 71

B0_1001:	.db $6f
B0_1002:		adc $218f		; 6d 8f 21
B0_1005:		dey				; 88 
B0_1006:		php				; 08 
B0_1007:		ora ($06, x)	; 01 06
B0_1009:		tay				; a8 
B0_100a:	.db $04
B0_100b:		ora ($f8, x)	; 01 f8
B0_100d:	.db $8f
B0_100e:		php				; 08 
B0_100f:		.db $00				; 00
B0_1010:		sty $30, x		; 94 30
B0_1012:	.db $73
B0_1013:		;removed
	.db $30 $74

B0_1015:		bmi B0_108a ; 30 73

B0_1017:		bvs B0_1088 ; 70 6f

B0_1019:		bcc B0_103c ; 90 21

B0_101b:	.db $89
B0_101c:		php				; 08 
B0_101d:		ora ($06, x)	; 01 06
B0_101f:		lda #$08		; a9 08
B0_1021:		.db $00				; 00
B0_1022:		sty $30, x		; 94 30
B0_1024:	.db $73
B0_1025:		;removed
	.db $30 $74

B0_1027:		bmi B0_109c ; 30 73

B0_1029:		;removed
	.db $70 $6f

B0_102b:		bcc B0_0fb6 ; 90 89

B0_102d:	.db $04
B0_102e:		.db $00				; 00
B0_102f:	.db $b9 $8f $00
B0_1032:		ora #$05		; 09 05
B0_1034:	.db $1a
B0_1035:	.db $02
B0_1036:	.db $80
B0_1037:	.db $03
B0_1038:		rol $07, x		; 36 07
B0_103a:		ora ($80, x)	; 01 80
B0_103c:		asl $80			; 06 80
B0_103e:		dey				; 88 
B0_103f:	.db $8f
B0_1040:		sty $9e, x		; 94 9e
B0_1042:		bmi B0_10c1 ; 30 7d

B0_1044:		bmi B0_10c4 ; 30 7e

B0_1046:		;removed
	.db $30 $7d

B0_1048:	.db $7b
B0_1049:		adc $949b, y	; 79 9b 94
B0_104c:	.db $04
B0_104d:		ora ($3e, x)	; 01 3e
B0_104f:		;removed
	.db $90 $89

B0_1051:		bcc B0_0fe8 ; 90 95

B0_1053:		ora $26			; 05 26
B0_1055:		sty $30, x		; 94 30
B0_1057:	.db $73
B0_1058:		bmi B0_10ce ; 30 74

B0_105a:		bmi B0_10cf ; 30 73

B0_105c:		bvs B0_10cd ; 70 6f

B0_105e:		;removed
	.db $90 $89

B0_1060:		ora $1a			; 05 1a
B0_1062:	.db $89
B0_1063:		bcc B0_0ffa ; 90 95

B0_1065:		ora $26			; 05 26
B0_1067:		sty $30, x		; 94 30
B0_1069:	.db $73
B0_106a:		bmi B0_10e0 ; 30 74

B0_106c:		;removed
	.db $30 $73

B0_106e:		bvs B0_10df ; 70 6f

B0_1070:		bvs B0_1079 ; 70 07

B0_1072:		ora ($80, x)	; 01 80
B0_1074:		ora $1a			; 05 1a
B0_1076:	.db $02
B0_1077:		.db $00				; 00
B0_1078:		php				; 08 
B0_1079:	.db $02
B0_107a:	.db $03
B0_107b:	.db $34
B0_107c:	.db $a7
B0_107d:	.db $03
B0_107e:		and $03a6, y	; 39 a6 03
B0_1081:	.db $3c
B0_1082:		ldy $03			; a4 03
B0_1084:		rol $03a5, x	; 3e a5 03
B0_1087:	.db $3f
B0_1088:		asl $a3			; 06 a3
B0_108a:	.db $63
B0_108b:	.db $63
B0_108c:		and ($a2, x)	; 21 a2
B0_108e:		php				; 08 
B0_108f:		ora ($a2, x)	; 01 a2
B0_1091:	.db $03
B0_1092:	.db $3c
B0_1093:		php				; 08 
B0_1094:		.db $00				; 00
B0_1095:		asl $a0			; 06 a0
B0_1097:		php				; 08 
B0_1098:		.db $00				; 00
B0_1099:		sta $6b30		; 8d 30 6b
B0_109c:		bmi B0_110b ; 30 6d

B0_109e:		bmi B0_110b ; 30 6b

B0_10a0:		ror a			; 6a
B0_10a1:		pla				; 68 
B0_10a2:		dey				; 88 
B0_10a3:		and ($83, x)	; 21 83
B0_10a5:		php				; 08 
B0_10a6:		ora ($06, x)	; 01 06
B0_10a8:	.db $a3
B0_10a9:	.db $04
B0_10aa:		ora ($97, x)	; 01 97
B0_10ac:		bcc B0_10b6 ; 90 08

B0_10ae:		.db $00				; 00
B0_10af:		;removed
	.db $90 $30

B0_10b1:	.db $6f
B0_10b2:		;removed
	.db $30 $70

B0_10b4:		bmi B0_1125 ; 30 6f

B0_10b6:	.db $6b
B0_10b7:		ror a			; 6a
B0_10b8:	.db $89
B0_10b9:		and ($84, x)	; 21 84
B0_10bb:		php				; 08 
B0_10bc:		ora ($06, x)	; 01 06
B0_10be:		ldy $08			; a4 08
B0_10c0:		.db $00				; 00
B0_10c1:		;removed
	.db $90 $30

B0_10c3:	.db $6f
B0_10c4:		;removed
	.db $30 $70

B0_10c6:		bmi B0_1137 ; 30 6f

B0_10c8:	.db $6b
B0_10c9:		ror a			; 6a
B0_10ca:	.db $89
B0_10cb:		sty $08			; 84 08
B0_10cd:	.db $02
B0_10ce:	.db $03
B0_10cf:	.db $34
B0_10d0:	.db $a7
B0_10d1:	.db $03
B0_10d2:		and $03a6, y	; 39 a6 03
B0_10d5:	.db $3c
B0_10d6:		ldy $03			; a4 03
B0_10d8:		rol $03a5, x	; 3e a5 03
B0_10db:	.db $3f
B0_10dc:		asl $a3			; 06 a3
B0_10de:	.db $63
B0_10df:	.db $63
B0_10e0:		and ($a2, x)	; 21 a2
B0_10e2:		php				; 08 
B0_10e3:		ora ($a2, x)	; 01 a2
B0_10e5:	.db $03
B0_10e6:	.db $3f
B0_10e7:		php				; 08 
B0_10e8:		.db $00				; 00
B0_10e9:	.db $02
B0_10ea:	.db $80
B0_10eb:	.db $07
B0_10ec:	.db $82
B0_10ed:		;removed
	.db $10 $05

B0_10ef:		asl $948f		; 0e 8f 94
B0_10f2:		sta $6d6d		; 8d 6d 6d
B0_10f5:		sta $6d6d		; 8d 6d 6d
B0_10f8:		sta $6d6d		; 8d 6d 6d
B0_10fb:	.db $04
B0_10fc:		ora ($f0, x)	; 01 f0
B0_10fe:		;removed
	.db $90 $90

B0_1100:		sta $8f, x		; 95 8f
B0_1102:	.db $6f
B0_1103:	.db $6f
B0_1104:	.db $8f
B0_1105:	.db $6f
B0_1106:	.db $6f
B0_1107:	.db $8f
B0_1108:	.db $6f
B0_1109:	.db $6f
B0_110a:	.db $04
B0_110b:		ora ($ff, x)	; 01 ff
B0_110d:		bcc B0_1113 ; 90 04

B0_110f:		.db $00				; 00
B0_1110:		adc ($90), y	; 71 90
B0_1112:		.db $00				; 00
B0_1113:		ora #$e0		; 09 e0
B0_1115:		cpx #$e0		; e0 e0
B0_1117:		cpx #$05		; e0 05
B0_1119:	.db $1a
B0_111a:	.db $03
B0_111b:		sta ($a9, x)	; 81 a9
B0_111d:		tay				; a8 
B0_111e:	.db $a7
B0_111f:		ldx $06			; a6 06
B0_1121:		lda ($71), y	; b1 71
B0_1123:		adc ($21), y	; 71 21
B0_1125:		bcs B0_112f ; b0 08

B0_1127:		ora ($b0, x)	; 01 b0
B0_1129:		php				; 08 
B0_112a:		.db $00				; 00
B0_112b:		dey				; 88 
B0_112c:	.db $8f
B0_112d:		and ($b4, x)	; 21 b4
B0_112f:		php				; 08 
B0_1130:		ora ($d4, x)	; 01 d4
B0_1132:	.db $04
B0_1133:		ora ($29, x)	; 01 29
B0_1135:		sta ($08), y	; 91 08
B0_1137:		.db $00				; 00
B0_1138:	.db $89
B0_1139:		bcc B0_115c ; 90 21

B0_113b:		lda $08, x		; b5 08
B0_113d:		ora ($d5, x)	; 01 d5
B0_113f:	.db $04
B0_1140:		ora ($36, x)	; 01 36
B0_1142:		sta ($08), y	; 91 08
B0_1144:		.db $00				; 00
B0_1145:		lda $b4, x		; b5 b4
B0_1147:	.db $b3
B0_1148:	.db $b2
B0_1149:		asl $b1			; 06 b1
B0_114b:		adc ($71), y	; 71 71
B0_114d:		and ($b0, x)	; 21 b0
B0_114f:		php				; 08 
B0_1150:		ora ($b0, x)	; 01 b0
B0_1152:	.db $04
B0_1153:		.db $00				; 00
B0_1154:		and #$91		; 29 91
B0_1156:		.db $00				; 00
B0_1157:		.db $00				; 00
B0_1158:	.db $80
B0_1159:		.db $00				; 00
B0_115a:		ora ($64, x)	; 01 64
B0_115c:	.db $80
B0_115d:		.db $00				; 00
B0_115e:		ora ($21, x)	; 01 21
B0_1160:	.db $80
B0_1161:		.db $00				; 00
B0_1162:	.db $0f
B0_1163:		adc $ae91		; 6d 91 ae
B0_1166:		sta ($10), y	; 91 10
B0_1168:	.db $92
B0_1169:		.db $00				; 00
B0_116a:		.db $00				; 00
B0_116b:		ror a			; 6a
B0_116c:	.db $92
B0_116d:		.db $00				; 00
B0_116e:		php				; 08 
B0_116f:	.db $03
B0_1170:	.db $3a
B0_1171:		php				; 08 
B0_1172:	.db $02
B0_1173:	.db $02
B0_1174:		cpy #$05		; c0 05
B0_1176:	.db $23
B0_1177:	.db $07
B0_1178:	.db $82
B0_1179:		bpl B0_1108 ; 10 8d

B0_117b:		sty $8d8c		; 8c 8c 8d
B0_117e:		sty $928c		; 8c 8c 92
B0_1181:		sta $928d		; 8d 8d 92
B0_1184:		sta $918d		; 8d 8d 91
B0_1187:		sty $918c		; 8c 8c 91
B0_118a:		sty $928c		; 8c 8c 92
B0_118d:		sta $928d		; 8d 8d 92
B0_1190:		sta $998d		; 8d 8d 99
B0_1193:		sty $948c		; 8c 8c 94
B0_1196:		sty $928c		; 8c 8c 92
B0_1199:	.db $8b
B0_119a:	.db $8b
B0_119b:		sta ($8b), y	; 91 8b
B0_119d:	.db $8b
B0_119e:		stx $8d, y		; 96 8d
B0_11a0:		sta $8d92		; 8d 92 8d
B0_11a3:		sta $869b		; 8d 9b 86
B0_11a6:		stx $98			; 86 98
B0_11a8:		stx $86			; 86 86
B0_11aa:	.db $04
B0_11ab:		.db $00				; 00
B0_11ac:		adc ($91), y	; 71 91
B0_11ae:		.db $00				; 00
B0_11af:		php				; 08 
B0_11b0:	.db $03
B0_11b1:		sec				; 38 
B0_11b2:		php				; 08 
B0_11b3:	.db $02
B0_11b4:	.db $02
B0_11b5:		cpy #$05		; c0 05
B0_11b7:	.db $17
B0_11b8:	.db $07
B0_11b9:	.db $82
B0_11ba:		bpl B0_1149 ; 10 8d

B0_11bc:		sty $94, x		; 94 94
B0_11be:		sta $9494		; 8d 94 94
B0_11c1:	.db $8f
B0_11c2:		stx $96, y		; 96 96
B0_11c4:	.db $8f
B0_11c5:		stx $96, y		; 96 96
B0_11c7:	.db $04
B0_11c8:		ora ($bb, x)	; 01 bb
B0_11ca:		sta ($8d), y	; 91 8d
B0_11cc:		sty $94, x		; 94 94
B0_11ce:		sta $9494		; 8d 94 94
B0_11d1:		;removed
	.db $90 $94

B0_11d3:		sty $90, x		; 94 90
B0_11d5:		sty $94, x		; 94 94
B0_11d7:	.db $8f
B0_11d8:		stx $96, y		; 96 96
B0_11da:	.db $8f
B0_11db:		stx $96, y		; 96 96
B0_11dd:		dey				; 88 
B0_11de:	.db $8f
B0_11df:	.db $8f
B0_11e0:		dey				; 88 
B0_11e1:	.db $8f
B0_11e2:	.db $8f
B0_11e3:		ora $0b			; 05 0b
B0_11e5:		php				; 08 
B0_11e6:		.db $00				; 00
B0_11e7:	.db $07
B0_11e8:		ora ($40, x)	; 01 40
B0_11ea:	.db $03
B0_11eb:	.db $3c
B0_11ec:		asl $ad			; 06 ad
B0_11ee:		asl $a5			; 06 a5
B0_11f0:		asl $a6			; 06 a6
B0_11f2:		asl $a8			; 06 a8
B0_11f4:		asl $ad			; 06 ad
B0_11f6:		asl $a1			; 06 a1
B0_11f8:		asl $a3			; 06 a3
B0_11fa:		asl $a6			; 06 a6
B0_11fc:		asl $ad			; 06 ad
B0_11fe:		asl $b1			; 06 b1
B0_1200:		asl $b0			; 06 b0
B0_1202:		asl $ab			; 06 ab
B0_1204:		asl $aa			; 06 aa
B0_1206:		asl $af			; 06 af
B0_1208:		asl $b0			; 06 b0
B0_120a:		asl $a8			; 06 a8
B0_120c:	.db $04
B0_120d:		.db $00				; 00
B0_120e:	.db $b2
B0_120f:		sta ($00), y	; 91 00
B0_1211:		php				; 08 
B0_1212:		ora $2f			; 05 2f
B0_1214:	.db $03
B0_1215:	.db $8f
B0_1216:		and ($d1, x)	; 21 d1
B0_1218:		php				; 08 
B0_1219:		ora ($06, x)	; 01 06
B0_121b:		lda ($08), y	; b1 08
B0_121d:		.db $00				; 00
B0_121e:	.db $92
B0_121f:		sty $30, x		; 94 30
B0_1221:	.db $74
B0_1222:		bmi B0_1299 ; 30 75

B0_1224:		bmi B0_129c ; 30 76

B0_1226:		sta $2198, y	; 99 98 21
B0_1229:	.db $d4
B0_122a:		php				; 08 
B0_122b:		ora ($06, x)	; 01 06
B0_122d:		ldy $08, x		; b4 08
B0_122f:		.db $00				; 00
B0_1230:	.db $92
B0_1231:		sty $30, x		; 94 30
B0_1233:	.db $74
B0_1234:		bmi B0_12ab ; 30 75

B0_1236:		;removed
	.db $30 $76

B0_1238:		sta $2198, y	; 99 98 21
B0_123b:		lda $0108, x	; bd 08 01
B0_123e:	.db $bd $08 $00
B0_1241:		sta $b794, y	; 99 94 b7
B0_1244:		stx $95, y		; 96 95
B0_1246:		stx $99, y		; 96 99
B0_1248:		and ($be, x)	; 21 be
B0_124a:		php				; 08 
B0_124b:		ora ($06, x)	; 01 06
B0_124d:	.db $be $08 $00
B0_1250:		ora $3b			; 05 3b
B0_1252:		bmi B0_12c4 ; 30 70

B0_1254:		;removed
	.db $30 $71

B0_1256:		;removed
	.db $30 $72

B0_1258:		and ($b3, x)	; 21 b3
B0_125a:		php				; 08 
B0_125b:		ora ($93, x)	; 01 93
B0_125d:		php				; 08 
B0_125e:		.db $00				; 00
B0_125f:		and ($b4, x)	; 21 b4
B0_1261:		php				; 08 
B0_1262:		ora ($94, x)	; 01 94
B0_1264:		php				; 08 
B0_1265:		.db $00				; 00
B0_1266:	.db $04
B0_1267:		.db $00				; 00
B0_1268:	.db $12
B0_1269:	.db $92
B0_126a:		.db $00				; 00
B0_126b:		.db $00				; 00
B0_126c:	.db $80
B0_126d:		.db $00				; 00
B0_126e:	.db $02
B0_126f:		eor ($80, x)	; 41 80
B0_1271:		.db $00				; 00
B0_1272:		.db $00				; 00
B0_1273:		.db $00				; 00
B0_1274:	.db $87
B0_1275:	.db $02


; song when using ocarina (normal villager song?)
data_0_1276:
	.db $0f
	.dw data_0_1281
	.dw data_0_12d3
	.dw $930b
	.dw $0000
	.dw $9337

data_0_1281:
	.db $00 $07
	.db $02 $80
	.db $03 $3c
	.db $05 $23 ; sets freq
	.db $08 $02
	.db $07
B0_128c:		sta $10			; 85 10
B0_128e:		sta ($91), y	; 91 91
B0_1290:		tya				; 98 
B0_1291:		tya				; 98 
B0_1292:		tya				; 98 
B0_1293:		tya				; 98 
B0_1294:	.db $04
B0_1295:		ora ($8e, x)	; 01 8e
B0_1297:	.db $92
B0_1298:		tya				; 98 
B0_1299:		sta $9698, y	; 99 98 96
B0_129c:		sty $96, x		; 94 96
B0_129e:		and ($b1, x)	; 21 b1
B0_12a0:		cmp ($91), y	; d1 91
B0_12a2:		sta ($98), y	; 91 98
B0_12a4:		tya				; 98 
B0_12a5:		tya				; 98 
B0_12a6:		tya				; 98 
B0_12a7:	.db $04
B0_12a8:		ora ($a1, x)	; 01 a1
B0_12aa:	.db $92
B0_12ab:		tya				; 98 
B0_12ac:		sta $9698, y	; 99 98 96
B0_12af:		sty $96, x		; 94 96
B0_12b1:		cmp ($07), y	; d1 07
B0_12b3:		ora ($60, x)	; 01 60
B0_12b5:		php				; 08 
B0_12b6:		.db $00				; 00
B0_12b7:	.db $8f
B0_12b8:		sta $918f		; 8d 8f 91
B0_12bb:	.db $8f
B0_12bc:		sta $8d8c		; 8d 8c 8d
B0_12bf:	.db $af
B0_12c0:		lda ($b8), y	; b1 b8
B0_12c2:		ldy $af, x		; b4 af
B0_12c4:		lda ($cf), y	; b1 cf
B0_12c6:		sta $218c		; 8d 8c 21
B0_12c9:		asl $ca			; 06 ca
B0_12cb:		php				; 08 
B0_12cc:		ora ($06, x)	; 01 06
B0_12ce:		dex				; ca 
B0_12cf:	.db $04
B0_12d0:		.db $00				; 00
B0_12d1:	.db $89
B0_12d2:	.db $92

data_0_12d3:
B0_12d3:		.db $00				; 00
B0_12d4:	.db $07
B0_12d5:	.db $02
B0_12d6:	.db $80
B0_12d7:	.db $03
B0_12d8:	.db $3b
B0_12d9:		ora $23			; 05 23
B0_12db:		php				; 08 
B0_12dc:		.db $00				; 00
B0_12dd:	.db $07
B0_12de:		sty $10			; 84 10
B0_12e0:		sta $a88d		; 8d 8d a8
B0_12e3:		tay				; a8 
B0_12e4:		sta $a88d		; 8d 8d a8
B0_12e7:		tay				; a8 
B0_12e8:	.db $92
B0_12e9:		sty $a5, x		; 94 a5
B0_12eb:		lda $ad			; a5 ad
B0_12ed:		lda $a5			; a5 a5
B0_12ef:	.db $04
B0_12f0:		ora ($e0, x)	; 01 e0
B0_12f2:	.db $92
B0_12f3:		ora $17			; 05 17
B0_12f5:	.db $07
B0_12f6:		ora ($40, x)	; 01 40
B0_12f8:		asl $cd			; 06 cd
B0_12fa:		asl $cc			; 06 cc
B0_12fc:		asl $d1			; 06 d1
B0_12fe:		asl $d2			; 06 d2
B0_1300:		and ($06, x)	; 21 06
B0_1302:		dec $08			; c6 08
B0_1304:		ora ($06, x)	; 01 06
B0_1306:		dec $04			; c6 04
B0_1308:		.db $00				; 00
B0_1309:	.db $d9 $92 $00
B0_130c:	.db $07
B0_130d:		ora $23			; 05 23
B0_130f:	.db $03
B0_1310:	.db $3f
B0_1311:		tax				; aa 
B0_1312:		lda ($b1), y	; b1 b1
B0_1314:		tax				; aa 
B0_1315:		lda ($b1), y	; b1 b1
B0_1317:		ldx $ad			; a6 ad
B0_1319:		lda $ada6		; ad a6 ad
B0_131c:		lda $0104		; ad 04 01
B0_131f:	.db $0f
B0_1320:	.db $93
B0_1321:	.db $03
B0_1322:		sta ($06, x)	; 81 06
B0_1324:	.db $c3
B0_1325:		asl $c1			; 06 c1
B0_1327:		asl $c6			; 06 c6
B0_1329:		asl $c8			; 06 c8
B0_132b:		lda ($ad), y	; b1 ad
B0_132d:	.db $af
B0_132e:		asl $aa			; 06 aa
B0_1330:		sty $8f8d		; 8c 8d 8f
B0_1333:	.db $04
B0_1334:		.db $00				; 00
B0_1335:	.db $0f
B0_1336:	.db $93
B0_1337:		.db $00				; 00
B0_1338:		.db $00				; 00
B0_1339:	.db $80
B0_133a:		.db $00				; 00
B0_133b:		ora ($22, x)	; 01 22
B0_133d:	.db $80
B0_133e:		.db $00				; 00
B0_133f:		.db $00				; 00
B0_1340:		.db $00				; 00
B0_1341:	.db $82
B0_1342:		.db $05


data_0_1343:
.db $0f
B0_1344:		lsr $c693		; 4e 93 c6
B0_1347:	.db $93
B0_1348:		cmp ($93), y	; d1 93
B0_134a:		.db $00				; 00
B0_134b:		.db $00				; 00
B0_134c:		clc				; 18 
B0_134d:		sty $00, x		; 94 00
B0_134f:		php				; 08 
B0_1350:	.db $03
B0_1351:	.db $3c
B0_1352:		php				; 08 
B0_1353:		ora ($05, x)	; 01 05
B0_1355:	.db $27
B0_1356:	.db $02
B0_1357:	.db $80
B0_1358:	.db $07
B0_1359:		ora ($40, x)	; 01 40
B0_135b:		tax				; aa 
B0_135c:		lda $21b1		; ad b1 21
B0_135f:	.db $b2
B0_1360:		php				; 08 
B0_1361:	.db $02
B0_1362:	.db $92
B0_1363:		php				; 08 
B0_1364:		ora ($30, x)	; 01 30
B0_1366:		adc ($30), y	; 71 30
B0_1368:	.db $72
B0_1369:		bmi B0_13dc ; 30 71

B0_136b:	.db $8f
B0_136c:		sta $a8af		; 8d af a8
B0_136f:		ldy $21, x		; b4 21
B0_1371:		lda ($08), y	; b1 08
B0_1373:	.db $02
B0_1374:		lda ($08), y	; b1 08
B0_1376:		ora ($b1, x)	; 01 b1
B0_1378:		bmi B0_13ce ; 30 54

B0_137a:		bmi B0_13d2 ; 30 56

B0_137c:		bmi B0_13d2 ; 30 54

B0_137e:		and ($76, x)	; 21 76
B0_1380:		ldx $94, y		; b6 94
B0_1382:	.db $92
B0_1383:		sta ($af), y	; 91 af
B0_1385:		ldy $21b4		; ac b4 21
B0_1388:		asl $d1			; 06 d1
B0_138a:		eor ($52), y	; 51 52
B0_138c:	.db $04
B0_138d:	.db $0b
B0_138e:		txa				; 8a 
B0_138f:	.db $93
B0_1390:		tax				; aa 
B0_1391:		lda $21b1		; ad b1 21
B0_1394:	.db $b2
B0_1395:		php				; 08 
B0_1396:	.db $02
B0_1397:	.db $92
B0_1398:		php				; 08 
B0_1399:		ora ($30, x)	; 01 30
B0_139b:		adc ($30), y	; 71 30
B0_139d:	.db $72
B0_139e:		bmi B0_1411 ; 30 71

B0_13a0:	.db $8f
B0_13a1:		sta $a8af		; 8d af a8
B0_13a4:		ldy $30, x		; b4 30
B0_13a6:	.db $72
B0_13a7:		bmi B0_141d ; 30 74

B0_13a9:		bmi B0_141d ; 30 72

B0_13ab:		asl $b1			; 06 b1
B0_13ad:		lda ($b6), y	; b1 b6
B0_13af:		clv				; b8 
B0_13b0:		lda $7830, y	; b9 30 78
B0_13b3:		bmi B0_142e ; 30 79

B0_13b5:		and ($30, x)	; 21 30
B0_13b7:		sei				; 78 
B0_13b8:		clv				; b8 
B0_13b9:		stx $b4, y		; 96 b4
B0_13bb:		and ($06, x)	; 21 06
B0_13bd:		dec $08, x		; d6 08
B0_13bf:	.db $02
B0_13c0:		asl $d6			; 06 d6
B0_13c2:	.db $04
B0_13c3:		.db $00				; 00
B0_13c4:	.db $52
B0_13c5:	.db $93
B0_13c6:		.db $00				; 00
B0_13c7:		php				; 08 
B0_13c8:		rti				; 40 


B0_13c9:		asl $80			; 06 80
B0_13cb:	.db $03
B0_13cc:	.db $34
B0_13cd:	.db $04
B0_13ce:		.db $00				; 00
B0_13cf:	.db $52
B0_13d0:	.db $93
B0_13d1:		.db $00				; 00
B0_13d2:		php				; 08 
B0_13d3:	.db $03
B0_13d4:		sta ($05, x)	; 81 05
B0_13d6:	.db $33
B0_13d7:		php				; 08 
B0_13d8:		ora ($06, x)	; 01 06
B0_13da:		cpy #$04		; c0 04
B0_13dc:		asl $d7			; 06 d7
B0_13de:	.db $93
B0_13df:		sta ($92), y	; 91 92
B0_13e1:		sta ($8f), y	; 91 8f
B0_13e3:		sta $aa8c		; 8d 8c aa
B0_13e6:		php				; 08 
B0_13e7:	.db $02
B0_13e8:		tax				; aa 
B0_13e9:		php				; 08 
B0_13ea:		ora ($ad, x)	; 01 ad
B0_13ec:	.db $af
B0_13ed:	.db $92
B0_13ee:		sta ($8f), y	; 91 8f
B0_13f0:		sta $ac21		; 8d 21 ac
B0_13f3:		php				; 08 
B0_13f4:	.db $02
B0_13f5:		ldy $0108		; ac 08 01
B0_13f8:		tay				; a8 
B0_13f9:		sta $8d8c		; 8d 8c 8d
B0_13fc:	.db $8f
B0_13fd:		sta $218c		; 8d 8c 21
B0_1400:		dec $08			; c6 08
B0_1402:	.db $02
B0_1403:		ldx $08			; a6 08
B0_1405:		ora ($a8, x)	; 01 a8
B0_1407:		tax				; aa 
B0_1408:		ldy $8c8a		; ac 8a 8c
B0_140b:		sta $918f		; 8d 8f 91
B0_140e:		stx $21, y		; 96 21
B0_1410:		tax				; aa 
B0_1411:		php				; 08 
B0_1412:	.db $02
B0_1413:		dex				; ca 
B0_1414:	.db $04
B0_1415:		.db $00				; 00
B0_1416:	.db $d7
B0_1417:	.db $93
B0_1418:		.db $00				; 00
B0_1419:		.db $00				; 00
B0_141a:	.db $80
B0_141b:		.db $00				; 00
B0_141c:		.db $00				; 00
B0_141d:		.db $00				; 00
B0_141e:	.db $80
B0_141f:		.db $00				; 00
B0_1420:		ora ($22, x)	; 01 22
B0_1422:	.db $80
B0_1423:		.db $00				; 00
B0_1424:	.db $0f
B0_1425:	.db $2f
B0_1426:		sty $7c, x		; 94 7c
B0_1428:		sty $a4, x		; 94 a4
B0_142a:		sty $00, x		; 94 00
B0_142c:		.db $00				; 00
B0_142d:	.db $d7
B0_142e:		sty $00, x		; 94 00
B0_1430:		php				; 08 
B0_1431:		ora $23			; 05 23
B0_1433:	.db $02
B0_1434:	.db $80
B0_1435:	.db $03
B0_1436:		rol $0107, x	; 3e 07 01
B0_1439:		rts				; 60 


B0_143a:		asl $ad			; 06 ad
B0_143c:	.db $22
B0_143d:		sty $d4, x		; 94 d4
B0_143f:	.db $54
B0_1440:		lsr $04, x		; 56 04
B0_1442:	.db $07
B0_1443:	.db $3f
B0_1444:		sty $92, x		; 94 92
B0_1446:		sty $b6, x		; 94 b6
B0_1448:		and ($f4, x)	; 21 f4
B0_144a:	.db $54
B0_144b:		lsr $04, x		; 56 04
B0_144d:	.db $07
B0_144e:		lsr a			; 4a
B0_144f:		sty $06, x		; 94 06
B0_1451:		lda $9421		; ad 21 94
B0_1454:	.db $f4
B0_1455:		ora $17			; 05 17
B0_1457:	.db $03
B0_1458:	.db $3f
B0_1459:	.db $43
B0_145a:		eor $46			; 45 46
B0_145c:		pha				; 48 
B0_145d:		lsr a			; 4a
B0_145e:		jmp $4f4d		; 4c 4d 4f


B0_1461:		eor ($52), y	; 51 52
B0_1463:	.db $54
B0_1464:		lsr $58, x		; 56 58
B0_1466:		eor $5d5b, y	; 59 5b 5d
B0_1469:	.db $9e
B0_146a:		sta $9d9b, x	; 9d 9b 9d
B0_146d:		ora $23			; 05 23
B0_146f:		.db $00				; 00
B0_1470:		asl a			; 0a
B0_1471:	.db $03
B0_1472:	.db $3e $f2 $00
B0_1475:		asl $cf21		; 0e 21 cf
B0_1478:		php				; 08 
B0_1479:		ora ($cf, x)	; 01 cf
B0_147b:		ora #$00		; 09 00
B0_147d:		php				; 08 
B0_147e:	.db $02
B0_147f:	.db $80
B0_1480:	.db $07
B0_1481:		ora ($50, x)	; 01 50
B0_1483:	.db $03
B0_1484:	.db $3a
B0_1485:		ora $2f			; 05 2f
B0_1487:		;removed
	.db $30 $6d

B0_1489:		;removed
	.db $30 $6f

B0_148b:		bmi B0_1501 ; 30 74

B0_148d:	.db $04
B0_148e:	.db $2f
B0_148f:	.db $87
B0_1490:		sty $05, x		; 94 05
B0_1492:	.db $23
B0_1493:		.db $00				; 00
B0_1494:		asl a			; 0a
B0_1495:		and ($cd, x)	; 21 cd
B0_1497:		php				; 08 
B0_1498:		ora ($cd, x)	; 01 cd
B0_149a:		.db $00				; 00
B0_149b:	.db $0e $08 $00
B0_149e:		and ($cd, x)	; 21 cd
B0_14a0:		php				; 08 
B0_14a1:		ora ($cd, x)	; 01 cd
B0_14a3:		ora #$00		; 09 00
B0_14a5:		php				; 08 
B0_14a6:	.db $03
B0_14a7:		sta ($05, x)	; 81 05
B0_14a9:	.db $17
B0_14aa:		asl $ad			; 06 ad
B0_14ac:	.db $22
B0_14ad:		sty $d4, x		; 94 d4
B0_14af:		php				; 08 
B0_14b0:		ora ($d4, x)	; 01 d4
B0_14b2:		php				; 08 
B0_14b3:		.db $00				; 00
B0_14b4:	.db $92
B0_14b5:		sty $b6, x		; 94 b6
B0_14b7:		and ($f4, x)	; 21 f4
B0_14b9:		php				; 08 
B0_14ba:		ora ($d4, x)	; 01 d4
B0_14bc:		php				; 08 
B0_14bd:		.db $00				; 00
B0_14be:		asl $ad			; 06 ad
B0_14c0:	.db $22
B0_14c1:		sty $f4, x		; 94 f4
B0_14c3:		php				; 08 
B0_14c4:		ora ($d4, x)	; 01 d4
B0_14c6:		php				; 08 
B0_14c7:		.db $00				; 00
B0_14c8:	.db $9b
B0_14c9:		sta $9998, y	; 99 98 99
B0_14cc:		.db $00				; 00
B0_14cd:		asl a			; 0a
B0_14ce:		inc $00, x		; f6 00
B0_14d0:		asl $d421		; 0e 21 d4
B0_14d3:		php				; 08 
B0_14d4:		ora ($d4, x)	; 01 d4
B0_14d6:		ora #$00		; 09 00
B0_14d8:		.db $00				; 00
B0_14d9:	.db $80
B0_14da:		.db $00				; 00
B0_14db:		ora ($43, x)	; 01 43
B0_14dd:	.db $80
B0_14de:		.db $00				; 00
B0_14df:	.db $0f
B0_14e0:		nop				; ea 
B0_14e1:		sty $d4, x		; 94 d4
B0_14e3:		sta $71, x		; 95 71
B0_14e5:		stx $00, y		; 96 00
B0_14e7:		.db $00				; 00
B0_14e8:	.db $ae $96 $00
B0_14eb:		php				; 08 
B0_14ec:		ora $2f			; 05 2f
B0_14ee:	.db $02
B0_14ef:	.db $80
B0_14f0:	.db $07
B0_14f1:		ora ($50, x)	; 01 50
B0_14f3:	.db $03
B0_14f4:	.db $3d $08 $00
B0_14f7:		bmi B0_155a ; 30 61

B0_14f9:		;removed
	.db $30 $63

B0_14fb:		and ($30, x)	; 21 30
B0_14fd:		adc ($81, x)	; 61 81
B0_14ff:		ldy $a8			; a4 a8
B0_1501:		and ($89, x)	; 21 89
B0_1503:		php				; 08 
B0_1504:		ora ($a9, x)	; 01 a9
B0_1506:		php				; 08 
B0_1507:		.db $00				; 00
B0_1508:		bmi B0_1572 ; 30 68

B0_150a:		;removed
	.db $30 $69

B0_150c:		bmi B0_1576 ; 30 68

B0_150e:		stx $84			; 86 84
B0_1510:		ora $23			; 05 23
B0_1512:	.db $b2
B0_1513:	.db $ab
B0_1514:	.db $b7
B0_1515:		;removed
	.db $30 $75

B0_1517:		bmi B0_1590 ; 30 77

B0_1519:		bmi B0_1590 ; 30 75

B0_151b:		and ($94, x)	; 21 94
B0_151d:		php				; 08 
B0_151e:		ora ($b4, x)	; 01 b4
B0_1520:		php				; 08 
B0_1521:		.db $00				; 00
B0_1522:		ldy $21, x		; b4 21
B0_1524:		sta $0108, y	; 99 08 01
B0_1527:	.db $b9 $08 $00
B0_152a:	.db $97
B0_152b:		lda $3b03, y	; b9 03 3b
B0_152e:		;removed
	.db $30 $7b

B0_1530:		bmi B0_15ae ; 30 7c

B0_1532:		and ($30, x)	; 21 30
B0_1534:	.db $7b
B0_1535:	.db $9b
B0_1536:	.db $b7
B0_1537:		ldy $03, x		; b4 03
B0_1539:	.db $3c
B0_153a:		and ($b9, x)	; 21 b9
B0_153c:		php				; 08 
B0_153d:		ora ($d9, x)	; 01 d9
B0_153f:		php				; 08 
B0_1540:		.db $00				; 00
B0_1541:	.db $03
B0_1542:		and $b721, x	; 3d 21 b7
B0_1545:		php				; 08 
B0_1546:		ora ($d7, x)	; 01 d7
B0_1548:		php				; 08 
B0_1549:		.db $00				; 00
B0_154a:		ora $2f			; 05 2f
B0_154c:	.db $07
B0_154d:	.db $ff
B0_154e:		bpl B0_1553 ; 10 03

B0_1550:	.db $3f
B0_1551:		ldx $aa			; a6 aa
B0_1553:		lda $6c30		; ad 30 6c
B0_1556:		;removed
	.db $30 $6d

B0_1558:		and ($30, x)	; 21 30
B0_155a:		jmp ($8aac)		; 6c ac 8a


B0_155d:		ldy $0621		; ac 21 06
B0_1560:		cmp $0108		; cd 08 01
B0_1563:		asl $cd			; 06 cd
B0_1565:		php				; 08 
B0_1566:		.db $00				; 00
B0_1567:		ldx $aa			; a6 aa
B0_1569:		lda ($30), y	; b1 30
B0_156b:	.db $4f
B0_156c:		;removed
	.db $30 $51

B0_156e:	.db $22
B0_156f:		;removed
	.db $30 $4f

B0_1571:	.db $6f
B0_1572:	.db $af
B0_1573:		sta $21af		; 8d af 21
B0_1576:	.db $b2
B0_1577:		php				; 08 
B0_1578:		ora ($d2, x)	; 01 d2
B0_157a:		php				; 08 
B0_157b:		.db $00				; 00
B0_157c:		and ($b4, x)	; 21 b4
B0_157e:		php				; 08 
B0_157f:		ora ($d4, x)	; 01 d4
B0_1581:		php				; 08 
B0_1582:		.db $00				; 00
B0_1583:		ora $23			; 05 23
B0_1585:	.db $03
B0_1586:		and $0107, x	; 3d 07 01
B0_1589:		rts				; 60 


B0_158a:		sta $9088		; 8d 88 90
B0_158d:		sta $9094		; 8d 94 90
B0_1590:		and ($95, x)	; 21 95
B0_1592:		php				; 08 
B0_1593:		ora ($b5, x)	; 01 b5
B0_1595:		php				; 08 
B0_1596:		.db $00				; 00
B0_1597:		bmi B0_160d ; 30 74

B0_1599:		bmi B0_1610 ; 30 75

B0_159b:		bmi B0_1611 ; 30 74

B0_159d:	.db $92
B0_159e:		;removed
	.db $90 $b2

B0_15a0:	.db $ab
B0_15a1:	.db $b7
B0_15a2:		bmi B0_1619 ; 30 75

B0_15a4:		;removed
	.db $30 $77

B0_15a6:		and ($30, x)	; 21 30
B0_15a8:		adc $95, x		; 75 95
B0_15aa:		ldy $b4, x		; b4 b4
B0_15ac:		and ($99, x)	; 21 99
B0_15ae:		php				; 08 
B0_15af:		ora ($b9, x)	; 01 b9
B0_15b1:		php				; 08 
B0_15b2:		.db $00				; 00
B0_15b3:	.db $9b
B0_15b4:		ldy $b9bb, x	; bc bb b9
B0_15b7:	.db $b7
B0_15b8:		ora $2f			; 05 2f
B0_15ba:	.db $22
B0_15bb:		lda $0108		; ad 08 01
B0_15be:	.db $ad $08 $00
B0_15c1:		eor $4f4d		; 4d 4d 4f
B0_15c4:		eor ($52), y	; 51 52
B0_15c6:	.db $54
B0_15c7:		lsr $58, x		; 56 58
B0_15c9:		and ($b9, x)	; 21 b9
B0_15cb:		php				; 08 
B0_15cc:		ora ($d9, x)	; 01 d9
B0_15ce:		php				; 08 
B0_15cf:		.db $00				; 00
B0_15d0:	.db $04
B0_15d1:		.db $00				; 00
B0_15d2:	.db $f3
B0_15d3:		sty $00, x		; 94 00
B0_15d5:		php				; 08 
B0_15d6:	.db $02
B0_15d7:		cpy #$03		; c0 03
B0_15d9:	.db $3a
B0_15da:	.db $07
B0_15db:		sta $0520		; 8d 20 05
B0_15de:	.db $17
B0_15df:		sta $9490		; 8d 90 94
B0_15e2:		;removed
	.db $90 $99

B0_15e4:		sty $92, x		; 94 92
B0_15e6:		sta $99, x		; 95 99
B0_15e8:		sta $9c, x		; 95 9c
B0_15ea:		sta $8f8b, y	; 99 8b 8f
B0_15ed:	.db $92
B0_15ee:	.db $8f
B0_15ef:	.db $97
B0_15f0:	.db $92
B0_15f1:		;removed
	.db $90 $94

B0_15f3:	.db $97
B0_15f4:		sta $94, x		; 95 94
B0_15f6:	.db $92
B0_15f7:		stx $89			; 86 89
B0_15f9:		sta $9289		; 8d 89 92
B0_15fc:		sta $8b88		; 8d 88 8b
B0_15ff:	.db $8f
B0_1600:	.db $8b
B0_1601:		sty $8f, x		; 94 8f
B0_1603:		sta $9490		; 8d 90 94
B0_1606:		bcc B0_15a1 ; 90 99

B0_1608:		sty $05, x		; 94 05
B0_160a:	.db $0b
B0_160b:	.db $07
B0_160c:	.db $ff
B0_160d:		bpl B0_1617 ; 10 08

B0_160f:		.db $00				; 00
B0_1610:	.db $03
B0_1611:	.db $3f
B0_1612:		adc $716f		; 6d 6f 71
B0_1615:	.db $72
B0_1616:	.db $74
B0_1617:		ror $78, x		; 76 78
B0_1619:		adc $1705, y	; 79 05 17
B0_161c:		bmi B0_168d ; 30 6f

B0_161e:		;removed
	.db $30 $71

B0_1620:		;removed
	.db $30 $72

B0_1622:		bmi B0_1698 ; 30 74

B0_1624:		bmi B0_169c ; 30 76

B0_1626:		bmi B0_16a0 ; 30 78

B0_1628:	.db $02
B0_1629:	.db $80
B0_162a:	.db $03
B0_162b:	.db $3c
B0_162c:		lda $b6b2		; ad b2 b6
B0_162f:	.db $8f
B0_1630:		dey				; 88 
B0_1631:		sty $928f		; 8c 8f 92
B0_1634:		sty $06, x		; 94 06
B0_1636:		dec $d4, x		; d6 d4
B0_1638:		adc ($72), y	; 71 72
B0_163a:		adc ($6f), y	; 71 6f
B0_163c:		lda $b9b2		; ad b2 b9
B0_163f:		ldy $b6, x		; b4 b6
B0_1641:		clv				; b8 
B0_1642:		lda $9896, y	; b9 96 98
B0_1645:		sta $069b, y	; 99 9b 06
B0_1648:		cld				; d8 
B0_1649:		ora $17			; 05 17
B0_164b:	.db $03
B0_164c:	.db $3a
B0_164d:	.db $07
B0_164e:		ora ($30, x)	; 01 30
B0_1650:		sty $90, x		; 94 90
B0_1652:		sta $9c94, y	; 99 94 9c
B0_1655:		sta $999c, y	; 99 9c 99
B0_1658:	.db $9c
B0_1659:	.db $9b
B0_165a:		sta $b799, y	; 99 99 b7
B0_165d:	.db $b2
B0_165e:	.db $bb
B0_165f:	.db $dc
B0_1660:		ldy $2305, x	; bc 05 23
B0_1663:		asl $d5			; 06 d5
B0_1665:	.db $b7
B0_1666:	.db $b2
B0_1667:	.db $b2
B0_1668:		ldy $b1, x		; b4 b1
B0_166a:	.db $af
B0_166b:		asl $d1			; 06 d1
B0_166d:	.db $04
B0_166e:		.db $00				; 00
B0_166f:	.db $dd $95 $00
B0_1672:		php				; 08 
B0_1673:		ora $23			; 05 23
B0_1675:	.db $03
B0_1676:		sta ($06, x)	; 81 06
B0_1678:		cmp $c606		; cd 06 c6
B0_167b:		asl $cb			; 06 cb
B0_167d:		asl $cf			; 06 cf
B0_167f:		asl $d5			; 06 d5
B0_1681:		asl $d4			; 06 d4
B0_1683:		asl $d9			; 06 d9
B0_1685:		asl $d7			; 06 d7
B0_1687:		asl $c6			; 06 c6
B0_1689:		asl $c8			; 06 c8
B0_168b:		and ($06, x)	; 21 06
B0_168d:		dex				; ca 
B0_168e:		tax				; aa 
B0_168f:		ldy $06ad		; ac ad 06
B0_1692:	.db $cf
B0_1693:		asl $c8			; 06 c8
B0_1695:		asl $c9			; 06 c9
B0_1697:		tay				; a8 
B0_1698:		tax				; aa 
B0_1699:		ldy $cd06		; ac 06 cd
B0_169c:		asl $c9			; 06 c9
B0_169e:		asl $cb			; 06 cb
B0_16a0:		asl $d0			; 06 d0
B0_16a2:		asl $d5			; 06 d5
B0_16a4:		asl $d7			; 06 d7
B0_16a6:		asl $d9			; 06 d9
B0_16a8:		asl $cd			; 06 cd
B0_16aa:	.db $04
B0_16ab:		.db $00				; 00
B0_16ac:	.db $77
B0_16ad:		stx $00, y		; 96 00
B0_16af:		.db $00				; 00
B0_16b0:	.db $80
B0_16b1:		.db $00				; 00
B0_16b2:		ora ($22, x)	; 01 22
B0_16b4:	.db $80
B0_16b5:		.db $00				; 00
B0_16b6:	.db $0f
B0_16b7:		cmp ($96, x)	; c1 96
B0_16b9:	.db $54
B0_16ba:	.db $97
B0_16bb:		ldx #$97		; a2 97
B0_16bd:		.db $00				; 00
B0_16be:		.db $00				; 00
B0_16bf:	.db $ef
B0_16c0:	.db $97
B0_16c1:		.db $00				; 00
B0_16c2:		asl $05			; 06 05
B0_16c4:	.db $12
B0_16c5:	.db $02
B0_16c6:		cpy #$07		; c0 07
B0_16c8:	.db $ff
B0_16c9:		rti				; 40 


B0_16ca:	.db $03
B0_16cb:	.db $3f
B0_16cc:		eor ($44, x)	; 41 44
B0_16ce:	.db $43
B0_16cf:	.db $47
B0_16d0:		lsr $49			; 46 49
B0_16d2:		pha				; 48 
B0_16d3:	.db $4b
B0_16d4:		lsr a			; 4a
B0_16d5:		lsr $504d		; 4e 4d 50
B0_16d8:	.db $4f
B0_16d9:	.db $53
B0_16da:	.db $52
B0_16db:		eor $54, x		; 55 54
B0_16dd:	.db $57
B0_16de:		lsr $5a, x		; 56 5a
B0_16e0:		eor $055c, y	; 59 5c 05
B0_16e3:		rol a			; 2a
B0_16e4:	.db $43
B0_16e5:	.db $47
B0_16e6:		php				; 08 
B0_16e7:		.db $00				; 00
B0_16e8:		ora $1e			; 05 1e
B0_16ea:	.db $02
B0_16eb:		cpy #$07		; c0 07
B0_16ed:		stx $20			; 86 20
B0_16ef:	.db $03
B0_16f0:		rol $30aa, x	; 3e aa 30
B0_16f3:		txa				; 8a 
B0_16f4:		bmi B0_167f ; 30 89

B0_16f6:		;removed
	.db $30 $8a

B0_16f8:		ldy $af85		; ac 85 af
B0_16fb:		sta $0107		; 8d 07 01
B0_16fe:		rti				; 40 


B0_16ff:		and ($ad, x)	; 21 ad
B0_1701:		php				; 08 
B0_1702:		ora ($cd, x)	; 01 cd
B0_1704:	.db $03
B0_1705:	.db $3c
B0_1706:		php				; 08 
B0_1707:		.db $00				; 00
B0_1708:		ror a			; 6a
B0_1709:		jmp ($6f6d)		; 6c 6d 6f


B0_170c:		adc $6a6c		; 6d 6c 6a
B0_170f:		pla				; 68 
B0_1710:	.db $6f
B0_1711:		adc $7476		; 6d 76 74
B0_1714:	.db $72
B0_1715:		adc ($6f), y	; 71 6f
B0_1717:		adc $218c		; 6d 8c 21
B0_171a:		sta ($08), y	; 91 08
B0_171c:		ora ($91, x)	; 01 91
B0_171e:		php				; 08 
B0_171f:		.db $00				; 00
B0_1720:	.db $4f
B0_1721:		eor $4a4c		; 4d 4c 4a
B0_1724:		sty $9121		; 8c 21 91
B0_1727:		php				; 08 
B0_1728:		ora ($91, x)	; 01 91
B0_172a:		php				; 08 
B0_172b:		.db $00				; 00
B0_172c:		eor ($52), y	; 51 52
B0_172e:		eor ($4f), y	; 51 4f
B0_1730:		adc ($6c), y	; 71 6c
B0_1732:		adc ($6c), y	; 71 6c
B0_1734:		adc ($6c), y	; 71 6c
B0_1736:		eor ($4f), y	; 51 4f
B0_1738:		eor $044c		; 4d 4c 04
B0_173b:		ora ($30, x)	; 01 30
B0_173d:	.db $97
B0_173e:		ora $2a			; 05 2a
B0_1740:		txa				; 8a 
B0_1741:		pla				; 68 
B0_1742:		ror a			; 6a
B0_1743:		sta ($6f), y	; 91 6f
B0_1745:		adc ($76), y	; 71 76
B0_1747:		adc ($72), y	; 71 72
B0_1749:	.db $6f
B0_174a:		adc ($6c), y	; 71 6c
B0_174c:		adc #$05		; 69 05
B0_174e:		asl $046c, x	; 1e 6c 04
B0_1751:		.db $00				; 00
B0_1752:		asl $97			; 06 97
B0_1754:		.db $00				; 00
B0_1755:		asl $05			; 06 05
B0_1757:	.db $12
B0_1758:	.db $02
B0_1759:		cpy #$07		; c0 07
B0_175b:	.db $ff
B0_175c:		rti				; 40 


B0_175d:	.db $03
B0_175e:	.db $3f
B0_175f:		rti				; 40 


B0_1760:		rts				; 60 


B0_1761:		eor ($44, x)	; 41 44
B0_1763:	.db $43
B0_1764:	.db $47
B0_1765:		lsr $49			; 46 49
B0_1767:		pha				; 48 
B0_1768:	.db $4b
B0_1769:		lsr a			; 4a
B0_176a:		lsr $504d		; 4e 4d 50
B0_176d:	.db $4f
B0_176e:	.db $53
B0_176f:	.db $52
B0_1770:		eor $54, x		; 55 54
B0_1772:	.db $57
B0_1773:		lsr $5a, x		; 56 5a
B0_1775:	.db $59 $08 $00
B0_1778:		ora $1e			; 05 1e
B0_177a:	.db $02
B0_177b:		cpy #$07		; c0 07
B0_177d:		stx $20			; 86 20
B0_177f:	.db $03
B0_1780:	.db $3c
B0_1781:		lda $30			; a5 30
B0_1783:		sta $30			; 85 30
B0_1785:		sta $30			; 85 30
B0_1787:		sta $a9			; 85 a9
B0_1789:		ora $12			; 05 12
B0_178b:		sty $91b1		; 8c b1 91
B0_178e:	.db $07
B0_178f:		ora ($40, x)	; 01 40
B0_1791:		and ($b1, x)	; 21 b1
B0_1793:		php				; 08 
B0_1794:		ora ($d1, x)	; 01 d1
B0_1796:	.db $03
B0_1797:		rol $30, x		; 36 30
B0_1799:		rts				; 60 


B0_179a:		jsr $0580		; 20 80 05
B0_179d:	.db $1e $04 $00
B0_17a0:		asl $97			; 06 97
B0_17a2:		.db $00				; 00
B0_17a3:		asl $05			; 06 05
B0_17a5:		asl $8103, x	; 1e 03 81
B0_17a8:		eor ($44, x)	; 41 44
B0_17aa:	.db $43
B0_17ab:	.db $47
B0_17ac:		lsr $49			; 46 49
B0_17ae:		pha				; 48 
B0_17af:	.db $4b
B0_17b0:		lsr a			; 4a
B0_17b1:		lsr $504d		; 4e 4d 50
B0_17b4:	.db $4f
B0_17b5:	.db $53
B0_17b6:	.db $52
B0_17b7:		eor $54, x		; 55 54
B0_17b9:	.db $57
B0_17ba:		lsr $5a, x		; 56 5a
B0_17bc:		eor $055c, y	; 59 5c 05
B0_17bf:		rol $43, x		; 36 43
B0_17c1:	.db $47
B0_17c2:		ora $1e			; 05 1e
B0_17c4:	.db $03
B0_17c5:		rti				; 40 


B0_17c6:		tax				; aa 
B0_17c7:		;removed
	.db $30 $8a

B0_17c9:		bmi B0_1755 ; 30 8a

B0_17cb:		bmi B0_1757 ; 30 8a

B0_17cd:		lda #$89		; a9 89
B0_17cf:		tay				; a8 
B0_17d0:		dey				; 88 
B0_17d1:	.db $03
B0_17d2:		sta ($21, x)	; 81 21
B0_17d4:	.db $a7
B0_17d5:		php				; 08 
B0_17d6:		ora ($c7, x)	; 01 c7
B0_17d8:		php				; 08 
B0_17d9:		.db $00				; 00
B0_17da:	.db $03
B0_17db:		rti				; 40 


B0_17dc:		txa				; 8a 
B0_17dd:	.db $04
B0_17de:	.db $0f
B0_17df:	.db $dc
B0_17e0:	.db $97
B0_17e1:	.db $8b
B0_17e2:	.db $04
B0_17e3:	.db $07
B0_17e4:		sbc ($97, x)	; e1 97
B0_17e6:		txa				; 8a 
B0_17e7:	.db $04
B0_17e8:	.db $07
B0_17e9:		inc $97			; e6 97
B0_17eb:	.db $04
B0_17ec:		.db $00				; 00
B0_17ed:	.db $da
B0_17ee:	.db $97
B0_17ef:		.db $00				; 00
B0_17f0:		.db $00				; 00
B0_17f1:	.db $80
B0_17f2:		.db $00				; 00
B0_17f3:		ora ($44, x)	; 01 44
B0_17f5:	.db $80
B0_17f6:		.db $00				; 00
B0_17f7:	.db $0f
B0_17f8:	.db $02
B0_17f9:		tya				; 98 
B0_17fa:		and $4998		; 2d 98 49
B0_17fd:		tya				; 98 
B0_17fe:		adc $7b98		; 6d 98 7b
B0_1801:		tya				; 98 
B0_1802:		.db $00				; 00
B0_1803:	.db $07
B0_1804:	.db $03
B0_1805:		rol $8807, x	; 3e 07 88
B0_1808:		jsr $0e05		; 20 05 0e
B0_180b:		php				; 08 
B0_180c:		ora ($02, x)	; 01 02
B0_180e:		cpy #$6a		; c0 6a
B0_1810:		adc ($76), y	; 71 76
B0_1812:	.db $77
B0_1813:		ror $71, x		; 76 71
B0_1815:	.db $7c
B0_1816:	.db $77
B0_1817:	.db $04
B0_1818:		ora ($0f, x)	; 01 0f
B0_181a:		tya				; 98 
B0_181b:		ora $1a			; 05 1a
B0_181d:	.db $63
B0_181e:		ror a			; 6a
B0_181f:	.db $6f
B0_1820:		;removed
	.db $70 $6f

B0_1822:		ror a			; 6a
B0_1823:		adc $70, x		; 75 70
B0_1825:	.db $04
B0_1826:		ora ($1d, x)	; 01 1d
B0_1828:		tya				; 98 
B0_1829:	.db $04
B0_182a:		.db $00				; 00
B0_182b:		asl $98			; 06 98
B0_182d:		.db $00				; 00
B0_182e:	.db $07
B0_182f:	.db $03
B0_1830:	.db $3f
B0_1831:		ora $0b			; 05 0b
B0_1833:		cmp $b2d4		; cd d4 b2
B0_1836:		asl $ab			; 06 ab
B0_1838:	.db $89
B0_1839:	.db $8b
B0_183a:		sty $d4cd		; 8c cd d4
B0_183d:	.db $92
B0_183e:	.db $74
B0_183f:		adc $06, x		; 75 06
B0_1841:	.db $b7
B0_1842:		sta $94, x		; 95 94
B0_1844:		bcc B0_184a ; 90 04

B0_1846:		.db $00				; 00
B0_1847:	.db $33
B0_1848:		tya				; 98 
B0_1849:		.db $00				; 00
B0_184a:	.db $07
B0_184b:	.db $03
B0_184c:		bmi B0_1853 ; 30 05

B0_184e:		asl $716a		; 0e 6a 71
B0_1851:		ror $77, x		; 76 77
B0_1853:		ror $71, x		; 76 71
B0_1855:	.db $7c
B0_1856:	.db $77
B0_1857:	.db $04
B0_1858:		ora ($4f, x)	; 01 4f
B0_185a:		tya				; 98 
B0_185b:		ora $1a			; 05 1a
B0_185d:	.db $63
B0_185e:		ror a			; 6a
B0_185f:	.db $6f
B0_1860:		bvs B0_18d1 ; 70 6f

B0_1862:		ror a			; 6a
B0_1863:		adc $70, x		; 75 70
B0_1865:	.db $04
B0_1866:		ora ($5d, x)	; 01 5d
B0_1868:		tya				; 98 
B0_1869:	.db $04
B0_186a:		.db $00				; 00
B0_186b:	.db $4d $98 $00
B0_186e:	.db $07
B0_186f:	.db $03
B0_1870:	.db $3f
B0_1871:	.db $07
B0_1872:		txa				; 8a 
B0_1873:		jsr $0208		; 20 08 02
B0_1876:	.db $eb
B0_1877:	.db $04
B0_1878:		.db $00				; 00
B0_1879:		ror $98, x		; 76 98
B0_187b:	.db $02
B0_187c:	.db $64
B0_187d:	.db $80
B0_187e:		.db $00				; 00
B0_187f:		.db $00				; 00
B0_1880:		.db $00				; 00
B0_1881:	.db $82
B0_1882:		php				; 08 
B0_1883:		.db $00				; 00
B0_1884:		.db $00				; 00
B0_1885:	.db $82
B0_1886:	.db $07
B0_1887:	.db $0f
B0_1888:	.db $92
B0_1889:		tya				; 98 
B0_188a:	.db $4f
B0_188b:		sta $9987, y	; 99 87 99
B0_188e:		.db $00				; 00
B0_188f:		.db $00				; 00
B0_1890:	.db $bd $99 $00
B0_1893:		php				; 08 
B0_1894:	.db $07
B0_1895:		ora ($60, x)	; 01 60
B0_1897:	.db $02
B0_1898:		.db $00				; 00
B0_1899:	.db $03
B0_189a:	.db $3f
B0_189b:		ora $23			; 05 23
B0_189d:		;removed
	.db $30 $8d

B0_189f:		;removed
	.db $30 $91

B0_18a1:		;removed
	.db $30 $94

B0_18a3:		ora $23			; 05 23
B0_18a5:		bmi B0_1860 ; 30 b9

B0_18a7:		bmi B0_1842 ; 30 99

B0_18a9:		;removed
	.db $30 $78

B0_18ab:		bmi B0_1926 ; 30 79

B0_18ad:		bmi B0_1847 ; 30 98

B0_18af:		bmi B0_1847 ; 30 96

B0_18b1:		;removed
	.db $30 $b4

B0_18b3:		bmi B0_1849 ; 30 94

B0_18b5:		;removed
	.db $30 $72

B0_18b7:		;removed
	.db $30 $74

B0_18b9:		;removed
	.db $30 $92

B0_18bb:		bmi B0_184e ; 30 91

B0_18bd:		bmi B0_1871 ; 30 b2

B0_18bf:		bmi B0_1853 ; 30 92

B0_18c1:		bmi B0_1872 ; 30 af

B0_18c3:		;removed
	.db $30 $8f

B0_18c5:		bmi B0_1878 ; 30 b1

B0_18c7:		bmi B0_185b ; 30 92

B0_18c9:		bmi B0_185f ; 30 94

B0_18cb:		bmi B0_1863 ; 30 96

B0_18cd:		;removed
	.db $30 $98

B0_18cf:		bmi B0_188a ; 30 b9

B0_18d1:		;removed
	.db $30 $99

B0_18d3:		bmi B0_194d ; 30 78

B0_18d5:		bmi B0_1950 ; 30 79

B0_18d7:		bmi B0_1871 ; 30 98

B0_18d9:		bmi B0_1871 ; 30 96

B0_18db:		;removed
	.db $30 $b4

B0_18dd:		bmi B0_1873 ; 30 94

B0_18df:		;removed
	.db $30 $72

B0_18e1:		bmi B0_1957 ; 30 74

B0_18e3:		bmi B0_1877 ; 30 92

B0_18e5:		bmi B0_1878 ; 30 91

B0_18e7:		bmi B0_187b ; 30 92

B0_18e9:		bmi B0_187c ; 30 91

B0_18eb:		bmi B0_187c ; 30 8f

B0_18ed:		bmi B0_189b ; 30 ac

B0_18ef:		bmi B0_1880 ; 30 8f

B0_18f1:		and ($ad, x)	; 21 ad
B0_18f3:		php				; 08 
B0_18f4:		ora ($ad, x)	; 01 ad
B0_18f6:		php				; 08 
B0_18f7:		.db $00				; 00
B0_18f8:		;removed
	.db $30 $b4

B0_18fa:		bmi B0_1890 ; 30 94

B0_18fc:		;removed
	.db $30 $75

B0_18fe:		bmi B0_1977 ; 30 77

B0_1900:		bmi B0_1897 ; 30 95

B0_1902:		bmi B0_1898 ; 30 94

B0_1904:		;removed
	.db $30 $b2

B0_1906:		bmi B0_1898 ; 30 90

B0_1908:		bmi B0_189a ; 30 90

B0_190a:		bmi B0_189b ; 30 8f

B0_190c:		;removed
	.db $30 $90

B0_190e:		;removed
	.db $30 $b4

B0_1910:		;removed
	.db $30 $94

B0_1912:		;removed
	.db $30 $b2

B0_1914:		;removed
	.db $30 $94

B0_1916:		;removed
	.db $30 $b2

B0_1918:		bmi B0_18ab ; 30 91

B0_191a:		adc ($6d), y	; 71 6d
B0_191c:		bmi B0_198f ; 30 71

B0_191e:		bmi B0_1994 ; 30 74

B0_1920:		;removed
	.db $30 $78

B0_1922:		bmi B0_18dd ; 30 b9

B0_1924:		bmi B0_18bf ; 30 99

B0_1926:		bmi B0_19a0 ; 30 78

B0_1928:		;removed
	.db $30 $79

B0_192a:		;removed
	.db $30 $98

B0_192c:		;removed
	.db $30 $96

B0_192e:		;removed
	.db $30 $b4

B0_1930:		ora $2f			; 05 2f
B0_1932:		bmi B0_18c1 ; 30 8d

B0_1934:		bmi B0_18c7 ; 30 91

B0_1936:		;removed
	.db $30 $92

B0_1938:		;removed
	.db $30 $94

B0_193a:		;removed
	.db $30 $92

B0_193c:		bmi B0_18cf ; 30 91

B0_193e:		bmi B0_18cf ; 30 8f

B0_1940:		;removed
	.db $30 $aa

B0_1942:		;removed
	.db $30 $8c

B0_1944:		lda $8130		; ad 30 81
B0_1947:		;removed
	.db $30 $85

B0_1949:		bmi B0_18d3 ; 30 88

B0_194b:	.db $04
B0_194c:		.db $00				; 00
B0_194d:	.db $a3
B0_194e:		tya				; 98 
B0_194f:		.db $00				; 00
B0_1950:		php				; 08 
B0_1951:	.db $07
B0_1952:		ora ($40, x)	; 01 40
B0_1954:		ora $17			; 05 17
B0_1956:	.db $02
B0_1957:	.db $80
B0_1958:	.db $03
B0_1959:		rol $b2a0, x	; 3e a0 b2
B0_195c:	.db $b3
B0_195d:		ldy $aaad		; ac ad aa
B0_1960:		tax				; aa 
B0_1961:		;removed
	.db $30 $a8

B0_1963:		bmi B0_18ed ; 30 88

B0_1965:		tay				; a8 
B0_1966:		ldx $b0, y		; b6 b0
B0_1968:		lda ($ae), y	; b1 ae
B0_196a:		tax				; aa 
B0_196b:		ldx $c5			; a6 c5
B0_196d:	.db $ab
B0_196e:		ldx $adad		; ae ad ad
B0_1971:		tax				; aa 
B0_1972:		ldy $aba8		; ac a8 ab
B0_1975:		ldx $b3, y		; b6 b3
B0_1977:		ldy $aaac		; ac ac aa
B0_197a:	.db $af
B0_197b:		bmi B0_192e ; 30 b1

B0_197d:		bmi B0_1910 ; 30 91

B0_197f:		bmi B0_1912 ; 30 91

B0_1981:		;removed
	.db $30 $a0

B0_1983:	.db $04
B0_1984:		.db $00				; 00
B0_1985:	.db $5b
B0_1986:		sta $0800, y	; 99 00 08
B0_1989:	.db $03
B0_198a:		adc $05			; 65 05
B0_198c:	.db $23
B0_198d:		ldy #$ad		; a0 ad
B0_198f:		bcs B0_1942 ; b0 b1

B0_1991:		tax				; aa 
B0_1992:	.db $af
B0_1993:		tay				; a8 
B0_1994:		lda $8d30		; ad 30 8d
B0_1997:		bmi B0_1928 ; 30 8f

B0_1999:		bmi B0_192c ; 30 91

B0_199b:	.db $b2
B0_199c:	.db $b3
B0_199d:		ldy $b1, x		; b4 b1
B0_199f:	.db $af
B0_19a0:		tay				; a8 
B0_19a1:		lda $b0a1		; ad a1 b0
B0_19a4:		bcs B0_194f ; b0 a9

B0_19a6:		tax				; aa 
B0_19a7:	.db $af
B0_19a8:		tay				; a8 
B0_19a9:		lda $b2ad		; ad ad b2
B0_19ac:		;removed
	.db $b0 $b1

B0_19ae:		tax				; aa 
B0_19af:	.db $af
B0_19b0:		tay				; a8 
B0_19b1:		bmi B0_1960 ; 30 ad

B0_19b3:		;removed
	.db $30 $88

B0_19b5:		bmi B0_1938 ; 30 81

B0_19b7:		bmi B0_1959 ; 30 a0

B0_19b9:	.db $04
B0_19ba:		.db $00				; 00
B0_19bb:	.db $8e $99 $00
B0_19be:		.db $00				; 00
B0_19bf:	.db $80
B0_19c0:		.db $00				; 00
B0_19c1:		ora ($41, x)	; 01 41
B0_19c3:	.db $80
B0_19c4:		.db $00				; 00
B0_19c5:	.db $0f
B0_19c6:		bne B0_1961 ; d0 99

B0_19c8:	.db $de $9a $00
B0_19cb:		.db $00				; 00
B0_19cc:		.db $00				; 00
B0_19cd:		.db $00				; 00
B0_19ce:	.db $eb
B0_19cf:		txs				; 9a 
B0_19d0:		.db $00				; 00
B0_19d1:	.db $04
B0_19d2:	.db $02
B0_19d3:		cpy #$03		; c0 03
B0_19d5:	.db $3f
B0_19d6:	.db $07
B0_19d7:		dey				; 88 
B0_19d8:		;removed
	.db $30 $05

B0_19da:	.db $12
B0_19db:		and ($63, x)	; 21 63
B0_19dd:		php				; 08 
B0_19de:		ora ($63, x)	; 01 63
B0_19e0:		php				; 08 
B0_19e1:		.db $00				; 00
B0_19e2:		ora $1e			; 05 1e
B0_19e4:		and ($6f, x)	; 21 6f
B0_19e6:		php				; 08 
B0_19e7:		ora ($6f, x)	; 01 6f
B0_19e9:		php				; 08 
B0_19ea:		.db $00				; 00
B0_19eb:		and ($70, x)	; 21 70
B0_19ed:		php				; 08 
B0_19ee:		ora ($70, x)	; 01 70
B0_19f0:		php				; 08 
B0_19f1:		.db $00				; 00
B0_19f2:		and ($76, x)	; 21 76
B0_19f4:		php				; 08 
B0_19f5:		ora ($76, x)	; 01 76
B0_19f7:		php				; 08 
B0_19f8:		.db $00				; 00
B0_19f9:		ora $12			; 05 12
B0_19fb:		and ($64, x)	; 21 64
B0_19fd:		php				; 08 
B0_19fe:		ora ($64, x)	; 01 64
B0_1a00:		php				; 08 
B0_1a01:		.db $00				; 00
B0_1a02:		ora $1e			; 05 1e
B0_1a04:		and ($6f, x)	; 21 6f
B0_1a06:		php				; 08 
B0_1a07:		ora ($6f, x)	; 01 6f
B0_1a09:		php				; 08 
B0_1a0a:		.db $00				; 00
B0_1a0b:		and ($70, x)	; 21 70
B0_1a0d:		php				; 08 
B0_1a0e:		ora ($70, x)	; 01 70
B0_1a10:		php				; 08 
B0_1a11:		.db $00				; 00
B0_1a12:		and ($76, x)	; 21 76
B0_1a14:		php				; 08 
B0_1a15:		ora ($76, x)	; 01 76
B0_1a17:		php				; 08 
B0_1a18:		.db $00				; 00
B0_1a19:		ora $12			; 05 12
B0_1a1b:		and ($68, x)	; 21 68
B0_1a1d:		php				; 08 
B0_1a1e:		ora ($68, x)	; 01 68
B0_1a20:		php				; 08 
B0_1a21:		.db $00				; 00
B0_1a22:		ora $1e			; 05 1e
B0_1a24:		and ($6f, x)	; 21 6f
B0_1a26:		php				; 08 
B0_1a27:		ora ($6f, x)	; 01 6f
B0_1a29:		php				; 08 
B0_1a2a:		.db $00				; 00
B0_1a2b:		and ($70, x)	; 21 70
B0_1a2d:		php				; 08 
B0_1a2e:		ora ($70, x)	; 01 70
B0_1a30:		php				; 08 
B0_1a31:		.db $00				; 00
B0_1a32:		and ($76, x)	; 21 76
B0_1a34:		php				; 08 
B0_1a35:		ora ($76, x)	; 01 76
B0_1a37:		php				; 08 
B0_1a38:		.db $00				; 00
B0_1a39:		ora $12			; 05 12
B0_1a3b:		and ($69, x)	; 21 69
B0_1a3d:		php				; 08 
B0_1a3e:		ora ($69, x)	; 01 69
B0_1a40:		php				; 08 
B0_1a41:		.db $00				; 00
B0_1a42:		ora $1e			; 05 1e
B0_1a44:		and ($6f, x)	; 21 6f
B0_1a46:		php				; 08 
B0_1a47:		ora ($6f, x)	; 01 6f
B0_1a49:		php				; 08 
B0_1a4a:		.db $00				; 00
B0_1a4b:		and ($70, x)	; 21 70
B0_1a4d:		php				; 08 
B0_1a4e:		ora ($70, x)	; 01 70
B0_1a50:		php				; 08 
B0_1a51:		.db $00				; 00
B0_1a52:		and ($76, x)	; 21 76
B0_1a54:		php				; 08 
B0_1a55:		ora ($76, x)	; 01 76
B0_1a57:		php				; 08 
B0_1a58:		.db $00				; 00
B0_1a59:		ora $06			; 05 06
B0_1a5b:		and ($6a, x)	; 21 6a
B0_1a5d:		php				; 08 
B0_1a5e:		ora ($6a, x)	; 01 6a
B0_1a60:		php				; 08 
B0_1a61:		.db $00				; 00
B0_1a62:		ora $1e			; 05 1e
B0_1a64:		and ($6a, x)	; 21 6a
B0_1a66:		php				; 08 
B0_1a67:		ora ($6a, x)	; 01 6a
B0_1a69:		php				; 08 
B0_1a6a:		.db $00				; 00
B0_1a6b:		and ($6b, x)	; 21 6b
B0_1a6d:		php				; 08 
B0_1a6e:		ora ($6b, x)	; 01 6b
B0_1a70:		php				; 08 
B0_1a71:		.db $00				; 00
B0_1a72:		and ($70, x)	; 21 70
B0_1a74:		php				; 08 
B0_1a75:		ora ($70, x)	; 01 70
B0_1a77:		php				; 08 
B0_1a78:		.db $00				; 00
B0_1a79:		ora $06			; 05 06
B0_1a7b:		and ($6b, x)	; 21 6b
B0_1a7d:		php				; 08 
B0_1a7e:		ora ($6b, x)	; 01 6b
B0_1a80:		php				; 08 
B0_1a81:		.db $00				; 00
B0_1a82:		ora $1e			; 05 1e
B0_1a84:		and ($6a, x)	; 21 6a
B0_1a86:		php				; 08 
B0_1a87:		ora ($6a, x)	; 01 6a
B0_1a89:		php				; 08 
B0_1a8a:		.db $00				; 00
B0_1a8b:		and ($6b, x)	; 21 6b
B0_1a8d:		php				; 08 
B0_1a8e:		ora ($6b, x)	; 01 6b
B0_1a90:		php				; 08 
B0_1a91:		.db $00				; 00
B0_1a92:		and ($70, x)	; 21 70
B0_1a94:		php				; 08 
B0_1a95:		ora ($70, x)	; 01 70
B0_1a97:		php				; 08 
B0_1a98:		.db $00				; 00
B0_1a99:		ora $06			; 05 06
B0_1a9b:		and ($70, x)	; 21 70
B0_1a9d:		php				; 08 
B0_1a9e:		ora ($70, x)	; 01 70
B0_1aa0:		php				; 08 
B0_1aa1:		.db $00				; 00
B0_1aa2:		ora $1e			; 05 1e
B0_1aa4:		and ($6a, x)	; 21 6a
B0_1aa6:		php				; 08 
B0_1aa7:		ora ($6a, x)	; 01 6a
B0_1aa9:		php				; 08 
B0_1aaa:		.db $00				; 00
B0_1aab:		and ($6b, x)	; 21 6b
B0_1aad:		php				; 08 
B0_1aae:		ora ($6b, x)	; 01 6b
B0_1ab0:		php				; 08 
B0_1ab1:		.db $00				; 00
B0_1ab2:		and ($70, x)	; 21 70
B0_1ab4:		php				; 08 
B0_1ab5:		ora ($70, x)	; 01 70
B0_1ab7:		php				; 08 
B0_1ab8:		.db $00				; 00
B0_1ab9:		ora $06			; 05 06
B0_1abb:		and ($6f, x)	; 21 6f
B0_1abd:		php				; 08 
B0_1abe:		ora ($6f, x)	; 01 6f
B0_1ac0:		php				; 08 
B0_1ac1:		.db $00				; 00
B0_1ac2:		ora $1e			; 05 1e
B0_1ac4:		and ($6a, x)	; 21 6a
B0_1ac6:		php				; 08 
B0_1ac7:		ora ($6a, x)	; 01 6a
B0_1ac9:		php				; 08 
B0_1aca:		.db $00				; 00
B0_1acb:		and ($6b, x)	; 21 6b
B0_1acd:		php				; 08 
B0_1ace:		ora ($6b, x)	; 01 6b
B0_1ad0:		php				; 08 
B0_1ad1:		.db $00				; 00
B0_1ad2:		and ($70, x)	; 21 70
B0_1ad4:		php				; 08 
B0_1ad5:		ora ($70, x)	; 01 70
B0_1ad7:		php				; 08 
B0_1ad8:		.db $00				; 00
B0_1ad9:	.db $04
B0_1ada:		.db $00				; 00
B0_1adb:		dec $99, x		; d6 99
B0_1add:		ora #$00		; 09 00
B0_1adf:	.db $04
B0_1ae0:	.db $02
B0_1ae1:		cpy #$03		; c0 03
B0_1ae3:		sec				; 38 
B0_1ae4:		asl $80			; 06 80
B0_1ae6:	.db $04
B0_1ae7:		.db $00				; 00
B0_1ae8:		dec $99, x		; d6 99
B0_1aea:		ora #$00		; 09 00
B0_1aec:		.db $00				; 00
B0_1aed:	.db $80
B0_1aee:		.db $00				; 00
B0_1aef:		ora ($22, x)	; 01 22
B0_1af1:	.db $80
B0_1af2:		.db $00				; 00
B0_1af3:	.db $0f
B0_1af4:		inc $2e9a, x	; fe 9a 2e
B0_1af7:	.db $9c
B0_1af8:		adc $789d, y	; 79 9d 78
B0_1afb:	.db $9e
B0_1afc:	.db $22
B0_1afd:	.db $9f
B0_1afe:		.db $00				; 00
B0_1aff:	.db $07
B0_1b00:	.db $03
B0_1b01:	.db $34
B0_1b02:	.db $02
B0_1b03:		.db $00				; 00
B0_1b04:		php				; 08 
B0_1b05:	.db $02
B0_1b06:		ora $28			; 05 28
B0_1b08:	.db $07
B0_1b09:		txa				; 8a 
B0_1b0a:		bpl B0_1a9d ; 10 91

B0_1b0c:	.db $8f
B0_1b0d:		sta ($98), y	; 91 98
B0_1b0f:	.db $04
B0_1b10:		ora $9b0b, x	; 1d 0b 9b
B0_1b13:		sta ($8f), y	; 91 8f
B0_1b15:		sta ($98), y	; 91 98
B0_1b17:	.db $03
B0_1b18:		rol $30, x		; 36 30
B0_1b1a:	.db $63
B0_1b1b:		bmi B0_1b82 ; 30 65

B0_1b1d:		;removed
	.db $30 $6a

B0_1b1f:		bmi B0_1b8d ; 30 6c

B0_1b21:		bmi B0_1b92 ; 30 6f

B0_1b23:		bmi B0_1b96 ; 30 71

B0_1b25:		bmi B0_1b9d ; 30 76

B0_1b27:		;removed
	.db $30 $78

B0_1b29:	.db $03
B0_1b2a:		sec				; 38 
B0_1b2b:		;removed
	.db $30 $71

B0_1b2d:		bmi B0_1ba3 ; 30 74

B0_1b2f:		bmi B0_1ba7 ; 30 76

B0_1b31:		bmi B0_1bab ; 30 78

B0_1b33:		php				; 08 
B0_1b34:		.db $00				; 00
B0_1b35:		ora $10			; 05 10
B0_1b37:	.db $07
B0_1b38:	.db $80
B0_1b39:		.db $00				; 00
B0_1b3a:		stx $8a, y		; 96 8a
B0_1b3c:		sta $988d, y	; 99 8d 98
B0_1b3f:		sty $8894		; 8c 94 88
B0_1b42:	.db $92
B0_1b43:		stx $96			; 86 96
B0_1b45:		txa				; 8a 
B0_1b46:		sty $88, x		; 94 88
B0_1b48:	.db $9b
B0_1b49:	.db $8f
B0_1b4a:		stx $8a, y		; 96 8a
B0_1b4c:		sta $988d, y	; 99 8d 98
B0_1b4f:		sty $8894		; 8c 94 88
B0_1b52:		tya				; 98 
B0_1b53:		sty $8f9b		; 8c 9b 8f
B0_1b56:		sta $038d, y	; 99 8d 03
B0_1b59:	.db $3f
B0_1b5a:	.db $02
B0_1b5b:		cpy #$05		; c0 05
B0_1b5d:		plp				; 28 
B0_1b5e:	.db $74
B0_1b5f:	.db $74
B0_1b60:	.db $74
B0_1b61:	.db $74
B0_1b62:		and ($06, x)	; 21 06
B0_1b64:		dec $08, x		; d6 08
B0_1b66:		ora ($f6, x)	; 01 f6
B0_1b68:		ldy #$08		; a0 08
B0_1b6a:		.db $00				; 00
B0_1b6b:		iny				; c8 
B0_1b6c:		and ($ca, x)	; 21 ca
B0_1b6e:		php				; 08 
B0_1b6f:		ora ($aa, x)	; 01 aa
B0_1b71:		php				; 08 
B0_1b72:		.db $00				; 00
B0_1b73:		dey				; 88 
B0_1b74:		txa				; 8a 
B0_1b75:		ldy $888a		; ac 8a 88
B0_1b78:		asl $aa			; 06 aa
B0_1b7a:	.db $87
B0_1b7b:	.db $cf
B0_1b7c:		php				; 08 
B0_1b7d:		ora ($ef, x)	; 01 ef
B0_1b7f:		php				; 08 
B0_1b80:		.db $00				; 00
B0_1b81:	.db $04
B0_1b82:		ora ($6b, x)	; 01 6b
B0_1b84:	.db $9b
B0_1b85:	.db $03
B0_1b86:	.db $3c
B0_1b87:	.db $07
B0_1b88:		ora ($20, x)	; 01 20
B0_1b8a:		cmp $cf21		; cd 21 cf
B0_1b8d:		php				; 08 
B0_1b8e:		ora ($af, x)	; 01 af
B0_1b90:		php				; 08 
B0_1b91:		.db $00				; 00
B0_1b92:		sta $b18f		; 8d 8f b1
B0_1b95:	.db $b2
B0_1b96:		and ($b4, x)	; 21 b4
B0_1b98:		php				; 08 
B0_1b99:		ora ($b4, x)	; 01 b4
B0_1b9b:		php				; 08 
B0_1b9c:		.db $00				; 00
B0_1b9d:		and ($ac, x)	; 21 ac
B0_1b9f:		php				; 08 
B0_1ba0:		ora ($ac, x)	; 01 ac
B0_1ba2:		php				; 08 
B0_1ba3:		.db $00				; 00
B0_1ba4:		and ($cd, x)	; 21 cd
B0_1ba6:		php				; 08 
B0_1ba7:		ora ($cd, x)	; 01 cd
B0_1ba9:		php				; 08 
B0_1baa:		.db $00				; 00
B0_1bab:		and ($ca, x)	; 21 ca
B0_1bad:		php				; 08 
B0_1bae:		ora ($ca, x)	; 01 ca
B0_1bb0:		php				; 08 
B0_1bb1:		.db $00				; 00
B0_1bb2:		and ($06, x)	; 21 06
B0_1bb4:		lda #$08		; a9 08
B0_1bb6:		ora ($a9, x)	; 01 a9
B0_1bb8:		php				; 08 
B0_1bb9:		.db $00				; 00
B0_1bba:		pla				; 68 
B0_1bbb:		ror a			; 6a
B0_1bbc:		jmp ($6f6d)		; 6c 6d 6f


B0_1bbf:		bvs B0_1b52 ; 70 91

B0_1bc1:	.db $8f
B0_1bc2:		sta ($21), y	; 91 21
B0_1bc4:		ldx $08, y		; b6 08
B0_1bc6:		ora ($96, x)	; 01 96
B0_1bc8:		php				; 08 
B0_1bc9:		.db $00				; 00
B0_1bca:		sta ($8f), y	; 91 8f
B0_1bcc:		sta ($8f), y	; 91 8f
B0_1bce:		sta ($21), y	; 91 21
B0_1bd0:		lda $08, x		; b5 08
B0_1bd2:		ora ($06, x)	; 01 06
B0_1bd4:		lda $08, x		; b5 08
B0_1bd6:		.db $00				; 00
B0_1bd7:	.db $03
B0_1bd8:	.db $3f
B0_1bd9:	.db $07
B0_1bda:	.db $80
B0_1bdb:		.db $00				; 00
B0_1bdc:		txa				; 8a 
B0_1bdd:		txa				; 8a 
B0_1bde:	.db $80
B0_1bdf:		txa				; 8a 
B0_1be0:	.db $80
B0_1be1:		sty $8d80		; 8c 80 8d
B0_1be4:		asl $a0			; 06 a0
B0_1be6:		and ($a8, x)	; 21 a8
B0_1be8:		php				; 08 
B0_1be9:		ora ($88, x)	; 01 88
B0_1beb:		php				; 08 
B0_1bec:		.db $00				; 00
B0_1bed:		adc $66			; 65 66
B0_1bef:		pla				; 68 
B0_1bf0:		adc #$8a		; 69 8a
B0_1bf2:		txa				; 8a 
B0_1bf3:	.db $80
B0_1bf4:		txa				; 8a 
B0_1bf5:	.db $80
B0_1bf6:		sty $8d80		; 8c 80 8d
B0_1bf9:	.db $80
B0_1bfa:		sta ($8f), y	; 91 8f
B0_1bfc:		sta ($8f), y	; 91 8f
B0_1bfe:		sta $6a6c		; 8d 6c 6a
B0_1c01:		pla				; 68 
B0_1c02:		adc $8a			; 65 8a
B0_1c04:		txa				; 8a 
B0_1c05:	.db $80
B0_1c06:		txa				; 8a 
B0_1c07:	.db $80
B0_1c08:		sty $8d80		; 8c 80 8d
B0_1c0b:	.db $80
B0_1c0c:	.db $8f
B0_1c0d:	.db $80
B0_1c0e:		sta ($80), y	; 91 80
B0_1c10:	.db $8f
B0_1c11:	.db $80
B0_1c12:	.db $22
B0_1c13:		sty $f4, x		; 94 f4
B0_1c15:		php				; 08 
B0_1c16:		ora ($f4, x)	; 01 f4
B0_1c18:		php				; 08 
B0_1c19:		.db $00				; 00
B0_1c1a:		sei				; 78 
B0_1c1b:		sei				; 78 
B0_1c1c:		sei				; 78 
B0_1c1d:		sei				; 78 
B0_1c1e:		sei				; 78 
B0_1c1f:		rts				; 60 


B0_1c20:		tya				; 98 
B0_1c21:	.db $80
B0_1c22:	.db $04
B0_1c23:		ora $20			; 05 20
B0_1c25:	.db $9c
B0_1c26:	.db $23
B0_1c27:		sta $08f9, y	; 99 f9 08
B0_1c2a:		ora ($f9, x)	; 01 f9
B0_1c2c:	.db $d9 $09 $00
B0_1c2f:	.db $07
B0_1c30:	.db $03
B0_1c31:	.db $34
B0_1c32:	.db $02
B0_1c33:		cpy #$05		; c0 05
B0_1c35:	.db $1c
B0_1c36:	.db $07
B0_1c37:	.db $02
B0_1c38:		jsr $cdca		; 20 ca cd
B0_1c3b:		cpy $c6c8		; cc c8 c6
B0_1c3e:		dex				; ca 
B0_1c3f:		iny				; c8 
B0_1c40:	.db $cf
B0_1c41:	.db $04
B0_1c42:	.db $03
B0_1c43:		and $039c, y	; 39 9c 03
B0_1c46:		sec				; 38 
B0_1c47:		php				; 08 
B0_1c48:		.db $00				; 00
B0_1c49:		ora $10			; 05 10
B0_1c4b:	.db $02
B0_1c4c:		.db $00				; 00
B0_1c4d:	.db $07
B0_1c4e:	.db $80
B0_1c4f:		.db $00				; 00
B0_1c50:	.db $8f
B0_1c51:	.db $83
B0_1c52:	.db $92
B0_1c53:		stx $91			; 86 91
B0_1c55:		sta $8f			; 85 8f
B0_1c57:		sta ($05, x)	; 81 05
B0_1c59:	.db $04
B0_1c5a:		tya				; 98 
B0_1c5b:		sty $8f9b		; 8c 9b 8f
B0_1c5e:		sta $058d, y	; 99 8d 05
B0_1c61:		;removed
	.db $10 $94

B0_1c63:		dey				; 88 
B0_1c64:	.db $8f
B0_1c65:	.db $83
B0_1c66:	.db $92
B0_1c67:		stx $91			; 86 91
B0_1c69:		sta $8d			; 85 8d
B0_1c6b:		sta ($91, x)	; 81 91
B0_1c6d:		sta $94			; 85 94
B0_1c6f:		dey				; 88 
B0_1c70:	.db $92
B0_1c71:		stx $03			; 86 03
B0_1c73:	.db $3f
B0_1c74:	.db $02
B0_1c75:		cpy #$05		; c0 05
B0_1c77:		plp				; 28 
B0_1c78:	.db $6f
B0_1c79:	.db $6f
B0_1c7a:	.db $6f
B0_1c7b:	.db $6f
B0_1c7c:		and ($06, x)	; 21 06
B0_1c7e:		cmp ($08), y	; d1 08
B0_1c80:		ora ($f1, x)	; 01 f1
B0_1c82:		ldy #$08		; a0 08
B0_1c84:		.db $00				; 00
B0_1c85:		ora $1c			; 05 1c
B0_1c87:		cmp ($06), y	; d1 06
B0_1c89:	.db $b3
B0_1c8a:		ror a			; 6a
B0_1c8b:	.db $6f
B0_1c8c:	.db $b3
B0_1c8d:		sta ($93), y	; 91 93
B0_1c8f:		ldy $93, x		; b4 93
B0_1c91:		sta ($06), y	; 91 06
B0_1c93:	.db $b3
B0_1c94:	.db $8f
B0_1c95:		asl $b6			; 06 b6
B0_1c97:		ror $73, x		; 76 73
B0_1c99:		lda ($8f), y	; b1 8f
B0_1c9b:		and ($b3, x)	; 21 b3
B0_1c9d:		php				; 08 
B0_1c9e:		ora ($06, x)	; 01 06
B0_1ca0:	.db $b3
B0_1ca1:		php				; 08 
B0_1ca2:		.db $00				; 00
B0_1ca3:		cmp ($06), y	; d1 06
B0_1ca5:	.db $b3
B0_1ca6:		ror a			; 6a
B0_1ca7:	.db $6f
B0_1ca8:	.db $b3
B0_1ca9:		sta ($93), y	; 91 93
B0_1cab:		ldy $93, x		; b4 93
B0_1cad:		sta ($06), y	; 91 06
B0_1caf:	.db $b3
B0_1cb0:	.db $8f
B0_1cb1:		asl $b6			; 06 b6
B0_1cb3:		ror $73, x		; 76 73
B0_1cb5:		lda ($8f), y	; b1 8f
B0_1cb7:	.db $93
B0_1cb8:		adc ($72), y	; 71 72
B0_1cba:	.db $74
B0_1cbb:		ror $78, x		; 76 78
B0_1cbd:	.db $7a
B0_1cbe:	.db $7b
B0_1cbf:	.db $7d $08 $00
B0_1cc2:		ora $28			; 05 28
B0_1cc4:	.db $07
B0_1cc5:		ora ($40, x)	; 01 40
B0_1cc7:		dex				; ca 
B0_1cc8:		sty $1c05		; 8c 05 1c
B0_1ccb:	.db $02
B0_1ccc:	.db $80
B0_1ccd:	.db $83
B0_1cce:		sta $86			; 85 86
B0_1cd0:		dey				; 88 
B0_1cd1:		txa				; 8a 
B0_1cd2:		sty $218d		; 8c 8d 21
B0_1cd5:	.db $af
B0_1cd6:		php				; 08 
B0_1cd7:		ora ($af, x)	; 01 af
B0_1cd9:		php				; 08 
B0_1cda:		.db $00				; 00
B0_1cdb:		ldy #$94		; a0 94
B0_1cdd:		sta ($8f), y	; 91 8f
B0_1cdf:		sta $8d8c		; 8d 8c 8d
B0_1ce2:		ldy $218a		; ac 8a 21
B0_1ce5:		ldy $0108		; ac 08 01
B0_1ce8:	.db $ac $08 $00
B0_1ceb:		txa				; 8a 
B0_1cec:		dey				; 88 
B0_1ced:		stx $85			; 86 85
B0_1cef:		and ($a6, x)	; 21 a6
B0_1cf1:		php				; 08 
B0_1cf2:		ora ($06, x)	; 01 06
B0_1cf4:		ldx $08			; a6 08
B0_1cf6:		.db $00				; 00
B0_1cf7:		dey				; 88 
B0_1cf8:		stx $84			; 86 84
B0_1cfa:		and ($a6, x)	; 21 a6
B0_1cfc:		php				; 08 
B0_1cfd:		ora ($06, x)	; 01 06
B0_1cff:		ldx $08			; a6 08
B0_1d01:		.db $00				; 00
B0_1d02:		and ($a5, x)	; 21 a5
B0_1d04:		php				; 08 
B0_1d05:		ora ($a5, x)	; 01 a5
B0_1d07:		php				; 08 
B0_1d08:		.db $00				; 00
B0_1d09:		and ($a9, x)	; 21 a9
B0_1d0b:		php				; 08 
B0_1d0c:		ora ($a9, x)	; 01 a9
B0_1d0e:		php				; 08 
B0_1d0f:		.db $00				; 00
B0_1d10:		and ($cc, x)	; 21 cc
B0_1d12:		php				; 08 
B0_1d13:		ora ($cc, x)	; 01 cc
B0_1d15:		php				; 08 
B0_1d16:		.db $00				; 00
B0_1d17:	.db $07
B0_1d18:	.db $80
B0_1d19:		.db $00				; 00
B0_1d1a:	.db $02
B0_1d1b:		cpy #$8d		; c0 8d
B0_1d1d:		sta $8d80		; 8d 80 8d
B0_1d20:	.db $80
B0_1d21:	.db $8f
B0_1d22:	.db $80
B0_1d23:		sta ($06), y	; 91 06
B0_1d25:		ldy #$21		; a0 21
B0_1d27:		ldy $0108		; ac 08 01
B0_1d2a:		asl $ac			; 06 ac
B0_1d2c:		php				; 08 
B0_1d2d:		.db $00				; 00
B0_1d2e:		sta $808d		; 8d 8d 80
B0_1d31:		sta $8f80		; 8d 80 8f
B0_1d34:	.db $80
B0_1d35:		sta ($80), y	; 91 80
B0_1d37:		sty $92, x		; 94 92
B0_1d39:		sty $92, x		; 94 92
B0_1d3b:		sta ($6f), y	; 91 6f
B0_1d3d:		adc $686c		; 6d 6c 68
B0_1d40:		sta $808d		; 8d 8d 80
B0_1d43:		sta $8f80		; 8d 80 8f
B0_1d46:	.db $80
B0_1d47:		sta ($80), y	; 91 80
B0_1d49:	.db $92
B0_1d4a:	.db $80
B0_1d4b:		sty $80, x		; 94 80
B0_1d4d:	.db $92
B0_1d4e:	.db $80
B0_1d4f:		lda #$02		; a9 02
B0_1d51:		.db $00				; 00
B0_1d52:		stx $91, y		; 96 91
B0_1d54:	.db $92
B0_1d55:	.db $8f
B0_1d56:		sta ($8d), y	; 91 8d
B0_1d58:	.db $8f
B0_1d59:		sty $8a8d		; 8c 8d 8a
B0_1d5c:		sty $8a88		; 8c 88 8a
B0_1d5f:		jmp ($6f6d)		; 6c 6d 6f


B0_1d62:		bvs B0_1d66 ; 70 02

B0_1d64:		cpy #$71		; c0 71
B0_1d66:		adc ($71), y	; 71 71
B0_1d68:		adc ($71), y	; 71 71
B0_1d6a:		rts				; 60 


B0_1d6b:		sta ($80), y	; 91 80
B0_1d6d:	.db $04
B0_1d6e:		ora $6b			; 05 6b
B0_1d70:		sta $9223, x	; 9d 23 92
B0_1d73:	.db $f2
B0_1d74:		php				; 08 
B0_1d75:		ora ($f2, x)	; 01 f2
B0_1d77:	.db $d2
B0_1d78:		ora #$00		; 09 00
B0_1d7a:	.db $07
B0_1d7b:	.db $03
B0_1d7c:		sta ($05, x)	; 81 05
B0_1d7e:	.db $1c
B0_1d7f:		cpx #$04		; e0 04
B0_1d81:		asl $7f			; 06 7f
B0_1d83:		sta $80c0, x	; 9d c0 80
B0_1d86:		bmi B0_1de9 ; 30 61

B0_1d88:		bmi B0_1ded ; 30 63

B0_1d8a:		bmi B0_1df1 ; 30 65

B0_1d8c:		;removed
	.db $30 $66

B0_1d8e:		;removed
	.db $30 $68

B0_1d90:		;removed
	.db $30 $6a

B0_1d92:		bmi B0_1e00 ; 30 6c

B0_1d94:		bmi B0_1e03 ; 30 6d

B0_1d96:		bmi B0_1e07 ; 30 6f

B0_1d98:		sta ($8f), y	; 91 8f
B0_1d9a:		sta ($21), y	; 91 21
B0_1d9c:		asl $b8			; 06 b8
B0_1d9e:		php				; 08 
B0_1d9f:		ora ($d8, x)	; 01 d8
B0_1da1:		php				; 08 
B0_1da2:		.db $00				; 00
B0_1da3:		sta ($8f), y	; 91 8f
B0_1da5:		lda ($8f), y	; b1 8f
B0_1da7:		txa				; 8a 
B0_1da8:		sty $918a		; 8c 8a 91
B0_1dab:	.db $22
B0_1dac:		sty $08cc		; 8c cc 08
B0_1daf:		ora ($06, x)	; 01 06
B0_1db1:	.db $cc $08 $00
B0_1db4:		ror a			; 6a
B0_1db5:		jmp ($716f)		; 6c 6f 71


B0_1db8:		ldx $91, y		; b6 91
B0_1dba:	.db $8f
B0_1dbb:		sta ($21), y	; 91 21
B0_1dbd:		asl $b6			; 06 b6
B0_1dbf:		php				; 08 
B0_1dc0:		ora ($b6, x)	; 01 b6
B0_1dc2:		php				; 08 
B0_1dc3:		.db $00				; 00
B0_1dc4:		tya				; 98 
B0_1dc5:		sta $9698, y	; 99 98 96
B0_1dc8:		sty $22, x		; 94 22
B0_1dca:		stx $f6, y		; 96 f6
B0_1dcc:		bmi B0_1e44 ; 30 76

B0_1dce:		bmi B0_1e48 ; 30 78

B0_1dd0:	.db $04
B0_1dd1:	.db $0b
B0_1dd2:		cpy $039d		; cc 9d 03
B0_1dd5:	.db $32
B0_1dd6:		tax				; aa 
B0_1dd7:	.db $04
B0_1dd8:		asl $9dd6		; 0e d6 9d
B0_1ddb:		adc #$69		; 69 69
B0_1ddd:		adc #$69		; 69 69
B0_1ddf:		txa				; 8a 
B0_1de0:		sta $04			; 85 04
B0_1de2:		ora $df			; 05 df
B0_1de4:		sta $068a, x	; 9d 8a 06
B0_1de7:		ldy #$03		; a0 03
B0_1de9:		eor ($21), y	; 51 21
B0_1deb:	.db $cf
B0_1dec:		php				; 08 
B0_1ded:		ora ($06, x)	; 01 06
B0_1def:	.db $af
B0_1df0:		php				; 08 
B0_1df1:		.db $00				; 00
B0_1df2:	.db $03
B0_1df3:		asl $6f6f, x	; 1e 6f 6f
B0_1df6:	.db $03
B0_1df7:		sta ($21, x)	; 81 21
B0_1df9:	.db $ef
B0_1dfa:		php				; 08 
B0_1dfb:		ora ($ef, x)	; 01 ef
B0_1dfd:		php				; 08 
B0_1dfe:		.db $00				; 00
B0_1dff:	.db $03
B0_1e00:	.db $44
B0_1e01:	.db $8f
B0_1e02:		txa				; 8a 
B0_1e03:	.db $04
B0_1e04:	.db $03
B0_1e05:		ora ($9e, x)	; 01 9e
B0_1e07:	.db $af
B0_1e08:	.db $af
B0_1e09:	.db $af
B0_1e0a:	.db $6f
B0_1e0b:	.db $6f
B0_1e0c:	.db $6f
B0_1e0d:	.db $6f
B0_1e0e:	.db $af
B0_1e0f:	.db $04
B0_1e10:	.db $07
B0_1e11:		asl $8f9e		; 0e 9e 8f
B0_1e14:		txa				; 8a 
B0_1e15:	.db $04
B0_1e16:	.db $03
B0_1e17:	.db $13
B0_1e18:	.db $9e
B0_1e19:	.db $03
B0_1e1a:		sta ($21, x)	; 81 21
B0_1e1c:		dec $08			; c6 08
B0_1e1e:		ora ($c6, x)	; 01 c6
B0_1e20:		php				; 08 
B0_1e21:		.db $00				; 00
B0_1e22:		and ($c8, x)	; 21 c8
B0_1e24:		php				; 08 
B0_1e25:		ora ($c8, x)	; 01 c8
B0_1e27:		php				; 08 
B0_1e28:		.db $00				; 00
B0_1e29:		and ($c5, x)	; 21 c5
B0_1e2b:		php				; 08 
B0_1e2c:		ora ($c5, x)	; 01 c5
B0_1e2e:		php				; 08 
B0_1e2f:		.db $00				; 00
B0_1e30:		and ($ca, x)	; 21 ca
B0_1e32:		php				; 08 
B0_1e33:		ora ($ca, x)	; 01 ca
B0_1e35:		php				; 08 
B0_1e36:		.db $00				; 00
B0_1e37:		and ($cf, x)	; 21 cf
B0_1e39:		php				; 08 
B0_1e3a:		ora ($cf, x)	; 01 cf
B0_1e3c:		php				; 08 
B0_1e3d:		.db $00				; 00
B0_1e3e:		and ($cb, x)	; 21 cb
B0_1e40:		php				; 08 
B0_1e41:		ora ($cb, x)	; 01 cb
B0_1e43:		php				; 08 
B0_1e44:		.db $00				; 00
B0_1e45:		and ($cc, x)	; 21 cc
B0_1e47:		php				; 08 
B0_1e48:		ora ($cc, x)	; 01 cc
B0_1e4a:		php				; 08 
B0_1e4b:		.db $00				; 00
B0_1e4c:		and ($c5, x)	; 21 c5
B0_1e4e:		php				; 08 
B0_1e4f:		ora ($c5, x)	; 01 c5
B0_1e51:		php				; 08 
B0_1e52:		.db $00				; 00
B0_1e53:	.db $03
B0_1e54:	.db $3c
B0_1e55:		txa				; 8a 
B0_1e56:	.db $04
B0_1e57:		rol $9e55		; 2e 55 9e
B0_1e5a:		lda #$84		; a9 84
B0_1e5c:	.db $89
B0_1e5d:		sty $04			; 84 04
B0_1e5f:		asl $5c			; 06 5c
B0_1e61:	.db $9e
B0_1e62:		ror a			; 6a
B0_1e63:		ror a			; 6a
B0_1e64:		ror a			; 6a
B0_1e65:		ror a			; 6a
B0_1e66:		ror a			; 6a
B0_1e67:		rts				; 60 


B0_1e68:		txa				; 8a 
B0_1e69:	.db $80
B0_1e6a:	.db $04
B0_1e6b:		ora $68			; 05 68
B0_1e6d:	.db $9e
B0_1e6e:	.db $03
B0_1e6f:		sta ($23, x)	; 81 23
B0_1e71:	.db $8b
B0_1e72:	.db $eb
B0_1e73:		php				; 08 
B0_1e74:		ora ($eb, x)	; 01 eb
B0_1e76:	.db $cb
B0_1e77:		ora #$00		; 09 00
B0_1e79:	.db $07
B0_1e7a:	.db $07
B0_1e7b:	.db $82
B0_1e7c:		rti				; 40 


B0_1e7d:	.db $02
B0_1e7e:	.db $80
B0_1e7f:	.db $03
B0_1e80:	.db $3a
B0_1e81:		sty $06			; 84 06
B0_1e83:		ldy #$03		; a0 03
B0_1e85:		rol $84, x		; 36 84
B0_1e87:		asl $a0			; 06 a0
B0_1e89:	.db $04
B0_1e8a:	.db $07
B0_1e8b:	.db $7f
B0_1e8c:	.db $9e
B0_1e8d:	.db $03
B0_1e8e:	.db $3a
B0_1e8f:		sty $80			; 84 80
B0_1e91:	.db $03
B0_1e92:		rol $84, x		; 36 84
B0_1e94:	.db $80
B0_1e95:	.db $04
B0_1e96:		asl $9e8d		; 0e 8d 9e
B0_1e99:	.db $03
B0_1e9a:	.db $3a
B0_1e9b:		sty $80			; 84 80
B0_1e9d:	.db $02
B0_1e9e:		.db $00				; 00
B0_1e9f:	.db $07
B0_1ea0:		sta ($20, x)	; 81 20
B0_1ea2:		jmp ($6c6c)		; 6c 6c 6c


B0_1ea5:		jmp ($8c8a)		; 6c 8a 8c


B0_1ea8:	.db $04
B0_1ea9:		asl $9ea6		; 0e a6 9e
B0_1eac:	.db $03
B0_1ead:	.db $3f
B0_1eae:		jmp ($6c6c)		; 6c 6c 6c


B0_1eb1:		jmp ($8307)		; 6c 07 83


B0_1eb4:		bpl B0_1e3d ; 10 87

B0_1eb6:	.db $07
B0_1eb7:		sta ($20, x)	; 81 20
B0_1eb9:		sty $8c8a		; 8c 8a 8c
B0_1ebc:	.db $04
B0_1ebd:	.db $04
B0_1ebe:		tsx				; ba 
B0_1ebf:	.db $9e
B0_1ec0:		sty $a006		; 8c 06 a0
B0_1ec3:	.db $07
B0_1ec4:		sta $10			; 85 10
B0_1ec6:	.db $22
B0_1ec7:		sbc $eded		; eded ed
B0_1eca:	.db $07
B0_1ecb:		sta ($20, x)	; 81 20
B0_1ecd:		txa				; 8a 
B0_1ece:		sty $0304		; 8c 04 03
B0_1ed1:		cmp $079e		; cd 9e 07
B0_1ed4:		sta $10			; 85 10
B0_1ed6:	.db $22
B0_1ed7:		sbc $eded		; eded ed
B0_1eda:	.db $07
B0_1edb:		sta ($20, x)	; 81 20
B0_1edd:		txa				; 8a 
B0_1ede:		sty $0304		; 8c 04 03
B0_1ee1:		cmp $e09e, x	; dd 9e e0
B0_1ee4:	.db $04
B0_1ee5:		asl $e3			; 06 e3
B0_1ee7:	.db $9e
B0_1ee8:		asl $c0			; 06 c0
B0_1eea:		ror a			; 6a
B0_1eeb:		ror a			; 6a
B0_1eec:		ror a			; 6a
B0_1eed:		ror a			; 6a
B0_1eee:		asl $aa			; 06 aa
B0_1ef0:		asl $aa			; 06 aa
B0_1ef2:		tax				; aa 
B0_1ef3:		asl $aa			; 06 aa
B0_1ef5:		asl $aa			; 06 aa
B0_1ef7:		ror a			; 6a
B0_1ef8:		ror a			; 6a
B0_1ef9:		ror a			; 6a
B0_1efa:		ror a			; 6a
B0_1efb:	.db $04
B0_1efc:	.db $02
B0_1efd:		inc $8a9e		; ee 9e 8a
B0_1f00:		sty $0704		; 8c 04 07
B0_1f03:	.db $ff
B0_1f04:	.db $9e
B0_1f05:		jmp ($6c6c)		; 6c 6c 6c


B0_1f08:		jmp ($606c)		; 6c 6c 60


B0_1f0b:		sty wEntitiesY.w		; 8c 80 04
B0_1f0e:	.db $04
B0_1f0f:	.db $0b
B0_1f10:	.db $9f
B0_1f11:		sty $308c		; 8c 8c 30
B0_1f14:		adc #$04		; 69 04
B0_1f16:	.db $1a
B0_1f17:	.db $13
B0_1f18:	.db $9f
B0_1f19:	.db $02
B0_1f1a:	.db $80
B0_1f1b:	.db $07
B0_1f1c:		dey				; 88 
B0_1f1d:		bpl B0_1f40 ; 10 21

B0_1f1f:	.db $cb
B0_1f20:	.db $fb
B0_1f21:		ora #$00		; 09 00
B0_1f23:		.db $00				; 00
B0_1f24:	.db $80
B0_1f25:		.db $00				; 00
B0_1f26:		ora ($42, x)	; 01 42
B0_1f28:	.db $80
B0_1f29:		.db $00				; 00
B0_1f2a:		.db $00				; 00
B0_1f2b:		.db $00				; 00
B0_1f2c:	.db $82
B0_1f2d:		php				; 08 
B0_1f2e:	.db $0f
B0_1f2f:		and $939f, y	; 39 9f 93
B0_1f32:		lda ($76, x)	; a1 76
B0_1f34:		ldy $00			; a4 00
B0_1f36:		.db $00				; 00
B0_1f37:		sta ($a5), y	; 91 a5
B0_1f39:		.db $00				; 00
B0_1f3a:	.db $07
B0_1f3b:		ora $16			; 05 16
B0_1f3d:	.db $07
B0_1f3e:		ora ($60, x)	; 01 60
B0_1f40:	.db $02
B0_1f41:		cpy #$03		; c0 03
B0_1f43:	.db $3b
B0_1f44:		ror $7071		; 6e 71 70
B0_1f47:		adc ($04), y	; 71 04
B0_1f49:	.db $03
B0_1f4a:	.db $44
B0_1f4b:	.db $9f
B0_1f4c:		adc $7071		; 6d 71 70
B0_1f4f:		adc ($04), y	; 71 04
B0_1f51:	.db $03
B0_1f52:		jmp $6c9f		; 4c 9f 6c


B0_1f55:		adc ($70), y	; 71 70
B0_1f57:		adc ($04), y	; 71 04
B0_1f59:	.db $03
B0_1f5a:	.db $54
B0_1f5b:	.db $9f
B0_1f5c:		ror a			; 6a
B0_1f5d:		adc ($70), y	; 71 70
B0_1f5f:		adc ($04), y	; 71 04
B0_1f61:	.db $03
B0_1f62:	.db $5c
B0_1f63:	.db $9f
B0_1f64:	.db $67
B0_1f65:		adc ($70), y	; 71 70
B0_1f67:		adc ($04), y	; 71 04
B0_1f69:	.db $03
B0_1f6a:	.db $64
B0_1f6b:	.db $9f
B0_1f6c:		adc #$71		; 69 71
B0_1f6e:		;removed
	.db $70 $71

B0_1f70:	.db $04
B0_1f71:	.db $03
B0_1f72:		jmp ($6a9f)		; 6c 9f 6a


B0_1f75:		adc ($70), y	; 71 70
B0_1f77:		adc ($04), y	; 71 04
B0_1f79:	.db $03
B0_1f7a:	.db $74
B0_1f7b:	.db $9f
B0_1f7c:		;removed
	.db $70 $71

B0_1f7e:	.db $73
B0_1f7f:		adc ($75), y	; 71 75
B0_1f81:	.db $73
B0_1f82:		adc ($73), y	; 71 73
B0_1f84:		adc ($70), y	; 71 70
B0_1f86:		ror $6e70		; 6e 70 6e
B0_1f89:		adc $6d6b		; 6d 6b 6d
B0_1f8c:		ora $22			; 05 22
B0_1f8e:	.db $03
B0_1f8f:		rol $ce21, x	; 3e 21 ce
B0_1f92:		php				; 08 
B0_1f93:		ora ($ce, x)	; 01 ce
B0_1f95:		php				; 08 
B0_1f96:		.db $00				; 00
B0_1f97:		and ($b1, x)	; 21 b1
B0_1f99:		php				; 08 
B0_1f9a:		ora ($d1, x)	; 01 d1
B0_1f9c:		php				; 08 
B0_1f9d:		.db $00				; 00
B0_1f9e:	.db $8f
B0_1f9f:		sta ($06), y	; 91 06
B0_1fa1:	.db $af
B0_1fa2:		stx $ce21		; 8e 21 ce
B0_1fa5:		php				; 08 
B0_1fa6:		ora ($06, x)	; 01 06
B0_1fa8:	.db $ce $08 $00
B0_1fab:		ldy $3d03		; ac 03 3d
B0_1fae:		and ($ca, x)	; 21 ca
B0_1fb0:		php				; 08 
B0_1fb1:		ora ($ca, x)	; 01 ca
B0_1fb3:		php				; 08 
B0_1fb4:		.db $00				; 00
B0_1fb5:		and ($af, x)	; 21 af
B0_1fb7:		php				; 08 
B0_1fb8:		ora ($cf, x)	; 01 cf
B0_1fba:		php				; 08 
B0_1fbb:		.db $00				; 00
B0_1fbc:		stx $038f		; 8e 8f 03
B0_1fbf:	.db $3f
B0_1fc0:		and ($f1, x)	; 21 f1
B0_1fc2:		php				; 08 
B0_1fc3:		ora ($f1, x)	; 01 f1
B0_1fc5:	.db $03
B0_1fc6:		rol $ce21, x	; 3e 21 ce
B0_1fc9:		php				; 08 
B0_1fca:		ora ($ce, x)	; 01 ce
B0_1fcc:		php				; 08 
B0_1fcd:		.db $00				; 00
B0_1fce:		and ($b1, x)	; 21 b1
B0_1fd0:		php				; 08 
B0_1fd1:		ora ($d1, x)	; 01 d1
B0_1fd3:		php				; 08 
B0_1fd4:		.db $00				; 00
B0_1fd5:	.db $8f
B0_1fd6:		sta ($06), y	; 91 06
B0_1fd8:	.db $af
B0_1fd9:		stx $ce21		; 8e 21 ce
B0_1fdc:		php				; 08 
B0_1fdd:		ora ($06, x)	; 01 06
B0_1fdf:	.db $ce $08 $00
B0_1fe2:		ldy $3f03		; ac 03 3f
B0_1fe5:		dex				; ca 
B0_1fe6:	.db $af
B0_1fe7:	.db $b3
B0_1fe8:		dex				; ca 
B0_1fe9:	.db $af
B0_1fea:		ldx $21, y		; b6 21
B0_1fec:		dec $08, x		; d6 08
B0_1fee:		ora ($d6, x)	; 01 d6
B0_1ff0:		php				; 08 
B0_1ff1:		.db $00				; 00
B0_1ff2:		adc $75, x		; 75 75
B0_1ff4:		adc $60, x		; 75 60
B0_1ff6:		adc $60, x		; 75 60
B0_1ff8:		adc $75, x		; 75 75
B0_1ffa:		cpy #$03		; c0 03
B0_1ffc:		sec				; 38 
B0_1ffd:		txa				; 8a 
B0_1ffe:	.db $04
B0_1fff:	.db $0f
B0_2000:		sbc $889f, x	; fd 9f 88
B0_2003:	.db $04
B0_2004:	.db $07
B0_2005:	.db $02
B0_2006:		ldy #$85		; a0 85
B0_2008:	.db $04
B0_2009:	.db $07
B0_200a:	.db $07
B0_200b:		ldy #$88		; a0 88
B0_200d:	.db $04
B0_200e:	.db $07
B0_200f:	.db $0c
B0_2010:		ldy #$8a		; a0 8a
B0_2012:	.db $04
B0_2013:	.db $07
B0_2014:		ora ($a0), y	; 11 a0
B0_2016:		clv				; b8 
B0_2017:		ldx $b5, y		; b6 b5
B0_2019:	.db $b3
B0_201a:		lda ($af), y	; b1 af
B0_201c:	.db $03
B0_201d:		rol $6c6a, x	; 3e 6a 6c
B0_2020:		adc $716f		; 6d 6f 71
B0_2023:	.db $72
B0_2024:	.db $74
B0_2025:		ror $03, x		; 76 03
B0_2027:		and $0107, y	; 39 07 01
B0_202a:		jsr $cf21		; 20 21 cf
B0_202d:		php				; 08 
B0_202e:		ora ($cf, x)	; 01 cf
B0_2030:		php				; 08 
B0_2031:		.db $00				; 00
B0_2032:		and ($cd, x)	; 21 cd
B0_2034:		php				; 08 
B0_2035:		ora ($cd, x)	; 01 cd
B0_2037:		php				; 08 
B0_2038:		.db $00				; 00
B0_2039:		and ($cc, x)	; 21 cc
B0_203b:		php				; 08 
B0_203c:		ora ($cc, x)	; 01 cc
B0_203e:		php				; 08 
B0_203f:		.db $00				; 00
B0_2040:		and ($c5, x)	; 21 c5
B0_2042:		php				; 08 
B0_2043:		ora ($c5, x)	; 01 c5
B0_2045:		php				; 08 
B0_2046:		.db $00				; 00
B0_2047:		and ($cd, x)	; 21 cd
B0_2049:		php				; 08 
B0_204a:		ora ($cd, x)	; 01 cd
B0_204c:		php				; 08 
B0_204d:		.db $00				; 00
B0_204e:		and ($cd, x)	; 21 cd
B0_2050:		php				; 08 
B0_2051:		ora ($cd, x)	; 01 cd
B0_2053:		php				; 08 
B0_2054:		.db $00				; 00
B0_2055:	.db $cf
B0_2056:	.db $cf
B0_2057:		and ($d1, x)	; 21 d1
B0_2059:		php				; 08 
B0_205a:		ora ($d1, x)	; 01 d1
B0_205c:	.db $03
B0_205d:	.db $3c
B0_205e:		php				; 08 
B0_205f:		.db $00				; 00
B0_2060:		and ($d1, x)	; 21 d1
B0_2062:		php				; 08 
B0_2063:		ora ($d1, x)	; 01 d1
B0_2065:		php				; 08 
B0_2066:		.db $00				; 00
B0_2067:		and ($d1, x)	; 21 d1
B0_2069:		php				; 08 
B0_206a:		ora ($d1, x)	; 01 d1
B0_206c:		php				; 08 
B0_206d:		.db $00				; 00
B0_206e:		and ($cf, x)	; 21 cf
B0_2070:		php				; 08 
B0_2071:		ora ($cf, x)	; 01 cf
B0_2073:		php				; 08 
B0_2074:		.db $00				; 00
B0_2075:	.db $07
B0_2076:		ora ($80, x)	; 01 80
B0_2078:	.db $67
B0_2079:		adc #$6a		; 69 6a
B0_207b:		jmp ($6a69)		; 6c 69 6a


B0_207e:		jmp ($6a6e)		; 6c 6e 6a


B0_2081:		jmp ($6f6e)		; 6c 6e 6f


B0_2084:		adc ($73), y	; 71 73
B0_2086:		adc $76, x		; 75 76
B0_2088:		and ($b6, x)	; 21 b6
B0_208a:		php				; 08 
B0_208b:		ora ($b6, x)	; 01 b6
B0_208d:		php				; 08 
B0_208e:		.db $00				; 00
B0_208f:		lda ($b0), y	; b1 b0
B0_2091:		and ($b0, x)	; 21 b0
B0_2093:		php				; 08 
B0_2094:		ora ($b0, x)	; 01 b0
B0_2096:		php				; 08 
B0_2097:		.db $00				; 00
B0_2098:		bcs B0_2049 ; b0 af

B0_209a:	.db $d3
B0_209b:		cmp $d8, x		; d5 d8
B0_209d:	.db $db
B0_209e:		ora $16			; 05 16
B0_20a0:	.db $03
B0_20a1:	.db $3f
B0_20a2:		asl $d6			; 06 d6
B0_20a4:		txs				; 9a 
B0_20a5:		sta $da06, x	; 9d 06 da
B0_20a8:		ldx $21, y		; b6 21
B0_20aa:		ldx $08, y		; b6 08
B0_20ac:		ora ($06, x)	; 01 06
B0_20ae:		ldx $08, y		; b6 08
B0_20b0:		.db $00				; 00
B0_20b1:		ldx $96, y		; b6 96
B0_20b3:	.db $d3
B0_20b4:	.db $b3
B0_20b5:	.db $b3
B0_20b6:		ora $0a			; 05 0a
B0_20b8:		txs				; 9a 
B0_20b9:		sta $9d9c, x	; 9d 9c 9d
B0_20bc:		txs				; 9a 
B0_20bd:		sta $9d9c, x	; 9d 9c 9d
B0_20c0:		tya				; 98 
B0_20c1:		sta $9d9b, x	; 9d 9b 9d
B0_20c4:		tya				; 98 
B0_20c5:		sta $9d9b, x	; 9d 9b 9d
B0_20c8:		asl $b6			; 06 b6
B0_20ca:		stx $9b, y		; 96 9b
B0_20cc:		txs				; 9a 
B0_20cd:		tya				; 98 
B0_20ce:		stx $06, y		; 96 06
B0_20d0:		lda $93, x		; b5 93
B0_20d2:		cmp ($03), y	; d1 03
B0_20d4:		and $0107, y	; 39 07 01
B0_20d7:		rts				; 60 


B0_20d8:	.db $02
B0_20d9:	.db $80
B0_20da:		ora $2e			; 05 2e
B0_20dc:		bmi B0_207e ; 30 a0

B0_20de:		rts				; 60 


B0_20df:		and ($b6, x)	; 21 b6
B0_20e1:		php				; 08 
B0_20e2:	.db $02
B0_20e3:		dec $08, x		; d6 08
B0_20e5:		.db $00				; 00
B0_20e6:		sta $96, x		; 95 96
B0_20e8:		and ($b8, x)	; 21 b8
B0_20ea:		php				; 08 
B0_20eb:	.db $02
B0_20ec:		cld				; d8 
B0_20ed:		php				; 08 
B0_20ee:		.db $00				; 00
B0_20ef:		stx $95, y		; 96 95
B0_20f1:		stx $95, y		; 96 95
B0_20f3:		and ($d3, x)	; 21 d3
B0_20f5:		php				; 08 
B0_20f6:	.db $02
B0_20f7:		asl $d3			; 06 d3
B0_20f9:		php				; 08 
B0_20fa:		.db $00				; 00
B0_20fb:		and ($06, x)	; 21 06
B0_20fd:		sta $30, x		; 95 30
B0_20ff:		sta $03			; 85 03
B0_2101:		and $c002, x	; 3d 02 c0
B0_2104:	.db $07
B0_2105:		ora ($40, x)	; 01 40
B0_2107:		ora $22			; 05 22
B0_2109:		and ($ca, x)	; 21 ca
B0_210b:		php				; 08 
B0_210c:		ora ($ca, x)	; 01 ca
B0_210e:		php				; 08 
B0_210f:		.db $00				; 00
B0_2110:		and ($af, x)	; 21 af
B0_2112:		php				; 08 
B0_2113:		ora ($cf, x)	; 01 cf
B0_2115:		php				; 08 
B0_2116:		.db $00				; 00
B0_2117:		stx $038f		; 8e 8f 03
B0_211a:	.db $3f
B0_211b:		and ($d1, x)	; 21 d1
B0_211d:		php				; 08 
B0_211e:		ora ($d1, x)	; 01 d1
B0_2120:		php				; 08 
B0_2121:		.db $00				; 00
B0_2122:		and ($d5, x)	; 21 d5
B0_2124:		php				; 08 
B0_2125:		ora ($d5, x)	; 01 d5
B0_2127:		ora $22			; 05 22
B0_2129:	.db $02
B0_212a:		cpy #$03		; c0 03
B0_212c:		and $d121, x	; 3d 21 d1
B0_212f:		php				; 08 
B0_2130:		ora ($d1, x)	; 01 d1
B0_2132:		php				; 08 
B0_2133:		.db $00				; 00
B0_2134:		and ($b6, x)	; 21 b6
B0_2136:		php				; 08 
B0_2137:		ora ($d6, x)	; 01 d6
B0_2139:		php				; 08 
B0_213a:		.db $00				; 00
B0_213b:		sta $96, x		; 95 96
B0_213d:		asl $b8			; 06 b8
B0_213f:		stx $21, y		; 96 21
B0_2141:	.db $da
B0_2142:		php				; 08 
B0_2143:		ora ($06, x)	; 01 06
B0_2145:		tsx				; ba 
B0_2146:		php				; 08 
B0_2147:		.db $00				; 00
B0_2148:		tya				; 98 
B0_2149:		stx $94, y		; 96 94
B0_214b:	.db $93
B0_214c:		sta ($07), y	; 91 07
B0_214e:	.db $80
B0_214f:		.db $00				; 00
B0_2150:	.db $cf
B0_2151:	.db $d3
B0_2152:		and ($b6, x)	; 21 b6
B0_2154:		php				; 08 
B0_2155:		ora ($06, x)	; 01 06
B0_2157:		ldx $08, y		; b6 08
B0_2159:		.db $00				; 00
B0_215a:	.db $9b
B0_215b:	.db $9b
B0_215c:	.db $9b
B0_215d:		cmp ($d5), y	; d1 d5
B0_215f:		and ($b8, x)	; 21 b8
B0_2161:		php				; 08 
B0_2162:		ora ($06, x)	; 01 06
B0_2164:		clv				; b8 
B0_2165:		ora $2e			; 05 2e
B0_2167:		php				; 08 
B0_2168:		.db $00				; 00
B0_2169:	.db $93
B0_216a:	.db $93
B0_216b:	.db $93
B0_216c:		and ($f6, x)	; 21 f6
B0_216e:		php				; 08 
B0_216f:		ora ($f6, x)	; 01 f6
B0_2171:		php				; 08 
B0_2172:		.db $00				; 00
B0_2173:	.db $03
B0_2174:	.db $3f
B0_2175:		.db $00				; 00
B0_2176:		php				; 08 
B0_2177:		stx $06, y		; 96 06
B0_2179:		ldy #$00		; a0 00
B0_217b:		asl a			; 0a
B0_217c:	.db $03
B0_217d:		sec				; 38 
B0_217e:	.db $07
B0_217f:		ora ($60, x)	; 01 60
B0_2181:		bmi B0_2132 ; 30 af

B0_2183:		bmi B0_2133 ; 30 ae

B0_2185:		bmi B0_2133 ; 30 ac

B0_2187:		.db $00				; 00
B0_2188:		asl $4c4e		; 0e 4e 4c
B0_218b:		and ($06, x)	; 21 06
B0_218d:		stx $0108		; 8e 08 01
B0_2190:		asl $ce			; 06 ce
B0_2192:		ora #$00		; 09 00
B0_2194:	.db $07
B0_2195:		ora $16			; 05 16
B0_2197:	.db $07
B0_2198:		ora ($60, x)	; 01 60
B0_219a:	.db $02
B0_219b:		cpy #$03		; c0 03
B0_219d:		and $30, x		; 35 30
B0_219f:	.db $80
B0_21a0:		ror $7071		; 6e 71 70
B0_21a3:		adc ($04), y	; 71 04
B0_21a5:	.db $03
B0_21a6:		ldy #$a1		; a0 a1
B0_21a8:		adc $7071		; 6d 71 70
B0_21ab:		adc ($04), y	; 71 04
B0_21ad:	.db $03
B0_21ae:		tay				; a8 
B0_21af:		lda ($6c, x)	; a1 6c
B0_21b1:		adc ($70), y	; 71 70
B0_21b3:		adc ($04), y	; 71 04
B0_21b5:	.db $03
B0_21b6:		bcs B0_2159 ; b0 a1

B0_21b8:		ror a			; 6a
B0_21b9:		adc ($70), y	; 71 70
B0_21bb:		adc ($04), y	; 71 04
B0_21bd:	.db $03
B0_21be:		clv				; b8 
B0_21bf:		lda ($67, x)	; a1 67
B0_21c1:		adc ($70), y	; 71 70
B0_21c3:		adc ($04), y	; 71 04
B0_21c5:	.db $03
B0_21c6:		cpy #$a1		; c0 a1
B0_21c8:		adc #$71		; 69 71
B0_21ca:		bvs B0_223d ; 70 71

B0_21cc:	.db $04
B0_21cd:	.db $03
B0_21ce:		iny				; c8 
B0_21cf:		lda ($6a, x)	; a1 6a
B0_21d1:		adc ($70), y	; 71 70
B0_21d3:		adc ($04), y	; 71 04
B0_21d5:	.db $03
B0_21d6:		bne B0_2179 ; d0 a1

B0_21d8:		bvs B0_224b ; 70 71

B0_21da:	.db $73
B0_21db:		adc ($75), y	; 71 75
B0_21dd:	.db $73
B0_21de:		adc ($73), y	; 71 73
B0_21e0:		adc ($70), y	; 71 70
B0_21e2:		ror $6e70		; 6e 70 6e
B0_21e5:		adc $6b30		; 6d 30 6b
B0_21e8:	.db $03
B0_21e9:	.db $3c
B0_21ea:		ora $22			; 05 22
B0_21ec:		and ($ca, x)	; 21 ca
B0_21ee:		php				; 08 
B0_21ef:		ora ($ca, x)	; 01 ca
B0_21f1:		php				; 08 
B0_21f2:		.db $00				; 00
B0_21f3:		asl $cc			; 06 cc
B0_21f5:		sty $068c		; 8c 8c 06
B0_21f8:		tax				; aa 
B0_21f9:		txa				; 8a 
B0_21fa:		and ($ca, x)	; 21 ca
B0_21fc:		php				; 08 
B0_21fd:		ora ($06, x)	; 01 06
B0_21ff:		dex				; ca 
B0_2200:		php				; 08 
B0_2201:		.db $00				; 00
B0_2202:		lda $21			; a5 21
B0_2204:	.db $c7
B0_2205:		php				; 08 
B0_2206:		ora ($c7, x)	; 01 c7
B0_2208:		php				; 08 
B0_2209:		.db $00				; 00
B0_220a:		and ($c9, x)	; 21 c9
B0_220c:		php				; 08 
B0_220d:		ora ($c9, x)	; 01 c9
B0_220f:		php				; 08 
B0_2210:		.db $00				; 00
B0_2211:		and ($cc, x)	; 21 cc
B0_2213:		php				; 08 
B0_2214:		ora ($cc, x)	; 01 cc
B0_2216:		php				; 08 
B0_2217:		.db $00				; 00
B0_2218:	.db $02
B0_2219:		.db $00				; 00
B0_221a:	.db $03
B0_221b:	.db $3f
B0_221c:	.db $07
B0_221d:	.db $80
B0_221e:		.db $00				; 00
B0_221f:		adc $64			; 65 64
B0_2221:		adc $67			; 65 67
B0_2223:		adc #$67		; 69 67
B0_2225:		adc #$6a		; 69 6a
B0_2227:		jmp ($6c6a)		; 6c 6a 6c


B0_222a:		ror $716f		; 6e 6f 71
B0_222d:	.db $73
B0_222e:		adc $6a, x		; 75 6a
B0_2230:		rts				; 60 


B0_2231:		ror a			; 6a
B0_2232:		ror a			; 6a
B0_2233:		ror a			; 6a
B0_2234:		rts				; 60 


B0_2235:		ror $6e6e		; 6e 6e 6e
B0_2238:		rts				; 60 


B0_2239:		adc ($71), y	; 71 71
B0_223b:		adc ($60), y	; 71 60
B0_223d:		ror $76, x		; 76 76
B0_223f:		jmp ($6c60)		; 6c 60 6c


B0_2242:		jmp ($606c)		; 6c 6c 60


B0_2245:		adc ($71), y	; 71 71
B0_2247:		adc ($60), y	; 71 60
B0_2249:		adc $75, x		; 75 75
B0_224b:		adc $60, x		; 75 60
B0_224d:		sei				; 78 
B0_224e:		sei				; 78 
B0_224f:		ror a			; 6a
B0_2250:		rts				; 60 


B0_2251:		ror a			; 6a
B0_2252:		ror a			; 6a
B0_2253:		ror a			; 6a
B0_2254:		rts				; 60 


B0_2255:		ror $6e6e		; 6e 6e 6e
B0_2258:		rts				; 60 


B0_2259:	.db $73
B0_225a:	.db $73
B0_225b:	.db $73
B0_225c:		rts				; 60 


B0_225d:		ror $76, x		; 76 76
B0_225f:		ror a			; 6a
B0_2260:		rts				; 60 


B0_2261:		ror a			; 6a
B0_2262:		ror a			; 6a
B0_2263:		ror a			; 6a
B0_2264:		rts				; 60 


B0_2265:		ror $6e6e		; 6e 6e 6e
B0_2268:		rts				; 60 


B0_2269:		adc ($71), y	; 71 71
B0_226b:		adc ($60), y	; 71 60
B0_226d:		ror $76, x		; 76 76
B0_226f:	.db $03
B0_2270:		and $a721, x	; 3d 21 a7
B0_2273:		php				; 08 
B0_2274:		ora ($a7, x)	; 01 a7
B0_2276:		php				; 08 
B0_2277:		.db $00				; 00
B0_2278:		tax				; aa 
B0_2279:	.db $af
B0_227a:		and ($a6, x)	; 21 a6
B0_227c:		php				; 08 
B0_227d:		ora ($a6, x)	; 01 a6
B0_227f:		php				; 08 
B0_2280:		.db $00				; 00
B0_2281:		tax				; aa 
B0_2282:	.db $af
B0_2283:		and ($d1, x)	; 21 d1
B0_2285:		php				; 08 
B0_2286:		ora ($d1, x)	; 01 d1
B0_2288:		adc ($71), y	; 71 71
B0_228a:		adc ($60), y	; 71 60
B0_228c:		adc ($60), y	; 71 60
B0_228e:		adc ($71), y	; 71 71
B0_2290:		cpy #$05		; c0 05
B0_2292:		asl $02, x		; 16 02
B0_2294:	.db $80
B0_2295:	.db $03
B0_2296:	.db $3f
B0_2297:	.db $07
B0_2298:		ora ($80, x)	; 01 80
B0_229a:		and ($af, x)	; 21 af
B0_229c:		php				; 08 
B0_229d:		ora ($cf, x)	; 01 cf
B0_229f:		php				; 08 
B0_22a0:		.db $00				; 00
B0_22a1:		sta ($93), y	; 91 93
B0_22a3:		and ($b4, x)	; 21 b4
B0_22a5:		php				; 08 
B0_22a6:		ora ($06, x)	; 01 06
B0_22a8:		ldy $08, x		; b4 08
B0_22aa:		.db $00				; 00
B0_22ab:	.db $93
B0_22ac:		sta ($8f), y	; 91 8f
B0_22ae:		asl $b1			; 06 b1
B0_22b0:		txa				; 8a 
B0_22b1:		and ($ca, x)	; 21 ca
B0_22b3:		php				; 08 
B0_22b4:		ora ($ea, x)	; 01 ea
B0_22b6:		php				; 08 
B0_22b7:		.db $00				; 00
B0_22b8:		and ($b1, x)	; 21 b1
B0_22ba:		php				; 08 
B0_22bb:		ora ($d1, x)	; 01 d1
B0_22bd:		php				; 08 
B0_22be:		.db $00				; 00
B0_22bf:	.db $93
B0_22c0:		sty $21, x		; 94 21
B0_22c2:		ldx $08, y		; b6 08
B0_22c4:		ora ($06, x)	; 01 06
B0_22c6:		ldx $08, y		; b6 08
B0_22c8:		.db $00				; 00
B0_22c9:		sty $96, x		; 94 96
B0_22cb:		sty $21, x		; 94 21
B0_22cd:		sed				; f8 
B0_22ce:		php				; 08 
B0_22cf:		ora ($f8, x)	; 01 f8
B0_22d1:		php				; 08 
B0_22d2:		.db $00				; 00
B0_22d3:	.db $07
B0_22d4:		ora ($60, x)	; 01 60
B0_22d6:		ora $22			; 05 22
B0_22d8:	.db $02
B0_22d9:		cpy #$03		; c0 03
B0_22db:		and $b821, x	; 3d 21 b8
B0_22de:		php				; 08 
B0_22df:		ora ($06, x)	; 01 06
B0_22e1:		clv				; b8 
B0_22e2:		php				; 08 
B0_22e3:		.db $00				; 00
B0_22e4:		stx $99, y		; 96 99
B0_22e6:		sta ($21), y	; 91 21
B0_22e8:		dec $08, x		; d6 08
B0_22ea:		ora ($d6, x)	; 01 d6
B0_22ec:		php				; 08 
B0_22ed:		.db $00				; 00
B0_22ee:		and ($b6, x)	; 21 b6
B0_22f0:		php				; 08 
B0_22f1:		ora ($06, x)	; 01 06
B0_22f3:		ldx $08, y		; b6 08
B0_22f5:		.db $00				; 00
B0_22f6:		sty $98, x		; 94 98
B0_22f8:	.db $8f
B0_22f9:		and ($b4, x)	; 21 b4
B0_22fb:		php				; 08 
B0_22fc:		ora ($06, x)	; 01 06
B0_22fe:		ldy $08, x		; b4 08
B0_2300:		.db $00				; 00
B0_2301:		sty $94, x		; 94 94
B0_2303:		sty $d4, x		; 94 d4
B0_2305:	.db $b2
B0_2306:		sta ($21), y	; 91 21
B0_2308:	.db $b2
B0_2309:		php				; 08 
B0_230a:		ora ($06, x)	; 01 06
B0_230c:	.db $b2
B0_230d:		php				; 08 
B0_230e:		.db $00				; 00
B0_230f:		lda ($b2), y	; b1 b2
B0_2311:	.db $03
B0_2312:		rol $b421, x	; 3e 21 b4
B0_2315:		php				; 08 
B0_2316:		ora ($b4, x)	; 01 b4
B0_2318:		php				; 08 
B0_2319:		.db $00				; 00
B0_231a:		and ($b5, x)	; 21 b5
B0_231c:		php				; 08 
B0_231d:		ora ($b5, x)	; 01 b5
B0_231f:		php				; 08 
B0_2320:		.db $00				; 00
B0_2321:	.db $03
B0_2322:	.db $3f
B0_2323:		and ($d6, x)	; 21 d6
B0_2325:		php				; 08 
B0_2326:		ora ($d6, x)	; 01 d6
B0_2328:		php				; 08 
B0_2329:		.db $00				; 00
B0_232a:		ora $2e			; 05 2e
B0_232c:	.db $02
B0_232d:	.db $80
B0_232e:	.db $03
B0_232f:		and $ce06, x	; 3d 06 ce
B0_2332:		sta ($98), y	; 91 98
B0_2334:		asl $d6			; 06 d6
B0_2336:		ldx $d121		; ae 21 d1
B0_2339:		sta ($af), y	; 91 af
B0_233b:		stx $cf21		; 8e 21 cf
B0_233e:		php				; 08 
B0_233f:	.db $02
B0_2340:	.db $cf
B0_2341:		php				; 08 
B0_2342:		.db $00				; 00
B0_2343:		dec $aaac		; ce ac aa
B0_2346:		dex				; ca 
B0_2347:		lda #$a7		; a9 a7
B0_2349:		and ($c7, x)	; 21 c7
B0_234b:		php				; 08 
B0_234c:	.db $02
B0_234d:	.db $c7
B0_234e:		php				; 08 
B0_234f:		.db $00				; 00
B0_2350:		and ($c5, x)	; 21 c5
B0_2352:		php				; 08 
B0_2353:	.db $02
B0_2354:		cmp $08			; c5 08
B0_2356:		.db $00				; 00
B0_2357:		ora $22			; 05 22
B0_2359:	.db $02
B0_235a:		cpy #$03		; c0 03
B0_235c:	.db $3f
B0_235d:		asl $ce			; 06 ce
B0_235f:		sta ($98), y	; 91 98
B0_2361:		asl $d6			; 06 d6
B0_2363:		ldx $d121		; ae 21 d1
B0_2366:		sta ($af), y	; 91 af
B0_2368:		stx $af21		; 8e 21 af
B0_236b:		php				; 08 
B0_236c:		ora ($af, x)	; 01 af
B0_236e:		php				; 08 
B0_236f:		.db $00				; 00
B0_2370:		tax				; aa 
B0_2371:		ldy $8002		; ac 02 80
B0_2374:		ora $2e			; 05 2e
B0_2376:		ror $6a65		; 6e 65 6a
B0_2379:		ror $716f		; 6e 6f 71
B0_237c:		bvs B0_23ef ; 70 71

B0_237e:		jmp ($6965)		; 6c 65 69


B0_2381:		jmp ($716f)		; 6c 6f 71


B0_2384:		;removed
	.db $70 $71

B0_2386:	.db $6f
B0_2387:		adc $69			; 65 69
B0_2389:		jmp ($716f)		; 6c 6f 71


B0_238c:	.db $6f
B0_238d:		adc ($75), y	; 71 75
B0_238f:	.db $6f
B0_2390:		adc ($75), y	; 71 75
B0_2392:		sei				; 78 
B0_2393:		adc wCurrLevel, x		; 75 71
B0_2395:	.db $6f
B0_2396:	.db $72
B0_2397:		adc $6d6a		; 6d 6a 6d
B0_239a:		ror a			; 6a
B0_239b:		adc $666a		; 6d 6a 66
B0_239e:		ror a			; 6a
B0_239f:		ror $62			; 66 62
B0_23a1:		ror $62			; 66 62
B0_23a3:		ror $62			; 66 62
B0_23a5:		ora $22			; 05 22
B0_23a7:		ror a			; 6a
B0_23a8:		jmp ($6c6b)		; 6c 6b 6c


B0_23ab:		adc ($6c), y	; 71 6c
B0_23ad:		adc ($75), y	; 71 75
B0_23af:		adc ($78), y	; 71 78
B0_23b1:		adc $78, x		; 75 78
B0_23b3:	.db $7b
B0_23b4:		adc $2e05, x	; 7d 05 2e
B0_23b7:		adc $78, x		; 75 78
B0_23b9:		adc $05, x		; 75 05
B0_23bb:		rol $b621		; 2e 21 b6
B0_23be:		php				; 08 
B0_23bf:	.db $02
B0_23c0:		dec $08, x		; d6 08
B0_23c2:		.db $00				; 00
B0_23c3:		sta $96, x		; 95 96
B0_23c5:		and ($b8, x)	; 21 b8
B0_23c7:		php				; 08 
B0_23c8:	.db $02
B0_23c9:		cld				; d8 
B0_23ca:		php				; 08 
B0_23cb:		.db $00				; 00
B0_23cc:		stx $95, y		; 96 95
B0_23ce:		stx $95, y		; 96 95
B0_23d0:		and ($d3, x)	; 21 d3
B0_23d2:		php				; 08 
B0_23d3:	.db $02
B0_23d4:		asl $d3			; 06 d3
B0_23d6:		php				; 08 
B0_23d7:		.db $00				; 00
B0_23d8:		cmp $21, x		; d5 21
B0_23da:		ldx $0208		; ae 08 02
B0_23dd:	.db $ce $08 $00
B0_23e0:		sty $cf8e		; 8c 8e cf
B0_23e3:		ldx $21af		; ae af 21
B0_23e6:	.db $d3
B0_23e7:		php				; 08 
B0_23e8:	.db $02
B0_23e9:	.db $d3
B0_23ea:		php				; 08 
B0_23eb:		.db $00				; 00
B0_23ec:		and ($d1, x)	; 21 d1
B0_23ee:		php				; 08 
B0_23ef:	.db $02
B0_23f0:		cmp ($08), y	; d1 08
B0_23f2:		.db $00				; 00
B0_23f3:		ora $22			; 05 22
B0_23f5:	.db $03
B0_23f6:	.db $3e $02 $00
B0_23f9:	.db $07
B0_23fa:	.db $80
B0_23fb:		.db $00				; 00
B0_23fc:		ror a			; 6a
B0_23fd:		rts				; 60 


B0_23fe:		ror a			; 6a
B0_23ff:		ror a			; 6a
B0_2400:		ror a			; 6a
B0_2401:		rts				; 60 


B0_2402:		ror $6e6e		; 6e 6e 6e
B0_2405:		rts				; 60 


B0_2406:		adc ($71), y	; 71 71
B0_2408:		adc ($60), y	; 71 60
B0_240a:		ror $76, x		; 76 76
B0_240c:		jmp ($6c60)		; 6c 60 6c


B0_240f:		jmp ($606c)		; 6c 6c 60


B0_2412:		adc ($71), y	; 71 71
B0_2414:		adc ($60), y	; 71 60
B0_2416:		adc $75, x		; 75 75
B0_2418:		adc $60, x		; 75 60
B0_241a:		sei				; 78 
B0_241b:		sei				; 78 
B0_241c:		ror a			; 6a
B0_241d:		rts				; 60 


B0_241e:		ror a			; 6a
B0_241f:		ror a			; 6a
B0_2420:		ror a			; 6a
B0_2421:		rts				; 60 


B0_2422:		ror $6e6e		; 6e 6e 6e
B0_2425:		rts				; 60 


B0_2426:	.db $73
B0_2427:	.db $73
B0_2428:	.db $73
B0_2429:		rts				; 60 


B0_242a:		ror $76, x		; 76 76
B0_242c:		ror a			; 6a
B0_242d:		rts				; 60 


B0_242e:		ror a			; 6a
B0_242f:		ror a			; 6a
B0_2430:		ror a			; 6a
B0_2431:		rts				; 60 


B0_2432:		ror $6e6e		; 6e 6e 6e
B0_2435:		rts				; 60 


B0_2436:		adc ($71), y	; 71 71
B0_2438:		adc ($60), y	; 71 60
B0_243a:		ror $76, x		; 76 76
B0_243c:		dex				; ca 
B0_243d:	.db $cf
B0_243e:		and ($b3, x)	; 21 b3
B0_2440:		php				; 08 
B0_2441:		ora ($06, x)	; 01 06
B0_2443:	.db $b3
B0_2444:		php				; 08 
B0_2445:		.db $00				; 00
B0_2446:		sta $95, x		; 95 95
B0_2448:		sta wPlayerY, x		; 95 cc
B0_244a:		cmp ($21), y	; d1 21
B0_244c:		lda $08, x		; b5 08
B0_244e:		ora ($06, x)	; 01 06
B0_2450:		lda $08, x		; b5 08
B0_2452:		.db $00				; 00
B0_2453:		tya				; 98 
B0_2454:		tya				; 98 
B0_2455:		tya				; 98 
B0_2456:		and ($fa, x)	; 21 fa
B0_2458:		php				; 08 
B0_2459:		ora ($fa, x)	; 01 fa
B0_245b:		php				; 08 
B0_245c:		.db $00				; 00
B0_245d:		.db $00				; 00
B0_245e:		php				; 08 
B0_245f:	.db $03
B0_2460:	.db $3f
B0_2461:		txs				; 9a 
B0_2462:		asl $a0			; 06 a0
B0_2464:	.db $02
B0_2465:		cpy #$07		; c0 07
B0_2467:		ora ($20, x)	; 01 20
B0_2469:	.db $03
B0_246a:		sec				; 38 
B0_246b:		.db $00				; 00
B0_246c:		asl a			; 0a
B0_246d:		dex				; ca 
B0_246e:		.db $00				; 00
B0_246f:		asl $c521		; 0e 21 c5
B0_2472:		php				; 08 
B0_2473:		ora ($c5, x)	; 01 c5
B0_2475:		ora #$00		; 09 00
B0_2477:	.db $07
B0_2478:	.db $03
B0_2479:		sta ($05, x)	; 81 05
B0_247b:		rol $f521		; 2e 21 f5
B0_247e:		php				; 08 
B0_247f:		ora ($06, x)	; 01 06
B0_2481:		cmp $08, x		; d5 08
B0_2483:		.db $00				; 00
B0_2484:		lda ($21), y	; b1 21
B0_2486:	.db $b3
B0_2487:		php				; 08 
B0_2488:		ora ($d3, x)	; 01 d3
B0_248a:		php				; 08 
B0_248b:		.db $00				; 00
B0_248c:		sta $96, x		; 95 96
B0_248e:		cmp $d1, x		; d5 d1
B0_2490:		and ($b3, x)	; 21 b3
B0_2492:		php				; 08 
B0_2493:		ora ($d3, x)	; 01 d3
B0_2495:		php				; 08 
B0_2496:		.db $00				; 00
B0_2497:		bcc B0_242c ; 90 93

B0_2499:		cmp ($b5), y	; d1 b5
B0_249b:		tsx				; ba 
B0_249c:		and ($da, x)	; 21 da
B0_249e:		php				; 08 
B0_249f:		ora ($da, x)	; 01 da
B0_24a1:		php				; 08 
B0_24a2:		.db $00				; 00
B0_24a3:		and ($d9, x)	; 21 d9
B0_24a5:		php				; 08 
B0_24a6:		ora ($d9, x)	; 01 d9
B0_24a8:		php				; 08 
B0_24a9:		.db $00				; 00
B0_24aa:		ora $22			; 05 22
B0_24ac:		php				; 08 
B0_24ad:	.db $03
B0_24ae:		nop				; ea 
B0_24af:		sbc #$e7		; e9 e7
B0_24b1:		sbc $e3			; e5 e3
B0_24b3:	.db $e3
B0_24b4:		and ($e5, x)	; 21 e5
B0_24b6:		sbc $03			; e5 03
B0_24b8:		;removed
	.db $50 $08

B0_24ba:		.db $00				; 00
B0_24bb:		tax				; aa 
B0_24bc:		tax				; aa 
B0_24bd:		tax				; aa 
B0_24be:		tax				; aa 
B0_24bf:		lda #$a9		; a9 a9
B0_24c1:		lda #$a9		; a9 a9
B0_24c3:		tay				; a8 
B0_24c4:		tay				; a8 
B0_24c5:		tay				; a8 
B0_24c6:		tay				; a8 
B0_24c7:	.db $a7
B0_24c8:	.db $a7
B0_24c9:	.db $a7
B0_24ca:	.db $a7
B0_24cb:	.db $a3
B0_24cc:	.db $04
B0_24cd:	.db $07
B0_24ce:	.db $cb
B0_24cf:		ldy $03			; a4 03
B0_24d1:		sta ($21, x)	; 81 21
B0_24d3:		sbc $08			; e5 08
B0_24d5:		ora ($06, x)	; 01 06
B0_24d7:		cmp $a0			; c5 a0
B0_24d9:		php				; 08 
B0_24da:		.db $00				; 00
B0_24db:	.db $03
B0_24dc:		bvc B0_246d ; 50 8f

B0_24de:	.db $04
B0_24df:	.db $07
B0_24e0:		cmp $8ea4, x	; dd a4 8e
B0_24e3:	.db $04
B0_24e4:	.db $07
B0_24e5:	.db $e2
B0_24e6:		ldy $8d			; a4 8d
B0_24e8:	.db $04
B0_24e9:	.db $07
B0_24ea:	.db $e7
B0_24eb:		ldy $8a			; a4 8a
B0_24ed:	.db $04
B0_24ee:	.db $07
B0_24ef:		cpx $8da4		; ec a4 8d
B0_24f2:	.db $04
B0_24f3:	.db $07
B0_24f4:		sbc ($a4), y	; f1 a4
B0_24f6:	.db $8f
B0_24f7:	.db $04
B0_24f8:	.db $07
B0_24f9:		inc $a4, x		; f6 a4
B0_24fb:		sta ($04), y	; 91 04
B0_24fd:	.db $07
B0_24fe:	.db $fb
B0_24ff:		ldy $03			; a4 03
B0_2501:		sta ($f1, x)	; 81 f1
B0_2503:	.db $f2
B0_2504:		;removed
	.db $f0 $ef

B0_2506:		sbc $f5f2		; edf2 f5
B0_2509:	.db $d4
B0_250a:		cmp ($f6), y	; d1 f6
B0_250c:	.db $03
B0_250d:		bvc B0_2499 ; 50 8a

B0_250f:	.db $04
B0_2510:	.db $07
B0_2511:		asl $89a5		; 0e a5 89
B0_2514:	.db $04
B0_2515:	.db $07
B0_2516:	.db $13
B0_2517:		lda $87			; a5 87
B0_2519:	.db $04
B0_251a:	.db $07
B0_251b:		clc				; 18 
B0_251c:		lda $86			; a5 86
B0_251e:	.db $04
B0_251f:	.db $07
B0_2520:		ora $85a5, x	; 1d a5 85
B0_2523:	.db $04
B0_2524:	.db $07
B0_2525:	.db $22
B0_2526:		lda $83			; a5 83
B0_2528:	.db $04
B0_2529:	.db $07
B0_252a:	.db $27
B0_252b:		lda $85			; a5 85
B0_252d:	.db $04
B0_252e:		ora $a52c		; 0d 2c a5
B0_2531:	.db $87
B0_2532:	.db $89
B0_2533:		txa				; 8a 
B0_2534:	.db $04
B0_2535:	.db $07
B0_2536:	.db $33
B0_2537:		lda $89			; a5 89
B0_2539:	.db $04
B0_253a:	.db $07
B0_253b:		sec				; 38 
B0_253c:		lda $87			; a5 87
B0_253e:	.db $04
B0_253f:	.db $07
B0_2540:		and $86a5, x	; 3d a5 86
B0_2543:	.db $04
B0_2544:	.db $07
B0_2545:	.db $42
B0_2546:		lda $03			; a5 03
B0_2548:		sta ($f1, x)	; 81 f1
B0_254a:	.db $ef
B0_254b:	.db $f2
B0_254c:		lda ($b3), y	; b1 b3
B0_254e:		ldy $b5, x		; b4 b5
B0_2550:		php				; 08 
B0_2551:	.db $03
B0_2552:		nop				; ea 
B0_2553:		sbc #$e7		; e9 e7
B0_2555:		sbc $e3			; e5 e3
B0_2557:	.db $e3
B0_2558:		and ($e5, x)	; 21 e5
B0_255a:		sbc $03			; e5 03
B0_255c:	.db $5f
B0_255d:		tax				; aa 
B0_255e:		tax				; aa 
B0_255f:		tax				; aa 
B0_2560:		tax				; aa 
B0_2561:		lda #$a9		; a9 a9
B0_2563:		lda #$a9		; a9 a9
B0_2565:		tay				; a8 
B0_2566:		tay				; a8 
B0_2567:		tay				; a8 
B0_2568:		tay				; a8 
B0_2569:	.db $a7
B0_256a:	.db $a7
B0_256b:	.db $a7
B0_256c:	.db $a7
B0_256d:	.db $a3
B0_256e:	.db $04
B0_256f:	.db $07
B0_2570:		adc $a5a5		; 6d a5 a5
B0_2573:	.db $04
B0_2574:	.db $07
B0_2575:	.db $72
B0_2576:		lda $03			; a5 03
B0_2578:		and $8a			; 25 8a
B0_257a:		sta $04			; 85 04
B0_257c:	.db $07
B0_257d:	.db $79 $a5 $00
B0_2580:		php				; 08 
B0_2581:		txa				; 8a 
B0_2582:	.db $80
B0_2583:		ldy #$03		; a0 03
B0_2585:		sta ($00, x)	; 81 00
B0_2587:		asl a			; 0a
B0_2588:		cmp $00			; c5 00
B0_258a:		asl $ca21		; 0e 21 ca
B0_258d:		php				; 08 
B0_258e:		ora ($ca, x)	; 01 ca
B0_2590:		ora #$00		; 09 00
B0_2592:		.db $00				; 00
B0_2593:	.db $80
B0_2594:		.db $00				; 00
B0_2595:		ora ($42, x)	; 01 42
B0_2597:	.db $80
B0_2598:		.db $00				; 00
B0_2599:	.db $02
B0_259a:		eor ($80, x)	; 41 80
B0_259c:		.db $00				; 00
B0_259d:	.db $02
B0_259e:		and ($80, x)	; 21 80
B0_25a0:		.db $00				; 00
B0_25a1:	.db $0f
B0_25a2:		ldy $0ca5		; ac a5 0c
B0_25a5:		ldx $7c			; a6 7c
B0_25a7:		ldx $00			; a6 00
B0_25a9:		.db $00				; 00
B0_25aa:	.db $ad $a6 $00
B0_25ad:		ora #$02		; 09 02
B0_25af:	.db $80
B0_25b0:	.db $03
B0_25b1:		rol $0107, x	; 3e 07 01
B0_25b4:		rts				; 60 


B0_25b5:		ora $23			; 05 23
B0_25b7:		lda $8d8c		; ad 8c 8d
B0_25ba:		txa				; 8a 
B0_25bb:		sty $c821		; 8c 21 c8
B0_25be:		php				; 08 
B0_25bf:		ora ($06, x)	; 01 06
B0_25c1:		tay				; a8 
B0_25c2:		php				; 08 
B0_25c3:		.db $00				; 00
B0_25c4:		txa				; 8a 
B0_25c5:		sta $918f		; 8d 8f 91
B0_25c8:		sty $ae, x		; 94 ae
B0_25ca:		and ($af, x)	; 21 af
B0_25cc:		php				; 08 
B0_25cd:		ora ($af, x)	; 01 af
B0_25cf:		php				; 08 
B0_25d0:		.db $00				; 00
B0_25d1:		ldx $92, y		; b6 92
B0_25d3:		sty $96, x		; 94 96
B0_25d5:		tya				; 98 
B0_25d6:		sta $9d98, y	; 99 98 9d
B0_25d9:	.db $9b
B0_25da:		sta $9998, y	; 99 98 99
B0_25dd:		tya				; 98 
B0_25de:		stx $91, y		; 96 91
B0_25e0:		sta $218c		; 8d 8c 21
B0_25e3:		tax				; aa 
B0_25e4:		php				; 08 
B0_25e5:		ora ($aa, x)	; 01 aa
B0_25e7:		php				; 08 
B0_25e8:		.db $00				; 00
B0_25e9:		;removed
	.db $30 $8c

B0_25eb:		bmi B0_257a ; 30 8d

B0_25ed:		;removed
	.db $30 $8f

B0_25ef:	.db $92
B0_25f0:		sty $8f, x		; 94 8f
B0_25f2:		sta ($92), y	; 91 92
B0_25f4:		sty $96, x		; 94 96
B0_25f6:		tya				; 98 
B0_25f7:		sty $96, x		; 94 96
B0_25f9:		tya				; 98 
B0_25fa:		sta $bb21, x	; 9d 21 bb
B0_25fd:		php				; 08 
B0_25fe:		ora ($db, x)	; 01 db
B0_2600:		php				; 08 
B0_2601:		.db $00				; 00
B0_2602:		lda $0108, y	; b9 08 01
B0_2605:	.db $d9 $08 $00
B0_2608:	.db $04
B0_2609:		.db $00				; 00
B0_260a:		lda $a5, x		; b5 a5
B0_260c:		.db $00				; 00
B0_260d:		ora #$02		; 09 02
B0_260f:	.db $80
B0_2610:	.db $03
B0_2611:	.db $3a
B0_2612:		ora $2f			; 05 2f
B0_2614:		php				; 08 
B0_2615:	.db $02
B0_2616:	.db $07
B0_2617:	.db $ff
B0_2618:		;removed
	.db $10 $03

B0_261a:		sec				; 38 
B0_261b:	.db $74
B0_261c:		ror $71, x		; 76 71
B0_261e:	.db $74
B0_261f:	.db $6f
B0_2620:		adc ($6a), y	; 71 6a
B0_2622:		adc $6a68		; 6d 68 6a
B0_2625:		adc $68			; 65 68
B0_2627:	.db $04
B0_2628:		ora ($19, x)	; 01 19
B0_262a:		ldx $68			; a6 68
B0_262c:		ror a			; 6a
B0_262d:		adc $716f		; 6d 6f 71
B0_2630:	.db $74
B0_2631:		ror $79, x		; 76 79
B0_2633:	.db $74
B0_2634:		ror $79, x		; 76 79
B0_2636:	.db $7b
B0_2637:		php				; 08 
B0_2638:		.db $00				; 00
B0_2639:	.db $03
B0_263a:	.db $3a
B0_263b:	.db $07
B0_263c:		ora ($50, x)	; 01 50
B0_263e:	.db $b3
B0_263f:	.db $d4
B0_2640:		ora $23			; 05 23
B0_2642:		and ($ad, x)	; 21 ad
B0_2644:		php				; 08 
B0_2645:		ora ($cd, x)	; 01 cd
B0_2647:		php				; 08 
B0_2648:		.db $00				; 00
B0_2649:		sta $91, x		; 95 91
B0_264b:		tya				; 98 
B0_264c:		tya				; 98 
B0_264d:		sta $91, x		; 95 91
B0_264f:		stx $91, y		; 96 91
B0_2651:		sta ($8a), y	; 91 8a
B0_2653:		txa				; 8a 
B0_2654:		sta $21			; 85 21
B0_2656:		lda ($08, x)	; a1 08
B0_2658:		ora ($c1, x)	; 01 c1
B0_265a:		php				; 08 
B0_265b:		.db $00				; 00
B0_265c:		and ($ad, x)	; 21 ad
B0_265e:		php				; 08 
B0_265f:		ora ($cd, x)	; 01 cd
B0_2661:		php				; 08 
B0_2662:		.db $00				; 00
B0_2663:		and ($b2, x)	; 21 b2
B0_2665:		php				; 08 
B0_2666:		ora ($d2, x)	; 01 d2
B0_2668:		php				; 08 
B0_2669:		.db $00				; 00
B0_266a:		and ($b4, x)	; 21 b4
B0_266c:		php				; 08 
B0_266d:		ora ($d4, x)	; 01 d4
B0_266f:		php				; 08 
B0_2670:		.db $00				; 00
B0_2671:		and ($b1, x)	; 21 b1
B0_2673:		php				; 08 
B0_2674:		ora ($d1, x)	; 01 d1
B0_2676:		php				; 08 
B0_2677:		.db $00				; 00
B0_2678:	.db $04
B0_2679:		.db $00				; 00
B0_267a:	.db $12
B0_267b:		ldx $00			; a6 00
B0_267d:		ora #$03		; 09 03
B0_267f:		sta ($05, x)	; 81 05
B0_2681:	.db $23
B0_2682:		and ($cd, x)	; 21 cd
B0_2684:		php				; 08 
B0_2685:		ora ($cd, x)	; 01 cd
B0_2687:		php				; 08 
B0_2688:		.db $00				; 00
B0_2689:		sty $8a8d		; 8c 8d 8a
B0_268c:		sty $c806		; 8c 06 c8
B0_268f:		asl $c9			; 06 c9
B0_2691:		ora $2f			; 05 2f
B0_2693:		asl $c6			; 06 c6
B0_2695:		iny				; c8 
B0_2696:		lda #$ca		; a9 ca
B0_2698:		tay				; a8 
B0_2699:		asl $c7			; 06 c7
B0_269b:		asl $c3			; 06 c3
B0_269d:		iny				; c8 
B0_269e:		ldy $b4af		; ac af b4
B0_26a1:		clv				; b8 
B0_26a2:		and ($ad, x)	; 21 ad
B0_26a4:		php				; 08 
B0_26a5:		ora ($cd, x)	; 01 cd
B0_26a7:		php				; 08 
B0_26a8:		.db $00				; 00
B0_26a9:	.db $04
B0_26aa:		.db $00				; 00
B0_26ab:	.db $80
B0_26ac:		ldx $00			; a6 00
B0_26ae:		.db $00				; 00
B0_26af:	.db $80
B0_26b0:		.db $00				; 00
B0_26b1:		ora ($43, x)	; 01 43
B0_26b3:	.db $80
B0_26b4:		.db $00				; 00
B0_26b5:		.db $00				; 00
B0_26b6:		.db $00				; 00
B0_26b7:		sta $05			; 85 05
B0_26b9:	.db $0f
B0_26ba:		cpy $a6			; c4 a6
B0_26bc:		ror $37a7		; 6e a7 37
B0_26bf:		tay				; a8 
B0_26c0:		.db $00				; 00
B0_26c1:		.db $00				; 00
B0_26c2:	.db $8c $a8 $00
B0_26c5:	.db $07
B0_26c6:		ora $17			; 05 17
B0_26c8:	.db $02
B0_26c9:		.db $00				; 00
B0_26ca:	.db $07
B0_26cb:		ora ($80, x)	; 01 80
B0_26cd:		php				; 08 
B0_26ce:		.db $00				; 00
B0_26cf:	.db $03
B0_26d0:	.db $3f
B0_26d1:		asl $b1			; 06 b1
B0_26d3:		adc ($71), y	; 71 71
B0_26d5:		sta ($8d), y	; 91 8d
B0_26d7:		sta ($94), y	; 91 94
B0_26d9:		asl $b2			; 06 b2
B0_26db:	.db $72
B0_26dc:	.db $72
B0_26dd:	.db $92
B0_26de:		stx $9592		; 8e 92 95
B0_26e1:		asl $b3			; 06 b3
B0_26e3:	.db $73
B0_26e4:	.db $73
B0_26e5:	.db $93
B0_26e6:	.db $8f
B0_26e7:	.db $93
B0_26e8:		stx $06, y		; 96 06
B0_26ea:		ldy $74, x		; b4 74
B0_26ec:	.db $74
B0_26ed:		sty $91, x		; 94 91
B0_26ef:		sty $99, x		; 94 99
B0_26f1:	.db $04
B0_26f2:		ora ($d1, x)	; 01 d1
B0_26f4:		ldx $03			; a6 03
B0_26f6:	.db $3c
B0_26f7:	.db $80
B0_26f8:		bcc B0_267a ; 90 80

B0_26fa:	.db $92
B0_26fb:	.db $80
B0_26fc:	.db $92
B0_26fd:	.db $80
B0_26fe:		sta $80, x		; 95 80
B0_2700:		sta $80, x		; 95 80
B0_2702:		and ($06, x)	; 21 06
B0_2704:		ldy $08, x		; b4 08
B0_2706:		ora ($b4, x)	; 01 b4
B0_2708:		php				; 08 
B0_2709:		.db $00				; 00
B0_270a:	.db $04
B0_270b:		ora ($f7, x)	; 01 f7
B0_270d:		ldx $21			; a6 21
B0_270f:		lda $0108, y	; b9 08 01
B0_2712:		asl $b9			; 06 b9
B0_2714:		php				; 08 
B0_2715:		.db $00				; 00
B0_2716:		sta $95, x		; 95 95
B0_2718:	.db $97
B0_2719:		bmi B0_26b4 ; 30 99

B0_271b:		bmi B0_269d ; 30 80

B0_271d:		bmi B0_26b6 ; 30 97

B0_271f:		asl $b9			; 06 b9
B0_2721:		sta $95, x		; 95 95
B0_2723:	.db $97
B0_2724:		bmi B0_26bf ; 30 99

B0_2726:		bmi B0_26a8 ; 30 80

B0_2728:		bmi B0_26c1 ; 30 97

B0_272a:		asl $b9			; 06 b9
B0_272c:		sta $95, x		; 95 95
B0_272e:	.db $97
B0_272f:		and ($b9, x)	; 21 b9
B0_2731:		php				; 08 
B0_2732:		ora ($b9, x)	; 01 b9
B0_2734:		php				; 08 
B0_2735:		.db $00				; 00
B0_2736:		and ($bb, x)	; 21 bb
B0_2738:		php				; 08 
B0_2739:		ora ($bb, x)	; 01 bb
B0_273b:		php				; 08 
B0_273c:		.db $00				; 00
B0_273d:	.db $02
B0_273e:		cpy #$05		; c0 05
B0_2740:	.db $23
B0_2741:	.db $07
B0_2742:		ora ($40, x)	; 01 40
B0_2744:		adc $706f		; 6d 6f 70
B0_2747:	.db $72
B0_2748:		sty $72, x		; 94 72
B0_274a:		bvs B0_26e1 ; 70 95

B0_274c:	.db $74
B0_274d:	.db $72
B0_274e:	.db $77
B0_274f:		adc $74, x		; 75 74
B0_2751:	.db $72
B0_2752:	.db $74
B0_2753:		jmp ($726f)		; 6c 6f 72


B0_2756:		adc $78, x		; 75 78
B0_2758:	.db $7b
B0_2759:		ror $2f05, x	; 7e 05 2f
B0_275c:	.db $74
B0_275d:	.db $73
B0_275e:		ora $23			; 05 23
B0_2760:	.db $7c
B0_2761:		adc $7074, y	; 79 74 70
B0_2764:	.db $6f
B0_2765:		pla				; 68 
B0_2766:	.db $04
B0_2767:		ora ($44, x)	; 01 44
B0_2769:	.db $a7
B0_276a:	.db $04
B0_276b:		.db $00				; 00
B0_276c:		dec $a6			; c6 a6
B0_276e:		.db $00				; 00
B0_276f:	.db $07
B0_2770:		ora $17			; 05 17
B0_2772:	.db $02
B0_2773:		.db $00				; 00
B0_2774:	.db $07
B0_2775:		ora ($80, x)	; 01 80
B0_2777:	.db $03
B0_2778:	.db $3f
B0_2779:		php				; 08 
B0_277a:		.db $00				; 00
B0_277b:		asl $ad			; 06 ad
B0_277d:		adc $8d68		; 6d 68 8d
B0_2780:		dey				; 88 
B0_2781:		sta $0691		; 8d 91 06
B0_2784:		ldx $696e		; ae 6e 69
B0_2787:		stx $8e89		; 8e 89 8e
B0_278a:	.db $92
B0_278b:		asl $af			; 06 af
B0_278d:	.db $6f
B0_278e:		ror a			; 6a
B0_278f:	.db $8f
B0_2790:		txa				; 8a 
B0_2791:	.db $8f
B0_2792:	.db $93
B0_2793:		asl $b1			; 06 b1
B0_2795:		adc ($6d), y	; 71 6d
B0_2797:		sta ($8d), y	; 91 8d
B0_2799:		sta ($94), y	; 91 94
B0_279b:	.db $04
B0_279c:		ora ($7b, x)	; 01 7b
B0_279e:	.db $a7
B0_279f:	.db $03
B0_27a0:	.db $3c
B0_27a1:	.db $80
B0_27a2:		dey				; 88 
B0_27a3:	.db $80
B0_27a4:		txa				; 8a 
B0_27a5:	.db $80
B0_27a6:		txa				; 8a 
B0_27a7:	.db $80
B0_27a8:	.db $8f
B0_27a9:	.db $80
B0_27aa:	.db $8f
B0_27ab:	.db $80
B0_27ac:	.db $8f
B0_27ad:	.db $03
B0_27ae:	.db $3f
B0_27af:	.db $02
B0_27b0:	.db $80
B0_27b1:		ora $23			; 05 23
B0_27b3:		rts				; 60 


B0_27b4:		pla				; 68 
B0_27b5:		ror a			; 6a
B0_27b6:	.db $6b
B0_27b7:		adc $706f		; 6d 6f 70
B0_27ba:	.db $72
B0_27bb:	.db $74
B0_27bc:		rts				; 60 


B0_27bd:	.db $03
B0_27be:	.db $3c
B0_27bf:		ora $17			; 05 17
B0_27c1:	.db $02
B0_27c2:		rti				; 40 


B0_27c3:		dey				; 88 
B0_27c4:	.db $80
B0_27c5:		txa				; 8a 
B0_27c6:	.db $80
B0_27c7:		txa				; 8a 
B0_27c8:	.db $80
B0_27c9:	.db $8f
B0_27ca:	.db $80
B0_27cb:	.db $8f
B0_27cc:	.db $80
B0_27cd:	.db $8f
B0_27ce:		rts				; 60 


B0_27cf:	.db $03
B0_27d0:	.db $3f
B0_27d1:	.db $02
B0_27d2:	.db $80
B0_27d3:		ora $23			; 05 23
B0_27d5:	.db $6f
B0_27d6:		bvs B0_284a ; 70 72

B0_27d8:	.db $74
B0_27d9:		adc $76, x		; 75 76
B0_27db:		sei				; 78 
B0_27dc:		ora $17			; 05 17
B0_27de:	.db $02
B0_27df:		rti				; 40 


B0_27e0:		and ($b1, x)	; 21 b1
B0_27e2:		php				; 08 
B0_27e3:		ora ($06, x)	; 01 06
B0_27e5:		lda ($08), y	; b1 08
B0_27e7:		.db $00				; 00
B0_27e8:		bcc B0_277a ; 90 90

B0_27ea:		bcc B0_281c ; 90 30

B0_27ec:		sta ($30), y	; 91 30
B0_27ee:	.db $80
B0_27ef:		;removed
	.db $30 $91

B0_27f1:		asl $b1			; 06 b1
B0_27f3:		;removed
	.db $90 $90

B0_27f5:		bcc B0_2827 ; 90 30

B0_27f7:		sta ($30), y	; 91 30
B0_27f9:	.db $80
B0_27fa:		bmi B0_278d ; 30 91

B0_27fc:		asl $b1			; 06 b1
B0_27fe:		bcc B0_2790 ; 90 90

B0_2800:		bcc B0_2823 ; 90 21

B0_2802:		lda $08, x		; b5 08
B0_2804:		ora ($b5, x)	; 01 b5
B0_2806:		php				; 08 
B0_2807:		.db $00				; 00
B0_2808:		and ($b8, x)	; 21 b8
B0_280a:		php				; 08 
B0_280b:		ora ($b8, x)	; 01 b8
B0_280d:		php				; 08 
B0_280e:		.db $00				; 00
B0_280f:		ora $17			; 05 17
B0_2811:		;removed
	.db $70 $60

B0_2813:		;removed
	.db $70 $70

B0_2815:		bvs B0_2877 ; 70 60

B0_2817:		bvs B0_288b ; 70 72

B0_2819:	.db $80
B0_281a:	.db $72
B0_281b:	.db $72
B0_281c:	.db $72
B0_281d:		rts				; 60 


B0_281e:	.db $6f
B0_281f:	.db $6f
B0_2820:	.db $6f
B0_2821:		rts				; 60 


B0_2822:	.db $6f
B0_2823:	.db $6f
B0_2824:	.db $6f
B0_2825:		rts				; 60 


B0_2826:	.db $6f
B0_2827:	.db $22
B0_2828:		;removed
	.db $70 $b0

B0_282a:		php				; 08 
B0_282b:		ora ($b0, x)	; 01 b0
B0_282d:		php				; 08 
B0_282e:		.db $00				; 00
B0_282f:	.db $04
B0_2830:		ora ($11, x)	; 01 11
B0_2832:		tay				; a8 
B0_2833:	.db $04
B0_2834:		.db $00				; 00
B0_2835:		bvs B0_27de ; 70 a7

B0_2837:		.db $00				; 00
B0_2838:	.db $07
B0_2839:		ora $23			; 05 23
B0_283b:	.db $03
B0_283c:		sta ($ed, x)	; 81 ed
B0_283e:	.db $04
B0_283f:	.db $03
B0_2840:		and wEntities_3a8.w, x	; 3d a8 03
B0_2843:		rti				; 40 


B0_2844:		lda $0e04		; ad 04 0e
B0_2847:	.db $44
B0_2848:		tay				; a8 
B0_2849:		tay				; a8 
B0_284a:		lda $adad		; ad ad ad
B0_284d:		lda $adad		; ad ad ad
B0_2850:		sty $8c88		; 8c 88 8c
B0_2853:		dey				; 88 
B0_2854:	.db $04
B0_2855:		ora ($4a, x)	; 01 4a
B0_2857:		tay				; a8 
B0_2858:		lda $04a8		; ad a8 04
B0_285b:		ora $58			; 05 58
B0_285d:		tay				; a8 
B0_285e:	.db $af
B0_285f:	.db $af
B0_2860:		tay				; a8 
B0_2861:		tay				; a8 
B0_2862:		adc $6d60		; 6d 60 6d
B0_2865:		adc $606d		; 6d 6d 60
B0_2868:		adc $806f		; 6d 6f 80
B0_286b:	.db $6f
B0_286c:	.db $6f
B0_286d:	.db $6f
B0_286e:		rts				; 60 


B0_286f:		adc #$69		; 69 69
B0_2871:		jmp ($6c60)		; 6c 60 6c


B0_2874:		jmp ($606c)		; 6c 6c 60


B0_2877:		jmp ($6d21)		; 6c 21 6d


B0_287a:		lda $6a68		; ad 68 6a
B0_287d:	.db $6b
B0_287e:		jmp ($adad)		; 6c ad ad


B0_2881:	.db $af
B0_2882:	.db $8f
B0_2883:	.db $89
B0_2884:		ldy $adac		; ac ac ad
B0_2887:	.db $ad $04 $00
B0_288a:	.db $3b
B0_288b:		tay				; a8 
B0_288c:		.db $00				; 00
B0_288d:		.db $00				; 00
B0_288e:	.db $80
B0_288f:		.db $00				; 00
B0_2890:		ora ($43, x)	; 01 43
B0_2892:	.db $80
B0_2893:		.db $00				; 00
B0_2894:		ora ($85, x)	; 01 85
B0_2896:	.db $80
B0_2897:		.db $00				; 00
B0_2898:	.db $0f
B0_2899:	.db $a3
B0_289a:		tay				; a8 
B0_289b:		plp				; 28 
B0_289c:		lda #$ba		; a9 ba
B0_289e:		lda #$00		; a9 00
B0_28a0:		.db $00				; 00
B0_28a1:		ora #$aa		; 09 aa
B0_28a3:		.db $00				; 00
B0_28a4:		php				; 08 
B0_28a5:	.db $02
B0_28a6:		cpy #$07		; c0 07
B0_28a8:		ora ($60, x)	; 01 60
B0_28aa:	.db $03
B0_28ab:	.db $3d $08 $00
B0_28ae:		ora $1a			; 05 1a
B0_28b0:		ldy #$6a		; a0 6a
B0_28b2:		adc $7470		; 6d 70 74
B0_28b5:	.db $b7
B0_28b6:	.db $6f
B0_28b7:	.db $72
B0_28b8:		adc wHealthTaken, x		; 75 79
B0_28ba:		ora $26			; 05 26
B0_28bc:		asl $b0			; 06 b0
B0_28be:	.db $8f
B0_28bf:		sta $b4, x		; 95 b4
B0_28c1:		ror $056f		; 6e 6f 05
B0_28c4:	.db $1a
B0_28c5:		ldy #$69		; a0 69
B0_28c7:		adc $726f		; 6d 6f 72
B0_28ca:		lda $6e, x		; b5 6e
B0_28cc:	.db $72
B0_28cd:	.db $74
B0_28ce:	.db $77
B0_28cf:		ora $26			; 05 26
B0_28d1:		asl $ae			; 06 ae
B0_28d3:		sta $b293		; 8d 93 b2
B0_28d6:		jmp ($056d)		; 6c 6d 05


B0_28d9:	.db $1a
B0_28da:		ldy #$68		; a0 68
B0_28dc:	.db $6b
B0_28dd:		ror $b471		; 6e 71 b4
B0_28e0:		adc $7370		; 6d 70 73
B0_28e3:		ror $06, x		; 76 06
B0_28e5:		lda $9e98, y	; b9 98 9e
B0_28e8:		lda $7877, x	; bd 77 78
B0_28eb:		ldy #$66		; a0 66
B0_28ed:		adc #$6c		; 69 6c
B0_28ef:	.db $6f
B0_28f0:	.db $b2
B0_28f1:		jmp ($726f)		; 6c 6f 72


B0_28f4:		adc $06, x		; 75 06
B0_28f6:		clv				; b8 
B0_28f7:	.db $97
B0_28f8:		sta $76bc, x	; 9d bc 76
B0_28fb:	.db $77
B0_28fc:		ora $26			; 05 26
B0_28fe:	.db $07
B0_28ff:		txa				; 8a 
B0_2900:		rts				; 60 


B0_2901:	.db $03
B0_2902:	.db $3f
B0_2903:	.db $02
B0_2904:		.db $00				; 00
B0_2905:		sta ($84, x)	; 81 84
B0_2907:	.db $83
B0_2908:	.db $82
B0_2909:		sta ($89, x)	; 81 89
B0_290b:		dey				; 88 
B0_290c:	.db $a7
B0_290d:		bcc B0_289e ; 90 8f

B0_290f:		stx $8c8d		; 8e 8d 8c
B0_2912:		stx $87			; 86 87
B0_2914:	.db $83
B0_2915:	.db $89
B0_2916:		dey				; 88 
B0_2917:	.db $87
B0_2918:		stx $8f			; 86 8f
B0_291a:		stx $93ad		; 8e ad 93
B0_291d:	.db $92
B0_291e:		sta ($90), y	; 91 90
B0_2920:	.db $8f
B0_2921:	.db $89
B0_2922:		txa				; 8a 
B0_2923:	.db $04
B0_2924:		.db $00				; 00
B0_2925:		lda $a8			; a5 a8
B0_2927:		ora #$00		; 09 00
B0_2929:		php				; 08 
B0_292a:	.db $02
B0_292b:		cpy #$07		; c0 07
B0_292d:		ora ($60, x)	; 01 60
B0_292f:	.db $03
B0_2930:		and $0e05, x	; 3d 05 0e
B0_2933:		ror a			; 6a
B0_2934:		adc $7470		; 6d 70 74
B0_2937:		and ($b7, x)	; 21 b7
B0_2939:		php				; 08 
B0_293a:		ora ($b7, x)	; 01 b7
B0_293c:		php				; 08 
B0_293d:		.db $00				; 00
B0_293e:		ora $1a			; 05 1a
B0_2940:		ror a			; 6a
B0_2941:		adc $7470		; 6d 70 74
B0_2944:		asl $b7			; 06 b7
B0_2946:		stx $9c, y		; 96 9c
B0_2948:	.db $bb
B0_2949:		adc $76, x		; 75 76
B0_294b:		ora $0e			; 05 0e
B0_294d:		adc #$6d		; 69 6d
B0_294f:	.db $6f
B0_2950:	.db $72
B0_2951:		and ($b5, x)	; 21 b5
B0_2953:		php				; 08 
B0_2954:		ora ($b5, x)	; 01 b5
B0_2956:		php				; 08 
B0_2957:		.db $00				; 00
B0_2958:		ora $1a			; 05 1a
B0_295a:		adc #$6d		; 69 6d
B0_295c:	.db $6f
B0_295d:	.db $72
B0_295e:		asl $b5			; 06 b5
B0_2960:		sty $9b, x		; 94 9b
B0_2962:		tsx				; ba 
B0_2963:	.db $74
B0_2964:		adc $05, x		; 75 05
B0_2966:		asl $6b68		; 0e 68 6b
B0_2969:		ror $2171		; 6e 71 21
B0_296c:		ldy $08, x		; b4 08
B0_296e:		ora ($b4, x)	; 01 b4
B0_2970:		php				; 08 
B0_2971:		.db $00				; 00
B0_2972:		ora $1a			; 05 1a
B0_2974:		pla				; 68 
B0_2975:	.db $6b
B0_2976:		ror $0671		; 6e 71 06
B0_2979:		ldy $93, x		; b4 93
B0_297b:		sta $73b8, y	; 99 b8 73
B0_297e:	.db $74
B0_297f:		ora $0e			; 05 0e
B0_2981:		ror $69			; 66 69
B0_2983:		jmp ($216f)		; 6c 6f 21


B0_2986:	.db $b2
B0_2987:		php				; 08 
B0_2988:		ora ($b2, x)	; 01 b2
B0_298a:		php				; 08 
B0_298b:		.db $00				; 00
B0_298c:		ora $1a			; 05 1a
B0_298e:		ror $69			; 66 69
B0_2990:		jmp ($066f)		; 6c 6f 06


B0_2993:	.db $b2
B0_2994:		sta ($99), y	; 91 99
B0_2996:		clv				; b8 
B0_2997:	.db $73
B0_2998:	.db $74
B0_2999:	.db $80
B0_299a:		stx $95, y		; 96 95
B0_299c:	.db $80
B0_299d:		stx $95, y		; 96 95
B0_299f:	.db $80
B0_29a0:		ldx $96, y		; b6 96
B0_29a2:		sta $80, x		; 95 80
B0_29a4:		stx $95, y		; 96 95
B0_29a6:		ldy #$80		; a0 80
B0_29a8:		tya				; 98 
B0_29a9:	.db $97
B0_29aa:	.db $80
B0_29ab:		tya				; 98 
B0_29ac:	.db $97
B0_29ad:	.db $80
B0_29ae:		clv				; b8 
B0_29af:		tya				; 98 
B0_29b0:	.db $97
B0_29b1:	.db $80
B0_29b2:		tya				; 98 
B0_29b3:	.db $97
B0_29b4:		ldy #$04		; a0 04
B0_29b6:		.db $00				; 00
B0_29b7:		and ($a9), y	; 31 a9
B0_29b9:		ora #$00		; 09 00
B0_29bb:		php				; 08 
B0_29bc:	.db $03
B0_29bd:	.db $7f
B0_29be:		ora $26			; 05 26
B0_29c0:		tax				; aa 
B0_29c1:		tay				; a8 
B0_29c2:		ldy $88			; a4 88
B0_29c4:		txa				; 8a 
B0_29c5:		bcs B0_2976 ; b0 af

B0_29c7:		tax				; aa 
B0_29c8:		sty $88			; 84 88
B0_29ca:		lda #$a7		; a9 a7
B0_29cc:	.db $a3
B0_29cd:		stx $88			; 86 88
B0_29cf:	.db $af
B0_29d0:		ldx $83a9		; ae a9 83
B0_29d3:	.db $87
B0_29d4:		tay				; a8 
B0_29d5:		lda $a2			; a5 a2
B0_29d7:		sta $88			; 85 88
B0_29d9:		ldx $a8ad		; ae ad a8
B0_29dc:	.db $82
B0_29dd:		stx $a6			; 86 a6
B0_29df:		ldy $a1			; a4 a1
B0_29e1:		sty $86			; 84 86
B0_29e3:		lda $a6ac		; ad ac a6
B0_29e6:		sta ($84, x)	; 81 84
B0_29e8:	.db $80
B0_29e9:	.db $8b
B0_29ea:	.db $8b
B0_29eb:	.db $80
B0_29ec:	.db $8b
B0_29ed:	.db $8b
B0_29ee:	.db $80
B0_29ef:	.db $ab
B0_29f0:	.db $8b
B0_29f1:	.db $8b
B0_29f2:	.db $80
B0_29f3:	.db $8b
B0_29f4:	.db $8b
B0_29f5:		ldy #$80		; a0 80
B0_29f7:		sty $808c		; 8c 8c 80
B0_29fa:		sty $808c		; 8c 8c 80
B0_29fd:		ldy $8c8c		; ac 8c 8c
B0_2a00:	.db $80
B0_2a01:		sty $a08c		; 8c 8c a0
B0_2a04:	.db $04
B0_2a05:		.db $00				; 00
B0_2a06:		cpy #$a9		; c0 a9
B0_2a08:		ora #$00		; 09 00
B0_2a0a:		.db $00				; 00
B0_2a0b:	.db $80
B0_2a0c:		.db $00				; 00
B0_2a0d:		ora ($85, x)	; 01 85
B0_2a0f:	.db $80
B0_2a10:		.db $00				; 00
B0_2a11:		.db $00				; 00
B0_2a12:		.db $00				; 00
B0_2a13:		sty $06			; 84 06
B0_2a15:	.db $0f
B0_2a16:		jsr $4faa		; 20 aa 4f
B0_2a19:		tax				; aa 
B0_2a1a:		sty $aa			; 84 aa
B0_2a1c:		.db $00				; 00
B0_2a1d:		.db $00				; 00
B0_2a1e:	.db $af
B0_2a1f:		tax				; aa 
B0_2a20:		.db $00				; 00
B0_2a21:		asl a			; 0a
B0_2a22:	.db $02
B0_2a23:	.db $80
B0_2a24:	.db $03
B0_2a25:	.db $3f
B0_2a26:	.db $07
B0_2a27:		ora ($60, x)	; 01 60
B0_2a29:		ora $26			; 05 26
B0_2a2b:		asl $a0			; 06 a0
B0_2a2d:		sty $918d		; 8c 8d 91
B0_2a30:		stx $91, y		; 96 91
B0_2a32:	.db $92
B0_2a33:		sta ($8f), y	; 91 8f
B0_2a35:	.db $92
B0_2a36:		lda ($71), y	; b1 71
B0_2a38:	.db $72
B0_2a39:		adc ($6d), y	; 71 6d
B0_2a3b:	.db $8f
B0_2a3c:		sta $8f8c		; 8d 8c 8f
B0_2a3f:		sta $9691		; 8d 91 96
B0_2a42:		sta ($93), y	; 91 93
B0_2a44:		sta $96, x		; 95 96
B0_2a46:		tya				; 98 
B0_2a47:		stx $95, y		; 96 95
B0_2a49:	.db $93
B0_2a4a:		sta $04, x		; 95 04
B0_2a4c:		.db $00				; 00
B0_2a4d:	.db $2b
B0_2a4e:		tax				; aa 
B0_2a4f:		.db $00				; 00
B0_2a50:		asl a			; 0a
B0_2a51:	.db $02
B0_2a52:	.db $80
B0_2a53:		ora $26			; 05 26
B0_2a55:	.db $07
B0_2a56:		ora ($60, x)	; 01 60
B0_2a58:	.db $03
B0_2a59:		sec				; 38 
B0_2a5a:		;removed
	.db $30 $a0

B0_2a5c:		asl $a0			; 06 a0
B0_2a5e:		sty $918d		; 8c 8d 91
B0_2a61:		stx $91, y		; 96 91
B0_2a63:	.db $92
B0_2a64:		sta ($8f), y	; 91 8f
B0_2a66:	.db $92
B0_2a67:		lda ($30), y	; b1 30
B0_2a69:		sta ($03), y	; 91 03
B0_2a6b:	.db $3f
B0_2a6c:		lda #$a5		; a9 a5
B0_2a6e:		sta $8d			; 85 8d
B0_2a70:		sta ($8d), y	; 91 8d
B0_2a72:		and ($af, x)	; 21 af
B0_2a74:		php				; 08 
B0_2a75:		ora ($af, x)	; 01 af
B0_2a77:		php				; 08 
B0_2a78:		.db $00				; 00
B0_2a79:		and ($ac, x)	; 21 ac
B0_2a7b:		php				; 08 
B0_2a7c:		ora ($ac, x)	; 01 ac
B0_2a7e:		php				; 08 
B0_2a7f:		.db $00				; 00
B0_2a80:	.db $04
B0_2a81:		.db $00				; 00
B0_2a82:		cli				; 58 
B0_2a83:		tax				; aa 
B0_2a84:		.db $00				; 00
B0_2a85:		asl a			; 0a
B0_2a86:	.db $03
B0_2a87:		sta ($05, x)	; 81 05
B0_2a89:		rol $8a			; 26 8a
B0_2a8b:		sta ($21), y	; 91 21
B0_2a8d:		ldx $08, y		; b6 08
B0_2a8f:		ora ($b6, x)	; 01 b6
B0_2a91:		php				; 08 
B0_2a92:		.db $00				; 00
B0_2a93:		sta ($8d), y	; 91 8d
B0_2a95:	.db $af
B0_2a96:		lda #$aa		; a9 aa
B0_2a98:		lda $ac			; a5 ac
B0_2a9a:		lda #$aa		; a9 aa
B0_2a9c:		lda $ac21		; ad 21 ac
B0_2a9f:		php				; 08 
B0_2aa0:		ora ($ac, x)	; 01 ac
B0_2aa2:		php				; 08 
B0_2aa3:		.db $00				; 00
B0_2aa4:		and ($a5, x)	; 21 a5
B0_2aa6:		php				; 08 
B0_2aa7:		ora ($a5, x)	; 01 a5
B0_2aa9:		php				; 08 
B0_2aaa:		.db $00				; 00
B0_2aab:	.db $04
B0_2aac:		.db $00				; 00
B0_2aad:		txa				; 8a 
B0_2aae:		tax				; aa 
B0_2aaf:		.db $00				; 00
B0_2ab0:		.db $00				; 00
B0_2ab1:	.db $80
B0_2ab2:		.db $00				; 00
B0_2ab3:	.db $02
B0_2ab4:		eor ($80, x)	; 41 80
B0_2ab6:		.db $00				; 00
B0_2ab7:		ldy #$0a		; a0 0a
B0_2ab9:		ora $01			; 05 01
B0_2abb:		sty $80			; 84 80
B0_2abd:		.db $00				; 00
B0_2abe:	.db $02
B0_2abf:		cpy #$03		; c0 03
B0_2ac1:	.db $3f
B0_2ac2:		ora ($20, x)	; 01 20
B0_2ac4:		sta ($c5, x)	; 81 c5
B0_2ac6:		.db $00				; 00
B0_2ac7:		php				; 08 
B0_2ac8:	.db $02
B0_2ac9:	.db $80
B0_2aca:		ora ($fd, x)	; 01 fd
B0_2acc:	.db $03
B0_2acd:	.db $3f
B0_2ace:	.db $80
B0_2acf:		ora #$03		; 09 03
B0_2ad1:		sec				; 38 
B0_2ad2:		sta ($c5, x)	; 81 c5
B0_2ad4:		.db $00				; 00
B0_2ad5:		php				; 08 
B0_2ad6:	.db $03
B0_2ad7:		and $80, x		; 35 80
B0_2ad9:		ora #$03		; 09 03
B0_2adb:	.db $34
B0_2adc:		sta ($c5, x)	; 81 c5
B0_2ade:		.db $00				; 00
B0_2adf:		php				; 08 
B0_2ae0:	.db $03
B0_2ae1:	.db $34
B0_2ae2:	.db $80
B0_2ae3:		ora #$06		; 09 06
B0_2ae5:	.db $80
B0_2ae6:		asl a			; 0a
B0_2ae7:	.db $02
B0_2ae8:		cpy #$01		; c0 01
B0_2aea:		;removed
	.db $10 $03

B0_2aec:	.db $3f
B0_2aed:	.db $80
B0_2aee:		inc $0400, x	; fe 00 04
B0_2af1:	.db $03
B0_2af2:	.db $3a
B0_2af3:	.db $80
B0_2af4:		asl a			; 0a
B0_2af5:		ora ($f0, x)	; 01 f0
B0_2af7:	.db $80
B0_2af8:		lda #$00		; a9 00
B0_2afa:	.db $03
B0_2afb:	.db $02
B0_2afc:	.db $80
B0_2afd:	.db $80
B0_2afe:		asl $01			; 06 01
B0_2b00:		bmi B0_2a91 ; 30 8f

B0_2b02:	.db $ff
B0_2b03:		.db $00				; 00
B0_2b04:	.db $04
B0_2b05:		ora ($03, x)	; 01 03
B0_2b07:	.db $80
B0_2b08:	.db $04
B0_2b09:		ora ($10, x)	; 01 10
B0_2b0b:	.db $03
B0_2b0c:		rol $80, x		; 36 80
B0_2b0e:		inc $0400, x	; fe 00 04
B0_2b11:	.db $03
B0_2b12:	.db $34
B0_2b13:	.db $80
B0_2b14:	.db $03
B0_2b15:		ora ($f0, x)	; 01 f0
B0_2b17:	.db $80
B0_2b18:		lda #$00		; a9 00
B0_2b1a:	.db $03
B0_2b1b:	.db $80
B0_2b1c:		asl $01			; 06 01
B0_2b1e:		bmi B0_2aaf ; 30 8f

B0_2b20:	.db $ff
B0_2b21:		.db $00				; 00
B0_2b22:		php				; 08 
B0_2b23:		ora ($03, x)	; 01 03
B0_2b25:	.db $80
B0_2b26:		asl $06			; 06 06
B0_2b28:		bcc B0_2b34 ; 90 0a

B0_2b2a:	.db $02
B0_2b2b:		cpy #$03		; c0 03
B0_2b2d:	.db $3f
B0_2b2e:	.db $80
B0_2b2f:		sec				; 38 
B0_2b30:		.db $00				; 00
B0_2b31:	.db $03
B0_2b32:	.db $02
B0_2b33:	.db $80
B0_2b34:	.db $03
B0_2b35:	.db $3f
B0_2b36:	.db $80
B0_2b37:	.db $04
B0_2b38:	.db $02
B0_2b39:		.db $00				; 00
B0_2b3a:	.db $80
B0_2b3b:		sec				; 38 
B0_2b3c:		.db $00				; 00
B0_2b3d:	.db $03
B0_2b3e:	.db $80
B0_2b3f:	.db $04
B0_2b40:	.db $80
B0_2b41:		rol a			; 2a
B0_2b42:		.db $00				; 00
B0_2b43:		asl $80			; 06 80
B0_2b45:	.db $03
B0_2b46:	.db $03
B0_2b47:	.db $3c
B0_2b48:	.db $8f
B0_2b49:	.db $ff
B0_2b4a:		.db $00				; 00
B0_2b4b:		asl $03			; 06 03
B0_2b4d:	.db $3c
B0_2b4e:	.db $80
B0_2b4f:	.db $03
B0_2b50:	.db $03
B0_2b51:	.db $3a
B0_2b52:	.db $8f
B0_2b53:	.db $ff
B0_2b54:		.db $00				; 00
B0_2b55:		asl $03			; 06 03
B0_2b57:	.db $3a
B0_2b58:	.db $8f
B0_2b59:	.db $0f
B0_2b5a:	.db $03
B0_2b5b:		rol $8f, x		; 36 8f
B0_2b5d:	.db $ff
B0_2b5e:		.db $00				; 00
B0_2b5f:		asl $03			; 06 03
B0_2b61:		rol $8f, x		; 36 8f
B0_2b63:	.db $0f
B0_2b64:	.db $03
B0_2b65:	.db $32
B0_2b66:	.db $8f
B0_2b67:	.db $ff
B0_2b68:		.db $00				; 00
B0_2b69:		bpl B0_2b6e ; 10 03

B0_2b6b:	.db $32
B0_2b6c:	.db $8f
B0_2b6d:	.db $0f
B0_2b6e:		asl $70			; 06 70
B0_2b70:		asl a			; 0a
B0_2b71:	.db $02
B0_2b72:		.db $00				; 00
B0_2b73:	.db $03
B0_2b74:	.db $3f
B0_2b75:	.db $80
B0_2b76:		cmp $00, x		; d5 00
B0_2b78:	.db $02
B0_2b79:	.db $02
B0_2b7a:	.db $80
B0_2b7b:	.db $03
B0_2b7c:	.db $3f
B0_2b7d:	.db $80
B0_2b7e:	.db $07
B0_2b7f:	.db $80
B0_2b80:		cmp $00, x		; d5 00
B0_2b82:	.db $04
B0_2b83:	.db $80
B0_2b84:	.db $07
B0_2b85:		ora $02			; 05 02
B0_2b87:		and ($80, x)	; 21 80
B0_2b89:		.db $00				; 00
B0_2b8a:	.db $03
B0_2b8b:		and $ff8f, x	; 3d 8f ff
B0_2b8e:		.db $00				; 00
B0_2b8f:	.db $03
B0_2b90:	.db $03
B0_2b91:		and $0780, x	; 3d 80 07
B0_2b94:	.db $03
B0_2b95:	.db $3c
B0_2b96:	.db $8f
B0_2b97:	.db $ff
B0_2b98:		.db $00				; 00
B0_2b99:	.db $03
B0_2b9a:	.db $03
B0_2b9b:	.db $3c
B0_2b9c:	.db $80
B0_2b9d:	.db $07
B0_2b9e:	.db $03
B0_2b9f:	.db $3a
B0_2ba0:	.db $8f
B0_2ba1:	.db $ff
B0_2ba2:		.db $00				; 00
B0_2ba3:	.db $03
B0_2ba4:	.db $03
B0_2ba5:	.db $3a
B0_2ba6:	.db $8f
B0_2ba7:	.db $0f
B0_2ba8:	.db $03
B0_2ba9:		rol $8f, x		; 36 8f
B0_2bab:	.db $ff
B0_2bac:		.db $00				; 00
B0_2bad:	.db $03
B0_2bae:	.db $03
B0_2baf:		rol $8f, x		; 36 8f
B0_2bb1:	.db $0f
B0_2bb2:	.db $03
B0_2bb3:	.db $3a
B0_2bb4:	.db $80
B0_2bb5:		cmp $00, x		; d5 00
B0_2bb7:	.db $03
B0_2bb8:	.db $03
B0_2bb9:	.db $3a
B0_2bba:	.db $80
B0_2bbb:	.db $07
B0_2bbc:	.db $03
B0_2bbd:		rol $8f, x		; 36 8f
B0_2bbf:	.db $ff
B0_2bc0:		.db $00				; 00
B0_2bc1:	.db $03
B0_2bc2:	.db $03
B0_2bc3:		rol $80, x		; 36 80
B0_2bc5:	.db $07
B0_2bc6:	.db $03
B0_2bc7:	.db $34
B0_2bc8:	.db $8f
B0_2bc9:	.db $ff
B0_2bca:		.db $00				; 00
B0_2bcb:	.db $03
B0_2bcc:	.db $03
B0_2bcd:	.db $34
B0_2bce:	.db $8f
B0_2bcf:	.db $0f
B0_2bd0:	.db $03
B0_2bd1:	.db $33
B0_2bd2:	.db $8f
B0_2bd3:	.db $ff
B0_2bd4:		.db $00				; 00
B0_2bd5:	.db $03
B0_2bd6:	.db $03
B0_2bd7:	.db $33
B0_2bd8:	.db $8f
B0_2bd9:	.db $0f
B0_2bda:	.db $03
B0_2bdb:		and ($8f), y	; 31 8f
B0_2bdd:	.db $ff
B0_2bde:		.db $00				; 00
B0_2bdf:	.db $12
B0_2be0:	.db $03
B0_2be1:		and ($8f), y	; 31 8f
B0_2be3:	.db $0f
B0_2be4:		.db $06


sndPressStartAtMenu:
	.db $a0 $0b
	.db $02 $00 $01 $30 $03 $3f $82 $3b
	.db $02 $00 $01 $30 $03 $3f $81 $45
	.db $00 $0b $02 $80 $03 $3c $80 $09
	.db $01 $00 $80 $50 $03 $3b $01 $00
	.db $80 $5a $00 $02 $03 $3f $80 $09
	.db $05 $02 $21 $80 $00 $03 $3c $8f
	.db $ff $05 $02 $21 $80 $00 $03 $38
	.db $8f $ff $00 $02 $03 $3c $80 $09
	.db $03 $38 $8f $ff $03 $35 $8f $ff
	.db $00 $02 $03 $38 $80 $08 $03 $35
	.db $8f $ff $03 $34 $8f $ff $00 $02
	.db $03 $35 $8f $0f $03 $33 $8f $ff
	.db $03 $32 $8f $ff $00 $02 $03 $32
	.db $8f $0f $02 $00 $01 $30 $03 $36
	.db $82 $3b $02 $00 $01 $30 $03 $36
	.db $81 $45 $00 $0b $02 $80 $03 $34
	.db $80 $09 $03 $36 $01 $00 $80 $50
	.db $03 $34 $01 $00 $80 $5a $00 $02
	.db $03 $36 $80 $09 $05 $02 $21 $80
	.db $00 $03 $34 $8f $ff $05 $02 $21
	.db $80 $00 $03 $33 $8f $ff $00 $02
	.db $03 $34 $80 $09 $03 $33 $8f $ff
	.db $03 $33 $8f $ff $00 $02 $03 $33
	.db $80 $08 $03 $32 $8f $ff $03 $32
	.db $8f $ff $00 $02 $03 $32 $8f $0f
	.db $03 $31 $8f $ff $03 $31 $8f $ff
	.db $00 $02 $03 $31 $8f $0f $06


data_0_2cbe:
.db $c0
B0_2cbf:		php				; 08 
B0_2cc0:		.db $00				; 00
B0_2cc1:	.db $03
B0_2cc2:		ora ($01, x)	; 01 01
B0_2cc4:	.db $03
B0_2cc5:	.db $3f
B0_2cc6:	.db $80
B0_2cc7:		asl a			; 0a
B0_2cc8:		.db $00				; 00
B0_2cc9:		ora $03			; 05 03
B0_2ccb:		and $80, x		; 35 80
B0_2ccd:		asl a			; 0a
B0_2cce:		.db $00				; 00
B0_2ccf:	.db $07
B0_2cd0:	.db $03
B0_2cd1:		.db $30 $80

B0_2cd3:		.db $00				; 00
B0_2cd4:	.db $04
B0_2cd5:	.db $03
B0_2cd6:		cpy #$ac		; c0 ac
B0_2cd8:		asl $f0			; 06 f0
B0_2cda:	.db $03
B0_2cdb:	.db $02
B0_2cdc:		cpy #$03		; c0 03
B0_2cde:	.db $3f
B0_2cdf:	.db $80
B0_2ce0:		cmp $00, x		; d5 00
B0_2ce2:	.db $04
B0_2ce3:	.db $02
B0_2ce4:		cpy #$03		; c0 03
B0_2ce6:		.db $30 $80

B0_2ce8:		ror a			; 6a
B0_2ce9:	.db $80
B0_2cea:		adc ($00), y	; 71 00
B0_2cec:	.db $04
B0_2ced:	.db $03
B0_2cee:	.db $3a
B0_2cef:	.db $80
B0_2cf0:		ror a			; 6a
B0_2cf1:	.db $8f
B0_2cf2:	.db $ff
B0_2cf3:		.db $00				; 00
B0_2cf4:	.db $04
B0_2cf5:	.db $80
B0_2cf6:		adc ($8f), y	; 71 8f
B0_2cf8:	.db $ff
B0_2cf9:		.db $00				; 00
B0_2cfa:	.db $04
B0_2cfb:	.db $8f
B0_2cfc:	.db $ff
B0_2cfd:	.db $03
B0_2cfe:		sec				; 38 
B0_2cff:	.db $80
B0_2d00:		cmp $00, x		; d5 00
B0_2d02:	.db $04
B0_2d03:	.db $03
B0_2d04:		.db $30 $80

B0_2d06:		ror a			; 6a
B0_2d07:	.db $80
B0_2d08:		adc ($00), y	; 71 00
B0_2d0a:	.db $04
B0_2d0b:	.db $03
B0_2d0c:		and $80, x		; 35 80
B0_2d0e:		ror a			; 6a
B0_2d0f:	.db $8f
B0_2d10:	.db $ff
B0_2d11:		.db $00				; 00
B0_2d12:	.db $04
B0_2d13:	.db $80
B0_2d14:		adc ($8f), y	; 71 8f
B0_2d16:	.db $ff
B0_2d17:		.db $00				; 00
B0_2d18:	.db $04
B0_2d19:	.db $8f
B0_2d1a:	.db $ff
B0_2d1b:		asl $f0			; 06 f0
B0_2d1d:	.db $03
B0_2d1e:	.db $02
B0_2d1f:		cpy #$05		; c0 05
B0_2d21:		.db $00				; 00
B0_2d22:		.db $00				; 00
B0_2d23:	.db $82
B0_2d24:	.db $0f
B0_2d25:	.db $03
B0_2d26:	.db $3f
B0_2d27:	.db $80
B0_2d28:	.db $e2
B0_2d29:		.db $00				; 00
B0_2d2a:		php				; 08 
B0_2d2b:		ora $00			; 05 00
B0_2d2d:		.db $00				; 00
B0_2d2e:	.db $82
B0_2d2f:	.db $0f
B0_2d30:	.db $02
B0_2d31:		cpy #$03		; c0 03
B0_2d33:	.db $3f
B0_2d34:	.db $80
B0_2d35:	.db $82
B0_2d36:	.db $03
B0_2d37:	.db $34
B0_2d38:	.db $80
B0_2d39:	.db $e2
B0_2d3a:		.db $00				; 00
B0_2d3b:		php				; 08 
B0_2d3c:	.db $03
B0_2d3d:	.db $34
B0_2d3e:	.db $80
B0_2d3f:	.db $82
B0_2d40:		asl $b0			; 06 b0
B0_2d42:	.db $03
B0_2d43:	.db $02
B0_2d44:	.db $80
B0_2d45:		ora ($01, x)	; 01 01
B0_2d47:	.db $03
B0_2d48:	.db $3f
B0_2d49:	.db $80
B0_2d4a:		ror a			; 6a
B0_2d4b:		.db $00				; 00
B0_2d4c:		php				; 08 
B0_2d4d:	.db $02
B0_2d4e:	.db $80
B0_2d4f:	.db $03
B0_2d50:		;removed
	.db $30 $80

B0_2d52:		.db $00				; 00
B0_2d53:	.db $8f
B0_2d54:	.db $ff
B0_2d55:		.db $00				; 00
B0_2d56:		php				; 08 
B0_2d57:	.db $03
B0_2d58:		sec				; 38 
B0_2d59:		ora ($01, x)	; 01 01
B0_2d5b:	.db $80
B0_2d5c:		ror a			; 6a
B0_2d5d:	.db $03
B0_2d5e:		and $ff8f, x	; 3d 8f ff
B0_2d61:		.db $00				; 00
B0_2d62:	.db $0c
B0_2d63:	.db $03
B0_2d64:	.db $37
B0_2d65:	.db $8f
B0_2d66:	.db $ff
B0_2d67:	.db $03
B0_2d68:	.db $3b
B0_2d69:	.db $8f
B0_2d6a:	.db $ff
B0_2d6b:		.db $00				; 00
B0_2d6c:	.db $0c
B0_2d6d:	.db $03
B0_2d6e:		rol $8f, x		; 36 8f
B0_2d70:	.db $ff
B0_2d71:	.db $03
B0_2d72:		and $ff8f, y	; 39 8f ff
B0_2d75:		.db $00				; 00
B0_2d76:	.db $0c
B0_2d77:	.db $03
B0_2d78:		and $8f, x		; 35 8f
B0_2d7a:	.db $ff
B0_2d7b:	.db $03
B0_2d7c:	.db $37
B0_2d7d:	.db $8f
B0_2d7e:	.db $ff
B0_2d7f:		.db $00				; 00
B0_2d80:	.db $0c
B0_2d81:	.db $03
B0_2d82:	.db $34
B0_2d83:	.db $8f
B0_2d84:	.db $ff
B0_2d85:	.db $03
B0_2d86:		rol $8f, x		; 36 8f
B0_2d88:	.db $ff
B0_2d89:		.db $00				; 00
B0_2d8a:	.db $0c
B0_2d8b:	.db $03
B0_2d8c:	.db $33
B0_2d8d:	.db $8f
B0_2d8e:	.db $ff
B0_2d8f:	.db $03
B0_2d90:	.db $33
B0_2d91:	.db $8f
B0_2d92:	.db $ff
B0_2d93:		.db $00				; 00
B0_2d94:	.db $0c
B0_2d95:	.db $03
B0_2d96:	.db $32
B0_2d97:	.db $8f
B0_2d98:	.db $ff
B0_2d99:	.db $03
B0_2d9a:		;removed
	.db $30 $80

B0_2d9c:		.db $00				; 00
B0_2d9d:		.db $00				; 00
B0_2d9e:		php				; 08 
B0_2d9f:	.db $03
B0_2da0:		and ($8f), y	; 31 8f
B0_2da2:	.db $ff
B0_2da3:		asl $90			; 06 90
B0_2da5:	.db $0f
B0_2da6:		ora $02			; 05 02
B0_2da8:		and ($81, x)	; 21 81
B0_2daa:	.db $03
B0_2dab:	.db $02
B0_2dac:		cpy #$01		; c0 01
B0_2dae:		bmi B0_2db3 ; 30 03

B0_2db0:	.db $3f
B0_2db1:	.db $80
B0_2db2:		ror a			; 6a
B0_2db3:		ora $02			; 05 02
B0_2db5:		and ($81, x)	; 21 81
B0_2db7:	.db $03
B0_2db8:	.db $02
B0_2db9:		cpy #$01		; c0 01
B0_2dbb:		bmi B0_2dc0 ; 30 03

B0_2dbd:	.db $3f
B0_2dbe:		sta ($a5, x)	; 81 a5
B0_2dc0:		ora $02			; 05 02
B0_2dc2:		and ($81, x)	; 21 81
B0_2dc4:	.db $03
B0_2dc5:	.db $03
B0_2dc6:		sta ($01, x)	; 81 01
B0_2dc8:		bmi B0_2d4a ; 30 80

B0_2dca:		lda #$00		; a9 00
B0_2dcc:		ora $03			; 05 03
B0_2dce:	.db $3f
B0_2dcf:	.db $80
B0_2dd0:		asl $0105		; 0e 05 01
B0_2dd3:	.db $43
B0_2dd4:		ora ($08, x)	; 01 08
B0_2dd6:		ora ($03, x)	; 01 03
B0_2dd8:	.db $80
B0_2dd9:	.db $47
B0_2dda:		ora $01			; 05 01
B0_2ddc:	.db $43
B0_2ddd:		ora ($08, x)	; 01 08
B0_2ddf:		ora ($03, x)	; 01 03
B0_2de1:	.db $80
B0_2de2:		ldx $01, y		; b6 01
B0_2de4:	.db $03
B0_2de5:	.db $80
B0_2de6:		stx $1000		; 8e 00 10
B0_2de9:		ora $00			; 05 00
B0_2deb:		ora ($01, x)	; 01 01
B0_2ded:	.db $0f
B0_2dee:	.db $80
B0_2def:	.db $07
B0_2df0:		ora $02			; 05 02
B0_2df2:		and ($81, x)	; 21 81
B0_2df4:	.db $03
B0_2df5:		ora ($30, x)	; 01 30
B0_2df7:	.db $03
B0_2df8:	.db $37
B0_2df9:	.db $80
B0_2dfa:		ror a			; 6a
B0_2dfb:		ora $02			; 05 02
B0_2dfd:		and ($81, x)	; 21 81
B0_2dff:	.db $03
B0_2e00:		ora ($30, x)	; 01 30
B0_2e02:	.db $03
B0_2e03:	.db $37
B0_2e04:		sta ($a5, x)	; 81 a5
B0_2e06:		ora ($30, x)	; 01 30
B0_2e08:	.db $80
B0_2e09:		lda #$00		; a9 00
B0_2e0b:		ora $03			; 05 03
B0_2e0d:		sec				; 38 
B0_2e0e:	.db $80
B0_2e0f:		asl $0105		; 0e 05 01
B0_2e12:	.db $43
B0_2e13:		ora ($0f, x)	; 01 0f
B0_2e15:		ora ($03, x)	; 01 03
B0_2e17:	.db $80
B0_2e18:	.db $47
B0_2e19:		ora $01			; 05 01
B0_2e1b:	.db $43
B0_2e1c:		ora ($0f, x)	; 01 0f
B0_2e1e:		ora ($03, x)	; 01 03
B0_2e20:	.db $80
B0_2e21:		ldx $01, y		; b6 01
B0_2e23:	.db $03
B0_2e24:	.db $80
B0_2e25:		stx $1a00		; 8e 00 1a
B0_2e28:		ora $00			; 05 00
B0_2e2a:		ora ($01, x)	; 01 01
B0_2e2c:	.db $0f
B0_2e2d:	.db $03
B0_2e2e:	.db $37
B0_2e2f:	.db $80
B0_2e30:	.db $07
B0_2e31:		asl $d0			; 06 d0
B0_2e33:	.db $0f
B0_2e34:	.db $02
B0_2e35:	.db $80
B0_2e36:	.db $03
B0_2e37:	.db $3f
B0_2e38:	.db $80
B0_2e39:		stx $8002		; 8e 02 80
B0_2e3c:	.db $03
B0_2e3d:		;removed
	.db $30 $80

B0_2e3f:		.db $00				; 00
B0_2e40:		.db $00				; 00
B0_2e41:		ora $03			; 05 03
B0_2e43:		sta ($81, x)	; 81 81
B0_2e45:		ora $8002, x	; 1d 02 80
B0_2e48:		ora $00			; 05 00
B0_2e4a:		.db $00				; 00
B0_2e4b:		ora ($04, x)	; 01 04
B0_2e4d:	.db $03
B0_2e4e:	.db $3a
B0_2e4f:	.db $80
B0_2e50:		ora $03			; 05 03
B0_2e52:	.db $3f
B0_2e53:	.db $80
B0_2e54:		stx $80			; 86 80
B0_2e56:		.db $00				; 00
B0_2e57:		sta ($0d, x)	; 81 0d
B0_2e59:		.db $00				; 00
B0_2e5a:		ora $03			; 05 03
B0_2e5c:		and $0580, y	; 39 80 05
B0_2e5f:	.db $80
B0_2e60:	.db $5f
B0_2e61:	.db $03
B0_2e62:		sec				; 38 
B0_2e63:	.db $80
B0_2e64:		stx $be80		; 8e 80 be
B0_2e67:		.db $00				; 00
B0_2e68:		ora $03			; 05 03
B0_2e6a:		sec				; 38 
B0_2e6b:	.db $80
B0_2e6c:		ora $80			; 05 80
B0_2e6e:		eor $8680, y	; 59 80 86
B0_2e71:	.db $80
B0_2e72:	.db $b3
B0_2e73:		.db $00				; 00
B0_2e74:		ora $03			; 05 03
B0_2e76:	.db $37
B0_2e77:	.db $80
B0_2e78:		ora $80			; 05 80
B0_2e7a:	.db $43
B0_2e7b:	.db $80
B0_2e7c:	.db $5f
B0_2e7d:	.db $80
B0_2e7e:		stx $00			; 86 00
B0_2e80:		ora $03			; 05 03
B0_2e82:		rol $80, x		; 36 80
B0_2e84:		ora $80			; 05 80
B0_2e86:	.db $47
B0_2e87:	.db $80
B0_2e88:		eor $8e80, y	; 59 80 8e
B0_2e8b:		.db $00				; 00
B0_2e8c:		ora $03			; 05 03
B0_2e8e:		and $80, x		; 35 80
B0_2e90:		ora $80			; 05 80
B0_2e92:	.db $3c
B0_2e93:	.db $80
B0_2e94:	.db $43
B0_2e95:	.db $80
B0_2e96:		sei				; 78 
B0_2e97:		.db $00				; 00
B0_2e98:		ora $03			; 05 03
B0_2e9a:	.db $34
B0_2e9b:	.db $80
B0_2e9c:		ora $80			; 05 80
B0_2e9e:	.db $3f
B0_2e9f:	.db $80
B0_2ea0:	.db $47
B0_2ea1:	.db $80
B0_2ea2:	.db $7f
B0_2ea3:		.db $00				; 00
B0_2ea4:		ora $03			; 05 03
B0_2ea6:	.db $33
B0_2ea7:	.db $80
B0_2ea8:		ora $03			; 05 03
B0_2eaa:	.db $3c
B0_2eab:	.db $80
B0_2eac:	.db $3f
B0_2ead:	.db $03
B0_2eae:		and $80, x		; 35 80
B0_2eb0:	.db $3c
B0_2eb1:	.db $03
B0_2eb2:		.db $00				; 00
B0_2eb3:	.db $80
B0_2eb4:		.db $00				; 00
B0_2eb5:		.db $00				; 00
B0_2eb6:		ora $03			; 05 03
B0_2eb8:	.db $33
B0_2eb9:	.db $80
B0_2eba:		ora $03			; 05 03
B0_2ebc:		and $3f80, y	; 39 80 3f
B0_2ebf:	.db $03
B0_2ec0:		and $80, x		; 35 80
B0_2ec2:	.db $3f
B0_2ec3:	.db $03
B0_2ec4:		.db $00				; 00
B0_2ec5:	.db $80
B0_2ec6:		.db $00				; 00
B0_2ec7:		.db $00				; 00
B0_2ec8:		php				; 08 
B0_2ec9:	.db $03
B0_2eca:	.db $33
B0_2ecb:	.db $80
B0_2ecc:		ora $03			; 05 03
B0_2ece:		rol $80, x		; 36 80
B0_2ed0:	.db $3f
B0_2ed1:	.db $03
B0_2ed2:	.db $33
B0_2ed3:	.db $80
B0_2ed4:	.db $3f
B0_2ed5:	.db $80
B0_2ed6:		.db $00				; 00
B0_2ed7:		.db $00				; 00
B0_2ed8:		php				; 08 
B0_2ed9:	.db $03
B0_2eda:	.db $32
B0_2edb:	.db $80
B0_2edc:		ora $03			; 05 03
B0_2ede:	.db $33
B0_2edf:	.db $80
B0_2ee0:	.db $3f
B0_2ee1:	.db $80
B0_2ee2:	.db $3f
B0_2ee3:	.db $80
B0_2ee4:		.db $00				; 00
B0_2ee5:		.db $00				; 00
B0_2ee6:		php				; 08 
B0_2ee7:	.db $03
B0_2ee8:	.db $32
B0_2ee9:	.db $80
B0_2eea:		ora $03			; 05 03
B0_2eec:		and ($80), y	; 31 80
B0_2eee:	.db $3f
B0_2eef:	.db $03
B0_2ef0:		and ($80), y	; 31 80
B0_2ef2:	.db $3f
B0_2ef3:	.db $80
B0_2ef4:		.db $00				; 00
B0_2ef5:		.db $00				; 00
B0_2ef6:		php				; 08 
B0_2ef7:	.db $03
B0_2ef8:		and ($80), y	; 31 80
B0_2efa:		ora $06			; 05 06
B0_2efc:		bne B0_2f08 ; d0 0a

B0_2efe:	.db $02
B0_2eff:	.db $80
B0_2f00:	.db $03
B0_2f01:	.db $3f
B0_2f02:	.db $80
B0_2f03:		stx $0500		; 8e 00 05
B0_2f06:	.db $02
B0_2f07:	.db $80
B0_2f08:		ora $00			; 05 00
B0_2f0a:		.db $00				; 00
B0_2f0b:		ora ($04, x)	; 01 04
B0_2f0d:	.db $03
B0_2f0e:	.db $3f
B0_2f0f:	.db $80
B0_2f10:		ora $05			; 05 05
B0_2f12:		.db $00				; 00
B0_2f13:		.db $00				; 00
B0_2f14:		ora ($04, x)	; 01 04
B0_2f16:		ora ($01, x)	; 01 01
B0_2f18:	.db $80
B0_2f19:		stx $00			; 86 00
B0_2f1b:	.db $20 $05 $00
B0_2f1e:		.db $00				; 00
B0_2f1f:		php				; 08 
B0_2f20:		php				; 08 
B0_2f21:		ora ($01, x)	; 01 01
B0_2f23:	.db $80
B0_2f24:		php				; 08 
B0_2f25:		asl $c0			; 06 c0
B0_2f27:	.db $02
B0_2f28:		.db $00				; 00
B0_2f29:		php				; 08 
B0_2f2a:		ora $00			; 05 00
B0_2f2c:		.db $00				; 00
B0_2f2d:	.db $80
B0_2f2e:		.db $00				; 00
B0_2f2f:	.db $02
B0_2f30:	.db $80
B0_2f31:	.db $03
B0_2f32:	.db $3f
B0_2f33:	.db $80
B0_2f34:	.db $7f
B0_2f35:		.db $00				; 00
B0_2f36:		php				; 08 
B0_2f37:	.db $80
B0_2f38:		adc ($00), y	; 71 00
B0_2f3a:		php				; 08 
B0_2f3b:	.db $80
B0_2f3c:	.db $5f
B0_2f3d:		.db $00				; 00
B0_2f3e:		php				; 08 
B0_2f3f:	.db $80
B0_2f40:	.db $54
B0_2f41:		.db $00				; 00
B0_2f42:		php				; 08 
B0_2f43:	.db $80
B0_2f44:	.db $5f
B0_2f45:		.db $00				; 00
B0_2f46:		php				; 08 
B0_2f47:	.db $80
B0_2f48:	.db $54
B0_2f49:		ora $02			; 05 02
B0_2f4b:		and ($80, x)	; 21 80
B0_2f4d:		.db $00				; 00
B0_2f4e:		.db $00				; 00
B0_2f4f:	.db $22
B0_2f50:	.db $80
B0_2f51:	.db $3f
B0_2f52:	.db $04
B0_2f53:	.db $02
B0_2f54:		plp				; 28 
B0_2f55:	.db $af
B0_2f56:		asl $60			; 06 60
B0_2f58:		php				; 08 
B0_2f59:		.db $00				; 00
B0_2f5a:	.db $03
B0_2f5b:		ora ($01, x)	; 01 01
B0_2f5d:	.db $03
B0_2f5e:	.db $3f
B0_2f5f:	.db $80
B0_2f60:	.db $03
B0_2f61:		.db $00				; 00
B0_2f62:		ora $05			; 05 05
B0_2f64:		.db $00				; 00
B0_2f65:		.db $00				; 00
B0_2f66:	.db $82
B0_2f67:	.db $07
B0_2f68:	.db $03
B0_2f69:	.db $3c
B0_2f6a:	.db $80
B0_2f6b:		ora ($06, x)	; 01 06
B0_2f6d:		cpy #$0e		; c0 0e
B0_2f6f:		ora $01			; 05 01
B0_2f71:	.db $64
B0_2f72:	.db $80
B0_2f73:		.db $00				; 00
B0_2f74:	.db $02
B0_2f75:		cpy #$03		; c0 03
B0_2f77:	.db $3f
B0_2f78:		ora ($db, x)	; 01 db
B0_2f7a:		sta ($c5, x)	; 81 c5
B0_2f7c:		ora $01			; 05 01
B0_2f7e:	.db $64
B0_2f7f:	.db $80
B0_2f80:		.db $00				; 00
B0_2f81:	.db $03
B0_2f82:		sta ($01, x)	; 81 01
B0_2f84:		dec $e280, x	; de 80 e2
B0_2f87:		.db $00				; 00
B0_2f88:		asl $01			; 06 01
B0_2f8a:		inc $3a03, x	; fe 03 3a
B0_2f8d:	.db $80
B0_2f8e:		ora $01			; 05 01
B0_2f90:		and $8f			; 25 8f
B0_2f92:	.db $ff
B0_2f93:		ora ($22, x)	; 01 22
B0_2f95:	.db $80
B0_2f96:	.db $e2
B0_2f97:		.db $00				; 00
B0_2f98:		asl $01			; 06 01
B0_2f9a:	.db $02
B0_2f9b:	.db $03
B0_2f9c:	.db $3f
B0_2f9d:	.db $8f
B0_2f9e:	.db $0f
B0_2f9f:	.db $04
B0_2fa0:	.db $07
B0_2fa1:	.db $6f
B0_2fa2:	.db $af
B0_2fa3:	.db $03
B0_2fa4:		and $db01, x	; 3d 01 db
B0_2fa7:		sta ($c5, x)	; 81 c5
B0_2fa9:	.db $03
B0_2faa:		.db $00				; 00
B0_2fab:		ora ($00, x)	; 01 00
B0_2fad:	.db $80
B0_2fae:		.db $00				; 00
B0_2faf:		.db $00				; 00
B0_2fb0:		php				; 08 
B0_2fb1:		ora ($fe, x)	; 01 fe
B0_2fb3:	.db $03
B0_2fb4:		and $0580, x	; 3d 80 05
B0_2fb7:	.db $03
B0_2fb8:	.db $3a
B0_2fb9:		sta ($c5, x)	; 81 c5
B0_2fbb:	.db $80
B0_2fbc:		.db $00				; 00
B0_2fbd:		.db $00				; 00
B0_2fbe:		php				; 08 
B0_2fbf:		ora ($fe, x)	; 01 fe
B0_2fc1:	.db $03
B0_2fc2:	.db $3a
B0_2fc3:	.db $80
B0_2fc4:		ora $03			; 05 03
B0_2fc6:	.db $37
B0_2fc7:		sta ($c5, x)	; 81 c5
B0_2fc9:	.db $80
B0_2fca:		.db $00				; 00
B0_2fcb:		.db $00				; 00
B0_2fcc:		php				; 08 
B0_2fcd:	.db $03
B0_2fce:	.db $37
B0_2fcf:	.db $80
B0_2fd0:		ora $03			; 05 03
B0_2fd2:	.db $33
B0_2fd3:		sta ($c5, x)	; 81 c5
B0_2fd5:	.db $80
B0_2fd6:		.db $00				; 00
B0_2fd7:		.db $00				; 00
B0_2fd8:		php				; 08 
B0_2fd9:	.db $03
B0_2fda:	.db $33
B0_2fdb:	.db $80
B0_2fdc:		ora $06			; 05 06
B0_2fde:		bne B0_2feb ; d0 0b

B0_2fe0:	.db $03
B0_2fe1:		and $1001, x	; 3d 01 10
B0_2fe4:	.db $80
B0_2fe5:		sec				; 38 
B0_2fe6:	.db $03
B0_2fe7:		and $1001, x	; 3d 01 10
B0_2fea:	.db $80
B0_2feb:	.db $7f
B0_2fec:		.db $00				; 00
B0_2fed:		ora #$05		; 09 05
B0_2fef:		.db $00				; 00
B0_2ff0:		.db $00				; 00
B0_2ff1:	.db $8f
B0_2ff2:	.db $02
B0_2ff3:	.db $03
B0_2ff4:	.db $3f
B0_2ff5:	.db $80
B0_2ff6:	.db $0c
B0_2ff7:		ora $02			; 05 02
B0_2ff9:	.db $42
B0_2ffa:	.db $8f
B0_2ffb:	.db $03
B0_2ffc:	.db $03
B0_2ffd:	.db $3a
B0_2ffe:	.db $80
B0_2fff:	.db $47
B0_3000:		ora $02			; 05 02
B0_3002:		sta $8f			; 85 8f
B0_3004:	.db $03
B0_3005:	.db $03
B0_3006:	.db $3a
B0_3007:		sta ($40, x)	; 81 40
B0_3009:		.db $00				; 00
B0_300a:		adc $05			; 65 05
B0_300c:		.db $00				; 00
B0_300d:		.db $00				; 00
B0_300e:	.db $8f
B0_300f:	.db $03
B0_3010:	.db $80
B0_3011:	.db $0c
B0_3012:		asl $d0			; 06 d0
B0_3014:		php				; 08 
B0_3015:		.db $00				; 00
B0_3016:		ora #$05		; 09 05
B0_3018:		.db $00				; 00
B0_3019:		.db $00				; 00
B0_301a:	.db $80
B0_301b:		ora $01			; 05 01
B0_301d:		ora ($03, x)	; 01 03
B0_301f:	.db $3f
B0_3020:	.db $80
B0_3021:		php				; 08 
B0_3022:		.db $00				; 00
B0_3023:		;removed
	.db $50 $05

B0_3025:		.db $00				; 00
B0_3026:		.db $00				; 00
B0_3027:		dey				; 88 
B0_3028:	.db $02
B0_3029:		ora ($00, x)	; 01 00
B0_302b:	.db $80
B0_302c:	.db $0b
B0_302d:		asl $d0			; 06 d0
B0_302f:		asl a			; 0a
B0_3030:		ora $01			; 05 01
B0_3032:		and ($80, x)	; 21 80
B0_3034:		ora ($02, x)	; 01 02
B0_3036:	.db $80
B0_3037:		ora ($ff, x)	; 01 ff
B0_3039:	.db $03
B0_303a:	.db $32
B0_303b:	.db $80
B0_303c:	.db $5f
B0_303d:		.db $00				; 00
B0_303e:		asl $03			; 06 03
B0_3040:	.db $32
B0_3041:	.db $80
B0_3042:		ora $03			; 05 03
B0_3044:	.db $34
B0_3045:	.db $8f
B0_3046:	.db $ff
B0_3047:		.db $00				; 00
B0_3048:		asl $03			; 06 03
B0_304a:	.db $34
B0_304b:	.db $8f
B0_304c:	.db $0f
B0_304d:	.db $03
B0_304e:		rol $8f, x		; 36 8f
B0_3050:	.db $ff
B0_3051:		.db $00				; 00
B0_3052:		asl $03			; 06 03
B0_3054:		rol $8f, x		; 36 8f
B0_3056:	.db $0f
B0_3057:	.db $03
B0_3058:		sec				; 38 
B0_3059:	.db $8f
B0_305a:	.db $ff
B0_305b:		.db $00				; 00
B0_305c:		asl $03			; 06 03
B0_305e:		sec				; 38 
B0_305f:	.db $8f
B0_3060:	.db $0f
B0_3061:	.db $03
B0_3062:	.db $3a
B0_3063:	.db $8f
B0_3064:	.db $ff
B0_3065:		.db $00				; 00
B0_3066:		asl $03			; 06 03
B0_3068:	.db $3a
B0_3069:	.db $8f
B0_306a:	.db $0f
B0_306b:	.db $03
B0_306c:	.db $3c
B0_306d:	.db $8f
B0_306e:	.db $ff
B0_306f:		.db $00				; 00
B0_3070:		asl $03			; 06 03
B0_3072:	.db $3c
B0_3073:	.db $8f
B0_3074:	.db $0f
B0_3075:	.db $03
B0_3076:		rol $ff8f, x	; 3e 8f ff
B0_3079:		.db $00				; 00
B0_307a:		asl $03			; 06 03
B0_307c:		rol $0f8f, x	; 3e 8f 0f
B0_307f:	.db $03
B0_3080:	.db $3f
B0_3081:		ora ($00, x)	; 01 00
B0_3083:	.db $8f
B0_3084:	.db $ff
B0_3085:		.db $00				; 00
B0_3086:	.db $0f
B0_3087:	.db $03
B0_3088:	.db $3f
B0_3089:	.db $8f
B0_308a:	.db $0f
B0_308b:		ora $01			; 05 01
B0_308d:		and ($80, x)	; 21 80
B0_308f:	.db $02
B0_3090:		ora ($01, x)	; 01 01
B0_3092:	.db $03
B0_3093:	.db $3f
B0_3094:	.db $8f
B0_3095:	.db $ff
B0_3096:		.db $00				; 00
B0_3097:		asl $05, x		; 16 05
B0_3099:		ora ($21, x)	; 01 21
B0_309b:	.db $80
B0_309c:	.db $02
B0_309d:	.db $03
B0_309e:	.db $3f
B0_309f:	.db $8f
B0_30a0:	.db $0f
B0_30a1:		ora ($ff, x)	; 01 ff
B0_30a3:	.db $03
B0_30a4:		rol $80, x		; 36 80
B0_30a6:		bvc B0_30a8 ; 50 00

B0_30a8:		asl $03			; 06 03
B0_30aa:	.db $3f
B0_30ab:	.db $8f
B0_30ac:	.db $0f
B0_30ad:	.db $03
B0_30ae:	.db $34
B0_30af:	.db $8f
B0_30b0:	.db $ff
B0_30b1:		.db $00				; 00
B0_30b2:		asl $03			; 06 03
B0_30b4:	.db $34
B0_30b5:	.db $8f
B0_30b6:	.db $0f
B0_30b7:	.db $03
B0_30b8:		rol $8f, x		; 36 8f
B0_30ba:	.db $ff
B0_30bb:		.db $00				; 00
B0_30bc:		asl $03			; 06 03
B0_30be:		rol $8f, x		; 36 8f
B0_30c0:	.db $0f
B0_30c1:	.db $03
B0_30c2:		sec				; 38 
B0_30c3:	.db $8f
B0_30c4:	.db $ff
B0_30c5:		.db $00				; 00
B0_30c6:		asl $03			; 06 03
B0_30c8:		sec				; 38 
B0_30c9:	.db $8f
B0_30ca:	.db $0f
B0_30cb:	.db $03
B0_30cc:		and $ff8f, y	; 39 8f ff
B0_30cf:		.db $00				; 00
B0_30d0:		asl $03			; 06 03
B0_30d2:	.db $3a
B0_30d3:	.db $8f
B0_30d4:	.db $0f
B0_30d5:	.db $03
B0_30d6:	.db $3a
B0_30d7:	.db $8f
B0_30d8:	.db $ff
B0_30d9:		.db $00				; 00
B0_30da:		asl $03			; 06 03
B0_30dc:	.db $3c
B0_30dd:	.db $8f
B0_30de:	.db $0f
B0_30df:	.db $03
B0_30e0:	.db $3b
B0_30e1:	.db $8f
B0_30e2:	.db $ff
B0_30e3:		.db $00				; 00
B0_30e4:		asl $03			; 06 03
B0_30e6:		rol $0f8f, x	; 3e 8f 0f
B0_30e9:	.db $03
B0_30ea:	.db $3c
B0_30eb:		ora ($00, x)	; 01 00
B0_30ed:	.db $8f
B0_30ee:	.db $ff
B0_30ef:		.db $00				; 00
B0_30f0:	.db $0f
B0_30f1:	.db $03
B0_30f2:	.db $3f
B0_30f3:	.db $8f
B0_30f4:	.db $0f
B0_30f5:		ora $01			; 05 01
B0_30f7:		and ($80, x)	; 21 80
B0_30f9:	.db $02
B0_30fa:		ora ($01, x)	; 01 01
B0_30fc:	.db $03
B0_30fd:		and $ff8f, x	; 3d 8f ff
B0_3100:		.db $00				; 00
B0_3101:		adc $05			; 65 05
B0_3103:		ora ($21, x)	; 01 21
B0_3105:	.db $80
B0_3106:	.db $02
B0_3107:	.db $03
B0_3108:		and $0f8f, x	; 3d 8f 0f
B0_310b:		asl $d0			; 06 d0
B0_310d:	.db $0f
B0_310e:	.db $02
B0_310f:	.db $80
B0_3110:		ora ($20, x)	; 01 20
B0_3112:	.db $03
B0_3113:	.db $3c
B0_3114:	.db $80
B0_3115:		and $02, x		; 35 02
B0_3117:	.db $80
B0_3118:		ora ($40, x)	; 01 40
B0_311a:	.db $03
B0_311b:	.db $3f
B0_311c:		sta ($c5, x)	; 81 c5
B0_311e:	.db $03
B0_311f:		eor ($01), y	; 51 01
B0_3121:		bmi B0_30a4 ; 30 81

B0_3123:	.db $53
B0_3124:		.db $00				; 00
B0_3125:		ora #$03		; 09 03
B0_3127:	.db $3f
B0_3128:	.db $80
B0_3129:		ora #$03		; 09 03
B0_312b:		bmi B0_30ae ; 30 81

B0_312d:		cmp $03			; c5 03
B0_312f:		bmi B0_30b2 ; 30 81

B0_3131:	.db $7d $03 $00
B0_3134:		sta ($53, x)	; 81 53
B0_3136:		.db $00				; 00
B0_3137:		inx				; e8 
B0_3138:		ora $00			; 05 00
B0_313a:		.db $00				; 00
B0_313b:		sta $01			; 85 01
B0_313d:	.db $80
B0_313e:	.db $0b
B0_313f:		asl $e0			; 06 e0
B0_3141:	.db $07
B0_3142:	.db $02
B0_3143:		.db $00				; 00
B0_3144:	.db $03
B0_3145:	.db $3f
B0_3146:		sta ($0d, x)	; 81 0d
B0_3148:	.db $02
B0_3149:		.db $00				; 00
B0_314a:	.db $03
B0_314b:	.db $3f
B0_314c:		sta ($40, x)	; 81 40
B0_314e:		.db $00				; 00
B0_314f:		bpl B0_3154 ; 10 03

B0_3151:		sta ($81, x)	; 81 81
B0_3153:	.db $93
B0_3154:		ora $01			; 05 01
B0_3156:	.db $63
B0_3157:	.db $80
B0_3158:		.db $00				; 00
B0_3159:	.db $8f
B0_315a:	.db $ff
B0_315b:		ora $01			; 05 01
B0_315d:	.db $63
B0_315e:	.db $80
B0_315f:		.db $00				; 00
B0_3160:	.db $8f
B0_3161:	.db $ff
B0_3162:		.db $00				; 00
B0_3163:		bpl B0_316a ; 10 05

B0_3165:		ora ($63, x)	; 01 63
B0_3167:	.db $80
B0_3168:		.db $00				; 00
B0_3169:	.db $8f
B0_316a:	.db $ff
B0_316b:		ora $00			; 05 00
B0_316d:		.db $00				; 00
B0_316e:	.db $80
B0_316f:		.db $00				; 00
B0_3170:		sta ($0d, x)	; 81 0d
B0_3172:		ora $00			; 05 00
B0_3174:		.db $00				; 00
B0_3175:	.db $80
B0_3176:		.db $00				; 00
B0_3177:		sta ($40, x)	; 81 40
B0_3179:		.db $00				; 00
B0_317a:		php				; 08 
B0_317b:		ora $00			; 05 00
B0_317d:		.db $00				; 00
B0_317e:	.db $80
B0_317f:		.db $00				; 00
B0_3180:	.db $83
B0_3181:	.db $27
B0_3182:	.db $04
B0_3183:		ora ($6b, x)	; 01 6b
B0_3185:		lda ($80), y	; b1 80
B0_3187:		;removed
	.db $f0 $81

B0_3189:		rti				; 40 


B0_318a:		.db $00				; 00
B0_318b:		clc				; 18 
B0_318c:		sta ($93, x)	; 81 93
B0_318e:	.db $80
B0_318f:		beq B0_3112 ; f0 81

B0_3191:		rti				; 40 


B0_3192:		.db $00				; 00
B0_3193:		php				; 08 
B0_3194:		sta ($93, x)	; 81 93
B0_3196:		sta ($0d, x)	; 81 0d
B0_3198:		sta ($40, x)	; 81 40
B0_319a:		.db $00				; 00
B0_319b:		php				; 08 
B0_319c:		sta ($93, x)	; 81 93
B0_319e:	.db $80
B0_319f:		;removed
	.db $f0 $81

B0_31a1:		rti				; 40 


B0_31a2:		.db $00				; 00
B0_31a3:		php				; 08 
B0_31a4:		sta ($93, x)	; 81 93
B0_31a6:	.db $80
B0_31a7:		cmp $80, x		; d5 80
B0_31a9:		inc $2800, x	; fe 00 28
B0_31ac:		sta ($40, x)	; 81 40
B0_31ae:		ora $01			; 05 01
B0_31b0:	.db $63
B0_31b1:	.db $80
B0_31b2:		.db $00				; 00
B0_31b3:	.db $8f
B0_31b4:	.db $ff
B0_31b5:		ora $01			; 05 01
B0_31b7:	.db $63
B0_31b8:	.db $80
B0_31b9:		.db $00				; 00
B0_31ba:	.db $8f
B0_31bb:	.db $ff
B0_31bc:		.db $00				; 00
B0_31bd:		plp				; 28 
B0_31be:		ora $01			; 05 01
B0_31c0:	.db $63
B0_31c1:	.db $80
B0_31c2:		.db $00				; 00
B0_31c3:	.db $8f
B0_31c4:	.db $ff
B0_31c5:	.db $03
B0_31c6:		bmi B0_3148 ; 30 80

B0_31c8:		cmp $03, x		; d5 03
B0_31ca:		bmi B0_314c ; 30 80

B0_31cc:		inc $2800, x	; fe 00 28
B0_31cf:	.db $03
B0_31d0:		.db $00				; 00
B0_31d1:	.db $80
B0_31d2:		.db $00				; 00
B0_31d3:		asl $d0			; 06 d0
B0_31d5:		asl a			; 0a
B0_31d6:		ora $00			; 05 00
B0_31d8:		.db $00				; 00
B0_31d9:		sta $06			; 85 06
B0_31db:	.db $02
B0_31dc:	.db $80
B0_31dd:	.db $03
B0_31de:	.db $3f
B0_31df:		ora ($20, x)	; 01 20
B0_31e1:		sta ($c5, x)	; 81 c5
B0_31e3:		.db $00				; 00
B0_31e4:	.db $03
B0_31e5:		ora ($ff, x)	; 01 ff
B0_31e7:	.db $03
B0_31e8:	.db $3f
B0_31e9:	.db $80
B0_31ea:	.db $07
B0_31eb:		ora ($e0, x)	; 01 e0
B0_31ed:		sta ($7d, x)	; 81 7d
B0_31ef:		.db $00				; 00
B0_31f0:		ora $01			; 05 01
B0_31f2:		ora ($80, x)	; 01 80
B0_31f4:	.db $03
B0_31f5:		asl $d0			; 06 d0
B0_31f7:	.db $03
B0_31f8:	.db $02
B0_31f9:		cpy #$03		; c0 03
B0_31fb:	.db $3f
B0_31fc:	.db $80
B0_31fd:		adc ($00), y	; 71 00
B0_31ff:		ora $02			; 05 02
B0_3201:		cpy #$03		; c0 03
B0_3203:	.db $3f
B0_3204:	.db $80
B0_3205:		sec				; 38 
B0_3206:	.db $80
B0_3207:		bvc B0_3209 ; 50 00

B0_3209:	.db $03
B0_320a:	.db $80
B0_320b:		adc ($80), y	; 71 80
B0_320d:		stx $00			; 86 00
B0_320f:	.db $03
B0_3210:	.db $80
B0_3211:		bvc B0_3193 ; 50 80

B0_3213:		eor wEntitiesControlByte.w, y	; 59 00 03
B0_3216:	.db $80
B0_3217:		stx $04			; 86 04
B0_3219:	.db $0c
B0_321a:		sed				; f8 
B0_321b:		lda ($06), y	; b1 06
B0_321d:		bne B0_322a ; d0 0b

B0_321f:		ora $00			; 05 00
B0_3221:		.db $00				; 00
B0_3222:	.db $83
B0_3223:		php				; 08 
B0_3224:	.db $02
B0_3225:	.db $80
B0_3226:		ora ($20, x)	; 01 20
B0_3228:	.db $03
B0_3229:	.db $3f
B0_322a:	.db $80
B0_322b:		bvc B0_3232 ; 50 05

B0_322d:		.db $00				; 00
B0_322e:		.db $00				; 00
B0_322f:	.db $83
B0_3230:		php				; 08 
B0_3231:	.db $02
B0_3232:	.db $80
B0_3233:		ora ($20, x)	; 01 20
B0_3235:	.db $03
B0_3236:	.db $3f
B0_3237:	.db $80
B0_3238:	.db $53
B0_3239:		.db $00				; 00
B0_323a:	.db $0c
B0_323b:		ora $00			; 05 00
B0_323d:		.db $00				; 00
B0_323e:		sty $08			; 84 08
B0_3240:	.db $03
B0_3241:	.db $3f
B0_3242:	.db $80
B0_3243:	.db $03
B0_3244:		asl $d0			; 06 d0
B0_3246:	.db $0b
B0_3247:	.db $02
B0_3248:		.db $00				; 00
B0_3249:		ora ($30, x)	; 01 30
B0_324b:	.db $03
B0_324c:	.db $3f
B0_324d:		sta ($1d, x)	; 81 1d
B0_324f:	.db $02
B0_3250:		.db $00				; 00
B0_3251:		ora ($30, x)	; 01 30
B0_3253:	.db $03
B0_3254:	.db $3f
B0_3255:	.db $80
B0_3256:		iny				; c8 
B0_3257:		.db $00				; 00
B0_3258:	.db $04
B0_3259:	.db $02
B0_325a:	.db $80
B0_325b:	.db $03
B0_325c:	.db $3f
B0_325d:	.db $80
B0_325e:		ora $01			; 05 01
B0_3260:		.db $00				; 00
B0_3261:	.db $80
B0_3262:	.db $54
B0_3263:		ora ($00, x)	; 01 00
B0_3265:	.db $80
B0_3266:		lsr wEntitiesControlByte.w, x	; 5e 00 03
B0_3269:	.db $80
B0_326a:		ora $04			; 05 04
B0_326c:		ora $b247, y	; 19 47 b2
B0_326f:		asl $d0			; 06 d0
B0_3271:	.db $07
B0_3272:		ora $01			; 05 01
B0_3274:		eor ($82, x)	; 41 82
B0_3276:	.db $02
B0_3277:	.db $02
B0_3278:		cpy #$03		; c0 03
B0_327a:	.db $3f
B0_327b:		sta ($40, x)	; 81 40
B0_327d:		ora $01			; 05 01
B0_327f:		eor ($82, x)	; 41 82
B0_3281:	.db $02
B0_3282:	.db $02
B0_3283:		cpy #$03		; c0 03
B0_3285:	.db $3f
B0_3286:	.db $80
B0_3287:		lda #$00		; a9 00
B0_3289:		cpy #$03		; c0 03
B0_328b:		.db $00				; 00
B0_328c:	.db $80
B0_328d:		.db $00				; 00
B0_328e:		ora $00			; 05 00
B0_3290:		.db $00				; 00
B0_3291:		stx $05			; 86 05
B0_3293:	.db $02
B0_3294:	.db $80
B0_3295:	.db $80
B0_3296:		beq B0_329d ; f0 05

B0_3298:		.db $00				; 00
B0_3299:		.db $00				; 00
B0_329a:		stx $05			; 86 05
B0_329c:	.db $02
B0_329d:	.db $80
B0_329e:		sta ($67, x)	; 81 67
B0_32a0:		.db $00				; 00
B0_32a1:		php				; 08 
B0_32a2:	.db $80
B0_32a3:		.db $00				; 00
B0_32a4:	.db $80
B0_32a5:	.db $e2
B0_32a6:		sta ($53, x)	; 81 53
B0_32a8:		.db $00				; 00
B0_32a9:		php				; 08 
B0_32aa:	.db $80
B0_32ab:		.db $00				; 00
B0_32ac:		sta ($2e, x)	; 81 2e
B0_32ae:		sta ($93, x)	; 81 93
B0_32b0:		.db $00				; 00
B0_32b1:		php				; 08 
B0_32b2:	.db $80
B0_32b3:		.db $00				; 00
B0_32b4:		sta ($1d, x)	; 81 1d
B0_32b6:		sta ($7d, x)	; 81 7d
B0_32b8:		.db $00				; 00
B0_32b9:		php				; 08 
B0_32ba:	.db $80
B0_32bb:		.db $00				; 00
B0_32bc:	.db $03
B0_32bd:	.db $3a
B0_32be:		sta ($1d, x)	; 81 1d
B0_32c0:	.db $03
B0_32c1:	.db $3a
B0_32c2:		sta ($7d, x)	; 81 7d
B0_32c4:		.db $00				; 00
B0_32c5:		php				; 08 
B0_32c6:	.db $80
B0_32c7:		.db $00				; 00
B0_32c8:	.db $03
B0_32c9:	.db $37
B0_32ca:		sta ($1d, x)	; 81 1d
B0_32cc:	.db $03
B0_32cd:	.db $37
B0_32ce:		sta ($7d, x)	; 81 7d
B0_32d0:		.db $00				; 00
B0_32d1:		php				; 08 
B0_32d2:	.db $80
B0_32d3:		.db $00				; 00
B0_32d4:	.db $03
B0_32d5:	.db $34
B0_32d6:		sta ($1d, x)	; 81 1d
B0_32d8:	.db $03
B0_32d9:	.db $34
B0_32da:		sta ($7d, x)	; 81 7d
B0_32dc:		.db $00				; 00
B0_32dd:		php				; 08 
B0_32de:	.db $80
B0_32df:		.db $00				; 00
B0_32e0:	.db $03
B0_32e1:	.db $32
B0_32e2:		sta ($1d, x)	; 81 1d
B0_32e4:	.db $03
B0_32e5:	.db $32
B0_32e6:		sta ($7d, x)	; 81 7d
B0_32e8:		.db $00				; 00
B0_32e9:		php				; 08 
B0_32ea:	.db $80
B0_32eb:		.db $00				; 00
B0_32ec:		asl $d0			; 06 d0
B0_32ee:	.db $03
B0_32ef:	.db $02
B0_32f0:		cpy #$03		; c0 03
B0_32f2:	.db $3f
B0_32f3:		ora ($20, x)	; 01 20
B0_32f5:	.db $80
B0_32f6:		stx $1000		; 8e 00 10
B0_32f9:	.db $02
B0_32fa:		cpy #$03		; c0 03
B0_32fc:	.db $3f
B0_32fd:		ora ($20, x)	; 01 20
B0_32ff:	.db $80
B0_3300:	.db $93
B0_3301:	.db $03
B0_3302:		sec				; 38 
B0_3303:	.db $80
B0_3304:		stx $1000		; 8e 00 10
B0_3307:	.db $03
B0_3308:		sec				; 38 
B0_3309:	.db $80
B0_330a:	.db $93
B0_330b:		asl $30			; 06 30
B0_330d:	.db $02
B0_330e:		.db $00				; 00
B0_330f:	.db $04
B0_3310:	.db $02
B0_3311:	.db $80
B0_3312:	.db $03
B0_3313:	.db $3f
B0_3314:	.db $80
B0_3315:	.db $47
B0_3316:		.db $00				; 00
B0_3317:	.db $04
B0_3318:	.db $80
B0_3319:		ror a			; 6a
B0_331a:		asl $e0			; 06 e0
B0_331c:	.db $07
B0_331d:	.db $02
B0_331e:		.db $00				; 00
B0_331f:	.db $03
B0_3320:	.db $3f
B0_3321:	.db $80
B0_3322:	.db $b3
B0_3323:	.db $02
B0_3324:		.db $00				; 00
B0_3325:	.db $03
B0_3326:	.db $3f
B0_3327:		sta ($2e, x)	; 81 2e
B0_3329:		.db $00				; 00
B0_332a:		clc				; 18 
B0_332b:	.db $03
B0_332c:		sta ($80, x)	; 81 80
B0_332e:		beq B0_3335 ; f0 05

B0_3330:		ora ($42, x)	; 01 42
B0_3332:	.db $80
B0_3333:		.db $00				; 00
B0_3334:	.db $8f
B0_3335:	.db $ff
B0_3336:		ora $01			; 05 01
B0_3338:	.db $42
B0_3339:	.db $80
B0_333a:		.db $00				; 00
B0_333b:	.db $8f
B0_333c:	.db $ff
B0_333d:		.db $00				; 00
B0_333e:		php				; 08 
B0_333f:		ora $01			; 05 01
B0_3341:	.db $42
B0_3342:	.db $80
B0_3343:		.db $00				; 00
B0_3344:	.db $8f
B0_3345:	.db $ff
B0_3346:		ora $00			; 05 00
B0_3348:		.db $00				; 00
B0_3349:	.db $80
B0_334a:		.db $00				; 00
B0_334b:	.db $80
B0_334c:	.db $b3
B0_334d:		ora $00			; 05 00
B0_334f:		.db $00				; 00
B0_3350:	.db $80
B0_3351:		.db $00				; 00
B0_3352:		sta ($2e, x)	; 81 2e
B0_3354:		.db $00				; 00
B0_3355:		php				; 08 
B0_3356:		ora $00			; 05 00
B0_3358:		.db $00				; 00
B0_3359:	.db $80
B0_335a:		.db $00				; 00
B0_335b:	.db $80
B0_335c:		beq B0_3362 ; f0 04

B0_335e:		ora ($46, x)	; 01 46
B0_3360:	.db $b3
B0_3361:	.db $80
B0_3362:		cmp #$81		; c9 81
B0_3364:		rol $1000		; 2e 00 10
B0_3367:	.db $80
B0_3368:		beq B0_336f ; f0 05

B0_336a:		ora ($42, x)	; 01 42
B0_336c:	.db $80
B0_336d:		.db $00				; 00
B0_336e:	.db $8f
B0_336f:	.db $ff
B0_3370:		ora $01			; 05 01
B0_3372:	.db $42
B0_3373:	.db $80
B0_3374:		.db $00				; 00
B0_3375:	.db $8f
B0_3376:	.db $ff
B0_3377:		.db $00				; 00
B0_3378:		php				; 08 
B0_3379:		ora $01			; 05 01
B0_337b:	.db $42
B0_337c:	.db $80
B0_337d:		.db $00				; 00
B0_337e:	.db $8f
B0_337f:	.db $ff
B0_3380:		ora $00			; 05 00
B0_3382:		.db $00				; 00
B0_3383:	.db $80
B0_3384:		.db $00				; 00
B0_3385:	.db $80
B0_3386:	.db $b3
B0_3387:		ora $00			; 05 00
B0_3389:		.db $00				; 00
B0_338a:	.db $80
B0_338b:		.db $00				; 00
B0_338c:		sta ($2e, x)	; 81 2e
B0_338e:		.db $00				; 00
B0_338f:		bpl B0_3396 ; 10 05

B0_3391:		.db $00				; 00
B0_3392:		.db $00				; 00
B0_3393:	.db $80
B0_3394:		.db $00				; 00
B0_3395:	.db $80
B0_3396:		cmp #$80		; c9 80
B0_3398:	.db $b3
B0_3399:		sta ($2e, x)	; 81 2e
B0_339b:		.db $00				; 00
B0_339c:		php				; 08 
B0_339d:	.db $80
B0_339e:		cmp #$80		; c9 80
B0_33a0:		ldy #$80		; a0 80
B0_33a2:		inc $1800, x	; fe 00 18
B0_33a5:	.db $80
B0_33a6:		cmp $05, x		; d5 05
B0_33a8:		ora ($42, x)	; 01 42
B0_33aa:	.db $80
B0_33ab:		.db $00				; 00
B0_33ac:	.db $8f
B0_33ad:	.db $ff
B0_33ae:		ora $01			; 05 01
B0_33b0:	.db $42
B0_33b1:	.db $80
B0_33b2:		.db $00				; 00
B0_33b3:	.db $8f
B0_33b4:	.db $ff
B0_33b5:		.db $00				; 00
B0_33b6:		clc				; 18 
B0_33b7:		ora $01			; 05 01
B0_33b9:	.db $42
B0_33ba:	.db $80
B0_33bb:		.db $00				; 00
B0_33bc:	.db $8f
B0_33bd:	.db $ff
B0_33be:	.db $03
B0_33bf:		bmi B0_3341 ; 30 80

B0_33c1:		inc $0a00, x	; fe 00 0a
B0_33c4:	.db $03
B0_33c5:		.db $00				; 00
B0_33c6:	.db $80
B0_33c7:		.db $00				; 00
B0_33c8:		asl $b0			; 06 b0
B0_33ca:		php				; 08 
B0_33cb:		.db $00				; 00
B0_33cc:	.db $0e $01 $00
B0_33cf:	.db $03
B0_33d0:	.db $3f
B0_33d1:	.db $80
B0_33d2:		asl $0600		; 0e 00 06
B0_33d5:	.db $80
B0_33d6:	.db $0f
B0_33d7:	.db $04
B0_33d8:		ora #$cb		; 09 cb
B0_33da:	.db $b3
B0_33db:		asl $00			; 06 00
B0_33dd:		.db $00				; 00
B0_33de:		.db $00				; 00
B0_33df:		.db $00				; 00
