import themidibus.*;
MidiBus midiBus;
//Syncopation example or 'swing'
//Move the mouse to change the amount: to the left it approaches zero, 
//to the right it approaches two beats

Score s;
Transport t;

int syncopationAmount;
int BPM;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  BPM = 120;
  s = new Score();
  t = new Transport(BPM);
  t.setListener(s);
}

void draw() {
  
}

void onTick(long now) {  
  if (t.newBeat()) {
    t.setSyncopation(floor(random(-syncopationAmount, syncopationAmount)));
    
    int channel = 0;
    int[] notes = {60, 62, 65, 67};
    int beat = t.beat();
    int midiNote = notes[beat];//one note per beat
    
    int duration = t.toTicks(1/4);
    
    //accent the first and third beat of every measure.
    int velocity = 60;
    s.add(channel, midiNote, velocity, duration, now);
    
  }
}

void mouseMoved(){
  syncopationAmount = floor(map(mouseX, 0, width, 0, t.beatLength/2));
  println("syncopation amount: " + syncopationAmount);
 
}

//remember to quit using X button on app window
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}






