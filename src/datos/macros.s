.module macros.s

.macro Define_Entidad	_comp,_x,_y,_ancho,_alto,_sprite,_entidad,_ent_type
	.db _comp			;;componente. indica si se pinta, si tiene IA,etc.
	.db _x
	.db _y
	.db _ancho
	.db _alto
	.dw _sprite
	.db 0
	.db 0
	.dw 0xcccc		;;sprite por defecto
	.db _entidad 	;;indica que tipo esd, enemigo,decorado,salida,tesoro
	.db _ent_type	
	.db 0			;;estado de la IA. patrulla,persecucion
	.db 0,0			;;xy objetivo
.endm
.macro Entidad_A_Cero 
	Define_Entidad 0,0,0,0x0000,0,0,0,0
.endm
.macro Define_Array_Entidades _N
	.rept _n 
		Entidad_A_Cero
	.endm
.endm


__off = 0
.macro Define_Plantilla size, _nombre
	_nombre = __off
	__off 	= __off + size
.endm

Define_Plantilla 1,e_componente
Define_Plantilla 1,e_x
Define_Plantilla 1,e_y
Define_Plantilla 1,e_ancho
Define_Plantilla 1,e_alto
Define_Plantilla 2,e_sprite
Define_Plantilla 1,e_vx
Define_Plantilla 1,e_vy
Define_Plantilla 2,e_oldVMem
Define_Plantilla 1,e_entidad
Define_Plantilla 1,e_tipo_entidad
Define_Plantilla 1,e_IA_estado
Define_Plantilla 1,e_obj_x
Define_Plantilla 1,e_obj_y

Define_Plantilla 0,e_sizeof

e_novalida 	= 0

maximo_entidades = 	10
;;
;;e_tipo_entidad
;;
e_player 	= 1
e_enemy		= 2
e_tesoro	= 3
e_salida	= 4
e_solido 	= 5
;;
;;e_componente
;;
entidad_no_valida	=	0b0000000000
entidad_pintable	=	0b0000000001
entidad_solida		=	0b0000000010
entidad_mortal		=	0b0000000100
entidad_con_IA		=   0b0000001000 

;
;e_IA_estado
;
e_standby	= 0
e_patrol	= 1
e_chase		= 2
e_moveto	= 3

;;======================================================
;;genrea una estructura de datos(array) de componentes 
;;generates data structure and array of type_t components
;;macro to generate all the data structurerber of elementsequired
;;to manage an array of components of the same type
;;it generates these labels
	;;t_num a byte to count the number of elements in array
	;;r_array this will be the first free element in the array
	;;t_Array the array itself
		;;inputs
		;; tname name of the component type
		;;n size of the array in number of components
		;;DefineTypeMacroDefault macro to be called to generates a default

.macro DefineComponentArrayStructure	_tname,_N,_DefineTypeMacroDefault
	_tname'_numero::	.db 0				;;number of defined elements
	_tname'_primera_entidad_libre::	.dw _tname'_array	;;pointer to the end of array of elemnents
	_tname'_array:: 					;;array of elements
		.rept _N
			_DefineTypeMacroDefault
		.endm
.endm

.macro DefineComponentArrayStructure_size _tname,_N,_ComponentSize
	_tname'_numero:: 	.db 0				;;number of defined elements
	_tname'_primera_entidad_libre:: 	.dw _tname_array		;;pointer to end
	_tname'_array::					;;array of elements
		.ds _N * _ComponentSize		;;rellena de 0 el espacio caluclado
.endm
;;
;;genera array de punteros de componentes del mismo tipo
.macro Define_Array_Punteros _nombre,_cantidad
	_nombre'_primera_entidad_libre:: .dw _nombre'_Puntero_Array
	_nombre'_Puntero_Array::
		.rept _cantidad
			.dw 0x0000
		.endm
.endm
