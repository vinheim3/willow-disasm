data_5_089c:
B5_089c:	.db $32
B5_089d:	.db $ff
B5_089e:		sty $1b			; 84 1b
B5_08a0:	.db $03
B5_08a1:	.db $1c
B5_08a2:	.db $03
B5_08a3:	.db $1c
B5_08a4:	.db $03
B5_08a5:	.db $1c
B5_08a6:	.db $ff
B5_08a7:		ora $1d40, x	; 1d 40 1d
B5_08aa:		rti				; 40 
B5_08ab:		ora $1d40, x	; 1d 40 1d
B5_08ae:		rti				; 40 


B5_08af:	.db $32
B5_08b0:	.db $ff
B5_08b1:	.db $04
B5_08b2:	.db $1b
B5_08b3:		sty $1b			; 84 1b
B5_08b5:	.db $83
B5_08b6:	.db $0c
B5_08b7:	.db $83
B5_08b8:	.db $1c
B5_08b9:	.db $ff
B5_08ba:		asl $1e40, x	; 1e 40 1e
B5_08bd:		rti				; 40 


B5_08be:		asl $1e40, x	; 1e 40 1e
B5_08c1:		rti				; 40 


B5_08c2:		.db $00				; 00
B5_08c3:		cpy #$80		; c0 80
B5_08c5:	.db $ff
B5_08c6:	.db $04
B5_08c7:	.db $1b
B5_08c8:		sta $09			; 85 09
B5_08ca:		ora $0e			; 05 0e
B5_08cc:		sty $1b			; 84 1b
B5_08ce:	.db $ff
B5_08cf:		rts				; 60 


B5_08d0:		.db $00				; 00
B5_08d1:		rts				; 60 


B5_08d2:		.db $00				; 00
B5_08d3:		rts				; 60 


B5_08d4:		.db $00				; 00
B5_08d5:		rts				; 60 


B5_08d6:		.db $00				; 00
B5_08d7:		rts				; 60 


B5_08d8:		.db $00				; 00
B5_08d9:		ora ($ff), y	; 11 ff
B5_08db:		sta ($00, x)	; 81 00
B5_08dd:		sta ($00, x)	; 81 00
B5_08df:		sta ($00, x)	; 81 00
B5_08e1:		sta ($00, x)	; 81 00
B5_08e3:	.db $ff
B5_08e4:	.db $1b
B5_08e5:		pha				; 48 
B5_08e6:		.db $00				; 00
B5_08e7:		cpy #$80		; c0 80
B5_08e9:	.db $ff
B5_08ea:	.db $82
B5_08eb:		ora $1e02, x	; 1d 02 1e
B5_08ee:		sty $1d			; 84 1d
B5_08f0:	.db $82
B5_08f1:	.db $22
B5_08f2:	.db $ff
B5_08f3:	.db $63
B5_08f4:		tay				; a8 
B5_08f5:		ror $b8			; 66 b8
B5_08f7:		jmp ($69a0)		; 6c a0 69


B5_08fa:		bcs B5_093e ; b0 42

B5_08fc:	.db $ff
B5_08fd:	.db $02
B5_08fe:		ora ($03), y	; 11 03
B5_0900:		;removed
	.db $10 $03

B5_0902:		bpl B5_0907 ; 10 03

B5_0904:		;removed
	.db $10 $ff

