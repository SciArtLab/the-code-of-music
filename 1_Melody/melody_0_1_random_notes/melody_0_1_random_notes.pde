import themidibus.*;

MidiBus midiBus; 

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  
}

void draw() {
  int channel; 
  int note = floor(random(0, 127));  
  int velocity = 80;
  midiBus.sendNoteOn(0, note, velocity);
  delay(200);
  midiBus.sendNoteOff(0, note, velocity);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
