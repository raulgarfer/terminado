.module pintado.s
.include "pintado.h.s"
.include "cpctelera.h.s"
.include "datos/macros.s"
.globl pintable_Puntero_Array
.globl devuelve_array_pintable_en_HL
pinta_entidad_init::
  ; ld (array_pinta_entidad),ix
   call devuelve_array_pintable_en_HL
   ld (array_pinta_entidad),hl
ret

pinta_entidad::
   array_pinta_entidad=.+1
   ld hl,#0x0000
loop_pintable:
   ;;DE=*entidad
   ld e,(hl)
   inc hl
   ld d,(hl)
   inc hl

   ld a,d      ;;comprueba si el puntero en nulo
   or e        ;;si es nulo,ret
   ret z

   ;;carga en IX el valor de DE
   ld__ixl_e      ;;ix_l==A
   ld__ixh_d      ;;ix_h==a
   push hl        ;;hl=>sp
   call pinta_una_entidad
   pop hl         ;;restaura hl
   jr loop_pintable  ;;loop
ret
pinta_una_entidad:
 ;  array_pinta_entidad = .+2
 ;  ld ix,#0x0000
  loop_pintado:
      ld e,e_oldVMem+0(ix)
      ld d,e_oldVMem+1(ix)
      xor a 
      ld c,e_ancho(ix)
      ld b,e_alto(ix)
      push bc
         call cpct_drawSolidBox_asm
   ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, e_y(ix)                  ;; B = y coordinate (24 = 0x18)
   ld    c, e_x(ix)                  ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   
   ld e_oldVMem+0(ix),l          ;|se guarda la posicion antigua en la entidad
   ld e_oldVMem+1(ix),h          ;|

   ex de,hl

   ld l,e_sprite+0(ix)
   ld h,e_sprite+1(ix)
   pop bc
   call cpct_drawSprite_asm
ret
 
