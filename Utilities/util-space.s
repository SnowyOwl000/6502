; util-space.s
; - space used by utility functions (and others)
;
; written 16 may 2020 by rwk
;
; modification history
;

  .ifndef         _util_space_s
  .defc           _util_space_s = 1

;==============================================================================
; zero-page section
;

  .section        zero_page,"adrw"

;------------------------------------------------------------------------------
; operand pointers and size fields and scratch space
; - pointers to two operands and their respective sizes
; - scratch space for various operations
;
; zero page usage
; 13 bytes
;

  zpage     util_dest_ptr
  zpage     util_src_ptr
  zpage     util_src_size
;  zpage     util_space1
util_dest_ptr:                    ; pointer to destination operand
  blk       2
util_src_ptr:                     ; pointer to source operand
  blk       2
util_src_size:                    ; source operand size in bytes
  blk       1
;util_space1:                      ; scratch space for multiply and divide
;  blk       8

  .endif
