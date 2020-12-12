
npcScriptsData:
	.dw scriptsData_00
	.dw scriptsData_01
	.dw scriptsData_02
	.dw scriptsData_03
	.dw scriptsData_04
	.dw scriptsData_05
	.dw scriptsData_06
	.dw scriptsData_07
	.dw scriptsData_08
	.dw scriptsData_09
	.dw scriptsData_0a
	.dw scriptsData_0b
	.dw scriptsData_0c
	.dw scriptsData_0d
	.dw scriptsData_0e
	.dw scriptsData_0f
	.dw scriptsData_10
	.dw scriptsData_11
	.dw scriptsData_12
	.dw scriptsData_13
	.dw scriptsData_14
	.dw scriptsData_15
	.dw scriptsData_16
	.dw scriptsData_17
	.dw scriptsData_18
	.dw scriptsData_19
	.dw scriptsData_1a
	.dw scriptsData_1b
	.dw scriptsData_1c
	.dw scriptsData_1d
	.dw scriptsData_1e
	.dw scriptsData_1f
	.dw scriptsData_20
	.dw scriptsData_21
	.dw scriptsData_22
	.dw scriptsData_23
	.dw scriptsData_24
	.dw scriptsData_25
	.dw scriptsData_26
	.dw scriptsData_27
	.dw scriptsData_28
	.dw scriptsData_29
	.dw scriptsData_2a
	.dw scriptsData_2b
	.dw scriptsData_2c
	.dw scriptsData_2d
	.dw scriptsData_2e
	.dw scriptsData_2f
	.dw scriptsData_30
	.dw scriptsData_31
	.dw scriptsData_32
	.dw scriptsData_33
	.dw scriptsData_34
	.dw scriptsData_35
	.dw scriptsData_36
	.dw scriptsData_37
	.dw scriptsData_38
	.dw scriptsData_39
	.dw scriptsData_3a
	.dw scriptsData_3b
	.dw scriptsData_3c
	.dw scriptsData_3d
	.dw scriptsData_3e
	.dw scriptsData_3f
	.dw scriptsData_40
	.dw scriptsData_41
	.dw scriptsData_42
	.dw scriptsData_43
	.dw scriptsData_44
	.dw scriptsData_45
	.dw scriptsData_46
	.dw scriptsData_47
	.dw scriptsData_48
	.dw scriptsData_49
	.dw scriptsData_4a
	.dw scriptsData_4b
	.dw scriptsData_4c
	.dw scriptsData_4d
	.dw scriptsData_4e
	.dw scriptsData_4f
	.dw scriptsData_50
	.dw scriptsData_51
	.dw scriptsData_52
	.dw scriptsData_53
	.dw scriptsData_54
	.dw scriptsData_55

scriptsData_00:
	.db $01
	.db GF_LONG_SWORD $07
	.db $06 ; sets GF_LONG_SWORD

scriptsData_01:
	.db $00
	.db $09

scriptsData_02:
	.db $00
	.db $09

scriptsData_03:
	.db $00
	.db $0a

scriptsData_04:
	.db $00
	.db $08

scriptsData_05:
	.db $00
	.db $05

scriptsData_06:
	.db $00
	.db $0c

scriptsData_07:
	.db $01
	.db GF_ACORN_MAGIC $01
	.db $00

scriptsData_08:
	.db $01
	.db GF_ACORN_MAGIC $03
	.db $02 ; sets GF_ACORN_MAGIC

scriptsData_09:
	.db $01
	.db GF_FIREFLOR_MAGIC $13
	.db $12

scriptsData_0a:
	.db $03
	.db GF_FIREFLOR_MAGIC $11
	.db GF_HEALMACE_MAGIC $10
	.db GF_WOOD_SHIELD $0f ; sets GF_HEALMACE_MAGIC
	.db $0e

scriptsData_0b:
	.db $01
	.db GF_FIREFLOR_MAGIC $13
	.db $14

scriptsData_0c:
	.db $00
	.db $09

scriptsData_0d:
	.db $03
	.db GF_DRAGON_SWORD $3a
	.db GF_SCALE_ITEM $6a ; sets GF_DRAGON_SWORD and GF_DRAGON_SHIELD
	.db GF_FIREFLOR_MAGIC $0b
	.db $6f

