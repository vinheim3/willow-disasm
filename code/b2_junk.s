
; 3fc0 - unused shape $ff
	.db $80 $80 $80 $82 $88 $92 $80 $80
	.db $91 $81 $81 $83 $88 $b0 $b1 $92
	.db $95 $89 $8a $8b $88 $b8 $b9 $92
	.db $9b $90 $88 $88 $88 $88 $88 $92
	.db $88 $88 $88 $88 $88 $88 $88 $92


.org $3fe8
	inc RESET_MMC1_CTRL_REG_ADDR.w
	sei
	cld
	jmp begin


; 3ff0
	.db $da $db $d6 $99 $88 $97 $d6 $c2
	.db $80 $80


.org $3ffa

	.dw nmiVector
	.dw resetVector
	.dw irqVector
