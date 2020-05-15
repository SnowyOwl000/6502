; lcd4.s
; - 16x2 lcd definitions, code and data for 4-bit operation
;
; written 20 april 2020 by rwk
;
; modification history:
; 21 april 2020:
; - modified hardware, data lines to B3--B0, E is B7, RW is B6, RS is B5
; - modified software to use new wiring
; - moved wait2 and its data to util.s
;

  ;
  ; requires 65c22.s and util-wait.s
  ;

  .include        ../Memory/65c22.s
  .include        ../Utilities/util-wait.s

;==============================================================================
; constants
;

;------------------------------------------------------------------------------
; pin definitions
;

LCD_E             .equ  %10000000       ; E bit port B
LCD_RW            .equ  %01000000       ; RW bit port B
LCD_RS            .equ  %00100000       ; RS bit port B

;------------------------------------------------------------------------------
; commands
;

LCD_CMD_CLEAR     .equ  %00000001       ; clear display reset DDRAM
LCD_CMD_HOME      .equ  %00000010       ; DDRAM address = 0; cursor home
LCD_CMD_ENTRY     .equ  %00000100       ; entry mode set
LCD_CMD_DISP      .equ  %00001000       ; display on/off control
LCD_CMD_SHIFT     .equ  %00010000       ; cursor / display shift
LCD_CMD_FNSET     .equ  %00100000       ; function set
LCD_CMD_CGRAM     .equ  %01000000       ; set CGRAM address
LCD_CMD_DDRAM     .equ  %10000000       ; set DDRAM address

;------------------------------------------------------------------------------
; command parameters / options
;

LCD_INC           .equ  %00000010       ; inc/dec, 1 = inc
LCD_SHIFT         .equ  %00000001       ; shift direction, 1 = left
LCD_DISP          .equ  %00000100       ; display on/off, 1 = on
LCD_CURSOR        .equ  %00000010       ; cursor on/off, 1 = on
LCD_BLINK         .equ  %00000001       ; cursor blink, 1 = blink
LCD_SM            .equ  %00001000       ; shift or move cursor, 1 = shift
LCD_DIR           .equ  %00000100       ; shift / move direction, 1 = left
LCD_8BIT          .equ  %00010000       ; data length, 1 = 8 bits
LCD_2LINES        .equ  %00001000       ; number of lines, 1 = 2 lines
LCD_5x10          .equ  %00000100       ; font select, 1 = 5x10 font

;==============================================================================
; macros
;

;------------------------------------------------------------------------------
; lcd16_init_macro
;  initialize 16x2 lcd screen using 4-bit input and control lines all on port B
;

  .macro          lcd16_init_macro
    lda   #%11101111                    ; set DDRB to output all but B5 (unused)
    sta   VIA0_DDRB

    ;
    ; run through list of commands to be sent in "8-bit" mode
    ;

    ldy   #0                            ; initialize counter

.loop1:
    lda   lcd16_first_cmd_data,y        ; outer loop timer
    sta   wait_count
    iny

    lda   lcd16_first_cmd_data,y        ; inner loop timer
    sta   wait_count+1
    iny

    jsr   wait2                         ; delay

    lda   lcd16_first_cmd_data,y        ; get command to send
    beq   .loop1_done                   ; stop if command is 0

    iny

    jsr   lcd16_first_cmd               ; send the command

    bra   .loop1                        ; cycle back

    ;
    ; next, run through list of commands sent in 4-bit mode
    ;
    ; these all use a standard delay except the last one, which is done
    ; after the loop ends
    ;

.loop1_done:
    ldy   #0

.loop2:
    lda   lcd16_4bit_cmd_data,y         ; get the command
    beq   .loop2_done                   ; stop if command is 0

    iny

    jsr   lcd16_cmd                     ; send the command

    bra .loop2                          ; cycle back

    ;
    ; extra wait time for the last command
    ;

.loop2_done:
    ldx   #$ff                          ; note: this can be tweaked probably
    ldy   #$18
    jsr   wait2
  .endm

;------------------------------------------------------------------------------
; lcd16_puts_macro
;  output a string
;
; parm
; ptr - address of string to be displayed
;
; zero page usage
; lcd_puts_ptr - 2-byte indirect address
;
; stack usage
; 4 bytes; 2 for return and 2 for return from lcd_putchar
;

  .macro          lcd16_puts_macro,ptr
    lda   #<\1                          ; get low byte of string address
    sta   lcd_puts_ptr                  ; store in zero page
    lda   #>\1                          ; high byte goes next
    sta   lcd_puts_ptr+1

    jsr   lcd16_puts                    ; call the puts function
  .endm

;==============================================================================
; zero-page section
;

  .section        zero_page,"adrw"

