.module colisionables.s
.include "datos/macros.s"
.include "cpctelera.h.s"

Define_Array_Punteros collision,maximo_entidades

man_entity_collision_init::
	ld hl,#collision_Puntero_Array
	ld (collision_primera_entidad_libre),hl

	xor a 
	ld (hl),a 
	ld d,h
	ld e,l
	inc de
	ld bc,#2*maximo_entidades-1
	ldir
ret
man_entity_collision_getArrayHL::
	ld hl,#collision_Puntero_Array
ret
man_entity_collision_add::
	ld hl,(collision_primera_entidad_libre)
	ld__a_ixl
	ld (hl),a 
	inc hl
	ld__a_ixh
	ld (hl),a 

	inc hl 
	ld(collision_primera_entidad_libre),hl 
	ret