scriptsData_0e:
	.db $01
	.db GF_WOOD_SHIELD $17
	.db $15 ; sets GF_WOOD_SHIELD

scriptsData_0f:
	.db $00
	.db $09

scriptsData_10:
	.db $01
	.db GF_NOCKMAAR_KEY_ITEM $5e
	.db $5c ; sets GF_NOCKMAAR_KEY_ITEM

scriptsData_11:
	.db $00
	.db $5f

scriptsData_12:
	.db $00
	.db $09

scriptsData_13:
	.db $00
	.db $09

scriptsData_14:
	.db $00
	.db $09

scriptsData_15:
	.db $02
	.db GF_NOCKMAAR_KEY_ITEM $59
	.db GF_UPGRADED_WING_SWORD $5a
	.db $58

scriptsData_16:
	.db $04
	.db GF_TALKED_TO_KAEL_IN_PRISON $1c
	.db GF_CREST_ITEM $72
	.db GF_RED_CRYSTAL_ITEM $4a ; sets GF_CREST_ITEM
	.db GF_BLUE_CRYSTAL_ITEM $47
	.db $46

scriptsData_17:
	.db $02
	.db GF_OCARINA_MAGIC $2b
	.db GF_HERBS_ITEM $1b
	.db $2a ; sets GF_HERBS_ITEM

scriptsData_18:
	.db $01
	.db GF_BRACELET_ITEM $32
	.db $31 ; sets GF_BRACELET_ITEM

scriptsData_19:
	.db $02
	.db GF_SHOES_ITEM $56
	.db GF_TALKED_TO_OLD_LADY_FOR_SHOES $55 ; sets GF_SHOES_ITEM
	.db $54

scriptsData_1a:
	.db $00
	.db $57 ; sets GF_TALKED_TO_OLD_LADY_FOR_SHOES

scriptsData_1b:
	.db $00
	.db $09

scriptsData_1c:
	.db $01
	.db GF_HEALED_FIN_RAZIEL $13
	.db $3f

scriptsData_1d:
	.db $03
	.db GF_FLUTE_ITEM $37
	.db GF_WAKKA_ITEM $39
	.db GF_NECKLACE_ITEM $38 ; sets GF_TRADED_NECKLACE_FOR_WAKKA
	.db $37

scriptsData_1e:
	.db $03
	.db GF_UPGRADED_WING_SWORD $4c
	.db GF_POWDER_ITEM $66
	.db GF_THUNDER_MAGIC $4c
	.db $4b ; sets GF_THUNDER_MAGIC

scriptsData_1f:
	.db $00
	.db $16

scriptsData_20:
scriptsData_21:
	.db $00
	.db $24

scriptsData_22:
	.db $00
	.db $44 ; sets GF_BOMBARD_MAGIC

scriptsData_23:
	.db $00
	.db $6c

scriptsData_24:
	.db $00
	.db $6d

scriptsData_25:
	.db $00
	.db $04

scriptsData_26:
	.db $00
	.db $71

scriptsData_27:
	.db $00
	.db $0d

scriptsData_28:
	.db $01
	.db GF_FIREFLOR_MAGIC $13
	.db $18

scriptsData_29:
	.db $00
	.db $19

scriptsData_2a:
	.db $00
	.db $1a

scriptsData_2b:
	.db $01
	.db GF_STATUE_ITEM $20 ; sets GF_HANDED_GOLD_STATUE
	.db $1f

scriptsData_2c:
	.db $01
	.db GF_RING_ITEM $1e
	.db $21 ; sets GF_RING_ITEM

scriptsData_2d:
	.db $01
	.db GF_BATTLE_SWORD $1e
	.db $22 ; sets GF_BATTLE_SWORD

scriptsData_2e:
	.db $01
	.db GF_STATUE_ITEM $1e
	.db $23 ; sets GF_STATUE_ITEM

scriptsData_2f:
	.db $01
	.db GF_SMALL_SHIELD $1e
	.db $26 ; sets GF_SMALL_SHIELD

scriptsData_30:
	.db $01
	.db GF_FIREFLOR_MAGIC $28
	.db $27

scriptsData_31:
	.db $00
	.db $29

scriptsData_32:
	.db $01
	.db GF_GOLD_SHIELD $1e
	.db $2c ; sets GF_GOLD_SHIELD

scriptsData_33:
	.db $00
	.db $2d ; sets GF_OCARINA_MAGIC

