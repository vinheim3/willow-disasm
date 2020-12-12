
.include "include/rominfo.s"
.include "include/constants.s"
.include "include/hardware.s"
.include "include/macros.s"
.include "include/scriptMacros.s"
.include "include/structs.s"
.include "include/wram.s"

.bank $00
.org 0

    .include "code/soundEngine.s"
    .include "data/soundData.s"
    .include "code/gameIntro.s"
    .include "data/rleStructs.s"
    .include "code/bankEnd.s"

.bank $01
.org 0

    .include "data/scripts.s"
    .include "data/scriptPresets.s"
    .include "code/bankEnd.s"

.bank $02
.org 0

    .include "data/outerRoomShapes.s"
    .include "code/b2_junk.s"

.bank $03
.org 0

    .include "data/innerRoomShapes.s"
    .include "data/metatiles_32to16.s"
    .include "data/roomGroupCollisionVals.s"
    .include "data/roomGroupAndShapes.s"
    .include "code/bankEnd.s"

.bank $04
.org 0

    b4_drawPlayer:
        jmp drawPlayer_body

    b4_drawEntities:
        jmp drawEntities_body

    .include "code/drawPlayer.s"

    ; unused?
        lda #$f8
        sta wOam.Y.w, x
        dec wNumEntityTiles
        bpl playerSendSpriteSpecTo_wOam
        rts

    .include "data/playerOamSpecsAnimationData.s"
    .include "code/drawEntities.s"
    .include "code/drawAll.s"
    .include "data/entitySpritesMiscData.s"
    .include "code/bankEnd.s"

.bank $05
.org 0

    .include "data/screenEntityBytes.s"

    b5_updateScreenEntities:
        jmp updateScreenEntities_body

    b5_loadScreenEntitiesOnRoomTransition:
    	jmp loadScreenEntitiesOnRoomTransition_body

    b5_updateMagicEntities:
    	jmp updateMagicEntities_body

    b5_loadScreenEntities:
        jmp loadScreenEntities_body

    b5_initNPC:
        jmp initNPC_body

    .include "code/loadScreenEntities.s"
    .include "data/screenEntitiesSpecs.s"
    .include "data/screenEntitiesPositions.s"
    .include "code/entityUpdateFuncs.s"
    .include "code/initNPC.s"
    .include "data/entityLoadStructs.s"

    .org $3bfe

    .dw $b052

    .include "code/bankEnd.s"

.bank $06
.org 0

    .include "code/bank06.s"
    .include "code/bankEnd.s"

.bank $07 slot 3
.org 0

    .include "code/bank07.s"
