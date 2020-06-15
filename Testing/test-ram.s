; test-ram.s
; - simple RAM test
;
; written 15 june 2020 by rwk
;
; notes:
; - this code just adds the integers from 6 down to 0, storing the sum in RAM.
;   the code then busy loops, loading the sum into A.
;

;==============================================================================
; include external defs and sections
;

  ;
  ; memory map
  ;

  .include        ../Memory/memory-map.s

;==============================================================================
; startup code
;

sum       .equ    $200

  .section        rom,"acdrx"
reset:
  lda     #0
  sta     sum
  ldx     #6

.loop0:
  txa
  adc     sum
  sta     sum
  dex
  bne     .loop0

.loop1:
  lda     sum
  bra     .loop1

;==============================================================================
; vector table
;

  .section        vectors,"adr"
  .word   0                             ; NMI interrupt vector
  .word   reset                         ; CPU reset vector
  .word   0                             ; break / IRQ vector
