import themidibus.*;
MidiBus midiBus;

Score s;
Transport t;

int BPM;
int beatsPerMeasure;

int [] scale = {62, 64, 66, 67, 69, 71, 73};//D major
int currentNote;
int velocity; 
int duration;

void setup(){
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  
  colorMode(HSB, 360, 100, 100);
  s = new Score();
  t = new Transport(240);
  t.setListener(s);
  
}

void draw(){
  background(0);
  int x = 0;
  int y = (int)map(currentNote, 0, 127, height, 0);
  int S = (int)map(velocity, 0, 127, 20, 100);
  int B = (int)map(velocity, 0, 127, 60, 100);
  int w = width/4;
  
  noStroke();
  fill(340, 100, B);
  rect((width - w)/2, y, w, height - y);
  
}

void onTick(long now){ 
  if (t.newBeat()) {
     int posInScale = floor(random(0, scale.length)); 
     int octave = floor(random(0,3));  
     currentNote = scale[posInScale] + 12*octave;
     int channel = 0;
     velocity = floor(random(0, 127));
     duration = floor(random(1/4, 1/2));
     s.add(channel, currentNote, velocity, t.toTicks(duration), now);
   }
} 
  

//remember to quit using X button on app window
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}

