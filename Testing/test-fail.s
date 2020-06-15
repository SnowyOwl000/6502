; test-fail.s
; - test memory map without VIA attached
;
; written 15 june 2020 by rwk
;
; notes:
; - this code is meant to be used with the Arduino monitor. It sets the reset
;   vector to 0x8000, which *should* be I/O space. The 8-input NOR gate should
;   output 1 at that location, which should disable ROM. RAM is disabled by
;   a15 == 1. So, there should be no device (without VIA) to provide data.
;   The code inserted at that location will execute if the address decoder
;   isn't working properly.
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

  .section        iospace,"adrw"
bad_reset:
  lda     #$ab
  tax
  bra     bad_reset

  .section        rom,"acdrx"
reset:
  nop
  bra     reset

;==============================================================================
; vector table
;

  .section        vectors,"adr"
  .word   0                             ; NMI interrupt vector
  .word   bad_reset                     ; CPU reset vector
  .word   0                             ; break / IRQ vector
