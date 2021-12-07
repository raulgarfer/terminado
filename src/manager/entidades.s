.module manager_entidades
.include "datos/macros.s"
.include "cpctelera.h.s"
.include "entidades.h.s"
DefineComponentArrayStructure entidades,maximo_entidades,Entidad_A_Cero
Define_Array_Punteros punteros_de_entidad,maximo_entidades;;
;;pone a 0 el numero de entidades,el puntero a primera entidad libre y al rray al principio
inicia_entidades::
	xor a 									;;A=0
	ld (entidades_numero),a 				;;numero = 0
	ld hl,#entidades_array					;;hl=&array entidades
	ld (entidades_primera_entidad_libre),hl 	;;Ptr = HL
ret
;;input hl puntero a entidad a copiar
;;return IX puntero a entidad nueva
crea_entidades::
	push hl 							;;guarda HL
	call entidad_nueva
	ld__ixh_d
	ld__ixl_e
	;;input bc sizeof
	;;de puntero a nueva entidad
	pop hl
	ldir
;;
;;segun el tipo de entidad, se manda a añadir un puntero al array acorreespondiente
	ld a,e_componente(ix)
	
	and #entidad_pintable
		call nz,incrementa_pintable
	ld a,e_componente(ix)
	and #entidad_con_IA
		call nz,incrementa_IA

ret

;puntero_primera_entidad_libre:: .dw entidades_array 
;entidades_array::
;		.ds e_sizeof * maximo_entidades
;;
;; devuelve en ix el array de entidades preciso		
get_array::
	ld ix,#entidades_array
	
ret
entidad_nueva::
	ld hl,#numero_entidades		;;numero entidades +1
	inc (hl)

	ld hl,(entidades_primera_entidad_libre)	;|DE=HL
	ld d,h 									;|	DE apunta a nueva entidad donde copiar
	ld e,l 									;|	*Entidad_libre +=sizeof_entity
	ld bc,#e_sizeof							;|	
	add hl,bc								;|	
	ld (entidades_primera_entidad_libre),hl 	;| actualiza puntero primera entidad

ret
resetea_entidades::
	xor a
	ld hl,#entidades_array
	ld (hl),a
	ld d,h
	ld e,l
	inc de 
	size= e_sizeof * maximo_entidades - 1
	ld bc,#size
	ldir
	ld ix,#entidades_array
	ld e_ancho(ix),#0

ret

