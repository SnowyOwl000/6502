; util-tohex.s
; - conversion to hex functions
;
; written 12 may 2020 by rwk
;

  ;
  ; requires arith-space
  ;

  .include        ../Arithmetic/arith-space.s

;==============================================================================
; macros
;

;------------------------------------------------------------------------------
; int2hex_macro
;  store pointers to source and dest, call int2hex
;
; parms
; dest   - pointer to space to hold converted int
; source - pointer to multibyte int
; size   - number of bytes in int
;
; stack usage
; 7 bytes for int2hex call
;
; note:
; - assumes dest space is at least 2*size+1 bytes
;

  .macro          int2hex_macro,dest,source,size
    lda   \3
    sta   arith_op_a_size               ; store a in operand a size field
    lda   #<\2                          ; store &source in operand a pointer
    sta   arith_op_a_ptr
    lda   #>\2
    sta   arith_op_a_ptr+1
    lda   #<\1                          ; store &dest in operand c pointer
    sta   arith_op_c_ptr
    lda   #>\1
    sta   arith_op_c_ptr+1

    jsr   int2hex                       ; call conversion function
  .endm

;==============================================================================
; rom section
;

  .section        rom,"acdrx"

;------------------------------------------------------------------------------
; byte2hex
; - convert reg a value to hex, store in op_c[y-1] and op_c[y-2]
; - also subtracts 2 from y
;
; parms
; a             - value to be converted
; y             - index in array indicating where to store hex digits
; operand_c_ptr - pointer to array of char to hold converted hex digits
;
; clobbers
; a
;
; stack usage
; 5 bytes - 2 for return address, 2 for calling into itself and 1 for a
;
; Notes:
; - code taken and modified from code modified from original Woz code
; - y is treated as a reference parameter; its value is decremented twice and
;   passed back to caller
;

byte2hex:
  pha                                   ; save a reg
  jsr   .to_hex                         ; convert low nybble
  pla                                   ; restore a
  ror                                   ; shift high nybble to low nybble
  ror
  ror
  ror

.to_hex:                                ; entry point from above
  and   #$0f                            ; mask off high nybble
  ora   #'0'                            ; convert to ASCII
  cmp   #'9'+1                          ; is value > 9?
  bcc   .output                         ; no, output
  adc   #6                              ; yes, adjust to A--F range

.output:
  dey                                   ; move back one position
  sta   (arith_op_c_ptr),y              ; store hex digit
  rts                                   ; done

;------------------------------------------------------------------------------
; int2hex
; - convert unsigned int to hex
;
; parms
; arith_op_a_ptr  - pointer to binary value, big-endian
; arith_op_c_ptr  - pointer to space to hold converted digits
; arith_op_a_size - number of bytes in binary value
;
; clobbers
; axy
;
; stack space
; 7 bytes - 2 for return address, 5 for byte2hex
;
; Note:
; - assumes operand c size is > 2 * (operand a size)

int2hex:
  clc                                   ; set y = 2 * (operand a size)
  lda   arith_op_a_size                 ; index of 0 at end of string

  tax                                   ; a brief zwischenzug
  dex                                   ; x is index of byte to be converted

  adc   arith_op_a_size
  tay

  lda   #0                              ; (*operand_c_ptr)[y] = 0
  sta   (arith_op_c_ptr),y

.loop:
  phy                                   ; save y

  txa                                   ; copy x to y for indirect index load
  tay
  lda (arith_op_a_ptr),y                ; a = (*operand_a_ptr)[y=x]

  ply                                   ; restore y
  dex                                   ; increment x

  jsr byte2hex                          ; convert a to hex

  ;
  ; note: this is a bit of a kludge. last three instructions prior to here are
  ;       dey, sta, rts. Only dey affects flags, so flags will tell us when
  ;       y reaches 0. Since y is decremented before storing a byte, we are done
  ;       when y is 0, not -1.
  ;

  bne .loop                             ; loop back if y != 0

  rts
