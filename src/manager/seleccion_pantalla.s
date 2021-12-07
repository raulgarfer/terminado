.module seleccion_pantalla.s
.include "cpctelera.h.s"
.include "datos/macros.s"
.include "seleccion_pantalla.h.s"
.include "cpc_funciones.h.s"

.globl ent_player
.globl ent_puerta
pantalla_init::
	ld (array_turno),ix
	ld (array_pantalla),ix
	;ld (array_pantalla_3),ix
	;ld (array_pantalla_4),ix
ret

seleccion_pantalla::
	cpctm_clearScreen_asm #0
	or a
	ld (tesoro_recogido),a
	call marcador
ret
turno_pantalla::
	array_turno = .+2
	or a
	ld (tesoro_recogido),a

	ld a,(pantalla)
	inc a
	ld (pantalla),a
		cp #1
			call z,pantalla1
		cp #2
			call z,pantalla2
		cp #3
			call z,pantalla3
		cp #4
			call z,pantalla4
		cp #5
			jp z,pantalla5
		cp #6
			jp z,pantalla6
		cp #7
			jp z,juego_pasado
ret
pantalla1::
	ld hl,#jugador
   	call crea_entidades
   		ld (ent_player),ix
   	ld hl,#joya
   	call crea_entidades
   	ld hl,#puerta
   	call crea_entidades
   		ld (ent_puerta),ix
   		call cierra_puerta
ret
pantalla2::
	array_pantalla = .+2
	ld ix,#0x0000
	call reset_player

	ld hl,#enemigo
	call crea_entidades
	ld hl,#joya
   	call crea_entidades
;;lleva el registro IX hasta la entidad joya
	ld bc,#e_sizeof		;;cambia los valores XY de joya
	ld bc,#e_sizeof		;;cambia los valores XY de joya

	add ix,bc
	ld e_x(ix),#10
	ld e_y(ix),#70
	ld ix,(ent_puerta)
	call cierra_puerta

ret
pantalla3::
	call reset_player
	ld hl,#vagoneta
	call crea_entidades
		ld ix,(ent_puerta)
	call cierra_puerta

ret
pantalla4::
	call reset_player
		ld ix,(ent_puerta)
	call cierra_puerta
ret
pantalla5:
	call reset_player

	ld hl,#enemigo1
   	call crea_entidades

   	ld ix,(ent_puerta)
	call cierra_puerta
ret
pantalla6:
	call reset_player
	ld hl,#vagoneta
	call crea_entidades
	 	ld ix,(ent_puerta)
	call cierra_puerta
ret
;;================================================
;;juego pasado
;;
fin_1: .asciz "Felicidades.Espero tus comentarios en el canal."
fin_2: .asciz "Gracias a @FranGallegoBR y los demas integrantes"
fin_3: .asciz "sin su ayuda, no habria aprendido nada."
juego_pasado:
 ld c,#2
	call cpct_setVideoMode_asm
		cpctm_clearScreen_asm #0
	
    cpctm_screenPtr_asm HL,0xc000,0,10
    ld iy,#fin_1
    call cpct_drawStringM2_asm

       cpctm_screenPtr_asm HL,0xc000,0,20
       ld iy,#fin_2
    call cpct_drawStringM2_asm
 	cpctm_screenPtr_asm HL,0xc000,0,30
    ld iy,#fin_3
    call cpct_drawStringM2_asm
    call espera_espacio
    jp _main
ret
;;================================================
;;espera espacio
;;
espera_espacio:
	call cpct_scanKeyboard_asm
	ld hl,#Key_Space
	call cpct_isKeyPressed_asm
	jr z,espera_espacio
ret
cierra_puerta:
		ld hl,#_puerta
		ld e_sprite+0(ix),l 
	inc hl
		ld e_sprite+1(ix),h
	or a
	ld (tesoro_recogido),a
ret
reset_player:
ld ix,(array_pantalla)
	ld e_x(ix),#8		;;XY de jugador 
	ld e_y(ix),#8
	ld e_IA_estado(ix),#0		;;tesoro dejado, desactiva persecucion en enemigo

	ld bc,#e_sizeof		;;cambia los valores XY de joya
	add ix,bc
	ld e_x(ix),#40
	ld e_y(ix),#120
ret