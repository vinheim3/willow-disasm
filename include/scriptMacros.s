.macro scr_bossBattle
    .db $f2
.endm

.macro scr_magicRingStrength
    .db $f3
.endm

.macro scr_unsetGlobalFlag
    .db $f4 \1
.endm

.macro scr_setRoomYX
    .db $f5 \1 \2
.endm

; f6 - uses a parameter 6 to 9

.macro scr_displayPreset
    .db $f7 \1
.endm

.macro scr_playSoundAndWait
    .db $f8 \1 \2
.endm

.macro scr_setGlobalFlag
    .db $fa \1
.endm

.macro scr_jingleSound
    .db $fb
.endm

; fc
; 0 - heal mp
; 1 - prompt for po's teleport
; 2 - heal hp
; 3 - trying to heal fin
; 4/5 - flute healing muzh event
; 6 - dragon items event

.macro scr_buttonPrompt
    .db $fd
.endm

; fe - scrolls text up/clears text for next text

.macro scr_end
    .db $ff
.endm