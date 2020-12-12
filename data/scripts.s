scriptAddresses:
	.dw script_00
	.dw script_01
	.dw script_02
	.dw script_03
	.dw script_04
	.dw script_05
	.dw script_06
	.dw script_07
	.dw script_08
	.dw script_09
	.dw script_0a
	.dw script_0b
	.dw script_0c
	.dw script_0d
	.dw script_0e
	.dw script_0f
	.dw script_10
	.dw script_11
	.dw script_12
	.dw script_13
	.dw script_14
	.dw script_15
	.dw script_16
	.dw script_17
	.dw script_18
	.dw script_19
	.dw script_1a
	.dw script_1b
	.dw script_1c
	.dw script_1d
	.dw script_1e
	.dw script_1f
	.dw script_20
	.dw script_21
	.dw script_22
	.dw script_23
	.dw script_24
	.dw script_25
	.dw script_26
	.dw script_27
	.dw script_28
	.dw script_29
	.dw script_2a
	.dw script_2b
	.dw script_2c
	.dw script_2d
	.dw script_2e
	.dw script_2f
	.dw script_30
	.dw script_31
	.dw script_32
	.dw script_33
	.dw script_34
	.dw script_35
	.dw script_36
	.dw script_37
	.dw script_38
	.dw script_39
	.dw script_3a
	.dw script_3b
	.dw script_3c
	.dw script_3d
	.dw script_3e
	.dw script_3f
	.dw script_40
	.dw script_41
	.dw script_42
	.dw script_43
	.dw script_44
	.dw script_45
	.dw script_46
	.dw script_47
	.dw script_48
	.dw script_49
	.dw script_4a
	.dw script_4b
	.dw script_4c
	.dw script_4d
	.dw script_4e
	.dw script_4f
	.dw script_50
	.dw script_51
	.dw script_52
	.dw script_53
	.dw script_54
	.dw script_55
	.dw script_56
	.dw script_57
	.dw script_58
	.dw script_59
	.dw script_5a
	.dw script_5b
	.dw script_5c
	.dw script_5d
	.dw script_5e
	.dw script_5f
	.dw script_60
	.dw script_61
	.dw script_62
	.dw script_63
	.dw script_64
	.dw script_65
	.dw script_66
	.dw script_67
	.dw script_68
	.dw script_69
	.dw script_6a
	.dw script_6b
	.dw script_6c
	.dw script_6d
	.dw script_6e
	.dw script_6f
	.dw script_70
	.dw script_71
	.dw script_72

script_00:
	.asc "OH, MY DEAR "
	.db $f7 $12
	.asc "."
	.db $fd $f7 $7b
	.asc " GET TIRED DURING"
	.db $fe $f7 $1f
	.asc " TRIP"
	.db $fe $f7 $2a $f7 $b5
	.asc " "
	.db $f7 $86 $fd $f7
	.asc "W REGAIN "
	.db $f7 $1f $fe $f7 $3a
	.asc "."
	.db $fd $f7 $66
	.asc " YOU BEGIN "
	.db $f7 $1f $fe
	.asc "TRIP YOU "
	.db $f7
	.asc "1"
	.db $f7 $96 $fe $f7 $1f
	.asc " NEIGHBOR, THE HIGH"
	.db $fd
	.asc "ALDWIN."
	.db $fe
	.asc "BE "
	.db $f7 $18
	.asc "."
	.db $ff

script_01:
	.db $f7
	.asc ", HOME "
	.db $f7 $12
	.asc "."
	.db $fe $f7 $1b
	.asc " RELAX AND REST"
	.db $fe $f7 $1f
	.asc " "
	.db $f7 $ad $40 $fc
	.asc "2"
	.db $fd
	.asc "BE "
	.db $f7 $18
	.asc " "
	.db $f7 $12
	.asc "."
	.db $ff

script_02:
	.asc "AH "
	.db $f7 $12
	.asc ", "
	.db $f7 $1c
	.asc "'S MAN"
	.db $fe
	.asc "OF PROPHECY."
	.db $fd
	.asc "TAKE THESE "
	.db $f7 $14 $fe
	.asc "ACORNS "
	.db $f7 $aa $fd
	.asc "THEY CAN TURN "
	.db $f7
	.asc "J"
	.db $fe
	.asc "TO STONE SO IT CAN'T"
	.db $fe
	.asc "MOVE."
	.db $fd $f7 $35 $f7 $14 $fe
	.asc "ACORNS!>"
	.db $fb
	scr_setGlobalFlag GF_ACORN_MAGIC
	.db $fc
	.asc "0"
	.db $fd $f7 $7b
	.asc " "
	.db $f7 $2a $f7 $b6 $fe
	.asc "DURING "
	.db $f7 $1f
	.asc " TRIP "
	.db $f7
	.asc "V"
	.db $fe $f7 $a9 $fd $f7 $14
	.asc "AL "
	.db $f7 $1e
	.asc "."
	.db $ff

script_03:
	.asc "WELCOME BACK, "
	.db $f7 $12
	.asc "!"
	.db $fd $f7
	.asc "V "
	.db $f7 $a9 $fe $f7 $14
	.asc "AL "
	.db $f7 $1e
	.asc "."
	.db $fc
	.asc "0"
	.db $ff

script_04:
	.asc "DID YOU MEET "
	.db $f7 $0b
	.asc ","
	.db $fe
	.asc "THE BEST SWORDSMAN IN"
	.db $fe
	.asc "THE "
	.db $f7 $15 $3f $fd
	.asc "HE "
	.db $f7
	.asc "1 BE PREPARING"
	.db $fe
	.asc "THE FINEST "
	.db $f7 $ac $fe
	.asc "FOR YOU."
	.db $ff

script_05:
	.db $f7 $7e
	.asc "HEARD RUMORS"
	.db $f7 $a5 $fe
	.asc "A "
	.db $f7 $33
	.asc " IS IN THE"
	.db $fe $f7 $7f
	.asc ", JUST"
	.db $fd $f7 $34
	.asc " OF"
	.db $f7 $b6
	.asc ", AND"
	.db $fe
	.asc "HAS BEEN TERRIFYING"
	.db $fd
	.asc "THE "
	.db $f7 $15
	.asc "RS."
	.db $ff

script_06:
	.db $f7
	.asc ", "
	.db $f7 $12
	.asc "."
	.db $fe $f7 $5d
	.asc " "
	.db $f7 $0b
	.asc "."
	.db $fe $f7 $1b
	.asc " TAKE"
	.db $fd
	.asc "THIS LONG "
	.db $f7 $16
	.asc "."
	.db $fe $f7 $35
	.asc "LONG"
	.db $fe $f7 $16
	.asc "!>"
	.db $fb
	scr_setGlobalFlag GF_LONG_SWORD
	.db $fd
	.asc "IT MAY BE HEAVY AND HARD"
	.db $fe
	.asc "TO USE AT FIRST "
	.db $f7 $ab $fe $f7
	.asc "1 GET USED TO IT"
	.db $fd
	.asc "AFTER A FEW "
	.db $f7 $6a
	.asc "S."
	.db $ff

script_07:
	.asc "GREAT, "
	.db $f7 $12
	.asc ". YOU SEEM"
	.db $fe
	.asc "COMPETENT"
	.db $f7 $b2
	.asc "THE"
	.db $fe
	.asc "LONG "
	.db $f7 $16
	.asc " NOW."
	.db $ff

script_08:
	.asc "YOU "
	.db $f7 $8d
	.asc " "
	.db $f7 $12
	.asc "!"
	.db $fe $f7 $ac
	.asc " AND "
	.db $f7 $14
	.asc " ITEMS"
	.db $fe $f7 $8d
	.asc " IN HAND IN"
	.db $fd
	.asc "ORDER TO USE THEM,"
	.db $fe
	.asc "SO BE "
	.db $f7 $18
	.asc "."
	.db $ff

script_09:
	.asc "<IT "
	.db $f7
	.asc "A NOBODY IS"
	.db $fe $f7 $88
	.asc ".>"
	.db $ff

script_0a:
	.db $f7 $12
	.asc ","
	.db $fe
	.asc "TO STOP "
	.db $f7
	.asc "0'S "
	.db $f7 $14 $fd $f7
	.asc "X DISPEL"
	.db $fe
	.asc "THE CURSE SHE PUT ON"
	.db $fe $f7
	.asc "8."
	.db $ff

script_0b:
	.db $f7 $1b
	.asc " REST"
	.db $f7 $b5 $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $fd
	.asc "BY THE WAY"
	.db $40 $fe
	.asc "HAVE YOU HEARD "
	.db $f7 $8e $fe
	.asc "THE "
	.db $f7
	.asc "L "
	.db $f7 $d4
	.asc "S"
	.db $3f $fd
	.asc "IT'S SAID"
	.db $f7 $a3
	.asc "THEY'RE"
	.db $fe
	.asc "PROOF "
	.db $f7 $99
	.asc " "
	.db $f7 $6a $fe
	.asc "BETWEEN AN "
	.db $f7 $2b
	.asc "R"
	.db $fd
	.asc "AND A VICIOUS "
	.db $f7
	.asc "L"
	.db $fe $f7 $d5
	.asc " "
	.db $f7 $77
	.asc "."
	.db $fe
	.asc "I USE "
	.db $f7 $95
	.asc " A BLACKSMITH"
	.db $fd $f7 $9b $f7 $15
	.asc "."
	.db $fe
	.asc "JUST ONCE I "
	.db $f7
	.asc "N "
	.db $f7 $cc $fe
	.asc "TO MAKE A "
	.db $f7 $b3 $fd $f7 $16 $f7 $b2
	.asc "THOSE "
	.db $f7 $d4
	.asc "S."
	.db $fd $f7 $7b
	.asc " FIND THEM, "
	.db $f7 $1b $fe
	.asc "BRING THEM TO ME."
	.db $ff

script_0c:
	.db $f7 $89
	.asc " "
	.db $f7 $60
	.asc " "
	.db $f7 $15
	.asc " OF"
	.db $fe
	.asc "DEW, "
	.db $f7
	.asc "X GO "
	.db $f7 $61
	.asc " "
	.db $fe
	.asc "THE RUGGED "
	.db $f7 $26
	.asc " JUST"
	.db $fd $f7 $34
	.asc " OF "
	.db $f7 $1c
	.asc "."
	.db $ff

script_0d:
	.asc "YOU "
	.db $f7
	.asc "1 BE"
	.db $fe $f7 $67
	.asc " GET "
	.db $f7 $60 $fe $f7 $7f
	.asc " "
	.db $f7 $7b $fd
	.asc "KEEP "
	.db $f7 $94
	.asc " "
	.db $f7 $34
	.asc " ON"
	.db $f7 $9f $fe
	.asc "ROAD."
	.db $ff

script_0e:
	.asc "I AM THE CHIEF "
	.db $f7 $99 $fe $f7 $7f
	.asc "."
	.db $fd $f7
	.asc "<"
	.db $fe
	.asc "OUTSIDERS"
	.db $fd
	.asc "MUST LEAVE IMMEDIATELY."
	.db $ff

