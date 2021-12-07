.include "cpctelera.h.s"
.include "datos/macros.s"
.include "main.h.s"
.globl reset_marcadores
.module inicia_juego.s
.globl comportamiento_init
inicia_juego::
 ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm
   cpctm_setBorder_asm #HW_RED
;;pone los valores del juego a su posicion original
   call reset_marcadores   
   ld c,#0
   call cpct_setVideoMode_asm

   call resetea_arrays

   call inicia_entidades 
   call reset_marcadores
   call resetea_entidades

   call sys_menu
      ;;llama a funciones para poner el array adecuado en cada una
   call get_array
   call comportamiento_init
   call pinta_entidad_init
   call sys_IA_init
   call fisica_init
   call colision_init
   call get_array
   call teclado_init
   call pantalla_init
   call marcador

   call turno_pantalla
ret
