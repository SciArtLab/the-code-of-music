import themidibus.*;
import controlP5.*;

MidiBus midiBus;
ControlP5 cp5;
Numberbox bpm, num, denom;
Range syncopationRange;


Score s;
Transport t;

//a quick grid system to position elements on the screen (see x() and y() functions at the bottom)
int x = 10;
int y = 10;
int col_w = 40;
int row_h = 14;
int pad = 4;

int BPM;
int baseVelocity = 40;
int accentVelocity = 120;

void setup() {
  size(800, 400);
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  int BPM = 120;
  s = new Score();
  t = new Transport(BPM);
  t.beatsPerMeasure = 4;
  t.setListener(s);
  
  setupControls();
}

void draw() {
  background(0); 
}

void onTick(long millis) {
  if(t.newBeat()){
    int channel = 0;
    int beat = t.beat();
    int midiNote = 60;//one note per beat
    
    int duration = t.toTicks(1/4);
    
    //accent the first and third beat of every measure.
    int velocity = baseVelocity;
    if(beat == 0){
      velocity = accentVelocity;
    }
    
    s.add(channel, midiNote, velocity, duration, millis);
    
  }
}

void setupControls(){
  cp5 = new ControlP5(this);      
  bpm = cp5.addNumberbox("bpm")
            .setRange(20, 999)
            .setPosition(x(0), y(0))
            .setSize(col_w, row_h) 
            .setValue(120); 
  num = cp5.addNumberbox("beats_per_measure")
            .setPosition(x(2), y(0))
            .setSize(col_w, row_h) 
            .setValue(6)
            .setRange(1,32);
  cp5.addSlider("firstBeatAccent")
     .setPosition(x(0),y(2))     
     .setRange(baseVelocity,127)
     .setValue(accentVelocity)
     ;
            
}

void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("bpm")) {
    t.setTempo(floor(int(theControlEvent.getController().getValue())));

  }
  if(theControlEvent.isFrom("beats_per_measure")) {
    t.beatsPerMeasure = floor(int(theControlEvent.getController().getValue()));
  }
  
}

int x(int colNumber){
  return x + colNumber*col_w + (colNumber + 1)*pad;
}

int y(int rowNumber){
  return y + rowNumber*row_h + (rowNumber + 1)*pad;
}


void firstBeatAccent(float theValue){
  accentVelocity = (int)theValue; 
}
  



//remember to quit using X button on app window
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}






