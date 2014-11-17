import themidibus.*;
MidiBus midiBus;


Player p;
int syncopationAmount;
int BPM;

int root, currentNote;
FloatDict intervals;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  BPM = 120;
  p = new Player(180);
  p.transport.beatsPerMeasure = 4;
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

void onTick(long millis) {  
  if (p.transport.isNewBeat) {
    //NOTE 1: MELODY
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
      
      
      int channel = 1; 
      int velocity = floor(random(40, 100));
      int duration = floor(random(200, 400));
      p.play(channel, note, velocity, duration, millis);
      
      //NOTE 2: PARALLEL DRONE
      channel = 0;
      int parallelDrone = note - (int)intervals.get("perfect fourth");
      p.play(channel, note, velocity, duration, millis);
    
  }
}

void mouseMoved(){
  syncopationAmount = floor(map(mouseX, 0, width, 0, p.transport.beatLength/2));
  println("syncopation amount: " + syncopationAmount);
 
}

void exit(){
  p.stopAll();
  super.exit();
}






