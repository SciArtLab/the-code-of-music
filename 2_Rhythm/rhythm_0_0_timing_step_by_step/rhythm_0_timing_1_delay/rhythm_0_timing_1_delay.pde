import themidibus.*;

MidiBus midiBus; 

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  
}

void draw() {
  int channel = 0; 
  int note = floor(random(0, 127));  
  int velocity = floor(random(0, 127));
  int duration = floor(random(10, 500));
  midiBus.sendNoteOn(channel, note, velocity);
  delay(duration);
  midiBus.sendNoteOff(channel, note, velocity);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
