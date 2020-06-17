//
// address_decoding_test.ino
// - test address decoding logic (or/nor)
//
// written 16 june 2020 by rwk
//

// address pins
const char
  ADDR[] = {22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52},
// control pins
  CLK_PIN = 2,
  OR_PIN = 4,
  BE_PIN = 47,
  NOR_PIN = 41,
  RDY_PIN = 45;

// global address counter
volatile unsigned int
  address = 0;

// clock signal interrupt handler
void onClock() {
  unsigned int
    addr = address;
    
  // set the address bus bits
  for (int i=15;i>=0;i--) {
    digitalWrite(ADDR[i],(addr & 1) ? HIGH : LOW);
    addr >>= 1;
  }

  // read the pins
  char orBit = digitalRead(OR_PIN) ? '1' : '0';
  char norBit = digitalRead(NOR_PIN) ? '1' : '0';

  // expected output
  char expect = ((~(address & 0x8000) & 0x8000) | (address & 0x7f00)) == 0 ? '0' : '1';

  // output
  char msg[32];

  //
  // Test 1: 64K range by 256
  //
/*  
  sprintf(msg,"addr=%04x  or=%c  exp=%c  nor=%c",address,orBit,expect,norBit);
  Serial.print(msg);
  if (expect != orBit)
    Serial.println("  *** FAIL ***");
  else
    Serial.println();

  // next address
  address = (address + 0x100) & 0x7fff;
*/

/*
  //
  // Test 2: 0 -- 0x7fff, all addresses, only output failures
  //

  if (orBit != expect) {
    sprintf(msg,"addr=%04x  or=%c  exp=%c  nor=%c",address,orBit,expect,norBit);
    Serial.print(msg);
    Serial.println("  *** FAIL ***");
  }

  if (address == 0)
    Serial.println('0');
  // next address
  address = ++address & 0x7fff;
*/

  //
  // Test 3: 0x8000 -- 0xffff, by 256, only output failures
  //

  if (orBit != expect) {
    sprintf(msg,"addr=%04x  or=%c  exp=%c  nor=%c",address,orBit,expect,norBit);
    Serial.print(msg);
    Serial.println("  *** FAIL ***");
  }

  if (address == 0) {
    address = 0x8000;
    Serial.println("0x8000");
  }

  // next address
  address = (address + 0x0100) & 0xffff;

}

void setup() {
  // set up address pins, BE and RDY as outputs
  pinMode(BE_PIN,OUTPUT);
  pinMode(RDY_PIN,OUTPUT);
  for (int i=0;i<16;i++)
    pinMode(ADDR[i],OUTPUT);

  // set up CLK, OR and NOR pins as inputs
  pinMode(CLK_PIN,INPUT);
  pinMode(OR_PIN,INPUT);
  pinMode(NOR_PIN,INPUT);

  // set BE and RDY pins low to disable CPU
  digitalWrite(BE_PIN,LOW);
  digitalWrite(RDY_PIN,LOW);

  // set interrupt
  attachInterrupt(digitalPinToInterrupt(CLK_PIN),onClock,RISING);

  Serial.begin(57600);
}

void loop() {
  // put your main code here, to run repeatedly:

}
