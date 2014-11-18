import themidibus.*;
MidiBus midiBus;
//TIME SIGNATURE
//Our Transport will now keep track the current measure, the current beat, and the current subdivision:
//Look at the console printouts ––the format is measure:beat:unit. There are 16 units in a beat (like in Ableton Live, for example)
//We'll control our time signature by setting the number of beats in a measure. 

//Press keys 2 through 6 to change the number of beats per measure

Score s;
Transport t;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  int BPM = 120;
  s = new Score();
  t = new Transport(BPM);
  t.beatsPerMeasure = 5;
  t.setListener(s);
}

void draw() {
  
}

void onTick(long millis) {
  println(t.measure() + " : " +  t.beat() + " : " + t.unit());
  if(t.newBeat()) {
    int channel = 0;
    int[] notes = {60, 62, 65, 67, 69, 71};
    int beat = t.beat();
    int midiNote = notes[beat];//one note per beat
    int duration = t.toTicks(1/4);
    //accent the first beat of every measure.
    int velocity = 40;
    if(beat == 0){
      velocity = 100;
    }
    
    s.add(channel, midiNote, velocity, duration, millis);
    
  }
}

void keyPressed(){
  switch(key){
    case '2':
      t.beatsPerMeasure = 2;
      break;
    case '3':
      t.beatsPerMeasure = 3;
      break;
    case '4':
      t.beatsPerMeasure = 4;
      break;
    case '5':
      t.beatsPerMeasure = 5;
      break;
    case '6':
      t.beatsPerMeasure = 6;
      break;
  }
  println("Beats per measure: " + t.beatsPerMeasure);
}


//to avoid lingering notes, quit your sketch by hiting the X button in the window.
//(otherwise Processing doesn't seem to call the 'exit' function)
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}