script_0f:
	.asc "THE STORY OF "
	.db $f7 $0e
	.asc " IS"
	.db $fe
	.asc "TRUE. MY"
	.db $f7 $c4
	.asc "WAS A"
	.db $fd $f7 $19
	.asc "OUS AND JUST"
	.db $fe $f7 $68
	.asc " BEFORE BEING"
	.db $fd
	.asc "PUT UNDER SUCH"
	.db $fe $f7
	.asc "G "
	.db $f7 $14
	.asc "."
	.db $fe
	.asc "THE "
	.db $f7 $15
	.asc "RS HAVE"
	.db $fd
	.asc "BEEN PUT "
	.db $f7 $61
	.asc " SUCH"
	.db $fe
	.asc "MISERY"
	.db $40 $fd $f7
	.asc "V "
	.db $f7 $80
	.asc "THIS"
	.db $fe $f7 $14
	.asc " HEALMACE."
	.db $fd $f7 $84
	.asc " A VALUED"
	.db $fe $f7 $6c $f7 $9a
	.asc " "
	.db $f7 $15 $fd
	.asc "AND IS A SYMBOL OF A"
	.db $fe $f7 $0f
	.asc " PROTECTING US."
	.db $fd
	.asc "WHEN "
	.db $f7
	.asc "U TIRED FROM"
	.db $fe $f7 $6a
	.asc "ING, JUST CLUTCH"
	.db $fe
	.asc "THE HEALMACE TIGHTLY"
	.db $fd
	.asc "AND SAY THE "
	.db $f7 $14
	.asc " WORD"
	.db $fe
	.asc "AND "
	.db $f7 $86
	.asc " REGAIN"
	.db $fe $f7 $1f
	.asc " "
	.db $f7 $3a
	.asc "."
	.db $fd $f7 $35
	.asc "HEALMACE.>"
	.db $fb
	scr_setGlobalFlag GF_HEALMACE_MAGIC
	.db $fc
	.asc "0"
	.db $ff

script_10:
	.db $f7
	.asc "U THE ONLY ONE WHO"
	.db $fe
	.asc "CAN TRANSFORM"
	.db $fd
	.asc "DEW "
	.db $f7 $bc $f7 $d3
	.asc " A"
	.db $fe $f7 $1d
	.asc "FUL "
	.db $f7 $15
	.asc "."
	.db $ff

script_11:
	.asc "OH, WHAT A "
	.db $f7 $19
	.asc "OUS"
	.db $fe $f7 $af
	.asc "!"
	.db $fd $f7
	.asc "> VERY MUCH."
	.db $ff

script_13:
	.db $f7
	.asc "> "
	.db $f7 $12
	.asc "!"
	.db $ff

script_14:
	.asc "THE "
	.db $f7 $33
	.asc " "
	.db $f7 $0e
	.asc " TAKES"
	.db $fe
	.asc "ALL "
	.db $f7 $99
	.asc " FRUIT"
	.db $fd
	.asc "GROW IN OUR "
	.db $f7 $15
	.asc ","
	.db $fe
	.asc "AND OUR GOLD AND"
	.db $fe
	.asc "SILVER, TOO!"
	.db $ff

script_15:
	.db $f7 $7c $fe $f7 $0e
	.asc " IS THE"
	.db $f7 $c4
	.asc "OF"
	.db $fd
	.asc "THE CHIEF"
	.db $f7 $9a $fe $f7 $15
	.asc ", AND HE WAS"
	.db $fe $f7 $73
	.asc "D "
	.db $f7 $d3
	.asc " A "
	.db $f7 $33
	.asc " BY"
	.db $fd
	.asc "THE "
	.db $f7
	.asc "G "
	.db $f7 $14
	.asc " OF"
	.db $fe $f7
	.asc "0."
	.db $fd
	.asc "HEY, IT LOOKS LIKE YOU"
	.db $fe
	.asc "COULD USE"
	.db $f7 $9d $f7
	.asc " !"
	.db $fd $f7 $35
	.asc "WOOD"
	.db $fe $f7
	.asc " !>"
	.db $fb
	scr_setGlobalFlag GF_WOOD_SHIELD
	.db $fd
	.asc "YOU "
	.db $f7
	.asc "1 HEAR THE"
	.db $fe
	.asc "STORY FROM THE "
	.db $f7 $15 $fe
	.asc "CHIEF."
	.db $ff

script_16:
	.asc "OH, "
	.db $f7 $12
	.asc "!"
	.db $fe
	.asc "I'LL TAKE YOU ANY"
	.db $f7 $6e $fe $f7 $90
	.asc "TO GO."
	.db $fd $fc
	.asc "1"
	.db $fd
	.asc "AL"
	.db $f7 $70 $fe
	.asc "THEN, HANG ON TIGHT!"
	.db $ff

script_12:
script_17:
	.db $f7 $1b $f7 $c9 $f7 $1d
	.asc " "
	.db $f7 $bc $fe
	.asc "TO"
	.db $f7 $9d $f7 $7f
	.asc "!"
	.db $ff

script_18:
	.asc "I "
	.db $f7 $98 $f7 $a3 $f7 $0e $fe
	.asc "LIVES IN THE "
	.db $f7 $26 $fe $f7 $34 $f7 $9a
	.asc " "
	.db $f7 $15
	.asc "."
	.db $ff

script_19:
	.db $f7 $7b
	.asc " GO WEST FROM"
	.db $f7 $b6 $fe $f7 $86
	.asc " SEE"
	.db $fe
	.asc "A ROAD"
	.db $f7 $a3
	.asc "GOES "
	.db $f7 $61 $fd
	.asc "THE ROCK "
	.db $f7 $82
	.asc "."
	.db $fd
	.asc "AS YOU GO "
	.db $f7 $c5 $fe $f7 $86
	.asc " FIND THE"
	.db $fe
	.asc "ENTRANCE "
	.db $f7 $60
	.asc " CAVE."
	.db $fd $f7
	.asc "IS "
	.db $f7 $87 $fe
	.asc "HEAR A WEIRD VOICE FROM"
	.db $fe
	.asc "INSIDE."
	.db $ff

script_1a:
	.db $f7 $6d
	.asc " ARE TWO RED TOWERS"
	.db $fe
	.asc "STANDING SIDE BY SIDE ON"
	.db $fd
	.asc "THE "
	.db $f7 $c3
	.asc " SIDE "
	.db $f7 $99 $fe $f7 $cd
	.asc "."
	.db $fd $f7
	.asc "0 HAS CLOSED"
	.db $fe
	.asc "THE ROAD"
	.db $f7 $a3
	.asc "LEADS"
	.db $fd
	.asc "TO THE TOWERS SO NO ONE"
	.db $fe
	.asc "CAN GO NEAR THEM!"
	.db $fd $f7 $6d
	.asc " "
	.db $f7 $8d
	.asc " SOME KIND"
	.db $fe
	.asc "OF SECRET "
	.db $f7 $6d
	.asc "."
	.db $fe
	.asc "I'M"
	.db $f7 $b4
	.asc " "
	.db $f7
	.asc "0 IS"
	.db $fd $f7 $c0
	.asc " IT!"
	.db $ff

script_1b:
	.db $40 $40 $40 $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $fd
	.asc "I'M SO WORRIED "
	.db $f7 $8e
	.asc "PO"
	.db $40 $ff

script_1c:
	.asc "OH, HOW HORRIBLE!"
	.db $fe
	.asc "HURRY UP AND RETRIEVE THE"
	.db $fe $f7 $8b
	.asc " OF THE "
	.db $f7 $0f
	.asc "S!"
	.db $ff

script_1d:
	.asc "WHAT DO YOU STILL NEED"
	.db $fe
	.asc "WITH ME"
	.db $3f $ff

script_1e:
	.asc "<"
	.db $f7
	.asc "K"
	.db $f7 $bf
	.asc " IN THE"
	.db $fe $f7 $6c
	.asc " CHEST.>"
	.db $ff

script_1f:
	.asc "YOU"
	.db $f7 $7a
	.asc "SEE "
	.db $f7 $0e
	.asc "!"
	.db $fd
	.asc "IF"
	.db $f7 $a5
	.asc "'S THE CASE, FIND"
	.db $fe
	.asc "AND"
	.db $f7 $c9
	.asc "BACK"
	.db $fe $f7 $81 $f7 $a3
	.asc "THE"
	.db $fd $f7 $15
	.asc "RS HID "
	.db $f7 $9b $fe $f7 $26
	.asc "."
	.db $fe $f7
	.asc "!!"
	.db $ff

script_20:
	.db $f7 $0e
	.asc " IS "
	.db $f7 $9b
	.asc "CAVE."
	.db $fd $f7 $b0
	.asc "YOU HAND OVER"
	.db $fe $f7 $81
	.asc " "
	.db $f7
	.asc "X"
	.db $fe
	.asc "RETURN"
	.db $f7 $b5 $fd $f7
	.asc "!!"
	scr_setGlobalFlag GF_HANDED_GOLD_STATUE
	.db $ff

script_21:
	.db $f7 $35
	.asc "RING.>"
	.db $fb
	scr_setGlobalFlag GF_RING_ITEM
	.db $f3 $fd
	.asc "<WHEN YOU WEAR IT "
	.db $f7 $1f $fe $f7 $3a
	.asc " INCREASES.>"
	.db $ff

script_22:
	.db $f7 $35
	.asc "BATTLE"
	.db $fe $f7 $16
	.asc "!>"
	.db $fb
	scr_setGlobalFlag GF_BATTLE_SWORD
	.db $fd
	.asc "<"
	.db $f7
	.asc "Y A SOLID AND"
	.db $fe
	.asc "FAIRLY HEAVY "
	.db $f7 $16
	.asc ".>"
	.db $fd $f7 $22 $fe $f7 $23 $fb $fc
	.asc "2"
	.db $ff

script_23:
	.db $f7 $35
	.asc "GOLD"
	.db $fe
	.asc "STATUE.>"
	.db $fb
	scr_setGlobalFlag GF_STATUE_ITEM
	.db $fd
	.asc "<"
	.db $f7
	.asc "Y A GOLDEN IMAGE OF"
	.db $fe
	.asc "A HUMAN FACE.>"
	.db $fd $f7 $22 $fe $f7 $23 $fb $fc
	.asc "2"
	.db $ff

script_24:
	.asc "SO "
	.db $f7
	.asc "Y YOU."
	.db $fe
	.asc "THE YOUNGSTER WITH"
	.db $fe $f7 $81
	.asc "."
	.db $fd
	.asc "WHAT!"
	.db $3f
	.asc " YOU WON'T GIVE ME"
	.db $fe
	.asc "THE STATUE."
	.db $fe $f7
	.asc "! "
	.db $f7
	.asc "!!!"
	.db $fd
	.asc "DO YOU INTEND TO OPPOSE"
	.db $fe
	.asc "ME"
	.db $3f $fd
	.asc "YOU PITIFUL CREATURE!!"
	.db $f2 $ff

script_25:
	.asc "OH! "
	.db $f7 $6e
	.asc " AM I"
	.db $3f $fe
	.asc "OH YES, I "
	.db $f7 $ae
	.asc "NOW."
	.db $fe $f7 $1b
	.asc " "
	.db $f7 $6a
	.asc " FOR "
	.db $f7 $1d
	.asc "."
	.db $fd $f7
	.asc "V TEACH YOU THE"
	.db $fe $f7 $14
	.asc " OF FLOWING FIRE."
	.db $fd
	.asc "IT "
	.db $f7
	.asc "1 BE OF HELP TO"
	.db $fe
	.asc "YOU."
	.db $fd $f7 $35 $f7 $14
	.asc " OF"
	.db $fe
	.asc "FLOWING FIRE.>"
	.db $fb
	scr_setGlobalFlag GF_FIREFLOR_MAGIC
	.db $fc
	.asc "0"
	.db $fd
	.asc "IF "
	.db $f7 $79
	.asc " MORE"
	.db $fe $f7 $8e $f7 $13
	.asc " "
	.db $f7
	.asc "0, GO"
	.db $fe
	.asc "AND"
	.db $f7 $96
	.asc " "
	.db $f7
	.asc "2,"
	.db $fd
	.asc "THE "
	.db $f7 $24
	.asc " WHO LIVES WEST"
	.db $fe $f7 $99
	.asc " "
	.db $f7 $7f
	.asc " IN"
	.db $fd
	.asc "LEGENDARY "
	.db $f7 $cd
	.asc " CHEEF."
	scr_setRoomYX $02 $02
	.db $ff

