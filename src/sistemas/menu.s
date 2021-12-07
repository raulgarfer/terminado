.module systems_menu.s
.include "cpctelera.h.s"
.include "cpc_funciones.h.s"
.include "datos/macros.s"
.include "menu.h.s"

sys_menu::
    ld c,#0
	call cpct_setVideoMode_asm
	cpctm_setBorder_asm #HW_BLUE
    cpctm_clearScreen_asm #0
    call sys_main_menu
    cpctm_clearScreen_asm #0
	cpctm_setBorder_asm #HW_WHITE
ret
sys_main_menu:
     cpctm_screenPtr_asm HL,0xc000,0,0
    ld iy,#espacio
    call cpct_drawStringM0_asm

    cpctm_screenPtr_asm HL,0xc000,0,16
    ld iy,#controles
    call cpct_drawStringM0_asm
    
    cpctm_screenPtr_asm HL,0xc000,0,32
    ld iy,#linea1
    call cpct_drawStringM0_asm
        
    cpctm_screenPtr_asm HL,0xc000,0,48
    ld iy,#linea2
    call cpct_drawStringM0_asm

    cpctm_screenPtr_asm HL,0xc000,0,140
    ld iy,#player
    cpctm_screenPtr_asm DE,0xc000,0,140
    call cpct_drawStringM0_asm
    cpctm_screenPtr_asm DE,0xc000,40,140
    ld hl,#_hero_left
    ld c,#4
    ld b,#12
    call cpct_drawSprite_asm

    cpctm_screenPtr_asm HL,0xc000,0,80
    ld iy,#enemy
    call cpct_drawStringM0_asm
     cpctm_screenPtr_asm DE,0xc000,40,80
    ld hl,#_enemy
    ld c,#4
    ld b,#10
    call cpct_drawSprite_asm

    cpctm_screenPtr_asm HL,0xc000,0,96
    ld iy,#tesoro
    call cpct_drawStringM0_asm
  cpctm_screenPtr_asm DE,0xc000,40,96
    ld hl,#_joya
    ld c,#4
    ld b,#8
    call cpct_drawSprite_asm

    cpctm_screenPtr_asm HL,0xc000,0,112
    ld iy,#salida
    call cpct_drawStringM0_asm
cpctm_screenPtr_asm DE,0xc000,40,112
    ld hl,#_puerta
    ld c,#4
    ld b,#8
    call cpct_drawSprite_asm
    call espera_espacio
ret

espera_espacio:
        call  cpct_scanKeyboard_asm
        ld hl,#Key_Space
        call cpct_isKeyPressed_asm
    jr z,espera_espacio
ret
fin_juego::
  ld c,#2
    call cpct_setVideoMode_asm
    cpctm_setBorder_asm #HW_BLUE
    cpctm_clearScreen_asm #0
    cpctm_screenPtr_asm HL,0xc000,0,50

    ld iy,#fin1
    call cpct_drawStringM2_asm
    call espera_espacio
    cpctm_clearScreen_asm #0
    cpctm_setBorder_asm #HW_WHITE
    ld c,#0
    call cpct_setVideoMode_asm
    
    or a
    ld (pantalla),a 
    ld (puntuacion),a
    
    jp _main
ret