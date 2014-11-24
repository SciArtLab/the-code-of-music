import controlP5.*;
import themidibus.*;

MidiBus midiBus; 
ControlP5 cp5;
Range noteRange, velocityRange;

int noteMin = 0;
int noteMax = 127;

int velocityMin = 0;
int velocityMax = 127;

void setup() {
  size(700, 400);
  background(0);
  colorMode(HSB, 360, 100, 100);
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  
  cp5 = new ControlP5(this);
  noteRange = cp5.addRange("note_range")
             // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setPosition(50,50)
             .setSize(400,40)
             .setHandleSize(20)
             .setRange(0,127)
             .setRangeValues(0,60)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true) 
             .setColorForeground(color(340, 100, 100))
             .setColorBackground(color(0, 0, 30));
  velocityRange = cp5.addRange("velocity_range")
             // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setPosition(50,100)
             .setSize(400,40)
             .setHandleSize(20)
             .setRange(0,127)
             .setRangeValues(30,60)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true) 
             .setColorForeground(color(340, 100, 100))
             .setColorBackground(color(0, 0, 30));
  
}

void draw() {
  int channel; 
  int note = floor(random(noteMin, noteMax));  
  int velocity = floor(random(velocityMin, velocityMax));
  midiBus.sendNoteOn(0, note, velocity);
  delay(200);
  midiBus.sendNoteOff(0, note, velocity);
  println(velocity);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("note_range")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    noteMin = int(theControlEvent.getController().getArrayValue(0));
    noteMax = int(theControlEvent.getController().getArrayValue(1));
  }
  if(theControlEvent.isFrom("velocity_range")) {
    velocityMin = int(theControlEvent.getController().getArrayValue(0));
    velocityMax = int(theControlEvent.getController().getArrayValue(1));
  }
  
}
