; arith-space.s
; - space used by arithmetic functions (and others)
;
; written 11 may 2020 by rwk
;
; modification history
; 13 may 2020
; - increased scratch space 2 to 16 bytes for udiv4
;

  .ifndef         _arith_space_s
  .defc           _arith_space_s = 1

;==============================================================================
; zero-page section
;

  .section        zero_page,"adrw"

;------------------------------------------------------------------------------
; operand pointers and size fields and scratch space
; - pointers to three operands and their respective sizes
; - scratch space for various operations
;
; zero page usage
; 42 bytes
;

  zpage     arith_op_a_ptr
  zpage     arith_op_b_ptr
  zpage     arith_op_c_ptr
  zpage     arith_op_d_ptr
  zpage     arith_op_a_size
  zpage     arith_op_c_size
  zpage     scratch_space1
  zpage     scratch_space2
arith_op_a_ptr:                   ; pointer to arithmetic operand a
  blk       2
arith_op_b_ptr:                   ; pointer to arithmetic operand b
  blk       2
arith_op_c_ptr:                   ; pointer to arithmetic operand c
  blk       2
arith_op_d_ptr:                   ; pointer to arithmetic operand d
  blk       2
arith_op_a_size:                  ; operand a size in bytes
  blk       1
arith_op_c_size:                  ; operand c size in bytes
  blk       1
scratch_space1:                   ; scratch space for multiply and divide
  blk       16
scratch_space2:
  blk       16

  .endif