B5_0906:	.db $0c
B5_0907:		.db $00				; 00
B5_0908:	.db $0c
B5_0909:		.db $00				; 00
B5_090a:	.db $0c
B5_090b:		.db $00				; 00
B5_090c:		asl $d6, x		; 16 d6
B5_090e:		dec $ff			; c6 ff
B5_0910:		sty $17			; 84 17
B5_0912:		sta $16			; 85 16
B5_0914:		sta $16			; 85 16
B5_0916:		sta $16			; 85 16
B5_0918:	.db $ff
B5_0919:	.db $6f
B5_091a:		ldy #$6f		; a0 6f
B5_091c:		ldy #$6f		; a0 6f
B5_091e:		ldy #$6f		; a0 6f
B5_0920:		ldy #$6f		; a0 6f
B5_0922:		ldy #$06		; a0 06
B5_0924:		dec $86			; c6 86
B5_0926:	.db $ff
B5_0927:	.db $07
B5_0928:		asl $07, x		; 16 07
B5_092a:		asl $07, x		; 16 07
B5_092c:		asl $07, x		; 16 07
B5_092e:		asl $ff, x		; 16 ff
B5_0930:		adc $a8, x		; 75 a8
B5_0932:		adc $b8, x		; 75 b8
B5_0934:		adc $b8, x		; 75 b8
B5_0936:		adc $a8, x		; 75 a8
B5_0938:		adc $b8, x		; 75 b8
B5_093a:		adc $a8, x		; 75 a8
B5_093c:		adc $b8, x		; 75 b8
B5_093e:		ora ($ff), y	; 11 ff
B5_0940:	.db $83
B5_0941:	.db $23
B5_0942:	.db $83
B5_0943:	.db $23
B5_0944:	.db $83
B5_0945:	.db $23
B5_0946:	.db $83
B5_0947:	.db $23
B5_0948:	.db $ff
B5_0949:	.db $0f
B5_094a:		rti				; 40 


B5_094b:	.db $0f
B5_094c:		rti				; 40 


B5_094d:	.db $0f
B5_094e:		rti				; 40 


B5_094f:		sta $ff			; 85 ff
B5_0951:	.db $02
B5_0952:		ora ($02, x)	; 01 02
B5_0954:	.db $02
B5_0955:	.db $03
B5_0956:	.db $03
B5_0957:	.db $03
B5_0958:	.db $04
B5_0959:	.db $03
B5_095a:		ora $ff			; 05 ff
B5_095c:	.db $12
B5_095d:		ora ($12, x)	; 01 12
B5_095f:	.db $33
B5_0960:	.db $12
B5_0961:		ror $42			; 66 42
B5_0963:	.db $c2
B5_0964:	.db $02
B5_0965:	.db $ff
B5_0966:		sta ($21, x)	; 81 21
B5_0968:		ora ($1f, x)	; 01 1f
B5_096a:		ora ($06, x)	; 01 06
B5_096c:		ora ($06, x)	; 01 06
B5_096e:	.db $ff
B5_096f:		sei				; 78 
B5_0970:		rts				; 60 


B5_0971:		ldx $d6			; a6 d6
B5_0973:		lsr $ff			; 46 ff
B5_0975:		sta ($21, x)	; 81 21
B5_0977:		ora ($1f, x)	; 01 1f
B5_0979:		sta ($21, x)	; 81 21
B5_097b:		ora ($1f, x)	; 01 1f
B5_097d:	.db $ff
B5_097e:	.db $7b
B5_097f:		cpx #$82		; e0 82
B5_0981:	.db $c2
B5_0982:	.db $22
B5_0983:	.db $ff
B5_0984:	.db $83
B5_0985:		asl $84			; 06 84
B5_0987:		ora #$82		; 09 82
B5_0989:		bpl B5_090c ; 10 81

