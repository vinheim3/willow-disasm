.org $3fe8

	inc RESET_MMC1_CTRL_REG_ADDR.w
	sei
	cld
	jmp begin


.org $3ffa

	.dw nmiVector
	.dw resetVector
	.dw irqVector
