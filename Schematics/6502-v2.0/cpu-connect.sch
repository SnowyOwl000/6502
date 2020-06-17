EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 5 10
Title "CPU Connections"
Date "2020-06-17"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 65xx:W65C02SxP U10
U 1 1 5F31BE8A
P 5400 3700
F 0 "U10" H 5000 5200 50  0000 C CNN
F 1 "W65C02SxP" H 5000 5100 50  0000 C CNN
F 2 "" H 5400 5700 50  0001 C CNN
F 3 "http://www.westerndesigncenter.com/wdc/documentation/w65c02s.pdf" H 5400 5600 50  0001 C CNN
	1    5400 3700
	1    0    0    -1  
$EndComp
Text GLabel 4650 2500 0    50   Input ~ 0
CTRL_RESB
Text GLabel 4650 2800 0    50   Input ~ 0
CTRL_CLK
Text GLabel 4650 3300 0    50   Input ~ 0
CTRL_IRQB
Text GLabel 4650 3400 0    50   Input ~ 0
CTRL_NMIB
Text GLabel 4650 3700 0    50   Output ~ 0
CTRL_RWB
Text GLabel 4650 4000 0    50   Input ~ 0
CTRL_RDY
Text GLabel 4650 4100 0    50   Input ~ 0
CTRL_BE
Wire Wire Line
	4650 2500 4800 2500
Wire Wire Line
	4650 3000 4800 3000
Wire Wire Line
	4650 3300 4800 3300
Wire Wire Line
	4650 3400 4800 3400
Wire Wire Line
	4650 3700 4800 3700
Wire Wire Line
	4650 4000 4800 4000
Wire Wire Line
	4650 4100 4800 4100
Wire Wire Line
	4800 4400 4650 4400
Wire Wire Line
	4800 4500 4650 4500
Wire Wire Line
	4800 4600 4650 4600
Wire Wire Line
	4800 4900 4650 4900
Wire Wire Line
	4800 2900 4650 2900
Wire Wire Line
	4800 2800 4650 2800
NoConn ~ 4650 2900
NoConn ~ 4650 4400
NoConn ~ 4650 4500
NoConn ~ 4650 4600
NoConn ~ 4650 4900
Text GLabel 6150 2500 2    50   Output ~ 0
ADDR_A0
Text GLabel 6150 2600 2    50   Output ~ 0
ADDR_A1
Text GLabel 6150 2700 2    50   Output ~ 0
ADDR_A2
Text GLabel 6150 2800 2    50   Output ~ 0
ADDR_A3
Text GLabel 6150 2900 2    50   Output ~ 0
ADDR_A4
Text GLabel 6150 3000 2    50   Output ~ 0
ADDR_A5
Text GLabel 6150 3100 2    50   Output ~ 0
ADDR_A6
Text GLabel 6150 3200 2    50   Output ~ 0
ADDR_A7
Text GLabel 6150 3300 2    50   Output ~ 0
ADDR_A8
Text GLabel 6150 3400 2    50   Output ~ 0
ADDR_A9
Text GLabel 6150 3500 2    50   Output ~ 0
ADDR_A10
Text GLabel 6150 3600 2    50   Output ~ 0
ADDR_A11
Text GLabel 6150 3700 2    50   Output ~ 0
ADDR_A12
Text GLabel 6150 3800 2    50   Output ~ 0
ADDR_A13
Text GLabel 6150 3900 2    50   Output ~ 0
ADDR_A14
Text GLabel 6150 4000 2    50   Output ~ 0
ADDR_A15
Text GLabel 6150 4200 2    50   BiDi ~ 0
DATA_D0
Text GLabel 6150 4300 2    50   BiDi ~ 0
DATA_D1
Text GLabel 6150 4400 2    50   BiDi ~ 0
DATA_D2
Text GLabel 6150 4500 2    50   BiDi ~ 0
DATA_D3
Text GLabel 6150 4600 2    50   BiDi ~ 0
DATA_D4
Text GLabel 6150 4700 2    50   BiDi ~ 0
DATA_D5
Text GLabel 6150 4800 2    50   BiDi ~ 0
DATA_D6
Text GLabel 6150 4900 2    50   BiDi ~ 0
DATA_D7
Wire Wire Line
	6000 2500 6150 2500
Wire Wire Line
	6000 2600 6150 2600
Wire Wire Line
	6000 2700 6150 2700
Wire Wire Line
	6000 2800 6150 2800
Wire Wire Line
	6000 2900 6150 2900
Wire Wire Line
	6000 3000 6150 3000
Wire Wire Line
	6000 3100 6150 3100
Wire Wire Line
	6000 3200 6150 3200
Wire Wire Line
	6000 3300 6150 3300
Wire Wire Line
	6000 3400 6150 3400
Wire Wire Line
	6000 3500 6150 3500
Wire Wire Line
	6000 3600 6150 3600
Wire Wire Line
	6000 3700 6150 3700
Wire Wire Line
	6000 3800 6150 3800
Wire Wire Line
	6000 3900 6150 3900
Wire Wire Line
	6000 4000 6150 4000
Wire Wire Line
	6000 4200 6150 4200
Wire Wire Line
	6000 4300 6150 4300
Wire Wire Line
	6000 4400 6150 4400
Wire Wire Line
	6000 4500 6150 4500
Wire Wire Line
	6000 4600 6150 4600
Wire Wire Line
	6000 4700 6150 4700
Wire Wire Line
	6000 4800 6150 4800
Wire Wire Line
	6000 4900 6150 4900
$Comp
L power:+5V #PWR0112
U 1 1 5F328DBE
P 5400 2050
F 0 "#PWR0112" H 5400 1900 50  0001 C CNN
F 1 "+5V" H 5415 2223 50  0000 C CNN
F 2 "" H 5400 2050 50  0001 C CNN
F 3 "" H 5400 2050 50  0001 C CNN
	1    5400 2050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0113
U 1 1 5F328F15
P 5400 5350
F 0 "#PWR0113" H 5400 5100 50  0001 C CNN
F 1 "GND" H 5405 5177 50  0000 C CNN
F 2 "" H 5400 5350 50  0001 C CNN
F 3 "" H 5400 5350 50  0001 C CNN
	1    5400 5350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 5350 5400 5250
Wire Wire Line
	5400 2150 5400 2050
Wire Notes Line
	6500 2400 6650 2400
Wire Notes Line
	6650 4100 6550 4100
Wire Notes Line
	6650 5000 6550 5000
Wire Notes Line
	6650 2400 6650 5000
Text Notes 6750 3450 1    50   ~ 0
Address Bus
Text Notes 6750 4700 1    50   ~ 0
Data Bus
Wire Notes Line
	4250 2400 4100 2400
Wire Notes Line
	4100 2400 4100 4200
Wire Notes Line
	4100 4200 4250 4200
Text Notes 4050 3100 3    50   ~ 0
Control Bus
NoConn ~ 4650 3000
$EndSCHEMATC
