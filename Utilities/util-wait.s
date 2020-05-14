; util-wait.s
; - definitions, code and data for wait2 function
;
; written 21 april 2020 by rwk
;

  .ifndef         _util_wait_s
  .defc           _util_wait_s = 1

;==============================================================================
; zero-page section
;

  .section        zero_page,"adrw"

;------------------------------------------------------------------------------
; wait_count
;  outer and inner loop counter values for wait loop
;
; zero page usage
; 2 bytes
;

  zpage           wait_count
wait_count:
  blk       2

;==============================================================================
; rom section
;

  .section        rom,"acdrx"

;------------------------------------------------------------------------------
; wait2
;  double-loop busy wait
;
; parms
; (wait_count) - outer loop counter
; (wait_count+1) - inner loop counter
;
; clobbers
; x,(wait_count)
;
; stack
; 2 bytes for return
;

wait2:
  ldx   wait_count+1                    ; set up inner loop counter       t=3x

.inner:                                 ; inner loop
  dex                                   ; y--                     t=x(2y)=2xy
  bne   .inner                          ; repeat until y == 0     t=x(3(y-1)+2)

  dec   wait_count                      ; back in outer loop, x--         t=5x
  bne   wait2                           ; repeat until x == 0   t=3(x-1)+2=3x-1

  rts                                   ; all done       total=5xy+8x+1+(6--14)

  .endif