;------------------------------------------------------------------------------
; lcd_puts_ptr
;  storage for address of string being displayed
;
; zero page usage
; 2 bytes
;

  zpage           lcd_puts_ptr
lcd_puts_ptr:                           ; pointer to string being printed
  blk   2

;------------------------------------------------------------------------------
; lcd_hi_bits
;  control bit settings for port B commands
;
; zero page usage
; 1 byte
;

  zpage           lcd_hi_bits
lcd_hi_bits:
  blk   1

;==============================================================================
; rom section
;

  .section        rom,"acdrx"

;------------------------------------------------------------------------------
; lcd_cmd
;  send control command to lcd screen
;
; parms
; a - command to send
;
; clobbers
; ax
;
; stack needs
; 3 bytes; 2 for return address, 1 for storing a
;

lcd16_cmd:
  ldx   #$00                            ; set line for sending command
  stx   lcd_hi_bits                     ; save it for later

  bra   lcd16_common                    ; off to the code for sending cmd/data

;------------------------------------------------------------------------------
; lcd16_putchar
;  send single character to lcd screen
;
; parms
; a - char to send
;
; clobbers
; ax
;
; stack needs
; 3 bytes; 2 for return address, 1 to store a
;

lcd16_putchar:
  ldx   #LCD_RS                         ; set line for sending data
  stx   lcd_hi_bits                     ; save it for later use

  ;
  ; entry point from lcd_cmd
  ;

lcd16_common:
  pha                                   ; save a for later
  ror                                   ; move high nybble to low nybble
  ror
  ror
  ror
  and   #$0f                            ; mask off high nybble
  ora   lcd_hi_bits                     ; replace with control bits
  sta   VIA0_PORTB                      ; send command to port B

.loop1:
  eor   #LCD_E                          ; toggle the E line
  sta   VIA0_PORTB
  bmi   .loop1

  pla                                   ; restore a
  and   #$0f                            ; mask off the high nybble
  ora   lcd_hi_bits                     ; replace with control bits again

;------------------------------------------------------------------------------
; lcd16_first_cmd
;  send control command to lcd screen in pseudo 8-bit mode
;
; parms
; a - command to send
;
; clobbers
; a
;
; stack needs
; 2 bytes for return address
;
; notes
; - this is used to send the initial sequence of 8-bit commands. since the
;   hardware doesn't care about the low 4 bits in these commands, we can just
;   directly send the high 4 bits without having to split and shift the byte
; - otherwise, the "normal" code for sending a byte as two 4-bit chunks falls
;   into this code from above when it's ready to send the low 4 bits.
;

lcd16_first_cmd:
  sta   VIA0_PORTB                      ; send RS-RW-E config to port B

.loop2:
  eor   #LCD_E                          ; toggle the E bit
  sta   VIA0_PORTB
  bmi   .loop2

  ;
  ; delay is 5a-1 = 44us
  ;

  lda #9
.delay
  dea
  bne   .delay

  rts                                   ; all done, go back

;------------------------------------------------------------------------------
; lcd16_puts
;  send single character to lcd screen
;
; parms
; lcd_puts_ptr - address of string to send must be preloaded here
;
; clobbers
; axy
;
; stack needs
; 5 bytes; 2 for return address, 3 for call to lcd_putchar
;

lcd16_puts:
  ldy   #0                              ; start y at 0

.loop:
  lda   (lcd_puts_ptr),y                ; a <- (*lcd_puts_ptr)[y]

  beq   .done                           ; if a == 0, we're done

  jsr   lcd16_putchar                   ; display the character

  iny                                   ; y++, move to next character

  bra .loop                             ; on to the next character

.done:
  rts                                   ; all done

;==============================================================================
; data
;

;------------------------------------------------------------------------------
; lcd16_first_cmd_data
;  timing delays and initial 8-bit commands to send to lcd
;

lcd16_first_cmd_data:
  .byte   24,165,(LCD_CMD_FNSET | LCD_8BIT)/16
  .byte   30, 65,(LCD_CMD_FNSET | LCD_8BIT)/16
  .byte    5, 38,(LCD_CMD_FNSET | LCD_8BIT)/16
  .byte    5, 38,(LCD_CMD_FNSET | LCD_2LINES)/16
  .byte    5, 38,0

;------------------------------------------------------------------------------
; lcd16_4bit_cmd_data
;  initial commands to be sent in 4-bit mode
;

lcd16_4bit_cmd_data:
  .byte   (LCD_CMD_FNSET | LCD_2LINES)
  .byte   (LCD_CMD_DISP | LCD_DISP | LCD_CURSOR)
  .byte   (LCD_CMD_ENTRY | LCD_INC)
  .byte   LCD_CMD_CLEAR
  .byte   0