script_26:
	.db $f7 $35
	.asc "SMALL"
	.db $fe $f7
	.asc " !>"
	.db $fb
	scr_setGlobalFlag GF_SMALL_SHIELD
	.db $fd
	.asc "<"
	.db $f7
	.asc "Y A STRONG "
	.db $f7
	.asc " "
	.db $fe
	.asc "MADE OF METAL.>"
	.db $ff

script_27:
	.db $f7
	.asc "Q"
	.db $fe
	.asc "CLAN."
	.db $fe $ff

script_28:
	.db $f7
	.asc "Q"
	.db $fe
	.asc "CLAN. OUR "
	.db $f7 $15
	.asc " IS IN"
	.db $fd
	.asc "THE "
	.db $f7 $26
	.asc " NEAR "
	.db $f7 $cd $fe
	.asc "CHEEF."
	.db $fe
	.asc "WHEN WE WENT "
	.db $f7 $60 $fd $f7 $7f
	.asc " "
	.db $f7 $76 $fe
	.asc "FOR FOOD, "
	.db $f7 $0e
	.asc " PUT A"
	.db $fd
	.asc "STRANGE SPELL ON THE"
	.db $fe
	.asc "BRIDGE SO WE COULD NOT"
	.db $fe
	.asc "GET OUT. BUT THANKS TO"
	.db $fd
	.asc "YOU, IT "
	.db $f7
	.asc "A WE"
	.db $fe
	.asc "CAN FINALLY RETURN"
	.db $fe
	.asc "TO OUR "
	.db $f7 $15
	.asc "."
	.db $fd $f7
	.asc ">!"
	.db $ff

script_29:
	.asc "WE ARE "
	.db $f7
	.asc "3 AND "
	.db $f7
	.asc "4"
	.db $fe $f7 $99
	.asc " BROWNIES CLAN!"
	.db $fd $f7
	.asc "3"
	.db $3a $fe
	.asc " "
	.db $f7
	.asc "<"
	.db $fd $f7
	.asc "4"
	.db $3a $fe
	.asc " "
	.db $f7
	.asc "<"
	.db $fd $f7
	.asc "3"
	.db $3a $fe
	.asc " YOU "
	.db $f7 $85
	.asc "SEE THE"
	.db $fe
	.asc " "
	.db $f7 $24
	.asc " "
	.db $f7
	.asc "2"
	.db $3f $fd
	.asc " "
	.db $f7
	.asc "!!"
	.db $fd
	.asc " "
	.db $f7
	.asc "2 IS THE"
	.db $fe
	.asc " "
	.db $f7 $24
	.asc " OF "
	.db $f7 $32 $fe
	.asc " "
	.db $f7 $cd
	.asc " CHEEF."
	.db $fd $f7
	.asc "4"
	.db $3a $fe
	.asc " SHE IS."
	.db $fd $f7
	.asc "3"
	.db $3a $fe
	.asc " "
	.db $f7 $7b
	.asc " DO WHAT WE SAY,"
	.db $fd
	.asc " WE CAN TELL YOU HOW TO"
	.db $fe
	.asc " GET TO "
	.db $f7 $cd
	.asc " CHEEF."
	.db $fd $f7
	.asc "4"
	.db $3a $fe
	.asc " WE CAN."
	.db $fd $f7
	.asc "3"
	.db $3a $fe
	.asc " "
	.db $f7 $7b
	.asc " GO "
	.db $f7 $34
	.asc " FROM"
	.db $fe
	.asc " HERE "
	.db $f7 $61 $fd
	.asc " DEATH "
	.db $f7 $26
	.asc ", "
	.db $f7
	.asc "K"
	.db $fe
	.asc " A CAVE "
	.db $f7 $6e
	.asc " A "
	.db $f7
	.asc "L"
	.db $fe
	.asc " "
	.db $f7 $d5
	.asc " "
	.db $f7 $77
	.asc " LIVES."
	.db $fd
	.asc " "
	.db $f7 $38
	.asc " "
	.db $f7 $77
	.asc " AND"
	.db $fe $f7 $c9
	.asc "THE "
	.db $f7 $5c
	.asc " BALL"
	.db $fe
	.asc " OF LIFE "
	.db $f7 $bb
	.asc " US."
	.db $fd
	.asc " "
	.db $f7
	.asc "!!"
	.db $fe $f7
	.asc "4"
	.db $3a $fe
	.asc " "
	.db $f7
	.asc "!!"
	.db $ff

script_2a:
	.db $40 $40
	.asc ","
	.db $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $fd
	.asc "WHAT IS"
	.db $f7 $9f $3f
	.asc " STORMING"
	.db $fe $f7 $d3
	.asc " "
	.db $f7 $6f
	.asc "'S HOME"
	.db $fe
	.asc "UNANNOUNCED"
	.db $3f $fd
	.asc "WAIT!"
	.db $fe
	.asc "YOU'RE JUST IN TIME."
	.db $fe
	.asc "MY DARLING PET HAS RUN"
	.db $fd
	.asc "OFF SOME"
	.db $f7 $6e
	.asc ". WON'T"
	.db $fe
	.asc "YOU "
	.db $f7 $1b
	.asc " FIND"
	.db $fe
	.asc "HIM"
	.db $3f
	.asc " HIS NAME IS PO."
	.db $fd
	.asc "HE IS "
	.db $f7 $78
	.asc " CUTE."
	.db $fe
	.asc "YOU'LL"
	.db $fe $f7 $cc
	.asc " HIM FOR"
	.db $f7 $b4
	.asc "."
	.db $fd
	.asc "HOLD ON, TAKE THESE"
	.db $fe $f7 $75
	.asc "HERBS IN CASE"
	.db $fe
	.asc "HE IS HURT."
	.db $fd
	.asc "<"
	.db $f7
	.asc "BOBTAINED"
	.db $fe
	.asc "THE "
	.db $f7 $75
	.asc "HERBS.>"
	.db $fb
	scr_setGlobalFlag GF_HERBS_ITEM
	.db $fd
	.asc "TAKE CARE."
	.db $ff

script_2b:
	.db $40 $40
	.asc ","
	.db $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $ff

script_2c:
	.asc "<"
	.db $f7
	.asc "BOBTAINED THE"
	.db $fe
	.asc "GOLD "
	.db $f7
	.asc " .>"
	.db $fb
	scr_setGlobalFlag GF_GOLD_SHIELD
	.db $fd
	.asc "<"
	.db $f7 $92
	.asc "A"
	.db $fe $f7 $16
	.asc "SMAN IS WRITTEN ON"
	.db $fd
	.asc "THE INSIDE, BUT "
	.db $f7
	.asc "Y"
	.db $fe
	.asc "TOO OLD TO READ.>"
	.db $fd $f7 $22 $fe $f7 $23 $fb $fc
	.asc "2"
	.db $ff

script_2d:
	.asc "OH, "
	.db $f7
	.asc ">!"
	.db $fe
	.asc "YES, "
	.db $f7 $5d
	.asc " PO."
	.db $fd $f7 $a4 $f7 $26
	.asc " OF DEATH"
	.db $fe
	.asc "GIVES ME THE CREEPS."
	.db $fd $f7
	.asc "IS I JUST HAVE"
	.db $fe $f7 $89
	.asc " OUT OF "
	.db $f7 $6d
	.asc "."
	.db $fd
	.asc "ANYWAY, THE SENILE"
	.db $fe
	.asc "OLD "
	.db $f7
	.asc "L "
	.db $f7 $bc $f7 $6d
	.asc ","
	.db $fd $f7 $77
	.asc ", GOT "
	.db $f7 $78 $fe
	.asc "HUFFY, WAVING HIS BIG"
	.db $fe
	.asc "TAIL "
	.db $f7 $88
	.asc " JUST "
	.db $f7
	.asc "5"
	.db $fd
	.asc "I PLAYED"
	.db $f7 $b2
	.asc "THE"
	.db $fe $f7 $5c
	.asc " BALL A LITTLE"
	.db $fe
	.asc "BIT. HE DAMAGED MY PRIZE"
	.db $fd $f7 $c2
	.asc "S. BUT THANKS TO"
	.db $fe
	.asc "YOU, "
	.db $f7 $7d
	.asc "SAVED."
	.db $fd
	.asc "HEY, I "
	.db $f7 $d1
	.asc "! I'LL GIVE"
	.db $fe
	.asc "YOU"
	.db $f7 $9d
	.asc "OCARINA WHICH I"
	.db $fe
	.asc "PICKED UP IN THE "
	.db $f7 $26
	.asc "."
	.db $fd $f7 $35 $f7 $14 $fe
	.asc "OCARINA!>"
	.db $fb
	scr_setGlobalFlag GF_OCARINA_MAGIC
	.db $fc
	.asc "0"
	.db $fd $f7 $7b
	.asc " EVER NEED ME,"
	.db $fe
	.asc "JUST CALL ME"
	.db $fe
	.asc "WITH"
	.db $f7 $9d
	.asc "OCARINA."
	.db $ff

script_2e:
	.asc "HAVE COURAGE AND "
	.db $f7 $6a
	.asc "HARD. THE FATE "
	.db $f7 $99 $f7
	.asc "O IS IN "
	.db $f7 $1f
	.asc "HAND."
	.db $ff

script_2f:
	.db $f7 $35 $f7
	.asc "L"
	.db $fe $f7 $d4
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_SCALE_ITEM
	.db $fd
	.asc "<"
	.db $f7
	.asc "Y A "
	.db $f7 $32
	.asc " GREEN"
	.db $fe $f7 $d4
	.asc ".>"
	.db $ff

script_30:
	.db $f7 $35
	.asc "FLAME"
	.db $fe $f7 $16
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_FLAME_SWORD
	.db $fd
	.asc "<WHAT A "
	.db $f7 $16
	.asc ", THE WHOLE"
	.db $fe $f7 $16
	.asc " IS RED WITH"
	.db $fe
	.asc "FLAMES.>"
	.db $ff

script_31:
	.asc "YOU'RE "
	.db $f7 $bc
	.asc "AGAIN! YOU"
	.db $fe
	.asc "THIEF. COUGH, COUGH"
	.db $40 $40 $40 $fd $f7
	.asc "V"
	.db $f7 $a7 $f7 $80 $fe
	.asc "THE "
	.db $f7 $5c
	.asc " BALL"
	.db $fe
	.asc "OF LIFE. COUGH, COUGH"
	.db $40 $fd
	.asc "ALTHOUGH I CAN'T "
	.db $f7 $6a
	.asc ","
	.db $fe
	.asc "IN FACT"
	.db $fe
	.asc "I CAN'T EVEN FLY,"
	.db $fd
	.asc "I'LL GIVE YOU A BRACELET"
	.db $fe $f7 $a4
	.asc "A THIEF LEFT"
	.db $f7 $b5 $fd $f7 $7b
	.asc " LET ME BE. COUGH,"
	.db $fe
	.asc "COUGH"
	.db $40 $fd
	.asc "<"
	.db $f7
	.asc "BOBTAINED THE"
	.db $fe
	.asc "THIEVES' BRACELET.>"
	.db $fb
	scr_setGlobalFlag GF_BRACELET_ITEM
	.db $fd $f7 $93
	.asc " LEAVE"
	.db $fd
	.asc "ME ALONE"
	.db $3f
	.asc " WHAT A KIND"
	.db $fe
	.asc "HEARTED "
	.db $f7 $af
	.asc "."
	.db $ff

