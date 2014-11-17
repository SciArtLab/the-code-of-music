import themidibus.*;

MidiBus midiBus; 

int root = 60; //middle C
//int root = 62 // D
int[] scale = {0, 2, 4, 5, 7, 9, 11};// MAJOR

// CHROMATIC_SCALE = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},
// MAJOR_SCALE = {0, 2, 4, 5, 7, 9, 11},
// MINOR_SCALE = {0, 2, 3, 5, 7, 8, 10},
// HARMONIC_MINOR_SCALE = {0, 2, 3, 5, 7, 8, 11},
// MELODIC_MINOR_SCALE = {0, 2, 3, 5, 7, 8, 9, 10, 11}, // mix of ascend and descend
// NATURAL_MINOR_SCALE = {0, 2, 3, 5, 7, 8, 10},
// DIATONIC_MINOR_SCALE = {0, 2, 3, 5, 7, 8, 10},
// AEOLIAN_SCALE = {0, 2, 3, 5, 7, 8, 10},
// DORIAN_SCALE = {0, 2, 3, 5, 7, 9, 10},  
// LYDIAN_SCALE = {0, 2, 4, 6, 7, 9, 11},
// MIXOLYDIAN_SCALE = {0, 2, 4, 5, 7, 9, 10},
// PENTATONIC_SCALE = {0, 2, 4, 7, 9},
// BLUES_SCALE = {0, 2, 3, 4, 5, 7, 9, 10, 11},
// TURKISH_SCALE = {0, 1, 3, 5, 7, 10, 11},
// INDIAN_SCALE = {0, 1, 1, 4, 5, 8, 10};

int pos;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
}

void draw() {
  int posInScale = pos % scale.length; //is it the tonic, second, third... seventh?
  int octave = pos / scale.length; 
  //now to get a note in the scale, we add the root to its respective interval. 
  int note = root + scale[posInScale] + 12*octave;
  pos = (pos + 1) % (scale.length*4 + 1); //let's span 4 octaves, then go back to 0
  //the + 1 is there so that we play the root at the top.
  
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


