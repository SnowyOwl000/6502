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
; macros
;

;------------------------------------------------------------------------------
; add3_macro
;  store pointers to operands and result, call add3
;
; parms
; op_c - pointer to space to hold result
; op_a - pointer to left operand
; op_b - pointer to right operand
; size - number of bytes in each operand
;
; stack usage
; 2 bytes for add3 call
;

  .macro          add3_macro,op_c,op_a,op_b,size
    lda   \4
    sta   arith_op_a_size               ; store a in operand a size field
    lda   #<\2                          ; store &op_a in operand a pointer
    sta   arith_op_a_ptr
    lda   #>\2
    sta   arith_op_a_ptr+1
    lda   #<\3                          ; store &op_b in operand b pointer
    sta   arith_op_a_ptr
    lda   #>\3
    sta   arith_op_a_ptr+1
    lda   #<\1                          ; store &op_c in operand c pointer
    sta   arith_op_c_ptr
    lda   #>\1
    sta   arith_op_c_ptr+1

    jsr   add3                          ; call add function
  .endm

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
