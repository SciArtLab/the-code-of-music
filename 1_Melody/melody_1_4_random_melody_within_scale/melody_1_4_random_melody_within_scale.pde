import themidibus.*;

MidiBus midiBus; 

//Note that by randomizing the order, different modes will sound the same.
//The way to emphasize the root is to start and end the melody on it, 
//and to repeat it more often than other notes. 

final int[] 
      //SCALES
      CHROMATIC = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},
      WHOLETONE = {0, 2, 4, 6, 8, 10},
      AUGMENTED = {0, 3, 4, 7, 8, 11},
      BLUES = {0, 3, 5, 6, 7, 10},
      MAJOR = {0, 2, 4, 5, 7, 9, 11},
      MINOR = {0, 2, 3, 5, 7, 8, 10},
      HARMONIC_MINOR = {0, 2, 3, 5, 7, 8, 11},
      MELODIC_MINOR = {0, 2, 3, 5, 7, 8, 9, 10, 11}, // mix of ascend and descend
      NATURAL_MINOR = {0, 2, 3, 5, 7, 8, 10},
      DIATONIC_MINOR = {0, 2, 3, 5, 7, 8, 10},
      AEOLIAN = {0, 2, 3, 5, 7, 8, 10},
      IONIAN = {0, 2, 4, 5, 7, 9, 11},
      DORIAN = {0, 2, 3, 5, 7, 9, 10},
      PHRYGIAN = {0, 1, 3, 5, 7, 8, 10},
      LOCRIAN = {0, 1, 3, 5, 6, 8, 10},  
      LYDIAN = {0, 2, 4, 6, 7, 9, 11},
      MIXOLYDIAN = {0, 2, 4, 5, 7, 9, 10},
      PENTATONIC = {0, 2, 4, 7, 9},
      MAJOR_PENTATONIC = {0, 2, 4, 7, 9},
      MINOR_PENTATONIC = {0, 3, 5, 7, 10},
      TURKISH = {0, 1, 3, 5, 7, 10, 11},
      INDIAN = {0, 1, 1, 4, 5, 8, 10},
      //CHORDS
      MAJOR_TRIAD = {0, 4, 7},
      MINOR_TRIAD = {0, 3, 7};
      

int root = 60; //middle C
int[] scale = MAJOR;


void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  
}

void draw() {
  int octaveSpan = 4; 
  int notePos = floor(random(0, octaveSpan*scale.length));
  int pitchClass = notePos % scale.length; //is it the tonic, second, third... seventh?
  int octave = notePos / scale.length; 
  //now to get a note in the scale, we add the root to its respective interval. 
  int note = root + scale[pitchClass] + 12*octave;
  
  int channel; 
  int velocity = 80;
  midiBus.sendNoteOn(0, note, velocity);
  delay(200);
  midiBus.sendNoteOff(0, note, velocity);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void exit(){
  //in case we exit while a note is playing, turn all notes off.
  for(int i = 0; i < 127; i++){
      midiBus.sendNoteOff(new Note(0, i, 0));
    }
  super.exit();
}


