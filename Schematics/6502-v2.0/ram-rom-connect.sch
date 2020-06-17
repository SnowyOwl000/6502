EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
encoding utf-8
Sheet 9 10
Title "RAM and ROM Connections"
Date "2020-06-17"
Rev "1"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L RAM:HM62256BLP-7 U14
U 1 1 5F332E34
P 4350 3550
F 0 "U14" H 3950 4550 50  0000 C CNN
F 1 "HM62256BLP-7" H 3950 4450 50  0000 C CNN
F 2 "DIP28" H 4350 3550 50  0001 C CIN
F 3 "" H 4350 3550 50  0001 C CNN
	1    4350 3550
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0114
U 1 1 5F333E62
P 4350 2450
F 0 "#PWR0114" H 4350 2300 50  0001 C CNN
F 1 "+5V" H 4365 2623 50  0000 C CNN
F 2 "" H 4350 2450 50  0001 C CNN
F 3 "" H 4350 2450 50  0001 C CNN
	1    4350 2450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0115
U 1 1 5F334074
P 4350 4450
F 0 "#PWR0115" H 4350 4200 50  0001 C CNN
F 1 "GND" H 4355 4277 50  0000 C CNN
F 2 "" H 4350 4450 50  0001 C CNN
F 3 "" H 4350 4450 50  0001 C CNN
	1    4350 4450
	1    0    0    -1  
$EndComp
Text GLabel 3650 2800 0    50   Input ~ 0
ADDR_A0
Text GLabel 3650 2900 0    50   Input ~ 0
ADDR_A1
Text GLabel 3650 3000 0    50   Input ~ 0
ADDR_A2
Text GLabel 3650 3100 0    50   Input ~ 0
ADDR_A3
Text GLabel 3650 3200 0    50   Input ~ 0
ADDR_A4
Text GLabel 3650 3300 0    50   Input ~ 0
ADDR_A5
Text GLabel 3650 3400 0    50   Input ~ 0
ADDR_A6
Text GLabel 3650 3500 0    50   Input ~ 0
ADDR_A7
Text GLabel 3650 3600 0    50   Input ~ 0
ADDR_A8
Text GLabel 3650 3700 0    50   Input ~ 0
ADDR_A9
Text GLabel 3650 3800 0    50   Input ~ 0
ADDR_A10
Text GLabel 3650 3900 0    50   Input ~ 0
ADDR_A11
Text GLabel 3650 4000 0    50   Input ~ 0
ADDR_A12
Text GLabel 3650 4100 0    50   Input ~ 0
ADDR_A13
Text GLabel 3650 4200 0    50   Input ~ 0
ADDR_A14
Text GLabel 5050 2800 2    50   BiDi ~ 0
DATA_D0
Text GLabel 5050 2900 2    50   BiDi ~ 0
DATA_D1
Text GLabel 5050 3000 2    50   BiDi ~ 0
DATA_D2
Text GLabel 5050 3100 2    50   BiDi ~ 0
DATA_D3
Text GLabel 5050 3200 2    50   BiDi ~ 0
DATA_D4
Text GLabel 5050 3300 2    50   BiDi ~ 0
DATA_D5
Text GLabel 5050 3400 2    50   BiDi ~ 0
DATA_D6
Text GLabel 5050 3500 2    50   BiDi ~ 0
DATA_D7
Text GLabel 5050 3750 2    50   Input ~ 0
CTRL_RWB
Text GLabel 5050 3900 2    50   Input ~ 0
CTRL_RAM
Wire Wire Line
	4350 2650 4350 2450
Wire Wire Line
	4350 4350 4350 4400
Wire Wire Line
	4850 3650 4950 3650
Wire Wire Line
	4950 3650 4950 4400
Wire Wire Line
	4950 4400 4350 4400
Connection ~ 4350 4400
Wire Wire Line
	4350 4400 4350 4450
Wire Wire Line
	5050 3900 4850 3900
Wire Wire Line
	4850 3750 5050 3750
Wire Wire Line
	4850 3500 5050 3500
Wire Wire Line
	4850 3400 5050 3400
Wire Wire Line
	4850 3300 5050 3300
Wire Wire Line
	4850 3200 5050 3200
Wire Wire Line
	4850 3100 5050 3100
Wire Wire Line
	4850 3000 5050 3000
Wire Wire Line
	4850 2900 5050 2900
Wire Wire Line
	4850 2800 5050 2800
Wire Wire Line
	3850 2800 3650 2800
Wire Wire Line
	3650 2900 3850 2900
Wire Wire Line
	3650 3000 3850 3000
Wire Wire Line
	3650 3100 3850 3100
Wire Wire Line
	3650 3200 3850 3200
Wire Wire Line
	3650 3300 3850 3300
Wire Wire Line
	3650 3400 3850 3400
Wire Wire Line
	3650 3500 3850 3500
Wire Wire Line
	3650 3600 3850 3600
Wire Wire Line
	3650 3700 3850 3700
Wire Wire Line
	3650 3800 3850 3800
Wire Wire Line
	3650 3900 3850 3900
Wire Wire Line
	3650 4000 3850 4000
