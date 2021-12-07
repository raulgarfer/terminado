.module colisiones.s
.include "datos/macros.s"
.include "cpctelera.h.s"
.globl contra_que_colisiono
colision_init::
	ld (player),ix
	ld bc,#e_sizeof
	add ix,bc
	ld (array_colision),ix
ret
comprueba_colision::
	player=.+2
	ld ix,#0x0000
	array_colision=.+2
	ld iy,#0x0000
	loop_colision:
	ld a,e_ancho(iy)
	cp #0
	ret z
player_por_izquierda:
	ld a,e_x(ix)		;|IF (e_x(ix)+e_ancho(ix)<e_x(iy)) no hay colision	
	add e_ancho(ix)	
	dec a	;|	
	sub e_x(iy)			;|
	jr c,no_colision
player_por_derecha:
	;;if (e_x(iy)+e_ancho(iy)<e_x(ix)) no hay colision
	ld a,e_x(iy)
	add e_ancho(iy)
	dec a
	sub e_x(ix)
	jr c,no_colision
player_por_arriba:
	ld a,e_y(ix)		;|IF (e_x(ix)+e_ancho(ix)<e_x(iy)) no hay colision	
	add e_alto(ix)	
	dec a	;|	
	sub e_y(iy)			;|
	jr c,no_colision
player_por_abajo:
	ld a,e_y(iy)		;|IF (e_x(ix)+e_ancho(ix)<e_x(iy)) no hay colision	
	add e_alto(iy)	
	dec a	;|	
	sub e_y(ix)			;|
	jr c,no_colision
	colision:
		cpctm_setBorder_asm #HW_GREEN
		call contra_que_colisiono
ret

no_colision:
	ld bc,#e_sizeof
	add iy,bc
	jr loop_colision