B5_098b:	.db $1c
B5_098c:	.db $ff
B5_098d:		sta ($00, x)	; 81 00
B5_098f:		sta ($00, x)	; 81 00
B5_0991:		sta ($00, x)	; 81 00
B5_0993:		sta ($00, x)	; 81 00
B5_0995:		ora $c5, x		; 15 c5
B5_0997:		sta $ff			; 85 ff
B5_0999:	.db $82
B5_099a:		ora $1d82, x	; 1d 82 1d
B5_099d:	.db $82
B5_099e:		ora $1d82, x	; 1d 82 1d
B5_09a1:	.db $ff
B5_09a2:		sty $88			; 84 88
B5_09a4:	.db $87
B5_09a5:		tya				; 98 
B5_09a6:	.db $74
B5_09a7:	.db $ff
B5_09a8:	.db $03
B5_09a9:	.db $1a
B5_09aa:	.db $03
B5_09ab:	.db $1a
B5_09ac:	.db $03
B5_09ad:	.db $1a
B5_09ae:	.db $03
B5_09af:	.db $1a
B5_09b0:	.db $ff
B5_09b1:		eor $4e00		; 4d 00 4e
B5_09b4:		.db $00				; 00
B5_09b5:	.db $4f
B5_09b6:		.db $00				; 00
B5_09b7:		.db $00				; 00
B5_09b8:	.db $ff
B5_09b9:		ora ($00, x)	; 01 00
B5_09bb:		ora ($00, x)	; 01 00
B5_09bd:		ora ($00, x)	; 01 00
B5_09bf:		ora ($00, x)	; 01 00
B5_09c1:	.db $ff
B5_09c2:		eor $00			; 45 00
B5_09c4:		and ($ff, x)	; 21 ff
B5_09c6:	.db $07
B5_09c7:		ora $1907, y	; 19 07 19
B5_09ca:	.db $07
B5_09cb:		ora $1907, y	; 19 07 19
B5_09ce:	.db $ff
B5_09cf:	.db $1c
B5_09d0:		.db $00				; 00
B5_09d1:	.db $1c
B5_09d2:		ora ($1c, x)	; 01 1c
B5_09d4:	.db $02
B5_09d5:	.db $1c
B5_09d6:	.db $03
B5_09d7:	.db $1c
B5_09d8:	.db $04
B5_09d9:	.db $1c
B5_09da:		ora $1c			; 05 1c
B5_09dc:		asl $56			; 06 56
B5_09de:	.db $ff
B5_09df:		ora ($0b, x)	; 01 0b
B5_09e1:		ora ($13, x)	; 01 13
B5_09e3:	.db $ff
B5_09e4:		ldx $00			; a6 00
B5_09e6:	.db $04
B5_09e7:	.db $ff
B5_09e8:		ora ($0a, x)	; 01 0a
B5_09ea:		ora ($2c, x)	; 01 2c
B5_09ec:		ora ($13, x)	; 01 13
B5_09ee:	.db $ff
B5_09ef:		ldx #$00		; a2 00
B5_09f1:	.db $14
B5_09f2:	.db $ff
B5_09f3:		ora ($0f, x)	; 01 0f
B5_09f5:	.db $ff
B5_09f6:		tax				; aa 
B5_09f7:		.db $00				; 00
B5_09f8:	.db $33
B5_09f9:	.db $73
B5_09fa:	.db $63
B5_09fb:	.db $ff
B5_09fc:	.db $82
B5_09fd:		.db $00				; 00
B5_09fe:	.db $02
B5_09ff:		ora ($82, x)	; 01 82
B5_0a01:		ora #$81		; 09 81
B5_0a03:	.db $0b
B5_0a04:	.db $ff
B5_0a05:		bcc B5_09e7 ; 90 e0

B5_0a07:		;removed
	.db $90 $e0

