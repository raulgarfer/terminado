player_cycles = 1              ;; Number of interrupt cycles between music calls
.include "cpctelera.h.s"

;;===============================================================================
;; DATA SECTION
;;===============================================================================
.globl cpct_setInterruptHandler_asm
;; Interrupt status counter
iscount:  .db player_cycles

interrupt_handler::
   array_pintado = .+2
   ld ix,#0x0000

   ;; Update interrupt counter variable (iscount)
   ld   hl, #iscount          ;; HL points to interrupt counter variable (iscount)
   dec (hl)                   ;; --iscount
   ret  nz                    ;; Do not play music if iscount != 0 (so, return)
    

   ret                           ;; Return
interrupt_init::
   ld    hl, #interrupt_handler       ;; HL points to the interrupt handler routine
   call  cpct_setInterruptHandler_asm ;; Set the new interrupt handler routine
   ld (array_pintado),ix
   ret                              ;; return

