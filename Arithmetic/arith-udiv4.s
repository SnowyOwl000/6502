; arith-udiv4.s
; - 4-operand unsigned divide
;
; written 13 may 2020 by rwk
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
; udiv4
; - four-operand unsigned divide: (q,r) = n / d
;
; parms
; arith_op_a_ptr  - pointer to n
; arith_op_b_ptr  - pointer to d
; arith_op_c_ptr  - pointer to q's final position
; arith_op_d_ptr  - pointer to r's final position
; arith_op_a_size - number of bytes in operands q, r and d
;
; clobbers
; axy
;
; stack usage
; 4 bytes - 2 for return address and two scratch bytes
;
; notes:
; - n is normally twice as wide as d, q, r. This allows for a full-width
;   multiply followed by a divide with that full value.
; - this code assumes n is twice as wide as d, q, r. That may require zero-
;   padding prior to use.
; - the algorithm wants r and d to be twice as wide as n. So, scratch space
;   must be at least 4 times larger. Assuming a max of 64-bit base operands,
;   this will allow dividing a 128-bit n by 64-bit d.
; - divide-by-zero is ignored; other functions can check for this if needed
; - overflow of q is ignored; other functions can check for this if needed
; - differs from wikipedia article in that I switch the sign on q[i]. That way,
;   the initial r = 2*r becomes a multi-byte rotate, with the outgoing bit
;   rotating around to q[i]. the sign switch is fixed in the standardizing step.
;

udiv4:
  ;
  ; copy n to scratch_space1:scratch_space2
  ;

  lda   arith_op_a_size                 ; y = 2 * op size - 1
  asl
  tay
  dey
  asl                                   ; x = 4 * op size - 1
  tax
  dex

.udiv4_copy_n_loop:                     ; copy n to low half in scratch space
  lda   (arith_op_a_ptr),y
  sta   scratch_space1,x

  dex
  dey

  bpl   .udiv4_copy_n_loop              ; copy 2 * op size bytes

  ;
  ; zero-pad n to proper length, 4 * op size
  ;

  lda   #0

.udiv4_pad_n_loop:
  sta   scratch_space1,x

  dex

  bpl   .udiv4_pad_n_loop

  ;
  ; calculate the loop count, 2 * op size
  ;

  lda   arith_op_a_size
  asl

  ;
  ; start the loop
  ;

.udiv4_outer_loop:
  pha                                   ; save count

  ;
  ; get the rotate count. do it now so carry isn't clobbered later
  ;

  lda   arith_op_a_size                 ; get the number of bytes to rotate
  asl
  asl
  tax
  dex

  ;
  ; push the sign bit
  ;

  lda   scratch_space1
  pha

  ;
  ; multi-byte rotate
  ;

  asl                                   ; prime the carry bit
.udiv4_shift_loop:
  rol   scratch_space1,x                ; rotate next byte
  dex

  bpl   .udiv4_shift_loop

  ;
  ; calculate end position of d and where to add it within r (high half)
  ;
  ; note: d is single length, the add or subtract is double length. The other
  ;       half is all zeroes
  ;

  lda   arith_op_a_size
  tay
  dey
  asl
  tax
  dex
  clc

  ;
  ; pop the sign bit
  ;

  pla

  ;
  ; if negative, add and go to end of loop
  ;

  bpl   .udiv4_sub_loop

.udiv4_add_loop:
  lda   scratch_space1,x
  adc   (arith_op_b_ptr),y
  sta   scratch_space1

  dex
  dey

  bpl   .udiv4_add_loop

  bra   .udiv4_outer_loop_end

  ;
  ; else, not negative, subtract
  ;

.udiv4_sub_loop:
  lda   scratch_space1,x
  sbc   (arith_op_b_ptr),y
  sta   scratch_space1

  dex
  dey

  bpl   .udiv4_sub_loop

  ;
  ; loop back
  ;

.udiv4_outer_loop_end:
  pla
  dec

  bne   .udiv4_outer_loop

  ;
  ; standardize q and copy it to proper location
  ;

  lda   arith_op_a_size                 ; y = 2 * op size
  asl
  tay
  asl                                   ; x = 4 * op size - 1
  tax
  dex
  clc

.udiv4_standardize_loop:
  lda   scratch_space1,x
  eor   #%11111111                      ; flip bits to get q
  sbc   scratch_space1,x                ; q -= ~q
  sta   scratch_space1,x

  dex
  dey

  bne   .udiv4_standardize_loop

  ;
  ; restoring step in case r < 0; copies r to proper location
  ;

  lda   scratch_space1                  ; is r < 0? if not, copy out

  bpl   .udiv4_restore_done

  lda   arith_op_a_size                 ; y = 2 * op size
  asl
  tay
  asl                                   ; x = 4 * op size - 1
  tax
  dex
  sec

.udiv4_dec_q_loop:                      ; decrement q by setting carry...
  lda   scratch_space1,x                ; ... and subtracting 0 with carry
  sbc   #0
  sta   scratch_space1,x

  dex
  dey

  bne   .udiv4_dec_q_loop

  ldy   arith_op_a_size                 ; y = op size - 1
  dey
  clc

.udiv4_add_d_loop
  lda   scratch_space1,x                ; r += d
  adc   (arith_op_b_ptr),y
  sta   scratch_space1,x

  dex
  dey

  bpl   .udiv4_add_d_loop

  ;
  ; copy q and r to proper location
  ;

  lda   arith_op_a_size                 ; y = op size - 1
  tay
  dey
  asl                                   ; x = 4 * op size - 1
  asl
  tax
  dex

.udiv4_copy_q_loop:
  lda   scratch_space1,x
  sta   (arith_op_c_ptr),y

  dex
  dey

  bpl   .udiv4_copy_q_loop

  lda   arith_op_a_size                 ; y = op size - 1
  tay
  dey
  asl                                   ; x = 2 * op size - 1
  tax
  dex

.udiv4_copy_r_loop:
  lda   scratch_space1,x
  sta   (arith_op_d_ptr),y

  dex
  dey

  bpl   .udiv4_copy_r_loop

  ;
  ; all done
  ;

  rts