B5_0a09:	.db $63
B5_0a0a:	.db $c3
B5_0a0b:	.db $d3
B5_0a0c:	.db $ff
B5_0a0d:		sta ($00, x)	; 81 00
B5_0a0f:		sta ($00, x)	; 81 00
B5_0a11:		sta ($00, x)	; 81 00
B5_0a13:		sta ($00, x)	; 81 00
B5_0a15:	.db $ff
B5_0a16:	.db $93
B5_0a17:		ldy #$03		; a0 03
B5_0a19:	.db $b3
B5_0a1a:	.db $43
B5_0a1b:	.db $ff
B5_0a1c:		sta ($0a, x)	; 81 0a
B5_0a1e:		sta ($0b, x)	; 81 0b
B5_0a20:		ora ($10, x)	; 01 10
B5_0a22:		ora ($10, x)	; 01 10
B5_0a24:	.db $ff
B5_0a25:		stx $e8, y		; 96 e8
B5_0a27:	.db $23
B5_0a28:	.db $d3
B5_0a29:	.db $83
B5_0a2a:	.db $ff
B5_0a2b:	.db $82
B5_0a2c:		ora #$81		; 09 81
B5_0a2e:	.db $0b
B5_0a2f:		ora ($12, x)	; 01 12
B5_0a31:		ora ($12, x)	; 01 12
B5_0a33:	.db $ff
B5_0a34:		sta $99c0, y	; 99 c0 99
B5_0a37:		cpy #$37		; c0 37
B5_0a39:	.db $ff
B5_0a3a:		ora ($18, x)	; 01 18
B5_0a3c:	.db $ff
B5_0a3d:		clv				; b8 
B5_0a3e:		bvc B5_09e7 ; 50 a7

B5_0a40:	.db $ff
B5_0a41:		ora ($02, x)	; 01 02
B5_0a43:	.db $ff
B5_0a44:		ldy $88, x		; b4 88
B5_0a46:		adc $ff, x		; 75 ff
B5_0a48:		ora ($02, x)	; 01 02
B5_0a4a:	.db $ff
B5_0a4b:		ldx $48, y		; b6 48
B5_0a4d:	.db $27
B5_0a4e:	.db $ff
B5_0a4f:		ora ($02, x)	; 01 02
B5_0a51:	.db $ff
B5_0a52:	.db $b7
B5_0a53:		dey				; 88 
B5_0a54:		adc ($ff, x)	; 61 ff
B5_0a56:		ora ($02, x)	; 01 02
B5_0a58:	.db $ff
B5_0a59:		tsx				; ba 
B5_0a5a:		cpy #$00		; c0 00
B5_0a5c:		cpy #$80		; c0 80
B5_0a5e:	.db $ff
B5_0a5f:		ora ($06, x)	; 01 06
B5_0a61:	.db $82
B5_0a62:	.db $1f
B5_0a63:	.db $82
B5_0a64:		jsr $2182		; 20 82 21
B5_0a67:	.db $ff
B5_0a68:		adc #$b0		; 69 b0
B5_0a6a:		jmp ($15a0)		; 6c a0 15


B5_0a6d:		cmp $85			; c5 85
B5_0a6f:	.db $ff
B5_0a70:	.db $82
B5_0a71:	.db $1f
B5_0a72:	.db $82
B5_0a73:	.db $1f
B5_0a74:	.db $82
B5_0a75:	.db $1f
B5_0a76:	.db $82
B5_0a77:	.db $1f
B5_0a78:	.db $ff
B5_0a79:		txa				; 8a 
B5_0a7a:		bcc B5_0a09 ; 90 8d