script_32:
	.asc "DO YOU STILL NEED"
	.db $fe $f7
	.asc "H FROM ME"
	.db $3f $ff

script_33:
	.db $f7
	.asc ", TO "
	.db $f7 $32 $fe $f7 $cd
	.asc " CHEEF. I AM THE"
	.db $fd
	.asc "PROTECTOR"
	.db $f7 $9a
	.asc " "
	.db $f7 $cd
	.asc ","
	.db $fe
	.asc "THE "
	.db $f7 $24
	.asc " "
	.db $f7
	.asc "2."
	.db $fd $f7 $8f
	.asc " CANE"
	.db $fe $f7 $aa
	.asc " IT'S A"
	.db $fd
	.asc "LEGENDARY "
	.db $f7 $14
	.asc " CANE."
	.db $fe
	.asc "ONLY THOSE WHO ARE PURE"
	.db $fd
	.asc "IN HEART MAY USE IT."
	.db $fe
	.asc "DURING"
	.db $f7 $9d $f7 $ca $fe $f7 $2b
	.asc " "
	.db $f7
	.asc "X PUT"
	.db $fd $f7 $1f
	.asc " ALL "
	.db $f7 $d3
	.asc " USING"
	.db $f7 $9f $fe
	.asc "CANE TO ITS UTMOST."
	.db $fe
	.asc "WHEN"
	.db $f7 $9d
	.asc "CANE REACHES"
	.db $fd
	.asc "ITS TRUE POTENTIAL,"
	.db $fe
	.asc "IT WILL BE THE BEGINNING"
	.db $fe
	.asc "OF THE END FOR ALL"
	.db $fd $f7
	.asc "G "
	.db $f7 $74
	.asc "S."
	.db $fe $f7 $35 $f7 $14 $fe
	.asc "CANE.>"
	.db $fb
	scr_setGlobalFlag GF_CANE_MAGIC
	.db $fc
	.asc "0"
	.db $fd
	.asc "NOW "
	.db $f7 $12
	.asc ", GO "
	.db $f7 $34
	.asc "."
	.db $fe $f7
	.asc "8, THE"
	.db $fd $f7 $1a
	.asc " OF "
	.db $f7 $c1
	.asc ", IS"
	.db $fe $f7 $5f
	.asc "."
	.db $fd $f7 $12
	.asc ", "
	.db $f7
	.asc "U THE ONLY"
	.db $fe
	.asc "ONE WHO CAN SAVE HER."
	.db $fe
	.asc "SHE WAS TURNED "
	.db $f7 $d3
	.asc " AN"
	.db $fd
	.asc "OPOSSUM BY THE EVIL"
	.db $fe $f7 $14
	.asc " OF "
	.db $f7 $13
	.asc " "
	.db $f7
	.asc "0."
	.db $fe
	.asc "NOW GO! GO "
	.db $f7 $34
	.asc "."
	.db $ff

script_34:
	.db $f7 $5d
	.asc " "
	.db $f7
	.asc "7."
	.db $fd
	.asc "I AM A "
	.db $f7
	.asc "S "
	.db $f7 $99 $fe
	.asc "DAIKINI CLAN. "
	.db $f7 $1b $fd
	.asc "RELEASE ME. "
	.db $f7
	.asc "K"
	.db $fd
	.asc "A KEY "
	.db $f7 $60
	.asc " HANDCUFFS"
	.db $fe
	.asc "HIDDEN IN THE "
	.db $f7 $26
	.asc "."
	.db $fe $f7 $1b
	.asc " GO FIND IT."
	.db $ff

script_35:
	.db $f7 $35
	.asc "KEY.>"
	.db $fb
	scr_setGlobalFlag GF_HANDCUFFS_KEY_ITEM
	.db $fd
	.asc "<"
	.db $f7
	.asc "Y OLD AND QUITE"
	.db $fe
	.asc "RUSTY.>"
	.db $ff

script_36:
	.asc "OH, FANTASTIC! I'M"
	.db $fe
	.asc "IN "
	.db $f7 $1f
	.asc " DEBT."
	.db $f7 $b6
	.asc ", TAKE"
	.db $fd
	.asc "MY "
	.db $f7
	.asc "' JUST MY WAY"
	.db $fe
	.asc "OF SAYING THANKS."
	.db $fd $f7 $35 $f7
	.asc "'>"
	.db $fb
	scr_setGlobalFlag GF_NECKLACE_ITEM
	.db $fd
	.asc "<IT'S MADE OF POOR"
	.db $fe
	.asc "QUALITY GLASS.>"
	.db $fd
	.asc "THE NAME'S "
	.db $f7
	.asc "7."
	.db $fe $f7 $ae
	.asc "IT. SO LONG."
	.db $ff

script_37:
	.db $f7 $2d $fe $f7
	.asc "."
	.db $fe $f7 $2b
	.asc "RS."
	.db $fd $f7 $2f $fe $f7 $30 $fe $f7 $31 $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $ff

script_38:
	.db $f7 $2d $fe $f7
	.asc "."
	.db $fe $f7 $2b
	.asc "RS."
	.db $fd $f7 $2f $fe $f7 $30 $fe $f7 $31 $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $fd $f6
	.asc "6I HAVEN'T SEEN YOU"
	.db $fe $f7 $88
	.asc " HERE "
	.db $f7 $66
	.asc ". ARE"
	.db $fd
	.asc "YOU PLANNING ON "
	.db $f7 $94 $fe $f7 $60
	.asc " CAVE OVER "
	.db $f7 $6d $3f $fd $f7 $8c $fe
	.asc "RUMOR, "
	.db $f7
	.asc "K A GHOST"
	.db $fd $f7 $a4
	.asc "PROTECTS A "
	.db $f7 $6c $fd
	.asc "AND KILLS ANYONE"
	.db $fe $f7 $a4
	.asc "GOES NEAR IT. IT"
	.db $fe
	.asc "IS SAID"
	.db $f7 $a3
	.asc "HER LOVER"
	.db $fd
	.asc "WENT ON A DANGEROUS"
	.db $fe
	.asc "JOURNEY TO FIND THE"
	.db $fe $f7 $6c
	.asc " FOR HER AND"
	.db $fd
	.asc "THEN MYSTERIOUSLY"
	.db $fe
	.asc "DIS"
	.db $f7 $63
	.asc "ED THE NIGHT HE"
	.db $fe
	.asc "RETURNED."
	.db $fd $f6
	.asc "7OH"
	.db $40
	.asc " SO SHE GUARDS IT"
	.db $fe
	.asc "FOREVER, WAITING FOR"
	.db $fe
	.asc "HIS RETURN"
	.db $3f $fd
	.asc "WHAT A TRAGIC STORY."
	.db $fe
	.asc "HEY "
	.db $f7 $12
	.asc ", THANKS FOR"
	.db $fe
	.asc "HELPING ME OUT OF"
	.db $f7 $a5 $fd
	.asc "JAM."
	.db $fe
	.asc "THERE I WAS, MINDING"
	.db $fe
	.asc "MY OWN BUSINESS WHEN,"
	.db $fd
	.asc "ALL OF A SUDDEN "
	.db $f7
	.asc "6"
	.db $fe
	.asc "CAME CHARGING UP AND"
	.db $fe
	.asc "TOOK ME PRISONER."
	.db $fd
	.asc "ANYWAY, THANKS."
	.db $fe
	.asc "YOU KNOW,"
	.db $fe
	.asc "YOU CAN'T GO ANY"
	.db $fd $f7 $c5 $f7 $c6
	.asc " CROSSING"
	.db $fe
	.asc "THE "
	.db $f7 $cd
	.asc ". "
	.db $f7 $8e
	.asc "THE ONLY"
	.db $fe
	.asc "WAY "
	.db $f7 $87
	.asc "DO "
	.db $f7 $a1 $fd
	.asc "IF "
	.db $f7
	.asc "BA "
	.db $f7 $ce
	.asc " SEED"
	.db $fe
	.asc "IN "
	.db $f7 $1f
	.asc " MOUTH SO YOU CAN"
	.db $fe
	.asc "BREATHE WATER. HA."
	.db $fd
	.asc "OF COURSE, THE ONLY ONES"
	.db $fe
	.asc "WHO HAVE "
	.db $f7 $ce
	.asc " SEEDS ARE"
	.db $fd
	.asc "THE MYTHICAL CREATURES"
	.db $fe $f7 $99
	.asc " NAIL CLAN."
	.db $fd $f7
	.asc "R "
	.db $f7 $95
	.asc " WHITE,"
	.db $fe
	.asc "SMALL,"
	.db $40
	.asc " SORT OF "
	.db $f7 $cc
	.asc " A"
	.db $fe
	.asc "RABBIT"
	.db $f7 $b2
	.asc "ANTLERS."
	.db $fd
	.asc "I'VE"
	.db $f7 $a7
	.asc "SEEN ONE."
	.db $fe
	.asc "PROBABLY JUST A LEGEND."
	scr_setGlobalFlag GF_TRADED_NECKLACE_FOR_WAKKA
	.db $ff

script_39:
	.db $f7
	.asc ",!"
	.db $fe $f7 $84
	.asc " AN OASIS"
	.db $fe
	.asc "FOR "
	.db $f7 $62
	.asc " "
	.db $f7 $2b
	.asc "RS."
	.db $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $fd $f7 $84
	.asc " THE TAVERN"
	.db $fe $f7 $99
	.asc " TRAVELER."
	.db $fe
	.asc "TAKE A LOAD OFF."
	.db $fd $f7
	.asc "7"
	.db $3f
	.asc " OH YEAH,"
	.db $fd
	.asc "THE "
	.db $f7 $62
	.asc " DAIKINI"
	.db $fe $f7
	.asc "S, RIGHT"
	.db $3f $fd
	.asc "HE MUMBLED "
	.db $f7
	.asc "H"
	.db $fe $f7 $8e
	.asc "DEFEATING "
	.db $f7
	.asc "0"
	.db $fe
	.asc "AND LEFT."
	.db $ff

script_3a:
	.db $f7 $1b
	.asc " RELAX AND TAKE"
	.db $fe
	.asc "IT EASY."
	.db $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $ff

script_3b:
	.db $f7 $35
	.asc "METAL"
	.db $fe $f7
	.asc " .>"
	.db $fb
	scr_setGlobalFlag GF_METAL_SHIELD
	.db $fd
	.asc "<"
	.db $f7
	.asc "Y TRANSLUCENT"
	.db $fe
	.asc "PURPLE AND VERY"
	.db $fe $f7 $32
	.asc ".>"
	.db $ff

script_3c:
	.asc "I AM "
	.db $f7 $10
	.asc " FROM THE EAGLE"
	.db $fe
	.asc "CLAN. "
	.db $f7 $7e $fe
	.asc "A FAVOR TO ASK OF YOU."
	.db $fd $f7 $be
	.asc " "
	.db $f7
	.asc "M WAS"
	.db $fe
	.asc "BURNED BY "
	.db $f7
	.asc "0'S"
	.db $fe $f7 $14
	.asc ". OUR "
	.db $f7 $25 $fd
	.asc "SCATTERED AND WE HAVE NO"
	.db $fe $f7 $64
	.asc " TO GO "
	.db $f7 $bb
	.asc "."
	.db $fd
	.asc "MY BROTHER, "
	.db $f7 $11
	.asc ","
	.db $fe
	.asc "AND I RAN AWAY"
	.db $fe
	.asc "BUT WE GOT SEPARATED."
	.db $fd $f7 $7b
	.asc " "
	.db $f7 $97 $fe
	.asc "TO MEET UP"
	.db $f7 $b2
	.asc "HIM,"
	.db $fd $f7 $1b
	.asc " GIVE HIM"
	.db $f7 $9f $fe $f7 $d2
	.asc " "
	.db $f7 $16
	.asc "."
	.db $fd $f7 $35 $f7 $d2 $fe $f7 $16
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_WING_SWORD
	.db $ff

