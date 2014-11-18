import themidibus.*;
MidiBus midiBus;


Score s;
Transport t;

int syncopationAmount;
int BPM;

int root, currentNote;
FloatDict intervals;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  BPM = 120;
  s = new Score();
  t = new Transport(BPM);
  t.setListener(s);
  root = 60;
  
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
  
}

void draw() {
  
}

void onTick(long now) {  
  if (t.newBeat()) {
    //NOTE 1: DRONE
    if(t.beat() == 0 || t.beat() == 2){
      int drone = root;
      int channel = 1; 
      int velocity = 100;
      int duration = t.toTicks(1/2);
      s.add(channel, drone, velocity, duration, now);
    }
    //NOTE 2: MELODY
    int octaveSpan = 2; 
    int maxPos = octaveSpan * 12; //let's assume a chromatic scale.
    
    int direction = 1; //1: up. -1: down
    if(random(0, 1) > 0.5){
      direction = -1;
    }
    //melody moves in small intevals.
    int step = (int)intervals.get("major second")*direction;
    if(random(0,1) > 0.3){
      step = (int)intervals.get("minor second")*direction;
    }
    if(random(0,1) < 0.3){
      step = (int)intervals.get("major third")*direction;
    }
    int nextPos = currentNote + step;
    if(nextPos > 0 && nextPos < maxPos){
      currentNote = nextPos;
    }
    
    int pitchClass = currentNote % 12 ; //is it the tonic, second, third... seventh?
    int octave = currentNote / 12;   
    //now to get a note in the scale, we add the root to its respective interval. 
    int note = root + currentNote + 12*octave;
    
    int channel = 2; 
    int velocity = floor(random(40, 100));
    int duration = floor(random(200, 400));
    s.add(channel, note, velocity, duration, now);
    
  }
}


//remember to quit using X button on app window
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}






