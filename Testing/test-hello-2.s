; test-hello-2.s
; - second version hello test from Ben Eater
;
; written 17 june 2020 by rwk
;
; notes:
; - displays "Hello, World!" on the display using 8-bit data interface
; - uses VIA 0 equates
; - uses branch-based E-bit toggle
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

  .include        ../IO/via-0.s

;==============================================================================
; startup code
;

  .section        rom,"acdrx"
reset:
  lda     #%11111111
  sta     VIA_0_DDR_B
  lda     #%11100000
  sta     VIA_0_DDR_A

  lda     #%00111000
  sta     VIA_0_PORT_B

  lda     #%00000000
;  sta     $8001
.l0:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l0

  lda     #%00001110
  sta     VIA_0_PORT_B

  lda     #%00000000
;  sta     $8001
.l1:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l1

  lda     #%00000110
  sta     VIA_0_PORT_B

  lda     #%00000000
;  sta     $8001
.l2:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l2

  lda     #'H'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l3:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l3

  lda     #'e'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l4:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l4

  lda     #'l'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l5:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l5

  lda     #'l'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l6:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l6

  lda     #'o'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l7:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l7

  lda     #','
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l8:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l8

  lda     #' '
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l9:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l9

  lda     #'W'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l10:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l10

  lda     #'o'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l11:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l11

  lda     #'r'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l12:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l12

  lda     #'l'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l13:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l13

  lda     #'d'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l14:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l14

  lda     #'!'
  sta     VIA_0_PORT_B

  lda     #%00100000
;  sta     $8001
.l15:
  eor     #%10000000
  sta     VIA_0_PORT_A
  bmi     .l15

  wai

;==============================================================================
; vector table
;

  .section        vectors,"adr"
  .word   0                             ; NMI interrupt vector
  .word   reset                         ; CPU reset vector
  .word   0                             ; break / IRQ vector