script_3d:
	.db $f7 $35
	.asc "BOOK OF"
	.db $fe $f7 $14
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_RENEW_MAGIC
	.db $fc
	.asc "0"
	.db $fd
	.asc "<THE BOOK TALKS "
	.db $f7 $8e $fe
	.asc "THE "
	.db $f7 $14
	.asc " WORD RENEW BUT"
	.db $fd
	.asc "I"
	.db $f7 $c8 $f7 $d1
	.asc " WHAT KIND"
	.db $fe
	.asc "OF "
	.db $f7 $14
	.asc " "
	.db $f7
	.asc "Y.>"
	.db $ff

script_3e:
	.db $f7 $35 $f7 $33
	.asc "'S"
	.db $fe $f7 $c2
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_TERSTORM_MAGIC
	.db $fc
	.asc "0"
	.db $fd
	.asc "<"
	.db $f7
	.asc "Y SAID"
	.db $f7 $a3 $f7 $7b $fe
	.asc "WAVE"
	.db $f7 $9d $f7 $c2
	.asc " YOU"
	.db $fe
	.asc "INVOKE THE "
	.db $f7 $14
	.asc " OF"
	.db $fd
	.asc "TERSTORM WHICH CREATES"
	.db $fe
	.asc "A GUST OF WIND.>"
	.db $ff

script_3f:
	.asc "I AM THE "
	.db $f7 $1a
	.asc " OF"
	.db $fe $f7 $c1
	.asc ", "
	.db $f7
	.asc "8. YOU"
	.db $fe
	.asc "MUST BE "
	.db $f7 $12
	.asc ". I'M"
	.db $fd
	.asc "GLAD YOU MADE IT"
	.db $fe
	.asc "ALL"
	.db $f7 $9d
	.asc "WAY. NOW "
	.db $f7 $1b $fd $f7 $73
	.asc " ME TO MY NORMAL"
	.db $fe $f7 $d0 $f7 $b2 $f7
	.asc "2'S"
	.db $fe $f7 $14
	.asc " CANE."
	.db $fd
	.asc "<"
	.db $f7 $12
	.asc " CLUTCHED"
	.db $fe
	.asc "THE CANE TIGHTLY AND"
	.db $fd
	.asc "SAID THE "
	.db $f7 $14
	.asc " WORDS.>"
	.db $fc
	.asc "3"

script_40:
	.db $fe
	.asc "OH NO! "
	.db $f7 $12
	.asc ", YOU"
	.db $fd
	.asc "DON'T HAVE ENOUGH"
	.db $fe
	.asc "EXPERIENCE TO CHANGE ME"
	.db $fe $f7 $bc
	.asc "YET."
	.db $ff

script_41:
	.db $fe $f7
	.asc "> "
	.db $f7 $12
	.asc "."
	.db $fd
	.asc "I KNEW YOU COULD DO IT."
	.db $fe
	.asc "I HAD BETTER PUT ALL"
	.db $fd
	.asc "OF MY ENERGY INTO USING"
	.db $fe $f7 $9e
	.asc "CANE."
	scr_playSoundAndWait SND_BOGARDA_BRIDGE_MORPHING $04
	.db $fd
	.asc "I CAN HELP OUT IN THE"
	.db $fd
	.asc "BATTLE, BUT YOU'RE THE"
	.db $fe
	.asc "ONE PROPHECY SAYS WILL"
	.db $fe
	.asc "FINALLY DEFEAT "
	.db $f7
	.asc "0."
	scr_setGlobalFlag GF_HEALED_FIN_RAZIEL
	.db $ff

script_42:
	.asc "I AM "
	.db $f7 $0c
	.asc ","
	.db $fd
	.asc "THE SPIRIT"
	.db $f7 $a3
	.asc "ROAMS"
	.db $fe $f7 $88
	.asc " "
	.db $f7 $76
	.asc " FOR HER"
	.db $fe
	.asc "LOVE."
	.db $fd $f7 $1b
	.asc " HELP ME. MY LOVE"
	.db $fe $f7 $8d
	.asc " NEARBY BUT HE"
	.db $fd
	.asc "WONT'T SHOW HIM"
	.db $f7 $d0
	.asc " TO"
	.db $fe
	.asc "ME."
	.db $fd $f7 $1b
	.asc " FIND HIM FOR ME."
	.db $fe
	.asc "<"
	.db $f7
	.asc "B"
	.db $f7 $0c
	.asc "'S CROSS"
	.db $fe
	.asc "FLUTE.>"
	.db $fb
	scr_setGlobalFlag GF_FLUTE_ITEM
	.db $ff

script_43:
	.asc "SO WE MEET AGAIN,"
	.db $fe $f7 $12
	.asc ". SEED OF "
	.db $f7 $ce $3f
	.asc " "
	.db $fe $f7 $7e
	.asc "IT RIGHT HERE."
	.db $fd
	.asc "<"
	.db $f7
	.asc "BOBTAINED THE"
	.db $fe
	.asc "SEED OF "
	.db $f7 $ce
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_WAKKA_ITEM
	.db $fd
	.asc "TAKE CARE."
	.db $ff

script_44:
	.asc "THE HARD SHELL "
	.db $f7 $99 $fe $f7 $33
	.asc " SPLIT IN TWO AND A"
	.db $fe
	.asc "MAN "
	.db $f7 $63
	.asc "ED FROM"
	.db $fd
	.asc "INSIDE. HOWEVER, HE"
	.db $fe
	.asc "WAS "
	.db $f7 $71
	.asc " HALF DEAD"
	.db $40 $fd $f7 $70
	.asc " AT"
	.db $f7 $a3
	.asc "MOMENT,"
	.db $fe $f7 $0c
	.asc "'S CROSS FLUTE"
	.db $fe
	.asc "BEGAN TO PLAY."
	scr_playSoundAndWait $06 $0a
	.db $fc
	.asc "4"
	scr_playSoundAndWait $08 $01
	.db $fd $f7 $0c $3a $fe
	.asc " "
	.db $f7 $0d
	.asc "! IT'S ME."
	.db $fe
	.asc " IT'S "
	.db $f7 $0c
	.asc "!!"
	.db $fd $f7 $0d $3a $fe
	.asc " "
	.db $f7 $0c
	.asc "!"
	.db $fd $f7 $0c $3a $fe
	.asc " WE FINALLY MEET!"
	.db $fe $f7 $0d $3a $fd
	.asc " "
	.db $f7 $0c
	.asc "."
	.db $fe
	.asc " I WAS TURNED "
	.db $f7 $d3 $fe
	.asc " AN UGLY "
	.db $f7 $65
	.asc " BY THE"
	.db $fd
	.asc " "
	.db $f7
	.asc "G "
	.db $f7 $14
	.asc " OF"
	.db $fe
	.asc " "
	.db $f7
	.asc "0 AND WAS"
	.db $fe
	.asc " ORDERED TO GUARD"
	.db $f7 $9f $fd
	.asc " DOOR THE REST OF MY"
	.db $fe
	.asc " LIFE. I COULDN'T GO"
	.db $fe
	.asc " HOME "
	.db $f7
	.asc "5 I COULD"
	.db $fd
	.asc " NOT LET YOU SEE MY UGLY"
	.db $fe
	.asc " STATE."
	.db $fd $f7 $0c $3a $fe
	.asc " BUT NOW WE CAN BE"
	.db $fe
	.asc " "
	.db $f7
	.asc "T."
	.db $fd $f7 $0d $3a $fe
	.asc " YES, FOREVER AND EVER."
	.db $fd
	.asc "THE TWO CAME "
	.db $f7
	.asc "T"
	.db $fe
	.asc "AND DIS"
	.db $f7 $63
	.asc "ED."
	.db $fd $fc
	.asc "5"
	.db $f7 $0d
	.asc " HAD LEFT A NOTE"
	.db $fe
	.asc "BEHIND."
	.db $fd
	.asc "<I THOUGHT"
	.db $f7 $9d
	.asc "TIME"
	.db $fe $f7
	.asc "N COME, SO I"
	.db $fd
	.asc "WROTE"
	.db $f7 $9d
	.asc "NOTE TO LEAVE"
	.db $fe
	.asc "BEHIND."
	.db $fd $f7
	.asc "0 IS "
	.db $f7 $c0 $fe
	.asc "THE POWER "
	.db $f7 $99
	.asc " "
	.db $f7 $0f
	.asc "S"
	.db $fe
	.asc "AND SHE FEARS JUST"
	.db $fd
	.asc "PEOPLE "
	.db $f7 $cc
	.asc " YOU."
	.db $fe $f7
	.asc "X HAVE BOTH"
	.db $fe
	.asc "OF THESE "
	.db $f7 $3a
	.asc "S TO"
	.db $fd $f7 $38
	.asc " HER. I'M"
	.db $f7 $b4 $fe $f7 $a4
	.asc "THE "
	.db $f7 $0f
	.asc "S"
	.db $f7 $b7 $fe
	.asc "HELP YOU IF THEY CAN."
	.db $fd $f7
	.asc "V"
	.db $fe
	.asc "WRITE DOWN THE "
	.db $f7 $14 $fe
	.asc "WORD OF BOMBARD"
	.db $f7 $b5 $fd
	.asc "I AM"
	.db $f7 $b4
	.asc " "
	.db $f7 $6d $f7 $b7
	.asc "BE"
	.db $fe
	.asc "A TIME WHEN "
	.db $f7
	.asc "Y"
	.db $fe
	.asc "NEEDED.>"
	.db $fd $f7 $35 $f7 $14
	.asc " OF"
	.db $fe
	.asc "BOMBARD!>"
	.db $fb
	scr_setGlobalFlag GF_BOMBARD_MAGIC
	.db $fc
	.asc "0"
	.db $ff

script_45:
	.db $f7 $35 $f7 $14
	.asc " OF"
	.db $fe
	.asc "FLEET.>"
	.db $fb
	scr_setGlobalFlag GF_FLEET_MAGIC
	.db $fc
	.asc "0"
	.db $fd
	.asc "<THE SLATE SAYS"
	.db $f7 $a5 $fe $f7
	.asc "K A WAY "
	.db $f7 $89 $fd
	.asc "OUT "
	.db $f7 $99
	.asc " CONFUSING"
	.db $fe
	.asc "CAVE.>"
	.db $ff

script_46:
	.asc "THE PREDICTIONS"
	.db $fe
	.asc "WERE "
	.db $f7 $78
	.asc " TRUE!"
	.db $fd
	.asc "I "
	.db $f7 $39
	.asc "D "
	.db $f7 $a2 $fe $f7
	.asc "N COME. "
	.db $f7
	.asc "9"
	.db $fd
	.asc "IS THE SACRED FUTURE"
	.db $fe $f7 $13
	.asc " OF "
	.db $f7
	.asc "8'S"
	.db $fe
	.asc "PROPHECY. "
	.db $f7 $12
	.asc "! YOU"
	.db $fd
	.asc "MUST NOW, AS "
	.db $f7
	.asc "8"
	.db $fe
	.asc "HAS PREDICTED,"
	.db $fe
	.asc "CALL DOWN THE "
	.db $f7 $0f
	.asc " OF"
	.db $fd $f7 $c1
	.asc " TO"
	.db $f7 $9d
	.asc "SACRED"
	.db $fe
	.asc "TOWER. WHEN THE"
	.db $fe $f7 $3a
	.asc " "
	.db $f7 $99
	.asc " TWO"
	.db $fd $f7 $0f
	.asc "S COMES "
	.db $f7
	.asc "T,"
	.db $fe $f7 $a1
	.asc "WHEN "
	.db $f7 $73 $fe $f7 $b8
	.asc " TRULY BEGIN. NOW,"
	.db $fd
	.asc "THE TWO "
	.db $f7 $0f
	.asc "S ARE"
	.db $fe $f7 $5f
	.asc " ON TOP"
	.db $fe $f7 $99
	.asc " TOWER."
	.db $ff

