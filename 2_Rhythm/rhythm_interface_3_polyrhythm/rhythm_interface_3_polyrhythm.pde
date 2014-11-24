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
int[] beatsPerMeasure = {3, 4, 5};


void setup() {
  size(800, 400);
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  int BPM = 120;
  s = new Score();
  t = new Transport(BPM);
  t.setListener(s);
  
  setupControls();
}

void draw() {
  background(0); 
}

void onTick(long millis) {
  if(t.newBeat()){
    //instead of using t.beat(), which depend on the time signature,
     //we'll use t.beats (the total number of beats).
     //an instrument that is playing at 4/4 (4 beats per measure) will play when p.transport.totalBeats % 4 == 0.
     //an instrument that is playing at 3/4 will play when p.transport.totalBeats % 3 == 0.
     int channel = 0;
     int midiNote;
     int velocity = 100;
     int duration = t.toTicks(1/2);
     
     println(beatsPerMeasure[0]);
     if(t.beats % beatsPerMeasure[0] == 0){
       channel = 0;
       midiNote = 13;
       velocity = 50;
       s.add(channel, midiNote, velocity, duration, millis);
     }
     if(t.beats % beatsPerMeasure[1] == 0){
       channel = 1;
       midiNote = 12;
       s.add(channel, midiNote, velocity, duration, millis);
     }
     if(t.beats % beatsPerMeasure[2] == 0){
       channel = 2;
       midiNote = 42;
       s.add(channel, midiNote, velocity, duration, millis);
     }
    
    
  }
}

void setupControls(){
  cp5 = new ControlP5(this);      
  bpm = cp5.addNumberbox("bpm")
            .setRange(20, 999)
            .setPosition(x(0), y(0))
            .setSize(col_w, row_h) 
            .setValue(120); 
  cp5.addSlider("beats_ch_0")
     .setPosition(x(0),y(2))     
     .setSize(col_w, row_h*4) 
     .setRange(1,12)
     .setValue(beatsPerMeasure[0])
     ;
  cp5.addSlider("beats_ch_1")
     .setPosition(x(2),y(2))     
     .setSize(col_w, row_h*4) 
     .setRange(1,12)
     .setValue(beatsPerMeasure[1])
     ;
  cp5.addSlider("beats_ch_2")
     .setPosition(x(4),y(2))     
     .setSize(col_w, row_h*4) 
     .setRange(1,12)
     .setValue(beatsPerMeasure[2])
     ;
    
            
}

void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("bpm")) {
    t.setTempo(floor(int(theControlEvent.getController().getValue())));
  }
  if(theControlEvent.isFrom("beats_ch_0")) {
    beatsPerMeasure[0] = floor(theControlEvent.getValue());
  }
  if(theControlEvent.isFrom("beats_ch_1")) {
    beatsPerMeasure[1] = floor(theControlEvent.getValue());
  }
  if(theControlEvent.isFrom("beats_ch_2")) {
    beatsPerMeasure[2] = floor(theControlEvent.getValue());
  }
  theControlEvent.getController().setValueLabel(floor(theControlEvent.getValue()) + "");
  
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






