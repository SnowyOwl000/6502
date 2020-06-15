; test-nop-loop.s
; - test nop in a loop
;
; written 15 june 2020 by rwk
;
; notes:
; - the intent is to create a simple two-statement loop, nop and branch to the
;   nop. This is just to test ROM-CPU connections and monitor via Arduino.
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

  .section        rom,"acdrx"
reset:
  nop
  bra     reset

;==============================================================================
; vector table
;

  .section        vectors,"adr"
  .word   0                             ; NMI interrupt vector
  .word   reset                         ; CPU reset vector
  .word   0                             ; break / IRQ vector