script_47:
	.asc "THE RED "
	.db $f7 $5c $fe
	.asc "IS NEEDED."
	.db $ff

script_48:
	.asc "GREETINGS, "
	.db $f7 $12
	.asc ". I AM"
	.db $fd
	.asc "THE "
	.db $f7 $0f
	.asc " OF THE SKIES."
	.db $fd $f7 $7e
	.asc "BORROWED"
	.db $f7 $9f $fe $f7 $74
	.asc "'S BODY TO"
	.db $f7 $96 $fe
	.asc "YOU FOR A SHORT WHILE."
	.db $fd $f7
	.asc "0,"
	.db $fe
	.asc "WHO I "
	.db $f7 $64
	.asc "D IN"
	.db $fe $f7 $9e $f7
	.asc "O, HAS MADE MY"
	.db $fd
	.asc "VOICE INAUDIBLE AND SHE"
	.db $fe
	.asc "IS TRYING TO CONQUER THE"
	.db $fe $f7
	.asc "O."
	.db $fd
	.asc "NOW "
	.db $f7
	.asc "V PUT MY"
	.db $fe $f7 $3a $f7 $9c
	.asc "BLUE"
	.db $fe $f7 $5c
	.asc ". "
	.db $f7 $8f
	.asc " AND"
	.db $fd
	.asc "GO CLIMB THE WEST TOWER."
	.db $fd $f7 $35
	.asc "BLUE"
	.db $fe $f7 $5c
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_BLUE_CRYSTAL_ITEM
	.db $ff

script_49:
	.asc "I'M GLAD YOU CAME"
	.db $fe $f7 $12
	.asc "."
	.db $fd
	.asc "I AM THE "
	.db $f7 $0f
	.asc " OF THE"
	.db $fe $f7 $c1 $40
	.asc "I AM BORRO"
	.db $f7 $d2 $fd $f7 $9e $f7 $74
	.asc "'S BODY TO"
	.db $fe
	.asc "TALK "
	.db $f7 $91
	.asc " FOR A SHORT"
	.db $fe
	.asc "WHILE. "
	.db $f7
	.asc "0 HAS"
	.db $fd
	.asc "CONFINED THE "
	.db $f7 $3a
	.asc " OF"
	.db $fe $f7
	.asc "8, WHOM I"
	.db $fe $f7 $64
	.asc "D ON"
	.db $f7 $9d $f7
	.asc "O."
	.db $fd
	.asc "NOW "
	.db $f7
	.asc "V PUT MY"
	.db $fe $f7 $3a $f7 $9c
	.asc "RED"
	.db $fe $f7 $5c
	.asc ". "
	.db $f7 $8f
	.asc " AND"
	.db $fd
	.asc "GO DOWN AND MEET"
	.db $fe $f7
	.asc "9."
	.db $fd $f7 $35
	.asc "RED"
	.db $fe $f7 $5c
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_RED_CRYSTAL_ITEM
	.db $ff

script_4a:
	.asc "<THE TWO LIGHTS"
	.db $f7 $a5 $fe
	.asc "RULE THE SKIES"
	.db $fd
	.asc "AND "
	.db $f7 $c1 $fe
	.asc "COME "
	.db $f7
	.asc "T AND ARE"
	.db $fd
	.asc "REBORN"
	.db $f7 $9c $f7
	.asc "O,"
	.db $fe
	.asc "THROUGH "
	.db $f7 $1f
	.asc " DILIGENCE,"
	.db $fe
	.asc "AS "
	.db $f7
	.asc "9. SHE"
	.db $fd $f7 $b8
	.asc " OVERTHROW ALL OF"
	.db $fe
	.asc "THE EVIL ENTITIES AND"
	.db $fd
	.asc "TURN THEIR EXISTENCE"
	.db $fe $f7 $d3 $f7 $bf
	.asc "."
	.db $fd
	.asc "<"
	.db $f7
	.asc "BOBTAINED THE"
	.db $fe $f7 $8b
	.asc " OF THE "
	.db $f7 $0f
	.asc "S.>"
	.db $fb
	scr_setGlobalFlag GF_CREST_ITEM
	.db $fd $f7 $9e $f7 $8b
	.asc " IS PRICELESS"
	.db $fe
	.asc "AND WILL PROTECT THE"
	.db $fe $f7 $6b
	.asc " "
	.db $f7
	.asc "O. IF"
	.db $f7 $9f $fd
	.asc "EVER GETS IN THE HANDS"
	.db $fe
	.asc "OF "
	.db $f7
	.asc "0 AND IS"
	.db $fe
	.asc "DESTROYED, THE POWER"
	.db $fd $f7 $99
	.asc " "
	.db $f7 $0f
	.asc "S "
	.db $f7 $b8 $fe
	.asc "DIS"
	.db $f7 $63
	.asc " AND"
	.db $fe $f7
	.asc "0"
	.db $f7 $b7 $f7
	.asc "W"
	.db $fd
	.asc "LIVE FOREVER."
	.db $fe $f7
	.asc "C"
	.db $fe $f7
	.asc "0'S "
	.db $f7 $3d
	.asc ","
	.db $fd $f7
	.asc "D"
	.db $fe $f7
	.asc "E"
	.db $fe $f7
	.asc "F"
	.db $ff

script_4b:
	.db $f7 $3b $40 $40
	.asc "HUH,"
	.db $fd
	.asc "I'VE"
	.db $f7 $a7
	.asc "HEARD OF IT."
	.db $fe
	.asc "I CAN TEACH YOU THE"
	.db $fe
	.asc "STRONGEST "
	.db $f7 $14
	.asc " WORD IN"
	.db $fd
	.asc "THE "
	.db $f7
	.asc "O."
	.db $fe $f7 $35 $f7 $14 $fe
	.asc "WORD OF THUNDER.>"
	.db $fb
	scr_setGlobalFlag GF_THUNDER_MAGIC
	.db $fc
	.asc "0"
	.db $fd $f7 $36 $fe $f7 $37 $fc
	.asc "2"
	.db $ff

script_4c:
	.db $f7 $36 $fe $f7 $37 $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $ff

script_4d:
	.asc "<"
	.db $f7
	.asc "BA "
	.db $f7 $65
	.asc "'S"
	.db $fe
	.asc "BONE!>"
	.db $fb
	scr_setGlobalFlag GF_SPECTER_MAGIC
	.db $fc
	.asc "0"
	.db $fd
	.asc "<PUT"
	.db $f7 $9d
	.asc "ON "
	.db $f7 $1f
	.asc " HEAD"
	.db $fe
	.asc "AND UTTER SPECTER'S"
	.db $fd $f7 $14
	.asc " WORD. "
	.db $f7 $9e
	.asc "TURNS"
	.db $fe
	.asc "YOU "
	.db $f7 $d3
	.asc " A "
	.db $f7 $65
	.asc ".>"
	.db $ff

script_4e:
	.asc "<"
	.db $f7
	.asc "BA HEAL BALL.>"
	.db $fb
	scr_setGlobalFlag GF_HEALBALL_MAGIC
	.db $fc
	.asc "0"
	.db $fd
	.asc "<A "
	.db $f7 $14
	.asc " BALL"
	.db $f7 $a5 $fe
	.asc "RETURNS "
	.db $f7 $1f
	.asc " "
	.db $f7 $3a
	.asc ".>"
	.db $ff

script_4f:
	.db $f7 $35
	.asc "FURY"
	.db $fe $f7
	.asc " .>"
	.db $fb
	scr_setGlobalFlag GF_FURY_SHIELD
	.db $fd
	.asc "<THE "
	.db $f7
	.asc "  "
	.db $f7 $a1 $fe
	.asc "CURSED BY ANGER AND"
	.db $fe
	.asc "HATRED.>"
	.db $ff

script_50:
	.db $f7 $35
	.asc "TAIL"
	.db $fe $f7
	.asc " .>"
	.db $fb
	scr_setGlobalFlag GF_TAIL_SHIELD
	.db $fd
	.asc "<A "
	.db $f7
	.asc "  "
	.db $f7 $a1
	.asc "MADE"
	.db $fe
	.asc "FROM THE TAIL OF"
	.db $fe
	.asc "A "
	.db $f7 $33
	.asc ".>"
	.db $ff

script_51:
	.db $f7 $35
	.asc "WONDER"
	.db $fe $f7 $16
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_WONDER_SWORD
	.db $fd $f7 $22 $fe $f7 $23 $fb $fc
	.asc "2"
	.db $ff

script_52:
	.db $f7 $35
	.asc "BATTLE"
	.db $fe $f7
	.asc " .>"
	.db $fb
	scr_setGlobalFlag GF_BATTLE_SHIELD
	.db $ff

script_53:
	.db $f7 $35
	.asc "DEVIL EYE.>"
	.db $fb
	scr_setGlobalFlag GF_DEVIL_EYE_SWORD
	.db $fd $f7 $22 $fe $f7 $23 $fb $fc
	.asc "2"
	.db $ff

script_54:
	.asc "YOU"
	.db $f7 $c8
	.asc "LOOK "
	.db $f7 $cc
	.asc " A"
	.db $fe $f7 $68
	.asc " FROM "
	.db $f7 $5b $fe
	.asc "BUT"
	.db $40 $fd
	.asc "WHAT"
	.db $3f
	.asc " YOU"
	.db $f7 $c8 $f7 $d1 $fe $f7 $5b
	.asc "!"
	.db $fd $f7
	.asc "Y "
	.db $f7 $92
	.asc "A"
	.db $fe
	.asc "SMALL "
	.db $f7
	.asc "M A LITTLE"
	.db $fe
	.asc "WAYS FROM"
	.db $f7 $b5 $fd
	.asc "ACCORDING TO AN OLD"
	.db $fe
	.asc "LEGEND, THE "
	.db $f7 $5b $fd $f7 $3d
	.asc " IS "
	.db $f7
	.asc "R "
	.db $f7 $95 $fe
	.asc "THE FUTURE "
	.db $f7 $3d
	.asc " OF"
	.db $fd
	.asc "THE "
	.db $f7 $1d
	.asc " LOVING"
	.db $fe $f7
	.asc "9."
	.db $fd
	.asc "IT'S BEEN SAID"
	.db $f7 $a3
	.asc "A"
	.db $fe $f7 $62
	.asc " MAN "
	.db $f7
	.asc "N"
	.db $fd $f7 $63
	.asc " AND SAVE"
	.db $f7 $9f $fe $f7
	.asc "O."
	.db $fd
	.asc "I AWAIT"
	.db $f7 $a3
	.asc "DAY."
	.db $ff

script_55:
	.db $f7 $93 $fe $f7 $5b $3f $fd
	.asc "THEN YOU "
	.db $f7
	.asc "1 WEAR"
	.db $fe
	.asc "THESE WITCH'S SHOES"
	.db $f7 $a5 $fd
	.asc "I USED WHEN I RAN FROM"
	.db $fe
	.asc "THE "
	.db $f7 $15
	.asc "."
	.db $fd $f7 $35
	.asc "WITCH'S"
	.db $fe
	.asc "SHOES.>"
	.db $fb
	scr_setGlobalFlag GF_SHOES_ITEM
	.db $ff