scriptsData_34:
	.db $01
	.db GF_SCALE_ITEM $1e
	.db $2f ; sets GF_SCALE_ITEM

scriptsData_35:
	.db $01
	.db GF_FLAME_SWORD $1e
	.db $30 ; sets GF_FLAME_SWORD

scriptsData_36:
	.db $00
	.db $33 ; sets GF_CANE_MAGIC

scriptsData_37:
	.db $01
	.db GF_HANDCUFFS_KEY_ITEM $36 ; sets GF_NECKLACE_ITEM
	.db $34

scriptsData_38:
	.db $01
	.db GF_HANDCUFFS_KEY_ITEM $1e
	.db $35 ; sets GF_HANDCUFFS_KEY_ITEM

scriptsData_39:
	.db $01
	.db GF_METAL_SHIELD $1e
	.db $3b ; sets GF_METAL_SHIELD

scriptsData_3a:
	.db $00
	.db $3c ; sets GF_WING_SWORD

scriptsData_3b:
	.db $01
	.db GF_RENEW_MAGIC $1e
	.db $3d ; sets GF_RENEW_MAGIC

scriptsData_3c:
	.db $01
	.db GF_TERSTORM_MAGIC $1e
	.db $3e ; sets GF_TERSTORM_MAGIC

scriptsData_3d:
	.db $00
	.db $42 ; sets GF_FLUTE_ITEM

scriptsData_3e:
	.db $00
	.db $43 ; sets GF_WAKKA_ITEM

scriptsData_3f:
	.db $01
	.db GF_FLEET_MAGIC $1e
	.db $45 ; sets GF_FLEET_MAGIC

scriptsData_40:
	.db $00
	.db $48 ; sets GF_BLUE_CRYSTAL_ITEM

scriptsData_41:
	.db $00
	.db $49 ; sets GF_RED_CRYSTAL_ITEM

scriptsData_42:
	.db $01
	.db GF_SPECTER_MAGIC $1e
	.db $4d ; sets GF_SPECTER_MAGIC

scriptsData_43:
	.db $01
	.db GF_HEALBALL_MAGIC $1e
	.db $4e ; sets GF_HEALBALL_MAGIC

scriptsData_44:
	.db $00
	.db $1e

scriptsData_45:
	.db $01
	.db GF_TAIL_SHIELD $1e
	.db $50 ; sets GF_TAIL_SHIELD

scriptsData_46:
	.db $01
	.db GF_WONDER_SWORD $1e
	.db $51 ; sets GF_WONDER_SWORD

scriptsData_47:
	.db $01
	.db GF_BATTLE_SHIELD $1e
	.db $52 ; sets GF_BATTLE_SHIELD

scriptsData_48:
	.db $01
	.db GF_DEVIL_EYE_SWORD $1e
	.db $53 ; sets GF_DEVIL_EYE_SWORD

scriptsData_49:
	.db $00
	.db $5b ; sets GF_UNLOCKED_TIR_ASLEEN_CASTLE

scriptsData_4a:
	.db $00
	.db $60 ; sets GF_KAISER_SWORD

scriptsData_4b:
	.db $00
	.db $61 ; sets GF_TALKED_TO_KAEL_IN_PRISON and unsets GF_CREST_ITEM

scriptsData_4c:
	.db $01
	.db GF_SPOKE_TO_MADMARTIGAN_IN_PRISON $63
	.db $62 ; sets GF_SPOKE_TO_MADMARTIGAN_IN_PRISON

scriptsData_4d:
	.db $00
	.db $64 ; sets GF_POWDER_ITEM

scriptsData_4e:
	.db $00
	.db $65

scriptsData_4f:
	.db $00
	.db $67

scriptsData_50:
	.db $00
	.db $69 ; sets GF_UPGRADED_WING_SWORD

scriptsData_51:
	.db $00
	.db $6b ; sets GF_USED_POWDER_ON_MADMARTIGAN

scriptsData_52:
	.db $00
	.db $1e

scriptsData_53:
	.db $00
	.db $25 ; sets GF_FIREFLOR_MAGIC

scriptsData_54:
	.db $00
	.db $6e ; sets GF_CREST_ITEM

scriptsData_55:
	.db $01
	.db GF_FURY_SHIELD $1e
	.db $4f ; sets GF_FURY_SHIELD
