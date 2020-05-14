; 65c22.s
; - definitions et al for working with 65c22 VIA chips
;
; written 12 april 2020 by rwk
;

  .ifndef         _65c22_s
  .defc           _65c22_s = 1

VIA0_PORTB  .equ  $8000   ; port b, in and out
VIA0_PORTA  .equ  $8001   ; port a, in and out
VIA0_DDRB   .equ  $8002   ; port b data direction register
VIA0_DDRA   .equ  $8003   ; port a data direction register
VIA0_T1C_L  .equ  $8004   ; timer 1 low-order counter / latches
VIA0_T1C_H  .equ  $8005   ; timer 1 high-order counter
VIA0_T1L_L  .equ  $8006   ; timer 1 low-order latches
VIA0_T1L_H  .equ  $8007   ; timer 1 high-order latches
VIA0_T2C_L  .equ  $8008   ; timer 2 low-order counter / latches
VIA0_T2C_H  .equ  $8009   ; timer 2 high-order counter
VIA0_SR     .equ  $800a   ; shift register
VIA0_ACR    .equ  $800b   ; aux control register
VIA0_PCR    .equ  $800c   ; peripheral control register
VIA0_IFR    .equ  $800d   ; interrupt flag register
VIA0_IER    .equ  $800e   ; interrupt enable register
VIA0_RAWA   .equ  $800f   ; port a in/out, no handshake

  .endif
  
