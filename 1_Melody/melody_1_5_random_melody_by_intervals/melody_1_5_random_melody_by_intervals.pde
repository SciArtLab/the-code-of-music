import themidibus.*;

MidiBus midiBus; 
FloatDict intervals;
//for this example let's ignore the scale.

int currentNote;
int root;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  
  intervals = new FloatDict();
  intervals.set("minor second", 1);
  intervals.set("major second", 2);
  intervals.set("minor third", 3);
  intervals.set("major third", 4);
  intervals.set("perfect fourth", 5);
  intervals.set("augmented fourth", 6);
  intervals.set("perfect fifth", 7);
  intervals.set("augmented fifth", 8);
  intervals.set("sixth", 9);
  intervals.set("minor seventh", 10);
  intervals.set("major seventh", 11);
  intervals.set("octave", 12);
  
  root = 60;
  currentNote = 0; //start at the root.
  
}

void draw() {
  //a melody that only goes up or down in major thirds.
  float choice = random(0, 1);
  int direction = 1; //1: up. -1: down
  if(choice > 0.5){
    direction = -1;
  }
  
  int octaveSpan = 6; 
  int maxPos = octaveSpan * 12; //let's assume a chromatic scale.
  int nextPos = currentNote + (int)intervals.get("augmented fourth")*direction;
  
  if(nextPos > 0 && nextPos < maxPos){
    currentNote = nextPos;
  }
  
  int pitchClass = currentNote % 12 ; //is it the tonic, second, third... seventh?
  int octave = currentNote / 12; 
  
  //now to get a note in the scale, we add the root to its respective interval. 
  int note = root + currentNote + 12*octave;
  
  
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


