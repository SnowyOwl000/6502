; lcd-16x2-8.s
; - 16 x 2 LCD display, 8-bit data interface
;
; written 17 june 2020 by rwk
;

  .ifndef         _lcd_16x2_8_s
  .defc           _lcd_16x2_8_s = 1

  ;
  ; include VIA 0 since it's the interface between the display and CPU
  ;

  .include        ../IO/via-0.s

;==============================================================================
; constants
;==============================================================================

;
; port A lines
;

LCD_16x2_E        .equ  %10000000
LCD_16x2_RW       .equ  %01000000
LCD_16x2_RS       .equ  %00100000

;
; commands
;

LCD_16x2_CLEAR    .equ  %00000001
LCD_16x2_HOME     .equ  %00000010
LCD_16x2_EMODE    .equ  %00000100
LCD_16x2_DISP     .equ  %00001000
LCD_16x2_SMOVE    .equ  %00010000
LCD_16x2_FSET     .equ  %00100000
LCD_16x2_SETCG    .equ  %01000000
LCD_16x2_SETDD    .equ  %10000000

;
; parameters
;

LCD_16x2_LR       .equ  %00000010
LCD_16x2_RL       .equ  0
LCD_16x2_DSHIFT   .equ  %00000001
LCD_16x2_ON       .equ  %00000100
LCD_16x2_OFF      .equ  0
LCD_16x2_CUR      .equ  %00000010
LCD_16x2_BLINK    .equ  %00000001
LCD_16x2_SHIFT    .equ  %00001000
LCD_16x2_MOVE     .equ  0
LCD_16x2_RIGHT    .equ  %00000100
LCD_16x2_LEFT     .equ  0
LCD_16x2_8BIT     .equ  %00010000
LCD_16x2_4BIT     .equ  0
LCD_16x2_2LINE    .equ  %00001000
LCD_16x2_1LINE    .equ  0
LCD_16x2_5x10     .equ  %00000100
LCD_16x2_5x8      .equ  0

;==============================================================================
; macros
;==============================================================================

;------------------------------------------------------------------------------
; lcd_16x2_init
; - initialize display
;

  .macro          lcd_16x2_init_macro

  ; port B is all output
  lda   #%11111111
  sta   VIA_0_DDR_B

  ; port A is only output for E, RW and RS lines
  lda   #(LCD_16x2_E | LCD_16x2_RW | LCD_16x2_RS)
  sta   VIA_0_DDR_A

  ; set 8-bit interface, 2 line display, 5x8 font
  lda   #(LCD_16x2_FSET | LCD_16x2_8BIT | LCD_16x2_2LINE | LCD_16x2_5x8)
  jsr   lcd_16x2_cmd

  ; turn on the display and cursor
  lda   #(LCD_16x2_DISP | LCD_16x2_ON | LCD_16x2_CUR)
  jsr   lcd_16x2_cmd

  ; move cursor left-to-right
  lda   #(LCD_16x2_EMODE | LCD_16x2_LR)
  jsr   lcd_16x2_cmd

  ; clear the display
  lda   #LCD_16x2_CLEAR
  jsr   lcd_16x2_cmd

  ; move cursor to home position
  lda   #LCD_16x2_HOME
  jsr   lcd_16x2_cmd

  .endm

;------------------------------------------------------------------------------
; lcd_16x2_puts_macro
; - output a string
;
; parameter
; ptr - address of string to be displayed
;
; zero page usage
; lcd_puts_ptr - 2-byte indirect address
;
; stack usage
; 4 bytes for lcd_16x2_puts
;

  .macro          lcd_16x2_puts_macro,ptr

    lda   #<\1                          ; get low byte of string address
    sta   lcd_puts_ptr                  ; store in zero page
    lda   #>\1                          ; high byte goes next
    sta   lcd_puts_ptr+1

    jsr   lcd_16x2_puts                 ; call the puts function

  .endm

;==============================================================================
; zero-page data
;==============================================================================

  .section        zero_page,"adrw"

  zpage           lcd_puts_ptr
lcd_puts_ptr:
  .blk            2

;==============================================================================
; code
;==============================================================================

  .section        rom,"acdrx"

;------------------------------------------------------------------------------
; lcd_16x2_cmd
; - send command to lcd
;
; parameters
; a - command to send
;
; stack space used
; - 2 bytes for return address
;
; clobbers
; - a,x
;

lcd_16x2_cmd:
  ; send command to output port
  sta   VIA_0_PORT_B

  ; configure a for control signals
  lda   #0

  ; jump to code shared with putchar
  bra   lcd_16x2_common

;------------------------------------------------------------------------------
; lcd_16x2_putchar
; - display char on lcd
;
; parameters
; a - character to display
;
; stack space used
; - 2 bytes for return address
;
; clobbers
; - a,x
;

lcd_16x2_putchar:
  ; send character to output port
  sta   VIA_0_PORT_B

  ; configure a for control signals
  lda   #LCD_16x2_RS

;
; code common to both sending commands and characters. the only difference is
; the setting of the RS line
;

lcd_16x2_common:
  ; toggle the E bit
  eor   #LCD_16x2_E
  ; send control signals to port A
  sta   VIA_0_PORT_A
  ; loop back if E bit is set... will loop once, so E on, E off, move on
  bmi   lcd_16x2_common

  ;
  ; wait for the busy flag
  ;

  ; configure port B for all input
  lda   #0
  sta   VIA_0_DDR_B

  ; set the RW line to indicate read. this has to be output before toggling E
  lda   #LCD_16x2_RW
  sta   VIA_0_PORT_A

.wait:
  ; toggle the E bit
  eor   #LCD_16x2_E
  sta   VIA_0_PORT_A
  ; if the bit is clear, this is the second time through, don't read or loop
  bpl   .skip

  ; read the port while E is set and go back
  ldx   VIA_0_PORT_B
  bra   .wait

.skip:
  ; if bit 7 is set, display is busy, go back and wait
  cpx   #$80
  bcs   .wait

  ; reset port B to all output
  lda   #%11111111
  sta   VIA_0_DDR_B
  ; set a to 0. this saves a byte since a is currently -1
  inc
  ; output a, clearing the RW line
  sta   VIA_0_PORT_A

  ; all done
  rts

;------------------------------------------------------------------------------
; lcd_16x2_puts
;  send nul-terminated string to lcd screen
;
; parameter
; - lcd_puts_ptr - address of string to send must be preloaded here
;
; clobbers
; a,x,y
;
; stack needs
; 4 bytes; 2 for return address, 2 for call to lcd_16x2_putchar
;

lcd_16x2_puts:
  ldy   #0                              ; start y at 0

.loop:
  lda   (lcd_puts_ptr),y                ; a <- lcd_puts_ptr[y]

  beq   .done                           ; if a == 0, we're done

  jsr   lcd_16x2_putchar                ; display the character

  iny                                   ; y++, move to next character

  bra   .loop                           ; on to the next character

.done:
  rts                                   ; all done

  .endif
