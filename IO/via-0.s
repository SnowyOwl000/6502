; via-0.s
; - VIA 0 register map
;
; written 17 june 2020 by rwk
;

  .ifndef       _via_0_s
  .defc         _via_0_s = 1

VIA_0_PORT_B    .equ    $8000
VIA_0_PORT_A    .equ    $8001
VIA_0_DDR_B     .equ    $8002
VIA_0_DDR_A     .equ    $8003
VIA_0_T1C_L     .equ    $8004
VIA_0_T1C_H     .equ    $8005
VIA_0_T1L_L     .equ    $8006
VIA_0_T1L_H     .equ    $8007
VIA_0_T2C_L     .equ    $8008
VIA_0_T2C_H     .equ    $8009
VIA_0_SR        .equ    $800a
VIA_0_ACR       .equ    $800b
VIA_0_PCR       .equ    $800c
VIA_0_IFR       .equ    $800d
VIA_0_IER       .equ    $800e
VIA_0_REG_A     .equ    $800f

  .endif
