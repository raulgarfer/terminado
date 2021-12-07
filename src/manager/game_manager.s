.module game_manager.s
.include "game_manager.h.s"
.include "cpctelera.h.s"

game_update::
	;call borra_entidad
		cpctm_setBorder_asm #HW_WHITE
    call escanea_teclado
		cpctm_setBorder_asm #HW_BLACK
    call fisica
	cpctm_setBorder_asm #HW_RED
	call pinta_entidad
	cpctm_setBorder_asm #HW_BLUE
	call comprueba_colision
	cpctm_setBorder_asm #HW_PINK
	call sys_IA_update
	cpctm_setBorder_asm #HW_YELLOW

	call cpct_waitVSYNC_asm
ret
