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
int[] velocities = {120, 40, 40, 40};


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
    
    int velocity = velocities[beat];
    
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
  cp5.addSlider("v_beat_0")
     .setPosition(x(0),y(2))     
     .setSize(col_w, row_h*4) 
     .setRange(0,127)
     .setValue(40)
     ;
  cp5.addSlider("v_beat_1")
     .setPosition(x(2),y(2))     
     .setSize(col_w, row_h*4) 
     .setRange(0,127)
     .setValue(40)
     ;
  cp5.addSlider("v_beat_2")
     .setPosition(x(4),y(2))     
     .setSize(col_w, row_h*4) 
     .setRange(0,127)
     .setValue(40)
     ;
  cp5.addSlider("v_beat_3")
     .setPosition(x(6),y(2)) 
     .setSize(col_w, row_h*4)     
     .setRange(0,127)
     .setValue(40)
     ;     
    
            
}

void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("bpm")) {
    t.setTempo(floor(int(theControlEvent.getController().getValue())));
  }
  if(theControlEvent.isFrom("v_beat_0")) {
    velocities[0] = floor(theControlEvent.getValue());
  }
  if(theControlEvent.isFrom("v_beat_1")) {
    velocities[1] = floor(theControlEvent.getValue());
  }
  if(theControlEvent.isFrom("v_beat_2")) {
    velocities[2] = floor(theControlEvent.getValue());
  }
  if(theControlEvent.isFrom("v_beat_3")) {
    velocities[3] = floor(theControlEvent.getValue());
  }
  
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






