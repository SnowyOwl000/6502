; util-tohex.s
; - conversion to hex functions
;
; written 12 may 2020 by rwk
;
; modification history
; - 16 may 2020
;   changed pointers to util_ pointers instead of arith_ pointers
;

  .ifndef         _util_tohex_s
  .defc           _util_tohex_s = 1

  ;
  ; requires util-space
  ;

  .include        ../Utilities/util-space.s

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
    sta   util_src_size                 ; store size in operand size field
    lda   #<\2                          ; store source operand pointer
    sta   util_src_ptr
    lda   #>\2
    sta   util_src_ptr+1
    lda   #<\1                          ; store dest operand pointer
    sta   util_dest_ptr
    lda   #>\1
    sta   util_dest_ptr+1

    jsr   int2hex                       ; call conversion function
  .endm

;==============================================================================
; rom section
;

  .section        rom,"acdrx"

;------------------------------------------------------------------------------
; byte2hex
; - convert reg a value to hex, store in dest[y-1] and dest[y-2]
; - also subtracts 2 from y
;
; parms
; a        - value to be converted
; y        - index in array indicating where to store hex digits
; dest_ptr - pointer to array of char to hold converted hex digits
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
  sta   (util_dest_ptr),y               ; store hex digit
  rts                                   ; done

;------------------------------------------------------------------------------
; int2hex
; - convert unsigned int to hex
;
; parms
; util_src_ptr   - pointer to binary value, big-endian
; util_dest_ptr  - pointer to space to hold converted digits
; util_src_size  - number of bytes in binary value
;
; clobbers
; axy
;
; stack space
; 7 bytes - 2 for return address, 5 for byte2hex
;
; Note:
; - assumes dest size is > 2 * (source operand size)

int2hex:
  lda   util_src_size

  tax                                   ; x = source size - 1
  dex                                   ; x is index of byte to be converted

  asl                                   ; y = 2 * source size
  tay                                   ; index of 0 at end of string

  lda   #0                              ; (*dest)[y] = 0
  sta   (util_dest_ptr),y

.loop:
  phy                                   ; save y

  txa                                   ; copy x to y for indirect index load
  tay
  lda (util_src_ptr),y                  ; a = (*source)[y=x]

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

  .endif
