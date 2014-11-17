import themidibus.*;
MidiBus midiBus;


Player p;
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
  p = new Player(100);
  p.transport.beatsPerMeasure = 4;
  root = 60;

  
}

void draw() {
  
}

void onTick(long millis) {  
  if (p.transport.isNewBeat) {
    int beat = p.transport.beat();
    
    int root = chordRoots[beat];
    int[] chord = chords[beat];
    
    int pitch;
    int channel = 0; 
    int velocity = 80;
    int duration = 24;
    for(int i = 0; i < chord.length; i++){
      pitch = root + chord[i];
      p.play(channel, pitch, velocity, duration, millis);
    }
    
  }
}

void exit(){
  p.stopAll();
  super.exit();
}






