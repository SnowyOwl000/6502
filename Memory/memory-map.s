; memory-map.s
; - memory map for rwk design
;
; written 12 may 2020 by rwk
;

;==============================================================================
; locations of items in rwk design
;
; also section definitions
;

RAM_START         .equ  $0000   ; start of the zero page
IOSPACE_START     .equ  $8000   ; start of I/O space
ROM_START         .equ  $8200   ; first byte of ROM code after I/O space
VECTOR_TABLE      .equ  $fffa   ; CPU vector table

;------------------------------------------------------------------------------
; sections
;

  .org            RAM_START
  .section        zero_page,"adrw"

  .org            IOSPACE_START
  .section        iospace,"adrw"

  .org            ROM_START
  .section        rom,"acdrx"

  .org            VECTOR_TABLE
  .section        vectors,"adr"
