EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 12
Title ""
Date "2020-06-17"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L RAM:HM62256BLP-7 U14
U 1 1 5F332E34
P 3450 3250
F 0 "U14" H 3050 4250 50  0000 C CNN
F 1 "HM62256BLP-7" H 3050 4150 50  0000 C CNN
F 2 "DIP28" H 3450 3250 50  0001 C CIN
F 3 "" H 3450 3250 50  0001 C CNN
	1    3450 3250
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR?
U 1 1 5F333E62
P 3450 2150
F 0 "#PWR?" H 3450 2000 50  0001 C CNN
F 1 "+5V" H 3465 2323 50  0000 C CNN
F 2 "" H 3450 2150 50  0001 C CNN
F 3 "" H 3450 2150 50  0001 C CNN
	1    3450 2150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F334074
P 3450 4150
F 0 "#PWR?" H 3450 3900 50  0001 C CNN
F 1 "GND" H 3455 3977 50  0000 C CNN
F 2 "" H 3450 4150 50  0001 C CNN
F 3 "" H 3450 4150 50  0001 C CNN
	1    3450 4150
	1    0    0    -1  
$EndComp
Text GLabel 2750 2500 0    50   Input ~ 0
ADDR_A0
Text GLabel 2750 2600 0    50   Input ~ 0
ADDR_A1
Text GLabel 2750 2700 0    50   Input ~ 0
ADDR_A2
Text GLabel 2750 2800 0    50   Input ~ 0
ADDR_A3
Text GLabel 2750 2900 0    50   Input ~ 0
ADDR_A4
Text GLabel 2750 3000 0    50   Input ~ 0
ADDR_A5
Text GLabel 2750 3100 0    50   Input ~ 0
ADDR_A6
Text GLabel 2750 3200 0    50   Input ~ 0
ADDR_A7
Text GLabel 2750 3300 0    50   Input ~ 0
ADDR_A8
Text GLabel 2750 3400 0    50   Input ~ 0
ADDR_A9
Text GLabel 2750 3500 0    50   Input ~ 0
ADDR_A10
Text GLabel 2750 3600 0    50   Input ~ 0
ADDR_A11
Text GLabel 2750 3700 0    50   Input ~ 0
ADDR_A12
Text GLabel 2750 3800 0    50   Input ~ 0
ADDR_A13
Text GLabel 2750 3900 0    50   Input ~ 0
ADDR_A14
Text GLabel 4150 2500 2    50   BiDi ~ 0
DATA_D0
Text GLabel 4150 2600 2    50   BiDi ~ 0
DATA_D1
Text GLabel 4150 2700 2    50   BiDi ~ 0
DATA_D2
Text GLabel 4150 2800 2    50   BiDi ~ 0
DATA_D3
Text GLabel 4150 2900 2    50   BiDi ~ 0
DATA_D4
Text GLabel 4150 3000 2    50   BiDi ~ 0
DATA_D5
Text GLabel 4150 3100 2    50   BiDi ~ 0
DATA_D6
Text GLabel 4150 3200 2    50   BiDi ~ 0
DATA_D7
Text GLabel 4150 3450 2    50   Input ~ 0
CTRL_RWB
Text GLabel 4150 3600 2    50   Input ~ 0
CTRL_RAM
Wire Wire Line
	3450 2350 3450 2150
Wire Wire Line
	3450 4050 3450 4100
Wire Wire Line
	3950 3350 4050 3350
Wire Wire Line
	4050 3350 4050 4100
Wire Wire Line
	4050 4100 3450 4100
Connection ~ 3450 4100
Wire Wire Line
	3450 4100 3450 4150
Wire Wire Line
	4150 3600 3950 3600
Wire Wire Line
	3950 3450 4150 3450
Wire Wire Line
	3950 3200 4150 3200
Wire Wire Line
	3950 3100 4150 3100
Wire Wire Line
	3950 3000 4150 3000
Wire Wire Line
	3950 2900 4150 2900
Wire Wire Line
	3950 2800 4150 2800
Wire Wire Line
	3950 2700 4150 2700
Wire Wire Line
	3950 2600 4150 2600
Wire Wire Line
	3950 2500 4150 2500
Wire Wire Line
	2950 2500 2750 2500
Wire Wire Line
	2750 2600 2950 2600
Wire Wire Line
	2750 2700 2950 2700
Wire Wire Line
	2750 2800 2950 2800
Wire Wire Line
	2750 2900 2950 2900
Wire Wire Line
	2750 3000 2950 3000
Wire Wire Line
	2750 3100 2950 3100
Wire Wire Line
	2750 3200 2950 3200
Wire Wire Line
	2750 3300 2950 3300
Wire Wire Line
	2750 3400 2950 3400
Wire Wire Line
	2750 3500 2950 3500
Wire Wire Line
	2750 3600 2950 3600
Wire Wire Line
	2750 3700 2950 3700
Wire Wire Line
	2750 3800 2950 3800
Wire Wire Line
	2750 3900 2950 3900
$EndSCHEMATC
