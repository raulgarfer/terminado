.module chocadoVS.s
.include "datos/macros.s"
.include "chocado.h.s"
.globl _puerta_abierta
;;input:
;; IX como player
;;IY como objeto colisionado

contra_que_colisiono::
	ld a,e_entidad(iy)
	ld b,a
	cp #e_enemy
		call z,mortal
	ld a,b
	cp #e_tesoro
		call z,treasure
	ld a,b
	cp #e_salida
		call z,exit
	ld a,b
	cp #e_solido
		call z,solido
ret

mortal::
	ld e_x(ix),#9
	ld e_y(ix),#50
	ld a,(vidas)
	dec a
	ld (vidas),a
	cp #0
	jp z,fin_juego
	call marcador
ret
treasure:
	ld e_IA_estado(ix),#1		;;tesoro recojido, activa persecucion en enemigo
	;ld a,#1
	ld a,(tesoro_recogido)
	inc a
	ld (tesoro_recogido),a
	;ld a,#56+tesoro_recogido*8
	rla
	add #46
	ld e_x(iy),a

	ld e_y(iy),#192
	ld a,(puntuacion)
	inc a
	ld (puntuacion),a
	ld bc,#e_sizeof
	add iy,bc
	ld hl,#_puerta_abierta
		ld e_sprite+0(iy),l 
	inc hl
		ld e_sprite+1(iy),h
ret
exit:
	ld a,(tesoro_recogido)			;;si no se ha cogido el tesoro, vuelve
	cp #0
		ret z
	call seleccion_pantalla
	call turno_pantalla
ret
solido::
	;;comprueba si hay colision izquierda o derecha
	;;if (e_x(ix) > e_x(iy))
	;;e_x(iy)-e_x(ix) < 0
	ld a,e_x(iy)
	sub e_x(ix)
	jr c,colion_a_derecha
		;;colisiona a la izquierda
		;;poner player e_x(iy)-e_ancho(ix)
colion_a_izquierda:
	ld a,e_x(iy)			;;
	sub e_ancho(ix)			;;A= e_x(iy)-e_ancho(ix)
	jr continua_x
		;;colisiona a la izquierda
		;;poner a player e_x(iy)+e_ancho(iy)
colion_a_derecha:
	ld a,e_x(iy)
	add e_ancho(iy)
continua_x:
	ld e_x(ix),a 
	ret

	ld a,e_y(iy)
	sub e_y(ix)
	jr c,colion_a_abajo
		;;colisiona a la izquierda
		;;poner player e_x(iy)-e_ancho(ix)
colion_a_arriba:
	ld a,e_y(iy)			;;
	sub e_alto(ix)			;;A= e_x(iy)-e_ancho(ix)
	jr continua_y
		;;colisiona a la izquierda
		;;poner a player e_x(iy)+e_ancho(iy)
colion_a_abajo:
	ld a,e_y(iy)
	add e_alto(iy)
continua_y:
	ld e_y(ix),a 
ret