script_56:
	.asc "DO YOU NEED "
	.db $f7
	.asc "H"
	.db $fe
	.asc "MORE FROM ME"
	.db $3f $fe $ff

script_57:
	.db $f7 $a4
	.asc "BRIDGE IS CURSED."
	.db $fe
	.asc "NO ONE CAN GO NEAR"
	.db $fe $f7 $5b
	.asc "."
	scr_setGlobalFlag GF_TALKED_TO_OLD_LADY_FOR_SHOES
	.db $ff

script_58:
	.asc "I DON'T "
	.db $f7 $d1
	.asc " "
	.db $f7
	.asc "J!"
	.db $fd
	.asc "IF "
	.db $f7
	.asc "0 KNEW"
	.db $f7 $a5 $fe $f7 $6f
	.asc " STILL LIVES"
	.db $fd
	.asc "HERE, SHE "
	.db $f7
	.asc "N SURELY"
	.db $fe
	.asc "ATTACK AGAIN."
	.db $fd
	.asc "IF "
	.db $f7 $79 $fe $f7 $8e $f7 $5b
	.asc ","
	.db $fe
	.asc "GO "
	.db $f7 $60 $f7 $83
	.asc " "
	.db $f7 $82 $fd
	.asc "EAST OF THE "
	.db $f7 $3d
	.asc "."
	.db $fe $f7 $6d
	.asc " "
	.db $f7
	.asc "1 BE AN OLD"
	.db $fe
	.asc "WOMAN "
	.db $f7 $6d
	.asc "."
	.db $fd
	.asc "SHE WAS TAKEN FROM"
	.db $fe $f7 $5b
	.asc " TO "
	.db $f7 $3c $fe $f7 $3d
	.asc " BY "
	.db $f7
	.asc "0, BUT"
	.db $fd
	.asc "WAS SAVED BY "
	.db $f7 $0a
	.asc ","
	.db $fe
	.asc "A "
	.db $f7
	.asc "S"
	.db $f7 $9a $fe $f7
	.asc "M."
	.db $ff

script_59:
	.asc "I DON'T "
	.db $f7 $d1
	.asc " "
	.db $f7
	.asc "J."
	.db $fe $f7 $1b
	.asc " LEAVE!"
	.db $ff

script_5a:
	.asc "IS IT YOU AGAIN"
	.db $3f $fd $f7 $a8 $f7 $3c $fe $f7 $3d $3f
	.asc " I "
	.db $f7 $d1 $f7 $bf $fe
	.asc "OF SUCH"
	.db $f7 $cb
	.asc "S."
	.db $fd $f7 $1b
	.asc " LEAVE NOW!"
	.db $ff

script_5b:
	.db $f7 $3b $3f $fd $f7 $93
	.asc " GO TO"
	.db $fe
	.asc "THE "
	.db $f7 $3d
	.asc " "
	.db $f7 $6e $f7 $a5 $fe
	.asc "WITCH LIVES"
	.db $3f $fe
	.asc "FORGET IT"
	.db $40 $40
	.asc " INSTEAD"
	.db $fd $f7 $39
	.asc " IN THE "
	.db $f7 $0f
	.asc "'S"
	.db $fe
	.asc "PROPHECY AND WAIT!"
	.db $fd $f7 $7e
	.asc "WAITED MANY YEARS"
	.db $fe
	.asc "ON"
	.db $f7 $9f $f7 $83
	.asc " "
	.db $f7 $82 $fe
	.asc "FOR THE DAY THE "
	.db $f7 $62 $fd
	.asc "MAN OF PROPHECY "
	.db $f7 $63
	.asc "S"
	.db $fe
	.asc "AT "
	.db $f7 $3b
	.asc " AND"
	.db $fd
	.asc "STOPS THE WITCHES'"
	.db $fe $f7 $14
	.asc "."
	scr_setGlobalFlag GF_UNLOCKED_TIR_ASLEEN_CASTLE
	.db $ff

script_5c:
	.asc "WHAT! YOU'VE MET "
	.db $f7 $0a
	.asc "!"
	.db $fd $f7 $7e
	.asc "CAUTIOUSLY KEPT"
	.db $fe $f7 $a8 $f7 $3c $fe $f7 $3d
	.asc " FOR HIM."
	.db $fd
	.asc "COULD YOU HAND"
	.db $f7 $9d
	.asc "OVER"
	.db $fe
	.asc "TO "
	.db $f7 $0a
	.asc "."
	.db $fd $f7 $35
	.asc "KEY TO"
	.db $fe $f7 $3b
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_NOCKMAAR_KEY_ITEM
	.db $ff

script_5d:
	.db $40 $40 $40 $40 $ff

script_5e:
	.db $f7 $0a
	.asc " "
	.db $f7 $b8
	.asc ", "
	.db $f7 $c6
	.asc " FAIL,"
	.db $fe
	.asc "SAVE"
	.db $f7 $9d $f7
	.asc "O."
	.db $ff

script_5f:
	.asc "SO, "
	.db $f7
	.asc "B"
	.db $f7 $85 $fe
	.asc "OVERTHROW "
	.db $f7
	.asc "0."
	.db $fe $f7 $1b
	.asc " REST"
	.db $f7 $b5 $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $ff

script_60:
	.asc "I AM "
	.db $f7 $0a
	.asc " OF"
	.db $fe $f7 $5b
	.asc "."
	.db $fd $f7
	.asc "K A "
	.db $f7 $65 $fd $f7 $d5
	.asc " EBORSISK IN THE"
	.db $fe
	.asc "NEXT ROOM BUT I AM TOO"
	.db $fd
	.asc "WEAK TO "
	.db $f7 $6a
	.asc " HIM."
	.db $fe $f7 $1b
	.asc " TAKE MY"
	.db $fe
	.asc "KAISER "
	.db $f7 $16
	.asc ". "
	.db $f7 $12
	.asc "!"
	.db $fd $f7 $87 $f7 $38 $f7 $a5 $fe $f7 $65
	.asc "."
	.db $fd $f7 $35
	.asc "KAISER"
	.db $fe $f7 $16
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_KAISER_SWORD
	.db $ff

script_61:
	.db $f7
	.asc "!!"
	.db $fd
	.asc "I AM KAEL, THE GENERAL"
	.db $fe
	.asc "OF "
	.db $f7 $3c
	.asc "!"
	.db $fd $f7
	.asc "BFALLEN"
	.db $fe $f7 $70
	.asc " "
	.db $f7 $d3
	.asc " OUR TRAP."
	.db $fd $f7 $7e
	.asc "TAKEN THE "
	.db $f7 $8b $fe
	.asc "OF THE "
	.db $f7 $0f
	.asc "S."
	.db $fd
	.asc "NOW OUR "
	.db $f7 $13
	.asc " "
	.db $f7
	.asc "0"
	.db $fe
	.asc "CAN DESTROY IT AND"
	.db $fd
	.asc "RECEIVE EVERLASTING"
	.db $fe
	.asc "LIFE. TO SHOW MY THANKS,"
	.db $fd
	.asc "I'LL LET YOU STAY"
	.db $f7 $b6 $fe
	.asc "TO DIE. "
	.db $f7
	.asc "!!"
	scr_setRoomYX $1c $02
	scr_setGlobalFlag GF_TALKED_TO_KAEL_IN_PRISON
	scr_unsetGlobalFlag GF_CREST_ITEM
	.db $ff

script_62:
	.asc "HEY "
	.db $f7 $12
	.asc "!"
	.db $fe
	.asc "WE MEET AGAIN."
	.db $fd
	.asc "ON THE WAY"
	.db $f7 $b6
	.asc " I MET A"
	.db $fd
	.asc "GUY "
	.db $f7 $d5
	.asc " "
	.db $f7 $0a
	.asc " WHO TOLD"
	.db $fe
	.asc "ME"
	.db $f7 $a3
	.asc "SOME"
	.db $f7 $6e
	.asc " IN"
	.db $fd $f7 $5b
	.asc " "
	.db $f7
	.asc "K A"
	.db $fe
	.asc "SECRET CAVE CONNECTING"
	.db $fe
	.asc "TO "
	.db $f7 $3b $40 $40 $fd
	.asc "BUT "
	.db $f7
	.asc "K"
	.db $f7 $bf $fe $f7 $a4
	.asc "CAN BE DONE NOW."
	scr_setGlobalFlag GF_SPOKE_TO_MADMARTIGAN_IN_PRISON
	.db $ff

script_63:
	.asc "STRUGGLING IS USELESS."
	.db $fe $ff

script_64:
	.db $f7
	.asc "3"
	.db $3a $fe
	.asc " "
	.db $f7 $12
	.asc "! "
	.db $f7 $3e
	.asc " TO"
	.db $fe
	.asc " HELP!"
	.db $fd $f7
	.asc "4"
	.db $3a $fe
	.asc " YEAH, TO HELP!"
	.db $fd $f7
	.asc "3"
	.db $3a $fe
	.asc " LEAVE"
	.db $f7 $9d $f7 $3d $fe
	.asc " AND FIND THE SECRET"
	.db $fd
	.asc " CAVE TO "
	.db $f7 $3c $fe
	.asc " "
	.db $f7 $3d
	.asc "."
	.db $fd $f7
	.asc "4"
	.db $3a $fe
	.asc " TO "
	.db $f7 $3c
	.asc "."
	.db $fd $f7
	.asc "3"
	.db $3a $fe
	.asc " "
	.db $f7 $8f
	.asc " "
	.db $f7 $72
	.asc " OF"
	.db $fe
	.asc " UNREQUITED LOVE! IT'S"
	.db $fd
	.asc " SAID"
	.db $f7 $a3
	.asc "ANYONE WHO"
	.db $fe
	.asc " TOUCHES"
	.db $f7 $9d $f7 $72 $fe $f7 $b7
	.asc "HAVE A HEART OF"
	.db $fd
	.asc " "
	.db $f7 $17
	.asc ". IT'S "
	.db $f7 $14
	.asc "AL."
	.db $fe
	.asc " IT "
	.db $f7
	.asc "1 BE OF HELP"
	.db $fe
	.asc " "
	.db $f7 $91
	.asc "."
	.db $fd $f7
	.asc "4"
	.db $3a $fe
	.asc " IT "
	.db $f7
	.asc "1!"
	.db $fd $f7 $35 $f7 $72
	.asc " OF"
	.db $fe
	.asc "UNREQUITED LOVE!>"
	.db $fb
	scr_setGlobalFlag GF_POWDER_ITEM
	.db $fd $f7
	.asc "3"
	.db $3a $fe
	.asc " "
	.db $f7
	.asc "7 HAS GONE"
	.db $fe
	.asc " AHEAD. "
	.db $f7 $40 $fd $f7
	.asc "4"
	.db $3a $fe
	.asc " "
	.db $f7 $40
	scr_setRoomYX $1c $02
	.db $ff

script_65:
	.db $f7
	.asc "3"
	.db $3a $fe $f7 $9d $f7
	.asc "A THE"
	.db $fe
	.asc " SECRET CAVE."
	.db $fd $f7
	.asc "4"
	.db $3a $fe
	.asc " "
	.db $f7
	.asc "A IT."
	.db $fd $f7
	.asc "3"
	.db $3a $fe
	.asc " BE "
	.db $f7 $18
	.asc " "
	.db $f7 $12
	.asc "!"
	.db $fd $f7
	.asc "4"
	.db $3a $fe
	.asc " "
	.db $f7 $18
	.asc ", "
	.db $f7 $18
	.asc "!"
	.db $ff

