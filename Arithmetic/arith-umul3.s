; arith-umul3.s
; - 3-operand unsigned multiply
;
; written 12 may 2020 by rwk
;

  ;
  ; requires arith-space
  ;

  .include          ../Arithmetic/arith-space.s

;==============================================================================
; macros
;

;------------------------------------------------------------------------------
; umul3_macro
;  store pointers to operands and result, call umul3
;
; parms
; op_c - pointer to space to hold result
; op_a - pointer to left operand
; op_b - pointer to right operand
; size - number of bytes in operands a and b
;
; stack usage
; 3 bytes for umul3 call
;
; note:
; - assumes dest space is at least 2*size bytes
;

  .macro          umul3_macro,op_c,op_a,op_b,size
    lda   \4
    sta   arith_op_a_size               ; store a in operand a size field
    lda   #<\2                          ; store &op_a in operand a pointer
    sta   arith_op_a_ptr
    lda   #>\2
    sta   arith_op_a_ptr+1
    lda   #<\3                          ; store &op_b in operand b pointer
    sta   arith_op_b_ptr
    lda   #>\3
    sta   arith_op_b_ptr+1
    lda   #<\1                          ; store &op_c in operand c pointer
    sta   arith_op_c_ptr
    lda   #>\1
    sta   arith_op_c_ptr+1

    jsr   umul3                         ; call umul function
  .endm

;==============================================================================
; rom section
;

  .section        rom,"acdrx"

;-----------------------------------------------------------------------------
; umul3
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

umul3:
  lda   arith_op_a_size                 ; y = operand a size - 1
  tay
  dey

  asl                                   ; x = 2 * operand a size - 1
  tax
  dex

  sta   arith_op_c_size                 ; save 2 * op a size for later

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

  ldy   arith_op_c_size                 ; y = 2*op size - 1
  dey

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

  ldx   #0                              ; x = 0
  ldy   arith_op_a_size                 ; y = number of bytes to shift
  clc

.mul_a_rshift_loop:                     ; work from msb to lsb
  ror   scratch_space2,x                ; shift scratch2[x]

  inx                                   ; x++
  dey                                   ; y--

  bne .mul_a_rshift_loop                ; loop back if y != 0

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
;  pla
;  rts
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
