; test-hello-3.s
; - third version hello test from Ben Eater
;
; written 17 june 2020 by rwk
;
; notes:
; - displays "Hello, World!" on the display using 8-bit data interface
; - uses lcd code including puts
;

;==============================================================================
; include external defs and sections
;

  ;
  ; memory map
  ;

  .include        ../Memory/memory-map.s

  ;
  ; 16x2 LCD display
  ;

  .include        ../IO/lcd-16x2-8.s

;==============================================================================
; startup code
;

  .section        rom,"acdrx"
reset:
  ldx     #$ff
  txs

  lcd_16x2_init_macro

  lcd_16x2_puts_macro   message
  
  wai

message:
  .asciiz         "Hello, World!"

;==============================================================================
; vector table
;

  .section        vectors,"adr"
  .word   0                             ; NMI interrupt vector
  .word   reset                         ; CPU reset vector
  .word   0                             ; break / IRQ vector
