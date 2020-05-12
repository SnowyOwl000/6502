; arith-mul3.s
; - 3-operand unsigned multiply
;
; written 12 may 2020 by rwk
;

  ;
  ; requires arith-space
  ;

  .include          arith-space.s

;-----------------------------------------------------------------------------
; mul3
; - three-operand unsigned multiply: c = a * b
;
; parms
; arith_op_a_ptr  - pointer to lhs
; arith_op_b_ptr  - pointer to rhs
; arith_op_c_ptr  - pointer to result
; arith_op_a_size - number of bytes in operands a and b; op c twice as large
;
; clobbers
; axy
;
; stack usage
; 3 bytes - 2 for return address and one scratch byte
;

mul3:
  lda   arith_op_a_size                 ; y = operand a size - 1
  tay
  dey

  asl                                   ; x = 2 * operand a size - 1
  tax
  dex

  phx                                   ; save 2 * op size - 1 for later

.prep_loop1:
  lda   (arith_op_a_ptr),y              ; scratch2[y] = (*a)[y]
  sta   scratch_space2,y

  lda   (arith_op_b_ptr),y              ; scratch1[x] = (*b)[y]
  sta   scratch_space1,x

  lda   #0                              ; scratch1[y] = 0
  sta   scratch_space1,y

  dex                                   ; x--
  dey                                   ; y--

  bpl   .prep_loop1                     ; loop back if y >= 0

  ply                                   ; pop 2*op size - 1 into y

.prep_loop2:
  sta   (arith_op_c_ptr),y              ; (*c)[y] = 0

  dey                                   ; y--

  bpl   .prep_loop2                     ; loop back if y >= 0

  ;
  ; at this point, a is in scratch2, b is zero-padded in scratch 1, c is 0
  ;

  lda   arith_op_a_size                 ; a = number of bits in operands
  asl
  asl
  asl

  ;
  ; loop over all bits in operand
  ;

.mul_outer_loop:
  pha                                   ; save count

  ;
  ; shift a (scratch 2) right 1 bit
  ;

  ldy   #0                              ; y = 0
  ldx   arith_op_a_size                 ; x = number of bytes to shift
  clc

.mul_a_rshift_loop:                     ; work from msb to lsb
  ror   scratch_space2,y                ; shift scratch2[y]

  iny                                   ; y++
  dex                                   ; x--

  bne .mul_a_rshift_loop                ; loop back if x != 0

  ;
  ; skip if carry clear
  ;

  bcc .mul_no_add

  ;
  ; add b (scratch 1) to c
  ;

  ldy   arith_op_c_size                 ; y = number of output bytes - 1
  dey
  clc

.mul_add_b_loop:
  lda   (arith_op_c_ptr),y              ; (*c)[y] += scratch1[y]
  adc   scratch_space1,y
  sta   (arith_op_c_ptr),y

  dey                                   ; y--

  bpl   .mul_add_b_loop                 ; loop back if y >= 0

.mul_no_add:

  ;
  ; shift b (scratch 1) left 1 bit
  ;

  ldx   arith_op_c_size                 ; x = # output bytes - 1
  dex
  clc

.mul_b_lshift_loop:                     ; work from lsb to msb
  rol scratch_space1,x

  dex

  bpl   .mul_b_lshift_loop              ; loop back if x >= 0

  ;
  ; decrement counter and jump to outer loop if not zero
  ;

  pla
  dec
  bne   .mul_outer_loop

  rts                                   ; all done
