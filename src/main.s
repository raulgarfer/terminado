;;========================================================================================
;; juego de prueba.
;; primer juego que doy por terminado, escrito enensamblador para CPC
;; decido terminarlo aqui porque las implementaciones que hay que hacer para mejorar el juego
;; implican retocar mucho el codigo,  y parte rehacerlo.
;; ya me he visto antes en esta situacion, y dejarlo por imposible el continuar, haciendo 
;;inservible el codigo. prefiero dejarlo como una pequeña demo que abandonarlo para siempre
;;
;; dar las gracias a @franGallegoBR, y a toda la gente que hace posible cpctelera
;;por ellos , todo este hobby no habria sido posible
;;
;;granada,eśpaña, a 7 de diciembre de 2021

;; Include all CPCtelera constant definitions, macros and variables

.include "cpctelera.h.s"
.include "datos/macros.s"
.include "main.h.s"
.area _DATA
;;==============================================
;;variables principales
;;
numero_entidades::   .db 0
puntuacion::         .db 0
vidas::              .db 3
pantalla::           .db 0
tesoro_recogido::    .db 0
;;declaracion para el uso en entidades
entidad_enemigo_IA	=	(entidad_pintable | entidad_mortal | entidad_con_IA)
entidad_decoracion         = (entidad_pintable | entidad_solida)
entidad_obstaculo_mortal   = (entidad_pintable | entidad_mortal)
;;declaracion de plantilla de entidades
jugador::  Define_Entidad entidad_pintable,10,20,4, 12, _hero_left,e_solido,entidad_pintable
enemigo::  Define_Entidad entidad_enemigo_IA,20,30,4,10, _enemy,  e_enemy,e_enemy
joya::     Define_Entidad entidad_pintable,40,60,4,8,_joya,e_tesoro,entidad_pintable
puerta::   Define_Entidad entidad_pintable,60,80,4,8, _puerta,e_salida,entidad_pintable
enemigo1:: Define_Entidad entidad_enemigo_IA,60,60,4,10, _enemy,e_enemy,e_enemy  
vagoneta:: Define_Entidad entidad_enemigo_IA,10,80,4,8, _vagoneta,e_enemy,e_enemy  
ladrillo:: Define_Entidad entidad_pintable,10,170,4,8,_ladrillo,e_solido,entidad_decoracion
pincho_abajo:: Define_Entidad entidad_pintable,0,150,4,8,_pincho_abajo,e_solido,entidad_obstaculo_mortal
;;texto usado durante el juego
fin1::         .asciz "Gracias por jugar!!!.Unete al canal de telegram @cpctelera"
espacio::      .asciz "WASD/WAOP/Cursores"
controles::    .asciz "Coge los tesoros.   Esc para salir"
linea1::       .asciz "Evita los enemigos. Pulsa Espacio"
player::       .asciz "Jugador"
enemy::        .asciz "Enemigo"
tesoro::       .asciz "Tesoro"
salida::       .asciz "Salida"
escudo::       .asciz "Escudo"
linea2::       .asciz "Granada,Spain 2021"
;;=========================================================
;; el juego salta aqui el principio
;;=========================================================
.area _CODE
_main::
   call inicia_juego
loop:
   call game_update
jr    loop
reset_marcadores::
   or a
   ld (pantalla),a
   ld (puntuacion),a
   ld (numero_entidades),a
   ld (tesoro_recogido),a
   ld a,#3
   ld (vidas),a
ret 
