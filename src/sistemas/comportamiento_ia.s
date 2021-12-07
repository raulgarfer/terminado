.module comportamiento_con_IA
;;====================================
;;sistema de control por IA
;;consulta si la entidad tiene IA, y cambia velocidad, destino,comportamiento,etc
;;IX entidad enemigo
;;IY entidad player
.include "cpctelera.h.s"
.include "datos/macros.s"
.globl entidades_array
comportamiento_init::
	ld (player_ptr),Ix
ret
comportamiento_con_IA::
player_ptr=.+2
	ld iy,#0x0000
	ld a,e_IA_estado(ix)
	cp #e_standby
		jr z,standby
	cp #e_patrol
		jr z,patrol	
	;jr nz,no_standby
	cp #e_chase
		jr z,chase 
;;
;; ponemos velocidad inicial al enemigo, si tiene IA
standby::
	ld e_vx(ix),#-1 				;;velx == -1
	ld e_vy(ix),#1 					;;vely== -1
	;ld a,#e_patrol
	ld e_IA_estado(ix),#e_patrol 	;;estado enemigo en patrulla
	ret
patrol::
	ld a,e_IA_estado(iy) 			;;tiene tesoro en poder?
	cp #1 							;;si
		jr z,pon_ia_en_persecucion	;;enemigo al ataque!!!
no_standby::
	
ret
;;
;;pone el estado de enemigo en persecucion
;;da como objetivo XY de player
pon_ia_en_persecucion::
	ld e_IA_estado(ix),#e_chase		;;cambio estado a persegui
	ld a,e_x(iy)					;;A==X player
	ld e_obj_x(Ix),a 				;;x objetivo enemigo==A
	ld a,e_y(IY) 					;;A==Y player
	ld e_obj_y(ix),a 				;;Y objetivo enemigo == A
ret
;;
;;comprobacion de xy enemigo VS xy objetivo
;;
chase:
	ld e_vx(IY),#0					;;pone a 0 las velocidades
	ld e_vy(iy),#0
	ld a,e_obj_x(iy)				;;A== objX
	sub e_x(iy)						;;A-=X entidad
	jr nc,mayor_o_igual
menor_que:
	ld e_vx(iy),#-1
	jr endif_x
mayor_o_igual:
	jr z,llegado_x
	ld e_vx(iy),#1
	jr endif_x
llegado_x:
	ld e_vx(iy),#0
endif_x:
ret

ret