B5_0a7c:	.db $80
B5_0a7d:		sta $ff			; 85 ff
B5_0a7f:	.db $04
B5_0a80:		.db $00				; 00
B5_0a81:	.db $04
B5_0a82:		asl $03			; 06 03
B5_0a84:	.db $07
B5_0a85:		asl $08			; 06 08
B5_0a87:		ora $09			; 05 09
B5_0a89:	.db $ff
B5_0a8a:	.db $12
B5_0a8b:		ora ($12, x)	; 01 12
B5_0a8d:	.db $33
B5_0a8e:	.db $12
B5_0a8f:		ror $12			; 66 12
B5_0a91:		sta $cc12, y	; 99 12 cc
B5_0a94:	.db $12
B5_0a95:	.db $ff
B5_0a96:	.db $02
B5_0a97:	.db $ff
B5_0a98:		ora ($14, x)	; 01 14
B5_0a9a:		ora ($0c, x)	; 01 0c
B5_0a9c:		ora ($2a, x)	; 01 2a
B5_0a9e:	.db $ff
B5_0a9f:		lda ($00, x)	; a1 00
B5_0aa1:	.db $53
B5_0aa2:	.db $ff
B5_0aa3:		ora ($12, x)	; 01 12
B5_0aa5:		ora ($13, x)	; 01 13
B5_0aa7:	.db $ff
B5_0aa8:		ldy #$00		; a0 00
B5_0aaa:	.db $02
B5_0aab:	.db $ff
B5_0aac:		ora ($0a, x)	; 01 0a
B5_0aae:		ora ($0d, x)	; 01 0d
B5_0ab0:		ora ($0e, x)	; 01 0e
B5_0ab2:		ora ($0f, x)	; 01 0f
B5_0ab4:		ora ($10, x)	; 01 10
B5_0ab6:		ora ($11, x)	; 01 11
B5_0ab8:		ora ($12, x)	; 01 12
B5_0aba:		ora ($13, x)	; 01 13
B5_0abc:	.db $ff
B5_0abd:		lda ($00, x)	; a1 00
B5_0abf:	.db $13
B5_0ac0:	.db $c3
B5_0ac1:	.db $ff
B5_0ac2:		ora ($0d, x)	; 01 0d
B5_0ac4:	.db $ff
B5_0ac5:		bcs B5_0ac7 ; b0 00


data_5_0ac7:
B5_0ac7:	.db $54
B5_0ac8:	.db $ff
B5_0ac9:		ora ($0b, x)	; 01 0b
B5_0acb:		ora ($0c, x)	; 01 0c
B5_0acd:		ora ($0d, x)	; 01 0d
B5_0acf:		ora ($00, x)	; 01 00
B5_0ad1:	.db $ff
B5_0ad2:		ldy $01			; a4 01


B5_0ad4:	.db $54
B5_0ad5:	.db $ff
B5_0ad6:		ora ($0d, x)	; 01 0d
B5_0ad8:		ora ($12, x)	; 01 12
B5_0ada:		ora ($00, x)	; 01 00
B5_0adc:		ora ($00, x)	; 01 00
B5_0ade:	.db $ff
B5_0adf:		lda $01			; a5 01
B5_0ae1:		cpx $ff			; e4 ff
B5_0ae3:		ora ($12, x)	; 01 12
B5_0ae5:		ora ($02, x)	; 01 02
B5_0ae7:	.db $ff
B5_0ae8:	.db $a7
B5_0ae9:		ora ($14, x)	; 01 14
B5_0aeb:	.db $ff
B5_0aec:		ora ($14, x)	; 01 14
B5_0aee:	.db $ff
B5_0aef:		tay				; a8 
B5_0af0:		ora ($e4, x)	; 01 e4
B5_0af2:	.db $ff
B5_0af3:	.db $02
B5_0af4:	.db $2b
B5_0af5:	.db $ff
B5_0af6:		lda #$01		; a9 01
B5_0af8:	.db $a7
B5_0af9:		ora ($14, x)	; 01 14
B5_0afb:		bit $ff			; 24 ff
B5_0afd:		ora ($11, x)	; 01 11
B5_0aff:		ora ($0a, x)	; 01 0a
B5_0b01:	.db $ff
B5_0b02:		ldx wStoryGlobalFlags1.w		; ae 01 06
B5_0b05:		dec $86, x		; d6 86
B5_0b07:	.db $ff
B5_0b08:	.db $07
B5_0b09:	.db $17
B5_0b0a:	.db $07
B5_0b0b:	.db $17
B5_0b0c:	.db $07
B5_0b0d:	.db $17
B5_0b0e:	.db $07
B5_0b0f:	.db $17
B5_0b10:	.db $ff
B5_0b11:		ldy $bcb0, x	; bc b0 bc
B5_0b14:		ldy #$bc		; a0 bc
B5_0b16:		ldy #$bc		; a0 bc
B5_0b18:		bcs B5_0ad6 ; b0 bc

