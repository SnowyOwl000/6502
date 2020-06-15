; util-utoa.s
; - convert unsigned int to asciiz
;
; written 12 may 2020 by rwk
;

  .ifndef         _util_utoa_s
  .defc           _util_utoa_s = 1

  ;
  ; requires arith-iszero, arith-udiv4 and util-space
  ;

  .include        ../Arithmetic/arith-iszero.s
  .include        ../Arithmetic/arith-udiv4.s
  .include        ../Utilities/util-space.s

;==============================================================================
; macros
;

;------------------------------------------------------------------------------
; utoa_macro
;  store pointers to source and dest, call int2dec
;
; parms
; dest   - pointer to space to hold converted int
; source - pointer to multibyte int
; size   - number of bytes in int
;
; stack usage
; 7 bytes for utoa call
;
; note:
; - assumes dest space is large enough for asciiz string
;

  .macro          utoa_macro,dest,source,size
    lda   \3
    sta   util_src_size                 ; store source size
    lda   #<\2                          ; store &source in operand a pointer
    sta   util_src_ptr
    lda   #>\2
    sta   util_src_ptr+1
    lda   #<\1                          ; store &dest in operand c pointer
    sta   util_dest_ptr
    lda   #>\1
    sta   util_dest_ptr+1

    jsr   utoa                          ; call conversion function
  .endm

;==============================================================================
; rom section
;

  .section        rom,"acdrx"

;------------------------------------------------------------------------------
; utoa
; - convert unsigned int to hex
;
; parms
; util_src_ptr  - pointer to binary value, big-endian
; util_dest_ptr - pointer to space to hold converted digits
; util_src_size - number of bytes in binary value
;
; clobbers
; axy
;
; stack space
; 6 bytes - 2 for return address, 4 for udiv4_core
;
; Note:
; - assumes dest size is sufficiently large (max 21 bytes)

utoa:
  ;
  ; see if operand is zero, store "0" if it is
  ;

  isnzero_macro   (util_src_ptr),util_src_size,.utoa_nonzero

  lda   #'0'                            ; store "0" as asciiz string
  sta   (util_dest_ptr)
  ldy   #1
  lda   #0
  sta   (util_dest_ptr),y

  ;
  ; all done
  ;
  ; note: it's cheaper to just return here than it is to branch around the
  ; else clause like a conventional if-else would. fewer bytes and fewer
  ; instructions.
  ;

  rts

  ;
  ; load src into scratch1:scratch2
  ;

.utoa_nonzero:
  lda   util_src_size                   ; y = src size - 1
  tay
  dey

  asl                                   ; x = 4 * src size - 1
  asl
  tax
  dex

.utoa_prep_loop1:
  lda   (util_src_ptr),y                ; a = src[y]
  sta   scratch_space1,x                ; scratch_space1[x] = a

  dex                                   ; x--
  dey                                   ; y--

  bpl   .utoa_prep_loop1                ; loop back if y >= 0

  sec
  txa                                   ; save &scratch1[x+1] as op a
  adc   #scratch_space1
  sta   arith_op_a_ptr
  lda   #0
  sta   arith_op_a_ptr+1                ; op a == &q after udiv4_core finishes

  lda   #0                              ; zero pad the scratch space
  ldy   util_src_size                   ; y = src size

.utoa_prep_loop2:
  sta   scratch_space1,x                ; zero pad to double width

  dex
  dey

  bne   .utoa_prep_loop2

  lda   util_src_size
  sta   arith_op_a_size                 ; op a size = src size

  lda   #<.ten_1                        ; op b ptr = ten, with appropriate size
  inc
  sec
  sbc   util_src_size
  sta   arith_op_b_ptr
  lda   #>.ten_1
  sta   arith_op_b_ptr+1

  ;
  ; utoa main loop
  ;
  ; since we know n != 0 at the start, this is set up as a do loop
  ;

  lda   util_src_size                   ; a = 2 * op size - 1
  asl
  dec
  sta   arith_op_c_size                 ; store in op c size

  lda   #0                              ; push end-of-string marker
  pha

.utoa_compute_loop:
  ldx   arith_op_c_size                 ; x = 2 * op size - 1

  lda   #0

.utoa_pad_loop:                         ; zero pad scratch space
  sta   scratch_space1,x

  dex

  bpl   .utoa_pad_loop

  jsr   udiv4_core                      ; call core to divide by 10

  ldx   arith_op_c_size                 ; x = 2 * op size - 1

  lda   scratch_space1,x                ; a = r[0]
  ora   #'0'                            ; convert to ascii digit

  pha                                   ; push onto stack for reversing

  isnzero_macro   (arith_op_a_ptr),util_src_size,.utoa_compute_loop

  ;
  ; at this point, the number has been converted but it's on the stack
  ;
  ; need to copy from stack and put into dest

  ldy   #0

.utoa_copy_loop:
  pla

  sta   (util_dest_ptr),y

  beq   .utoa_copy_done

  iny

  bra   .utoa_copy_loop

  ;
  ; all done
  ;

.utoa_copy_done:
  rts

  .byte   0,0,0,0,0,0,0
.ten_1:
  .byte   10

  .endif
