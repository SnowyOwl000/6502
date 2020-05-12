; arith-add3.s
; - 3-operand add
;
; written 11 may 2020 by rwk
;

  ;
  ; requires arith-space
  ;

  .include          arith-space.s

;==============================================================================
; rom section
;

  .section        rom,"acdrx"

;------------------------------------------------------------------------------
; add3
; - three-operand add: c = a + b
;
; parms
; arith_op_a_ptr  - pointer to lhs
; arith_op_b_ptr  - pointer to rhs
; arith_op_c_ptr  - pointer to result
; arith_op_a_size - number of bytes in each of the three operands
;
; clobbers
; ay
;
; stack usage
; 2 bytes for return address
;

add3:
  ldy   arith_op_a_size                 ; y = operand a size - 1
  dey
  clc                                   ; clear any stray carry

.loop:
  lda   (arith_op_a_ptr),y              ; get (*a)[y]
  adc   (arith_op_b_ptr),y              ; add (*b)[y]
  sta   (arith_op_c_ptr),y              ; store in (*c)[y]

  dey                                   ; y--

  bpl   .loop                           ; if y >= 0, loop back

  rts                                   ; all done