script_66:
	.db $f7
	.asc "U NO DOUBT THE"
	.db $fe $f7 $5e
	.asc " ONE WHO CAN SAVE"
	.db $fe
	.asc "THE "
	.db $f7
	.asc "O."
	.db $fd
	.asc "I THOUGHT SO THE FIRST"
	.db $fe
	.asc "TIME I MET YOU SO"
	.db $fe
	.asc "I TAUGHT YOU THE SPECIAL"
	.db $fd $f7 $14
	.asc " WORD "
	.db $f7 $d5 $fe
	.asc "THUNDER."
	.db $fd
	.asc "YOU "
	.db $f7
	.asc "1 REST"
	.db $f7 $b5 $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $fd $f7 $8c
	.asc "RUMOR, THE"
	.db $fe $f7 $8b
	.asc " OF THE "
	.db $f7 $0f
	.asc "S IS"
	.db $fd
	.asc "IN THE HANDS OF "
	.db $f7
	.asc "6,"
	.db $fe $f7
	.asc "0'S DAUGHTER."
	.db $ff

script_67:
	.asc "WHAT ARE YOU DOING"
	.db $f7 $b6
	.asc "!"
	.db $fd $f7 $84
	.asc " NOT A "
	.db $f7 $64 $fe
	.asc "FOR THE "
	.db $f7 $cc
	.asc "S OF YOU."
	.db $ff

script_68:
	.asc "OH NO! A "
	.db $f7 $65
	.asc "!!"
	scr_setGlobalFlag GF_UNBLOCKED_FINAL_DUNGEON
	.db $ff

script_69:
	.asc "I'M "
	.db $f7 $11
	.asc ", A "
	.db $f7
	.asc "S OF"
	.db $fe
	.asc "THE "
	.db $f7 $be
	.asc "."
	.db $fd
	.asc "WHY DO "
	.db $f7
	.asc "BMY "
	.db $f7 $d2 $fe $f7 $16 $3f
	.asc "! OH, "
	.db $f7 $10
	.asc " MUST"
	.db $fe
	.asc "HAVE GIVEN IT TO YOU."
	.db $fd
	.asc "NOW I CAN PUT MY"
	.db $fe $f7 $3a
	.asc " BEHIND MY"
	.db $fe $f7 $16
	.asc "!"
	scr_playSoundAndWait SND_BOGARDA_BRIDGE_MORPHING $04
	.db $fd $40 $40
	.asc "BUT IT "
	.db $f7
	.asc "A THE"
	.db $fe
	.asc "DOOR TO "
	.db $f7 $3b $fd $f7
	.asc "Z BE OPENED "
	.db $f7 $c6 $fe
	.asc "A KEY."
	.db $fd
	.asc "I "
	.db $f7 $98
	.asc " "
	.db $f7 $0a $fe
	.asc "WAS SAYING"
	.db $f7 $a0
	.asc "OLD"
	.db $fd
	.asc "WOMAN HE RESCUED FROM"
	.db $fe $f7 $9e $f7 $3d
	.asc " HAS THE KEY."
	.db $fd
	.asc "I HAVEN'T SEEN"
	.db $fe
	.asc "HER THOUGH."
	scr_setGlobalFlag GF_UPGRADED_WING_SWORD
	.db $ff

script_6a:
	.db $f7 $1b
	.asc " REST AND TAKE IT"
	.db $fe
	.asc "EASY."
	.db $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $fd
	.asc "OH, "
	.db $f7 $84
	.asc " "
	.db $f7 $78
	.asc " A"
	.db $fe $f7
	.asc "L "
	.db $f7 $d4
	.asc "!"
	.db $fd $f7
	.asc "V MAKE YOU A"
	.db $fe $f7 $b3
	.asc " "
	.db $f7 $16
	.asc " AND"
	.db $fe $f7
	.asc " ."
	.db $fc
	.asc "6"
	.db $fd $f7 $35 $f7
	.asc "L"
	.db $fe $f7 $16
	.asc ".>"
	.db $fb
	scr_setGlobalFlag GF_DRAGON_SWORD
	.db $fd $f7 $35 $f7
	.asc "L"
	.db $fe $f7
	.asc " .>"
	.db $fb
	scr_setGlobalFlag GF_DRAGON_SHIELD
	.db $ff

script_6b:
	.asc "I'M "
	.db $f7
	.asc "6, DAUGHTER"
	.db $fe $f7 $99
	.asc " GREAT"
	.db $fe $f7 $13
	.asc " "
	.db $f7
	.asc "0."
	.db $fd $f7 $87
	.asc "NO LONGER"
	.db $fe
	.asc "ESCAPE. GO TO BLAZES"
	.db $fe
	.asc "WITH"
	.db $f7 $9d
	.asc "MAN."
	.db $fd
	.asc "<"
	.db $f7 $12
	.asc " THREW THE "
	.db $f7 $72 $fe
	.asc "OF UNREQUITED LOVE AT"
	.db $fe $f7
	.asc "6"
	.db $40 $40
	.asc " BUT "
	.db $f7
	.asc "6"
	.db $fd
	.asc "DODGED IT AND THE "
	.db $f7 $72 $fe
	.asc "GOT ON "
	.db $f7
	.asc "7.>"
	scr_playSoundAndWait SND_BOGARDA_BRIDGE_MORPHING $04
	.db $fd $f6
	.asc "8"
	.db $40 $40 $f7
	.asc "6. AH DEAREST"
	.db $fe $f7
	.asc "6! I LOVE YOU."
	.db $fd $f7
	.asc "U MY MOON AND MY"
	.db $fe
	.asc "SUN IN THE CLEAR BLUE"
	.db $fe
	.asc "SKY. "
	.db $f7 $c6
	.asc " YOU I AM"
	.db $fd
	.asc "IN DARKNESS."
	.db $fe $f7
	.asc "6! "
	.db $f7
	.asc "U "
	.db $f7 $74 $fe
	.asc "FOOLED! "
	.db $f7 $1f
	.asc " EYES ARE"
	.db $fd
	.asc "OVERFLO"
	.db $f7 $d2 $f7 $b2 $f7 $17 $fe
	.asc "AND HOPE."
	.db $fd $f7
	.asc "6, I DO NOT "
	.db $f7 $39 $fe
	.asc "THE PROPHECY. "
	.db $f7 $6d $fe
	.asc "IS NO "
	.db $f7 $5e
	.asc " HERO."
	.db $fd
	.asc "IF "
	.db $f7
	.asc "K A HERO,"
	.db $fe
	.asc "EVERY "
	.db $f7 $69
	.asc " CREATURE"
	.db $fd
	.asc "IN THE "
	.db $f7
	.asc "O IS IT."
	.db $fe
	.asc "ALL OF US"
	.db $fd $f7 $99
	.asc " DAIKINI CLAN,"
	.db $fe
	.asc "THE "
	.db $f7 $1c
	.asc " CLAN, THE"
	.db $fe $f7 $be $f7 $b2
	.asc "THE"
	.db $fd $f7 $d2
	.asc "S, AND THE RABBIT"
	.db $fe
	.asc "LIKE NAIL CLAN ARE IT."
	.db $fd
	.asc "ALL ARE "
	.db $f7 $69
	.asc " TO THEIR"
	.db $fe
	.asc "FULLEST, AND THE EFFORT"
	.db $fd
	.asc "PUT FORTH "
	.db $f7 $d3
	.asc " "
	.db $f7 $69
	.asc " IS"
	.db $fe
	.asc "THE "
	.db $f7 $b9
	.asc " "
	.db $f7 $3a
	.asc " IN"
	.db $fe $f7 $9e $f7
	.asc "O."
	.db $fd $f7
	.asc "6 "
	.db $f7 $1f
	.asc " "
	.db $f7 $3a
	.asc " IS"
	.db $fe $f7
	.asc "P NOW."
	.db $fe
	.asc "LET'S GIVE"
	.db $fd
	.asc "OUR "
	.db $f7 $3a
	.asc " TO "
	.db $f7 $12
	.asc "!"
	.db $fd $f6
	.asc "9"
	.db $40 $40 $40 $f7
	.asc "7"
	.db $40 $40 $fd $f7
	.asc "> "
	.db $f7
	.asc "7. I"
	.db $fe
	.asc "FEEL "
	.db $f7 $cc
	.asc " I'VE AWAKENED,"
	.db $fd $f7 $12
	.asc ", THE "
	.db $f7 $8b
	.asc " OF THE"
	.db $fe $f7 $0f
	.asc "S "
	.db $f7
	.asc "1 BE IN A"
	.db $fd $f7 $6c
	.asc " CHEST IN THE"
	.db $fe
	.asc "CAVE BELOW"
	.db $f7 $9d $f7 $3d
	.asc "."
	scr_setGlobalFlag GF_USED_POWDER_ON_MADMARTIGAN
	.db $ff

script_6c:
	.asc "YOUNGSTER!"
	.db $fd
	.asc "IT'S TOO LATE! I'VE"
	.db $fe $f7 $71
	.asc " GIVEN THE"
	.db $fe
	.asc "CREST OF THE "
	.db $f7 $0f
	.asc "S TO"
	.db $fd $f7
	.asc "0. "
	.db $f7
	.asc "!!"
	.db $f2 $ff

script_6d:
	.asc "I DIDN'T "
	.db $f7 $98
	.asc " YOU "
	.db $f7
	.asc "N"
	.db $fe
	.asc "MAKE IT SO FAR. BUT"
	.db $f7 $9f $fe
	.asc "IS AS FAR AS YOU GO!"
	.db $fd $f7 $b0
	.asc "I SEAL THE"
	.db $fe $f7 $0f
	.asc "'S CREST. "
	.db $fe $f7
	.asc "V"
	.db $f7 $a7
	.asc "HAVE"
	.db $fd $f7 $95
	.asc " "
	.db $f7 $c0 $fe
	.asc "HIGHER "
	.db $f7 $1e
	.asc " OR MEN."
	.db $fe $f7
	.asc "V BE IMMORTAL."
	.db $fd $f7
	.asc "!!"
	.db $f2 $ff

script_6e:
	.asc "<"
	.db $f7
	.asc "BRETRIEVED THE"
	.db $fe $f7 $8b
	.asc " OF THE "
	.db $f7 $0f
	.asc "S!>"
	.db $fb
	scr_setGlobalFlag GF_CREST_ITEM
	.db $fd
	.asc "NO "
	.db $f7 $12
	.asc ", DON'T"
	.db $40 $40 $fd
	.asc "I'LL BE DESTROYED."
	.db $f2
	scr_setRoomYX $1e $1c
	.db $ff

script_6f:
	.asc "SO, "
	.db $f7
	.asc "BCOME FROM"
	.db $fe $f7 $1c
	.asc "."
	.db $fd $f7 $1b
	.asc " REST AS LONG AS"
	.db $fe $f7 $90
	.asc "TO."
	.db $fc
	.asc "0"
	.db $fc
	.asc "2"
	.db $ff

script_70:
script_71:
	.asc "I'M "
	.db $f7
	.asc "6, DAUGHTER OF"
	.db $fe
	.asc "THE "
	.db $f7 $ba
	.asc " "
	.db $f7 $13 $fe $f7
	.asc "0."
	.db $fd
	.asc "HAVE YOU SEEN"
	.db $fe
	.asc "A MAN BY "
	.db $f7 $92 $fe $f7
	.asc "7 "
	.db $f7 $88 $f7 $b6 $3f $fd
	.asc "HE WAS A SUSPICIOUS MAN,"
	.db $fe
	.asc "SO WE CAUGHT HIM. BUT HE"
	.db $fe
	.asc "GOT AWAY SOMEHOW."
	.db $ff

script_72:
	.db $f7
	.asc "C"
	.db $fe $f7
	.asc "0'S "
	.db $f7 $3d $fd $f7
	.asc "D"
	.db $fe $f7
	.asc "E"
	.db $fe $f7
	.asc "F"
	.db $ff