Wire Wire Line
	3650 4100 3850 4100
Wire Wire Line
	3650 4200 3850 4200
$Comp
L RAM:28C256 U13
U 1 1 5F33FF1B
P 7050 3650
F 0 "U13" H 7650 3000 50  0000 C CNN
F 1 "28C256" H 7650 2900 50  0000 C CNN
F 2 "" H 7050 3650 50  0001 C CNN
F 3 "memory/28c256.pdf" H 7050 3650 50  0001 C CNN
	1    7050 3650
	1    0    0    -1  
$EndComp
Text GLabel 6150 2750 0    50   Input ~ 0
ADDR_A0
Text GLabel 6150 2850 0    50   Input ~ 0
ADDR_A1
Text GLabel 6150 2950 0    50   Input ~ 0
ADDR_A2
Text GLabel 6150 3050 0    50   Input ~ 0
ADDR_A3
Text GLabel 6150 3150 0    50   Input ~ 0
ADDR_A4
Text GLabel 6150 3250 0    50   Input ~ 0
ADDR_A5
Text GLabel 6150 3350 0    50   Input ~ 0
ADDR_A6
Text GLabel 6150 3450 0    50   Input ~ 0
ADDR_A7
Text GLabel 6150 3550 0    50   Input ~ 0
ADDR_A8
Text GLabel 6150 3650 0    50   Input ~ 0
ADDR_A9
Text GLabel 6150 3750 0    50   Input ~ 0
ADDR_A10
Text GLabel 6150 3850 0    50   Input ~ 0
ADDR_A11
Text GLabel 6150 3950 0    50   Input ~ 0
ADDR_A12
Text GLabel 6150 4050 0    50   Input ~ 0
ADDR_A13
Text GLabel 6150 4150 0    50   Input ~ 0
ADDR_A14
Text GLabel 7950 2750 2    50   Input ~ 0
DATA_D0
Text GLabel 7950 2850 2    50   Input ~ 0
DATA_D1
Text GLabel 7950 2950 2    50   Input ~ 0
DATA_D2
Text GLabel 7950 3050 2    50   Input ~ 0
DATA_D3
Text GLabel 7950 3150 2    50   Input ~ 0
DATA_D4
Text GLabel 7950 3250 2    50   Input ~ 0
DATA_D5
Text GLabel 7950 3350 2    50   Input ~ 0
DATA_D6
Text GLabel 7950 3450 2    50   Input ~ 0
DATA_D7
$Comp
L power:+5V #PWR0116
U 1 1 5F34693C
P 7050 2450
F 0 "#PWR0116" H 7050 2300 50  0001 C CNN
F 1 "+5V" H 7065 2623 50  0000 C CNN
F 2 "" H 7050 2450 50  0001 C CNN
F 3 "" H 7050 2450 50  0001 C CNN
	1    7050 2450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0117
U 1 1 5F346B06
P 7050 4750
F 0 "#PWR0117" H 7050 4500 50  0001 C CNN
F 1 "GND" H 7055 4577 50  0000 C CNN
F 2 "" H 7050 4750 50  0001 C CNN
F 3 "" H 7050 4750 50  0001 C CNN
	1    7050 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	6350 4350 6250 4350
Wire Wire Line
	6250 4350 6250 2550
Wire Wire Line
	6250 2550 7050 2550
Wire Wire Line
	7050 2550 7050 2450
Wire Wire Line
	7050 2650 7050 2550
Connection ~ 7050 2550
Wire Wire Line
	7050 4650 7050 4750
Wire Wire Line
	6150 2750 6350 2750
Wire Wire Line
	6150 2850 6350 2850
Wire Wire Line
	6150 2950 6350 2950
Wire Wire Line
	6150 3050 6350 3050
Wire Wire Line
	6150 3150 6350 3150
Wire Wire Line
	6150 3250 6350 3250
Wire Wire Line
	6150 3350 6350 3350
Wire Wire Line
	6150 3450 6350 3450
Wire Wire Line
	6150 3550 6350 3550
Wire Wire Line
	6150 3650 6350 3650
Wire Wire Line
	6150 3750 6350 3750
Wire Wire Line
	6150 3850 6350 3850
Wire Wire Line
	6150 3950 6350 3950
Wire Wire Line
	6150 4050 6350 4050
Wire Wire Line
	6150 4150 6350 4150
Wire Wire Line
	7950 2750 7750 2750
Wire Wire Line
	7950 2850 7750 2850
Wire Wire Line
	7950 2950 7750 2950
Wire Wire Line
	7950 3050 7750 3050
Wire Wire Line
	7950 3150 7750 3150
Wire Wire Line
	7950 3250 7750 3250
Wire Wire Line
	7950 3350 7750 3350
Wire Wire Line
	7950 3450 7750 3450
Text GLabel 6150 4450 0    50   Input ~ 0
CTRL_A15B
Text GLabel 6150 4550 0    50   Input ~ 0
CTRL_NOR
Wire Wire Line
	6150 4450 6350 4450
Wire Wire Line
	6150 4550 6350 4550
$EndSCHEMATC
