import themidibus.*;

MidiBus midiBus;

Score s;
Transport t;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  
  s = new Score();
  t = new Transport(240);
  t.setListener(s); 
}

void draw() {
  
}

void onTick(long now) {
  if (t.newBeat()) {
    int channel = 0;
    int midiNote = floor(random(0, 127));
    int q = 24; //a quarter note has 24 ticks 
    int duration = t.toTicks(random(1/8, 1/2));
    int velocity = floor(random(0, 127));  
    
    s.add(channel, midiNote, velocity, duration, now);
    
  }
}

//to avoid lingering notes, quit your sketch by hiting the X button in the window.
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}






