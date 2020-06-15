; arith-iszero.s
; - conversion to hex functions
;
; written 15 may 2020 by rwk
;

  .ifndef         _arith_iszero_s
  .defc           _arith_iszero_s = 1

  ;
  ; requires arith-space
  ;

  .include        ../Arithmetic/arith-space.s

;==============================================================================
; macros
;

;------------------------------------------------------------------------------
; iszero_macro
;  compares value to zero, branches to dest if zero, falls through if not zero
;
; parms
; val  - address of int to be checked
; size - number of bytes in int
; dest - where to branch if val is zero
;
; clobbers
; ay
;

  .macro          iszero_macro,val,size,dest
  ldy   \2                              ; y = op size - 1
  dey

.\@_loop:
  lda   \1,y                            ; check op_a[y]
  bne   .\@_done                        ; not zero? all done

  dey                                   ; y--

  bpl   .\@_loop                        ; loop back if y >= 0

  bra   \3                              ; load zero to force set of z flag

.\@_done:
  .endm

;------------------------------------------------------------------------------
; isnzero_macro
;  compares value to zero, branches to dest if not zero, falls through if zero
;
; parms
; val  - address of int to be checked
; size - number of bytes in int
; dest - where to branch if val is not zero
;
; clobbers
; ay
;

  .macro          isnzero_macro,val,size,dest
  ldy   \2                              ; y = op size - 1
  dey

.\@_loop:
  lda   \1,y                            ; check op_a[y]
  bne   \3                              ; not zero? all done

  dey                                   ; y--

  bpl   .\@_loop                        ; loop back if y >= 0
  .endm

  .endif
