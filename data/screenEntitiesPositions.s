
B5_0bd4:		adc #$50		; 69 50
B5_0bd6:		lda #$90		; a9 90
B5_0bd8:	.db $89
B5_0bd9:		.db $30 $a9

B5_0bdb:		;removed
	.db $50 $69

B5_0bdd:		bcs B5_0b68 ; b0 89

B5_0bdf:		bne B5_0c2a ; d0 49

B5_0be1:		bcc B5_0c2c ; 90 49

B5_0be3:		;removed
	.db $d0 $29

B5_0be5:		;removed
	.db $70 $29

B5_0be7:		bne B5_0c52 ; d0 69

B5_0be9:		bne B5_0c54 ; d0 69

B5_0beb:		;removed
	.db $30 $29

B5_0bed:		;removed
	.db $b0 $29

B5_0bef:		.db $70 $c9

B5_0bf1:		bmi B5_0c3c ; 30 49

B5_0bf3:		.db $90 $89

B5_0bf5:		bcc B5_0c40 ; 90 49

B5_0bf7:		.db $70 $c9

B5_0bf9:		bne B5_0c24 ; d0 29

B5_0bfb:		;removed
	.db $d0 $49

B5_0bfd:		bcs B5_0c48 ; b0 49

B5_0bff:		bvs B5_0c2a ; 70 29

B5_0c01:		bne B5_0c6c ; d0 69

B5_0c03:		bcs B5_0c2e ; b0 29

B5_0c05:		bne B5_0c50 ; d0 49

B5_0c07:		.db $70 $c9

B5_0c09:		bvc B5_0c74 ; 50 69

B5_0c0b:		.db $d0 $a9

B5_0c0d:		bmi B5_0c78 ; 30 69

B5_0c0f:		.db $b0 $a9

B5_0c11:		bvs B5_0c5c ; 70 49

B5_0c13:		;removed
	.db $b0 $c9

B5_0c15:		bvc B5_0c40 ; 50 29

B5_0c17:		;removed
	.db $d0 $49

B5_0c19:		;removed
	.db $70 $50

B5_0c1b:		clv				; b8 
B5_0c1c:		sei				; 78 
B5_0c1d:		dey				; 88 
B5_0c1e:		dey				; 88 
B5_0c1f:	.db $80
B5_0c20:		;removed
	.db $70 $c0

B5_0c22:		.db $50 $80

B5_0c24:		rts				; 60 


B5_0c25:		sei				; 78 
B5_0c26:		pha				; 48 
B5_0c27:		ldy #$90		; a0 90
B5_0c29:		cld				; d8 
B5_0c2a:		cld				; d8 
B5_0c2b:		tay				; a8 
B5_0c2c:		tya				; 98 
B5_0c2d:		cli				; 58 
B5_0c2e:		tay				; a8 
B5_0c2f:		sei				; 78 
B5_0c30:		cli				; 58 
B5_0c31:		ldy #$60		; a0 60
B5_0c33:		sec				; 38 
B5_0c34:		bmi B5_0c4e ; 30 18

B5_0c36:		bcc B5_0c50 ; 90 18

B5_0c38:		rts				; 60 


B5_0c39:		;removed
	.db $d0 $98

B5_0c3b:		cld				; d8 
B5_0c3c:		cli				; 58 
B5_0c3d:		pha				; 48 
B5_0c3e:		;removed
	.db $90 $a0

B5_0c40:		pha				; 48 
B5_0c41:		bcs B5_0c8b ; b0 48

B5_0c43:		;removed
	.db $d0 $5c

B5_0c45:		sty $1178		; 8c 78 11
B5_0c48:		rts				; 60 


B5_0c49:	.db $ef
B5_0c4a:		bcc B5_0c3b ; 90 ef

B5_0c4c:		ldy #$11		; a0 11
B5_0c4e:		sec				; 38 
B5_0c4f:	.db $ef
B5_0c50:		bvc B5_0c63 ; 50 11

B5_0c52:		clv				; b8 
B5_0c53:	.db $ef
B5_0c54:		ora ($98), y	; 11 98
B5_0c56:	.db $df
B5_0c57:	.db $80
B5_0c58:	.db $df
B5_0c59:		clv				; b8 
B5_0c5a:		ora ($d0), y	; 11 d0
B5_0c5c:	.db $df
B5_0c5d:		bvc B5_0c70 ; 50 11

B5_0c5f:		rts				; 60 


B5_0c60:	.db $df
B5_0c61:		ldy #$10		; a0 10
B5_0c63:		jmp ($c410)		; 6c 10 c4


B5_0c66:		ora ($18), y	; 11 18
B5_0c68:		ora ($38), y	; 11 38
B5_0c6a:		ora ($60), y	; 11 60
B5_0c6c:		ora ($88), y	; 11 88
B5_0c6e:		ora ($a0), y	; 11 a0
B5_0c70:		ora ($c8), y	; 11 c8
B5_0c72:		ora ($e8), y	; 11 e8
B5_0c74:		cli				; 58 
B5_0c75:	.db $3a
B5_0c76:		rts				; 60 


