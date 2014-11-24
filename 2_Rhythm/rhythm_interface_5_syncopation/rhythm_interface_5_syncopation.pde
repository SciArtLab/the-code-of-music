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
boolean swing = false;
int syncopationMin, syncopationMax;

void setup() {
  size(800, 400);
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  int BPM = 120;
  s = new Score();
  t = new Transport(BPM);
  t.beatsPerMeasure = 4;
  t.setListener(s);
  
  syncopationMin = (int)-t.beatLength/2;
  syncopationMax = (int)t.beatLength/2;
  
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
    if(swing){
      t.setSyncopation(floor(random(syncopationMin, syncopationMax)));
    }
    
    //accent the first and third beat of every measure.
    int velocity = 40;
    if(beat == 0){
      velocity = 127;
    }
    else{
      velocity = 50;
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
  cp5.addToggle("swing_on")
     .setPosition(x(0),y(2))
     .setSize(50,20)
     ;
  syncopationRange = cp5.addRange("syncopation_range")
             .setBroadcast(false) 
             .setPosition(x(2), y(2))  
             .setSize(col_w*4, row_h)
             .setHandleSize(20)
             .setRange(syncopationMin, syncopationMax)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true) 
             .setColorForeground(color(340, 100, 100))
             .setColorBackground(color(0, 0, 30));
            
}

void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("bpm")) {
    t.setTempo(floor(int(theControlEvent.getController().getValue())));

  }
  if(theControlEvent.isFrom("beats_per_measure")) {
    t.beatsPerMeasure = floor(int(theControlEvent.getController().getValue()));
  }
  if(theControlEvent.isFrom("syncopation_range")) {
    syncopationMin = int(theControlEvent.getController().getArrayValue(0));
    syncopationMax = int(theControlEvent.getController().getArrayValue(1));
    
  }
  
}

void swing_on(boolean theFlag) {
  swing = theFlag;
  if(!swing) t.setSyncopation(0);
  println(swing);
}

void accents(float value){


}


int x(int colNumber){
  return x + colNumber*col_w + (colNumber + 1)*pad;
}

int y(int rowNumber){
  return y + rowNumber*row_h + (rowNumber + 1)*pad;
}

  



//remember to quit using X button on app window
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}






