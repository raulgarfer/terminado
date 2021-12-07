.module fisica.s
.include "datos/macros.s"
screen_ancho 	= 80-3		;;anchgo pantalla menos decorado
screen_alto		= 200-14 	;;alto total menos marcador
fisica_init::
	ld (array_fisica),ix
ret

fisica::
	array_fisica=.+2
	ld ix,#0x0000
loop_fisica:
	ld a,e_ancho(ix)		;;comprueba si la entidad es valida (ancho>0)
		cp #e_novalida
		ret z
	ld a,e_x(ix)
		sub  #5
		jr c,no_mas_izquierda
	ld a,#screen_ancho		;|
	sub e_ancho(ix)			;|carga en C el ancho de pantalla menos ancho de entidad
	ld c,a					;|

	ld a,e_x(ix)			;; A=x entidad
	add e_vx(ix)			;;A+=velocidad X entidad
		cp c 				;;compara con C
		jr nc,invalid_x		;;se sale de pantalla?

			ld e_x(ix),a 	;;no, actualiza X
			jr endif_x		;;salta al final de X
invalid_x:				;;se sale de pantalla
		ld a,e_vx(ix)		;;A=Velocidad X
		neg					;;A ==-(A)
		ld e_vx(ix),a 		;;guarda A
endif_x:

	ld a,e_y(ix)
	sub #10
	jr c,no_mas_arriba

	ld a,#screen_alto
	sub e_alto(ix)
		ld c,a

	ld a,e_y(ix)
	add e_vy(ix)
		cp c
		jr nc,invalid_y
			ld e_y(ix),a
			jr endif_y
invalid_y:
		ld a,e_vy(ix)
		neg
		ld e_vy(ix),a
endif_y:

	ld bc,#e_sizeof
	add ix,bc
	jr loop_fisica

no_mas_izquierda:
	ld e_x(ix),#5
	jr invalid_x

no_mas_arriba:
	ld e_y(ix),#10
	jr invalid_y