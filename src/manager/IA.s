.module IA_creacion_array.s
.include "datos/macros.s"
.include "cpctelera.h.s"

Define_Array_Punteros IA,maximo_entidades
;;===============================================================
;;pone a 0 los punteros del array de entidades a pintar
inicia_array_IA::
	ld hl,#IA_Puntero_Array					;;HL=puntero al array de IAs
	ld (IA_primera_entidad_libre),hl 	;;Primera_entidad_libre == HL (array de punteros)
	xor a 									;;A=0
	ld (hl),a 								;;*HL == 0 == A
	ld d,h 									;;
	ld e,l 									;;DE=HL
	inc de 									;;DE++
	ld bc,#2*maximo_entidades-1				;;BC=maximo de entidades*2 menos 1 porque antes lo hemos incrementado
	ldir									;;copia

devuelve_array_IA_en_HL::
	ld hl,#IA_Puntero_Array					;;HL=&array IA
ret
;;===============================================================
;;añade un nuevo puntero al array de punteros de IA
;;input ix como entidad
incrementa_IA::
	ld hl,(IA_primera_entidad_libre)	;;HL=&primera entida libre
	ld__a_ixl								;; A==L
	ld (hl),a 								;;*HL==A
	inc hl 									;;&HL++
	ld__a_ixh								;;A=H
	ld (hl),a 								;;*HL==A
	inc hl 									;;HL**
	ld (IA_primera_entidad_libre),hl 	;;*primera entidad ==&HL
ret
