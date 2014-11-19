import themidibus.*;
MidiBus midiBus;

Score s;
Transport t;

int syncopationAmount;
int BPM;

int root, currentNote;
      
      
final int[] 
  MAJOR_TRIAD = {0, 4, 7},
  MINOR_TRIAD = {0, 3, 7},
  DIMINISHED_TRIAD = {0, 3, 6},
  AUGMENTED_TRIAD = {0, 3, 8};


int[] chordRoots = {60, 64, 65, 67};//C, E, F, G  
int[][] chords = {MAJOR_TRIAD, MINOR_TRIAD, MAJOR_TRIAD, MAJOR_TRIAD};
  
  //  Major
  //  maj 6th 0 4 7 9
  //  maj add9 0 4 7 14
  //  maj 6/9 0 4 7 9 14
  //  maj sus2 0 2 7
  //  maj 7 0 4 7 11
  //  maj 7(9) 0 4 7 11 14
  //  maj 7(#11) 0 4 7 11 18
  //  maj7(13) 0 4 7 11 21
  //  Minor
  //  minor triad 0 3 7
  //  min add9 0 3 7 14
  //  min 6/9 0 3 7 9 14
  //  min 7th 0 3 7 10
  //  min 7(9) 0 3 7 10 14
  //  min 7(11) 0 3 7 10 17
  //  min add11 0 3 7 17

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  BPM = 120;
  s = new Score();
  t = new Transport(BPM);
  t.setListener(s);
  root = 60;

  
}

void draw() {
  
}

void onTick(long now) {  
  if (t.newBeat()) {
    int beat = t.beat();
    
    int root = chordRoots[beat];
    int[] chord = chords[beat];
    
    int pitch;
    int channel = 0; 
    int velocity = 80;
    int duration = t.toTicks(1/4);
    for(int i = 0; i < chord.length; i++){
      pitch = root + chord[i];
      s.add(channel, pitch, velocity, duration, now);
    }
  }
}

//remember to quit using X button on app window
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}