B5_0b1a:		ldy #$bc		; a0 bc
B5_0b1c:		bcs B5_0ada ; b0 bc

B5_0b1e:		ldy #$00		; a0 00
B5_0b20:	.db $ff
B5_0b21:		ora ($0a, x)	; 01 0a
B5_0b23:	.db $ff
B5_0b24:		ldy $1501		; ac 01 15
B5_0b27:	.db $ff
B5_0b28:		ora ($15, x)	; 01 15
B5_0b2a:	.db $ff
B5_0b2b:		lda $e401		; ad 01 e4
B5_0b2e:	.db $ff
B5_0b2f:	.db $02
B5_0b30:		bit $ff			; 24 ff
B5_0b32:		lda #$01		; a9 01
B5_0b34:		tay				; a8 
B5_0b35:		ora ($84, x)	; 01 84
B5_0b37:	.db $ff
B5_0b38:	.db $04
B5_0b39:		and $06			; 25 06
B5_0b3b:		and $08			; 25 08
B5_0b3d:		and $04			; 25 04
B5_0b3f:		plp				; 28 
B5_0b40:		asl $28			; 06 28
B5_0b42:		php				; 08 
B5_0b43:		plp				; 28 
B5_0b44:	.db $ff
B5_0b45:		ora #$01		; 09 01
B5_0b47:		ora #$19		; 09 19
B5_0b49:		ora #$31		; 09 31
B5_0b4b:		ora #$49		; 09 49
B5_0b4d:		asl a			; 0a
B5_0b4e:		adc ($0a, x)	; 61 0a
B5_0b50:		adc $910b, y	; 79 0b 91
B5_0b53:	.db $0b
B5_0b54:		lda #$84		; a9 84
B5_0b56:	.db $ff
B5_0b57:	.db $02
B5_0b58:		rol $04			; 26 04
B5_0b5a:		rol $06			; 26 06
B5_0b5c:		rol $02			; 26 02
B5_0b5e:	.db $27
B5_0b5f:	.db $04
B5_0b60:	.db $27
B5_0b61:		asl $27			; 06 27
B5_0b63:	.db $02
B5_0b64:		and #$ff		; 29 ff
B5_0b66:		ora #$01		; 09 01
B5_0b68:		ora #$19		; 09 19
B5_0b6a:		asl a			; 0a
B5_0b6b:		and ($0a), y	; 31 0a
B5_0b6d:		eor #$0b		; 49 0b
B5_0b6f:		adc ($0b, x)	; 61 0b
B5_0b71:		.db $79


screenEntitiesSpecs:
	.dw data_5_089c
	.dw data_5_089c
	.dw $88af
	.dw $88c2
	.dw $88d9
	.dw $88e6
	.dw $88fb
	.dw $890c
	.dw $8923
	.dw $893e
	.dw $894f
	.dw $8962
	.dw $8971
	.dw $8980
	.dw $8995
	.dw $89a6
	.dw $89b7
	.dw $89c4
	.dw $89dd
	.dw $89e6
	.dw $89f1
	.dw $89f8
	.dw $8a09
	.dw $8a18
	.dw $8a27
	.dw $8a38
	.dw $8a3f
	.dw $8a46
	.dw $8a4d
	.dw $8a54
	.dw $8a5b
	.dw $8a6c
	.dw $8a7d
	.dw $8a96
	.dw $8aa1
	.dw $8aaa
	.dw $8abf
	.dw data_5_0ac7
	.dw $8ad4
	.dw $8ae1
	.dw $8aea
	.dw $8af1
	.dw $8afa
	.dw $8b04
	.dw $8b1f
	.dw $8b26
	.dw $8b2d
	.dw $8b36
	.dw $8b55