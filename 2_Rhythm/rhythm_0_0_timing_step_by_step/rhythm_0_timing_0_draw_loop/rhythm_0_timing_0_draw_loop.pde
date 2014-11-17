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
}