B5_0c77:	.db $62
B5_0c78:	.db $80
B5_0c79:		bvc B5_0c0b ; 50 90

B5_0c7b:		bvc B5_0c1d ; 50 a0

B5_0c7d:		bcc B5_0c0f ; 90 90

B5_0c7f:		bcs B5_0cd1 ; b0 50

B5_0c81:		dey				; 88 
B5_0c82:		bvc B5_0c24 ; 50 a0

B5_0c84:		;removed
	.db $70 $80

B5_0c86:		dey				; 88 
B5_0c87:		cli				; 58 
B5_0c88:	.db $80
B5_0c89:		ora ($80), y	; 11 80
B5_0c8b:	.db $ef
B5_0c8c:	.db $df
B5_0c8d:	.db $80
B5_0c8e:		ora ($80), y	; 11 80
B5_0c90:	.db $df
B5_0c91:	.db $80
B5_0c92:		;removed
	.db $90 $ef

B5_0c94:		ora ($80), y	; 11 80
B5_0c96:		;removed
	.db $d0 $80

B5_0c98:		ora ($90), y	; 11 90
B5_0c9a:		bne B5_0c2c ; d0 90

B5_0c9c:		ora ($a0), y	; 11 a0
B5_0c9e:		bne B5_0c40 ; d0 a0

B5_0ca0:		ldy #$11		; a0 11
B5_0ca2:		ldy #$df		; a0 df
B5_0ca4:	.db $14
B5_0ca5:		sty $eccc		; 8c cc ec
B5_0ca8:	.db $dc
B5_0ca9:		bit $90			; 24 90
B5_0cab:		.db $d0 $70

B5_0cad:		inx				; e8 
B5_0cae:		cli				; 58 
B5_0caf:		clv				; b8 
B5_0cb0:		;removed
	.db $d0 $88

B5_0cb2:		bcc B5_0cec ; 90 38

B5_0cb4:		rts				; 60 


B5_0cb5:		pla				; 68 
B5_0cb6:		rts				; 60 


B5_0cb7:		sec				; 38 
B5_0cb8:	.db $dc
B5_0cb9:		;removed
	.db $70 $b0

B5_0cbb:		sec				; 38 
B5_0cbc:		cpx $60			; e4 60
B5_0cbe:		cpy #$38		; c0 38
B5_0cc0:		jsr $7088		; 20 88 70
B5_0cc3:		sec				; 38 
B5_0cc4:		bit $70			; 24 70
B5_0cc6:		rts				; 60 


B5_0cc7:		sec				; 38 
B5_0cc8:		bit $60			; 24 60
B5_0cca:		;removed
	.db $50 $38

B5_0ccc:		bvs B5_0cb6 ; 70 e8

B5_0cce:		jsr $6098		; 20 98 60
B5_0cd1:		inx				; e8 
B5_0cd2:		bit $b0			; 24 b0
B5_0cd4:		bvc B5_0cbe ; 50 e8

B5_0cd6:		bit $c0			; 24 c0
B5_0cd8:		rti				; 40 


B5_0cd9:		clv				; b8 
B5_0cda:		rti				; 40 


B5_0cdb:		inx				; e8 
B5_0cdc:		bvs B5_0cc6 ; 70 e8

B5_0cde:		cpy #$98		; c0 98
B5_0ce0:		bcc B5_0cca ; 90 e8

B5_0ce2:		cpy $b0			; c4 b0
B5_0ce4:		ldy #$e8		; a0 e8
B5_0ce6:		cpy $c0			; c4 c0
B5_0ce8:		ldy #$38		; a0 38
B5_0cea:		ldy #$68		; a0 68
B5_0cec:		clv				; b8 
B5_0ced:		tay				; a8 
B5_0cee:		cli				; 58 
B5_0cef:		;removed
	.db $b0 $58

B5_0cf1:		.db $d0 $60

B5_0cf3:		.db $c0


screenEntitiesYXPositions:
	.dw $8bd4
	.dw $8bdc
	.dw $8be0
	.dw $8be4
	.dw $8bea
	.dw $8bf0
	.dw $8bf6
	.dw $8bfe
	.dw $8c04
	.dw $8c10
	.dw $8c1a
	.dw $8c1c
	.dw $8c1e
	.dw $8c24
	.dw $8c26
	.dw $8c30
	.dw $8c32
	.dw $8c38
	.dw $8c3c
	.dw $8c3e
	.dw $8c40
	.dw $8c44
	.dw $8c46
	.dw $8c54
	.dw $8c62
	.dw $8c66
	.dw $8c74
	.dw $8c7a
	.dw $8c82
	.dw $8c88
	.dw $8c90
	.dw $8c94
	.dw $8c98
	.dw $8c9c
	.dw $8ca0
	.dw $8ca4
	.dw $8caa
	.dw $8cb0
	.dw $8cc0
	.dw $8ccc
	.dw $8cd8
	.dw $8ce8
	.dw $8cec
	.dw $8cee
	.dw $8cf2