.module teclado.s

.include "cpctelera.h.s"
.include "teclado.h.s"
.include "datos/macros.s"
teclado_init::
	ld (array_teclado),ix
ret

escanea_teclado::
	array_teclado =.+2
	ld ix,#0x0000
		;;pone a 0 las velocidades del jugador
	ld e_vx(ix),#0
	ld e_vy(ix),#0
		;;escanea teclado
	call cpct_scanKeyboard_f_asm
		;;accion,reaccion
	ld iy,#tecla_accion-4
loop:
	ld bc,#4
	add iy,bc
	ld l,0(iy)		;;HL==*tecla
	ld h,1(iy)
		;;check if key==null
	ld a,l 		;;if HL==0,ret
	or h
	ret z
		call cpct_isKeyPressed_asm
			jr z,loop
	ld hl,#loop 		;;carga en pila la direccion donde volver
	push hl
	ld l,2(iy)
	ld h,3(iy)
	jp (hl)
continue:
	jr loop
derecha:
	ld e_vx(ix),#1
ret
izquierda:
	ld e_vx(ix),#-1
ret
arriba:
	ld e_vy(ix),#-2
ret
abajo:
	ld e_vy(ix),#2
ret
fin:
	pop hl
	jp _main
tecla_accion:
	.dw	Key_P,derecha
	.dw Key_O, izquierda
	.dw Key_S,abajo
	.dw Key_W,arriba
	.dw Key_A, izquierda
	.dw Key_D, derecha
	.dw Key_CursorRight, derecha
	.dw Key_CursorLeft, izquierda
	.dw Key_CursorUp, arriba
	.dw Key_CursorDown, abajo
	.dw Key_Esc,fin
	.dw 0
ret

