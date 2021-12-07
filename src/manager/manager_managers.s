.module manager_managers

.globl inicia_array_pintable
.globl inicia_array_IA

resetea_arrays::
	call inicia_array_pintable
	call inicia_array_IA
ret
