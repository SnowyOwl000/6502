; test-hello-1.s
; - first hello test from Ben Eater
;
; written 15 june 2020 by rwk
;
; notes:
; - displays "Hello, World!" on the display using 8-bit data interface
; - does not use lcd support code (support code in part derived from these
;   tests)
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
  lda     #%11111111
  sta     $8002
  lda     #%11100000
  sta     $8003

  lda     #%00111000
  sta     $8000

  lda     #%00000000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #%00001110
  sta     $8000

  lda     #%00000000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #%00000110
  sta     $8000

  lda     #%00000000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'H'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'e'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'l'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'l'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'o'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #','
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #' '
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'W'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'o'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'r'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'l'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'d'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  lda     #'!'
  sta     $8000

  lda     #%00100000
  sta     $8001
  eor     #%10000000
  sta     $8001
  eor     #%10000000
  sta     $8001

  wai

;==============================================================================
; vector table
;

  .section        vectors,"adr"
  .word   0                             ; NMI interrupt vector
  .word   reset                         ; CPU reset vector
  .word   0                             ; break / IRQ vector
