; test-hello-3.s
; - third version hello test from Ben Eater
;
; written 17 june 2020 by rwk
;
; notes:
; - displays "Hello, World!" on the display using 8-bit data interface
; - uses lcd code
;

;==============================================================================
; include external defs and sections
;

  ;
  ; memory map
  ;

  .include        ../Memory/memory-map.s

  ;
  ; VIA 0
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

  lda     #'H'
  jsr     lcd_16x2_putchar

  lda     #'e'
  jsr     lcd_16x2_putchar

  lda     #'l'
  jsr     lcd_16x2_putchar

  lda     #'l'
  jsr     lcd_16x2_putchar

  lda     #'o'
  jsr     lcd_16x2_putchar

  lda     #','
  jsr     lcd_16x2_putchar

  lda     #' '
  jsr     lcd_16x2_putchar

  lda     #'W'
  jsr     lcd_16x2_putchar

  lda     #'o'
  jsr     lcd_16x2_putchar

  lda     #'r'
  jsr     lcd_16x2_putchar

  lda     #'l'
  jsr     lcd_16x2_putchar

  lda     #'d'
  jsr     lcd_16x2_putchar

  lda     #'!'
  jsr     lcd_16x2_putchar

  wai

;==============================================================================
; vector table
;

  .section        vectors,"adr"
  .word   0                             ; NMI interrupt vector
  .word   reset                         ; CPU reset vector
  .word   0                             ; break / IRQ vector
