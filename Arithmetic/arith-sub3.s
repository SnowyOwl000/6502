; arith-sub3.s
; - 3-operand subtract
;
; written 11 may 2020 by rwk
;

  .ifndef         _arith_sub3_s
  .defc           _arith_subs_s = 1

  ;
  ; requires arith-space
  ;

  .include        arith-space.s

;==============================================================================
; macros
;

;------------------------------------------------------------------------------
; sub3_macro
;  store pointers to operands and result, call sub3
;
; parms
; op_c - pointer to space to hold result
; op_a - pointer to left operand
; op_b - pointer to right operand
; size - number of bytes in each operand
;
; stack usage
; 2 bytes for sub3 call
;

  .macro          sub3_macro,op_c,op_a,op_b,size
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

    jsr   sub3                          ; call sub function
  .endm

;==============================================================================
; rom section
;

  .section        rom,"acdrx"

;------------------------------------------------------------------------------
; sub3
; - three-operand subtract: c = a - b
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

sub3:
  ldy   arith_op_a_size                 ; y = size of operands - 1
  dey
  clc                                   ; clear any stray carry

.loop:
  lda   (arith_op_a_ptr),y              ; get (*a)[y]
  sbc   (arith_op_b_ptr),y              ; add (*b)[y]
  sta   (arith_op_c_ptr),y              ; store in (*c)[y]

  dey                                   ; y--

  bpl   .loop                           ; if y != 0, loop back

  rts                                   ; all done

  .endif
