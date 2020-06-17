const char ADDR[] = {52,50,48,46,44,42,40,38,36,34,32,30,28,26,24,22};
const char DATA[] = {53,51,49,47,45,43,41,39};
const char CLOCK = 2;
const char RW_PIN = 3;
const char OR_PIN = 4;

void onClock() {
  //delay(10);
  bool
    ad[16],
    dt[8],
    rw,cs;
  unsigned int
    addr=0,data=0;
  char
    output[16];
    
  for (int i=15;i>=0;i--) {
    ad[i] = digitalRead(ADDR[i]);
  }

  for (int i=0;i<8;i++) {
    dt[i] = digitalRead(DATA[i]);
  }

  rw = digitalRead(RW_PIN);
  cs = digitalRead(OR_PIN);

  for (int i=15;i>=0;i--) {
    int bit = ad[i] ? 1 : 0;
    Serial.print(bit);
    addr = (addr << 1) + bit;
  }

  Serial.print("   ");

  for (int i=0;i<8;i++) {
    int bit = dt[i] ? 1 : 0;
    Serial.print(bit);
    data = (data << 1) + bit;
  }

  sprintf(output,"   %04x %c %c %02x",addr,rw ? 'r' : 'W',cs ? '1' : '0',data);
  Serial.println(output);
}

void setup() {
  // put your setup code here, to run once:
  for (int i=0;i<16;i++) {
    pinMode(ADDR[i],INPUT);
  }
  for (int i=0;i<8;i++) {
    pinMode(DATA[i],INPUT);
  }
  pinMode(CLOCK,INPUT);
  pinMode(RW_PIN,INPUT);
  pinMode(OR_PIN,INPUT);

  attachInterrupt(digitalPinToInterrupt(CLOCK),onClock,RISING);
  
  Serial.begin(57600);
}

void loop() {
//  Serial.println('.');
//  delay(2000);
  // put your main code here, to run repeatedly:
}
