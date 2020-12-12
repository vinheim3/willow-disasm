.include "constants/globalFlags.s"
.include "constants/rleStructs.s"

.define RESET_MMC1_CTRL_REG_ADDR $ffe9

; magic from 0 to 7
.define FIRST_SCREEN_ENTITY_IDX $08
.define MAX_ENTITIES $18

; palette specs
.define PS_JUST_TEXT $34

; sounds
.define MUS_INTRO_CUTSCENE $10
.define SND_OPENING_INV $26
.define SND_MOVING_IN_INV $27
.define SND_BRACELET_PATH_OPENING $2f
.define SND_USING_BOMBARD $37
; todo: also played when healing Fin
; todo: also played when getting wing sword upgrade
; todo: also played when using powder on madmartigan
.define SND_BOGARDA_BRIDGE_MORPHING $38

; animations
.define ANIM_PLAYER_FACING_DOWN $02
.define ANIM_PLAYER_SLIME $1b

; directions
.define DIR_UP $00
.define DIR_RIGHT $01
.define DIR_DOWN $02
.define DIR_LEFT $03