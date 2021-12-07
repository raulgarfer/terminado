.module sys_IA
.include "cpctelera.h.s"
.include "datos/macros.s"
.globl get_array
.globl devuelve_array_IA_en_HL
.globl comportamiento_con_IA
sys_IA_init::
	call get_array
	ld (array_IA),ix
ret
sys_IA_update::
	;;puntero automodificable
	array_IA=.+2
	ld ix,#0x0000

loop:
	;ld e,(hl)		;;carga en DE el puntero a entidad
	;inc hl
	;ld d,(hl)
	;inc hl
	;LD A,d 			;;si DE==null , vuelve
	;OR e
	ld a,e_ancho(ix)		;;comprueba si la entidad es valida (ancho>0)
		cp #e_novalida
		ret z         ;|

	ld a,e_componente(ix)
	and #entidad_con_IA
	jr nz,tiene_IA
	
	jr Entidad_sin_ia
tiene_IA:
	call comportamiento_con_IA
Entidad_sin_ia:
	ld bc,#e_sizeof
	add ix,bc
	jr loop

ret
