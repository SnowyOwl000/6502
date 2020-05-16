# 6502
Code and hardware inspired by Ben Eater's 6502 computer project
## Directories
### Arithmetic
Arithmetic functions
- arith-add3.s *3-operand integer addition*
    - add3_macro
    - add3
- arith-sub3.s *3-operand integer subtraction*
    - sub3_macro
    - sub3
- arith-umul3.s *3-operand unsigned integer multiplication*
    - umul3_macro
    - umul3
- arith-udiv4.s *4-operand unsigned integer division*
    - udiv4_macro
    - udiv4
### LCD-16x2
Functions for 16x2 LCD display
- lcd16x2-4.s *communication using 4 data lines*
    - lcd16_init_macro
    - lcd16_puts_macro
    - lcd16_cmd
    - lcd16_putchar
    - lcd16_puts
### Memory
Memory mapping, based on modified Eater design
- memory-map.s *basic memory map and section starts*
- 65c22.s *65c22 I/O map*
### Testing
Programs to test various features
### Utilities
Utility functions
- util-tohex.s *displaying ints in hex*
    - int2hex_macro
    - int2hex
    - byte2hex
### Vasm
Changes to vasm 1.8h to allow sections to start with an empty definition and
split into parts without overlap errors. It's kludgy but it works so far.
## Other Files
- test.pdf
    - Schematic of the computer hardware
## Notes
- Multi-byte integers are stored in big-endian form. This simplifies the loops
used in processing.
- Integers are one to eight bytes in length. Integer operations need a size
operand.
