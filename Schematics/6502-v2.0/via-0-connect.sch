EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 6 10
Title "VIA 0 Connections"
Date "2020-06-17"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 65xx:W65C22SxP U16
U 1 1 5F59AB6A
P 5800 3500
F 0 "U16" H 6200 4900 50  0000 C CNN
F 1 "W65C22SxP" H 6200 4800 50  0000 C CNN
F 2 "" H 5800 3650 50  0001 C CNN
F 3 "http://www.westerndesigncenter.com/wdc/documentation/w65c22.pdf" H 5800 3650 50  0001 C CNN
	1    5800 3500
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0122
U 1 1 5F59BC37
P 5800 1950
F 0 "#PWR0122" H 5800 1800 50  0001 C CNN
F 1 "+5V" H 5815 2123 50  0000 C CNN
F 2 "" H 5800 1950 50  0001 C CNN
F 3 "" H 5800 1950 50  0001 C CNN
	1    5800 1950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0123
U 1 1 5F59BE4B
P 5800 5050
F 0 "#PWR0123" H 5800 4800 50  0001 C CNN
F 1 "GND" H 5805 4877 50  0000 C CNN
F 2 "" H 5800 5050 50  0001 C CNN
F 3 "" H 5800 5050 50  0001 C CNN
	1    5800 5050
	1    0    0    -1  
$EndComp
Text GLabel 4950 2400 0    50   Input ~ 0
CTRL_RESB
Text GLabel 4950 2500 0    50   Input ~ 0
CTRL_CLK
Text GLabel 4950 2700 0    50   Input ~ 0
CTRL_NMIB
Text GLabel 4950 3000 0    50   Input ~ 0
CTRL_OR
Text GLabel 4950 3200 0    50   Input ~ 0
ADDR_A0
Text GLabel 4950 3300 0    50   Input ~ 0
ADDR_A1
Text GLabel 4950 3400 0    50   Input ~ 0
ADDR_A2
Text GLabel 4950 3500 0    50   Input ~ 0
ADDR_A3
Text GLabel 4950 3700 0    50   Input ~ 0
CTRL_RWB
Text GLabel 4950 3900 0    50   BiDi ~ 0
DATA_D0
Text GLabel 4950 4000 0    50   BiDi ~ 0
DATA_D1
Text GLabel 4950 4100 0    50   BiDi ~ 0
DATA_D2
Text GLabel 4950 4200 0    50   BiDi ~ 0
DATA_D3
Text GLabel 4950 4300 0    50   BiDi ~ 0
DATA_D4
Text GLabel 4950 4400 0    50   BiDi ~ 0
DATA_D5
Text GLabel 4950 4500 0    50   BiDi ~ 0
DATA_D6
Text GLabel 4950 4600 0    50   BiDi ~ 0
DATA_D7
Text GLabel 6650 2400 2    50   BiDi ~ 0
VIA0_PA0
Text GLabel 6650 2500 2    50   BiDi ~ 0
VIA0_PA1
Text GLabel 6650 2600 2    50   BiDi ~ 0
VIA0_PA2
Text GLabel 6650 2700 2    50   BiDi ~ 0
VIA0_PA3
Text GLabel 6650 2800 2    50   BiDi ~ 0
VIA0_PA4
Text GLabel 6650 2900 2    50   BiDi ~ 0
VIA0_PA5
Text GLabel 6650 3000 2    50   BiDi ~ 0
VIA0_PA6
Text GLabel 6650 3100 2    50   BiDi ~ 0
VIA0_PA7
Text GLabel 6650 3300 2    50   BiDi ~ 0
VIA0_CA1
Text GLabel 6650 3400 2    50   BiDi ~ 0
VIA0_CA2
Text GLabel 6650 3600 2    50   BiDi ~ 0
VIA0_PB0
Text GLabel 6650 3700 2    50   BiDi ~ 0
VIA0_PB1
Text GLabel 6650 3800 2    50   BiDi ~ 0
VIA0_PB2
Text GLabel 6650 3900 2    50   BiDi ~ 0
VIA0_PB3
Text GLabel 6650 4000 2    50   BiDi ~ 0
VIA0_PB4
Text GLabel 6650 4100 2    50   BiDi ~ 0
VIA0_PB5
Text GLabel 6650 4200 2    50   BiDi ~ 0
VIA0_PB6
Text GLabel 6650 4300 2    50   BiDi ~ 0
VIA0_PB7
Text GLabel 6650 4500 2    50   BiDi ~ 0
VIA0_CB1
Text GLabel 6650 4600 2    50   BiDi ~ 0
VIA0_CB2
Wire Wire Line
	5200 2900 5100 2900
Wire Wire Line
	5100 2900 5100 2000
Wire Wire Line
	5100 2000 5800 2000
Wire Wire Line
	5800 2000 5800 1950
Wire Wire Line
	5800 2050 5800 2000
Connection ~ 5800 2000
Wire Wire Line
	5200 2400 4950 2400
Wire Wire Line
	5200 2500 4950 2500
Wire Wire Line
	5200 2700 4950 2700
Wire Wire Line
	5200 3000 4950 3000
Wire Wire Line
	5200 3200 4950 3200
Wire Wire Line
	5200 3300 4950 3300
Wire Wire Line
	5200 3400 4950 3400
Wire Wire Line
	5200 3500 4950 3500
Wire Wire Line
	5200 3700 4950 3700
Wire Wire Line
	5200 3900 4950 3900
Wire Wire Line
	5200 4000 4950 4000
Wire Wire Line
	5200 4100 4950 4100
Wire Wire Line
	5200 4200 4950 4200
Wire Wire Line
	5200 4300 4950 4300
Wire Wire Line
	5200 4400 4950 4400
Wire Wire Line
	5200 4500 4950 4500
Wire Wire Line
	5200 4600 4950 4600
Wire Wire Line
	5800 5050 5800 4950
Wire Wire Line
	6400 4600 6650 4600
Wire Wire Line
	6650 4500 6400 4500
Wire Wire Line
	6400 4300 6650 4300
Wire Wire Line
	6650 4200 6400 4200
Wire Wire Line
	6400 4100 6650 4100
Wire Wire Line
	6650 4000 6400 4000
Wire Wire Line
	6400 3900 6650 3900
Wire Wire Line
	6650 3800 6400 3800
Wire Wire Line
	6400 3700 6650 3700
Wire Wire Line
	6650 3600 6400 3600
Wire Wire Line
	6400 3400 6650 3400
Wire Wire Line
	6650 3300 6400 3300
Wire Wire Line
	6400 3100 6650 3100
Wire Wire Line
	6650 3000 6400 3000
Wire Wire Line
	6400 2900 6650 2900
Wire Wire Line
	6650 2800 6400 2800
Wire Wire Line
	6400 2700 6650 2700
Wire Wire Line
	6650 2600 6400 2600
Wire Wire Line
	6400 2500 6650 2500
Wire Wire Line
	6650 2400 6400 2400
$EndSCHEMATC
