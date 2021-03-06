import themidibus.*;
import controlP5.*;

MidiBus midiBus; 
ControlP5 cp5;
RadioButton r;

//int root = 60; //middle C
int root = 70; // D
int[] scale = {0, 1, 1, 4, 5, 8, 10};
int octaveRange = 1;

final int[] CHROMATIC_SCALE = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},
 MAJOR_SCALE = {0, 2, 4, 5, 7, 9, 11},
 MINOR_SCALE = {0, 2, 3, 5, 7, 8, 10},
 DORIAN_SCALE = {0, 2, 3, 5, 7, 9, 10},
 LYDIAN_SCALE = {0, 2, 4, 6, 7, 9, 11},
 MIXOLYDIAN_SCALE = {0, 2, 4, 5, 7, 9, 10},
 PENTATONIC_SCALE = {0, 2, 4, 7, 9},
 BLUES_SCALE = {0, 2, 3, 4, 5, 7, 9, 10, 11};
 
 int[][] scales = {MAJOR_SCALE, 
                   MINOR_SCALE,  
                   DORIAN_SCALE, 
                   LYDIAN_SCALE, 
                   MIXOLYDIAN_SCALE, 
                   PENTATONIC_SCALE, 
                   BLUES_SCALE};
int pos;

void setup() {
  background(0);
  size(800, 400);
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  cp5 = new ControlP5(this);
  cp5.addSlider("root_slider")
     .setSize(40*8,10)
     .setRange(0,127)
     ;
     
  r = cp5.addRadioButton("radio_scale")
         .setPosition(20,80)
         .setSize(40,20)
         .setColorForeground(color(120))
         .setColorActive(color(255, 0 ,0))
         .setColorLabel(color(0))
         .setItemsPerRow(8)
         .setSpacingColumn(50)
         .addItem("Major",0)
         .addItem("Minor / Aeolian",1)
         .addItem("Dorian",2)
         .addItem("Lydian",3)
         .addItem("Mixolydian",4)
         .addItem("Pentatonic",5)
         .addItem("Blues",6)
         ;
         
   cp5.addSlider("octave_range_slider")
     .setSize(40*8,10)
     .setPosition(20, 160)
     .setRange(1,8)
     ;
 
   for(Toggle t:r.getItems()) {
     t.captionLabel().setColorBackground(color(255,80));
     t.captionLabel().style().moveMargin(-7,0,0,-3);
     t.captionLabel().style().movePadding(7,0,0,3);
     t.captionLabel().style().backgroundWidth = 45;
     t.captionLabel().style().backgroundHeight = 13;
   }
   
   
}

void draw() {
  int posInScale = pos % scale.length; //is it the tonic, second, third... seventh?
  int octave = pos / scale.length; 
  //now to get a note in the scale, we add the root to its respective interval. 
  int note = root + scale[posInScale] + 12*octave;
  pos = (pos + 1) % (scale.length*octaveRange); //let's span 4 octaves, then go back to 0
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



void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("root_slider")) {
    root = round(int(theControlEvent.getController().getValue()));
    theControlEvent.getController().setValueLabel(root + "");
    pos = 0;
  }
  if(theControlEvent.isFrom("octave_range_slider")) {
    octaveRange = round(int(theControlEvent.getController().getValue()));
    theControlEvent.getController().setValueLabel(octaveRange + "");
  }
  if(theControlEvent.isFrom("radio_scale")) {
    int scalePos =int(theControlEvent.getValue());
    scale = scales[scalePos];
    pos = 0;
  }
  
}


