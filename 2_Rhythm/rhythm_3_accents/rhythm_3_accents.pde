import themidibus.*;
MidiBus midiBus;
//TIME SIGNATURE
//Our Transport will now keep track the current measure, the current beat, and the current subdivision.
//We'll control our time signature by setting the number of beats in a measure.

Player p;

int BPM;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  int BPM = 120;
  p = new Player(180);
}

void draw() {
  
}

void onTick(long millis) {
  println(p.transport.measure() + " : " +  p.transport.beat());
  if (p.transport.isNewBeat) {
    int channel = 0;
    int[] notes = {60, 62, 65, 67};
    int beat = p.transport.beat();
    int midiNote = notes[beat];//one note per beat
    
    int duration = 24;
    
    //accent the first and third beat of every measure.
    int velocity = 20;
    if(beat == 0){
      velocity = 127;
    }
    if(beat == 2){
      velocity = 60;
    }
    p.play(channel, midiNote, velocity, duration, millis);
    
  }
}

void mouseMoved(){
  int tempo = floor(map(mouseX, 0, height, 20, 500));
  p.transport.setTempo(tempo);
  println("tempo: " + tempo + " BPM");
}

void exit(){
  p.stopAll();
  super.exit();
}






