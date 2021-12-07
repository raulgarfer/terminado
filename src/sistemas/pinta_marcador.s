.module pinta_marcador.s
.include "cpc_funciones.h.s"
.include "cpctelera.h.s"
.globl cpct_etm_drawTilemap4x8_agf_asm
.globl vidas
.globl _mapa
.globl cpct_etm_setDrawTilemap4x8_ag_asm
.globl cpct_etm_drawTilemap4x8_ag_asm
.globl _tiles_0
.globl pantalla
.globl puntuacion
vida: .asciz"VIDAS   PUNTOS"

marcador::
;;pinta el fondo 
	 ld c,#20
    ld b,#25
    ld de,#20
    ld hl,#_tiles_0
    call cpct_etm_setDrawTilemap4x8_ag_asm

    ld hl,#0xc000
    ld de,#_mapa
    call cpct_etm_drawTilemap4x8_ag_asm

;pinta marcador
    ;.macro cpctm_screenPtr_asm REG16, VMEM, X, Y
    cpctm_screenPtr_asm HL,0xc000,0,192
    ld iy,#vida
    call cpct_drawStringM0_asm

    cpctm_screenPtr_asm HL,0xc000,24,192

	ld a,(vidas)
	add #0x30		;;caaracter 0 en ascii
	ld e,a
    call cpct_drawCharM0_asm

    cpctm_screenPtr_asm HL,0xc000,58,192

    ld a,(puntuacion)
	add #0x30		;;caaracter 0 en ascii
	ld e,a
    call cpct_drawCharM0_asm

ret

