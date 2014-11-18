import themidibus.*;
MidiBus midiBus;

//Press keys 2 through 6 to change the number of beats per measure. Hear how the accent shifts 
//(we're accenting the first beat in each measure)

Score s;
Transport t;

int BPM;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  int BPM = 120;
  s = new Score();
  t = new Transport(BPM);
  t.setListener(s);
}

void draw() {
  
}

void onTick(long millis) {
  if(t.newBeat()){
    int channel = 0;
    int[] notes = {60, 62, 65, 67, 69, 71};
    int beat = t.beat();
    int midiNote = notes[beat];//one note per beat
    
    int duration = t.toTicks(1/4);
    
    //accent the first and third beat of every measure.
    int velocity = 40;
    if(beat == 0){
      velocity = 100;
    }
    if(beat == 2){
      velocity = 80;
    }
    
    s.add(channel, midiNote, velocity, duration, millis);
    println(beat);
    
  }
}

  



//remember to quit using X button on app window
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}






