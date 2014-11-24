import controlP5.*;
import themidibus.*;

MidiBus midiBus; 
ControlP5 cp5;
Range frequencyRange, velocityRange;

int frequencyMin = 100;
int frequencyMax = 2000;

int velocityMin = 0;
int velocityMax = 127;


void setup() {
  size(700, 400);
  colorMode(HSB, 360, 100, 100);
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  
  cp5 = new ControlP5(this);
  frequencyRange = cp5.addRange("frequency_range")
             // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setPosition(50,50)
             .setSize(400,40)
             .setHandleSize(20)
             .setRange(0,2000)
             .setRangeValues(0,255)
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
             .setRange(20,127)
             .setRangeValues(0,100)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true) 
             .setColorForeground(color(340, 100, 100))
             .setColorBackground(color(0, 0, 30));
  
}

void draw() {  
  background(0);
  double frequency = floor(random(frequencyMin, frequencyMax));    
  int duration = 80; //note that in this example we're using delay; if you want to vary the duration, integrate it with the transport + score classes
  int velocity = floor(random(velocityMin, velocityMax));
  sendNoteOn(0, frequency, velocity, duration);
  
  
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void sendNoteOn(int channel, double frequency, int velocity, int duration) {
  //Convert from any frequency to pitch (to the nearest note and how far it is from it, which can be sent  
  //through MIDI by using the 'pitch wheel' value. Although the resolution is much lower than that of a double, 
  //the difference in frequencies it supports is under the human perception threshold.

  //See an explanation of this calculation at http://newt.phys.unsw.edu.au/jw/notes.html
  //C0 requency = 16.3515978312876
  double totalCents = 1200.0 * Math.log(frequency / 16.3515978312876) / Math.log(2);//calculate octaves over C0
  double octave = Math.round(totalCents / 1200d);//integer part of octaves 
  double semitoneCents = totalCents - (octave * 1200d);//calculate semitones
  double semitone = Math.round(semitoneCents / 100d);//integer part of semitones
  double cents = Math.round(semitoneCents - (semitone * 100d));//calculate cents
  
  double note = (octave * 12d) + semitone;
  if (note > 127) {
      note = 127;
  }
  
  if(cents < 0){
    note --;
    cents = 100 + cents;
  }
  double bend = map((float)cents, 0f, 100f, 0, 8192f);
  //we will send this bend value as a 'pitch wheel' message, 
  //and then a 'note on' message with the value of the 'note' variable.
  
  int status_byte = 0xE0; // The code for the Pitch Wheel
  int channel_byte = 0; // On channel 0 again
  
  //send pitch wheel back to its original value:
  int LSB = 8192 % 128;  //least significant byte
  int MSB = 8192 / 128; //most significant byte  
  midiBus.sendMessage(status_byte, channel_byte, 0x00, 0x40);
  
  long wheel = (int)bend;
  int roundedBend = (int)Math.ceil(bend);
   LSB = roundedBend % 128;  //least significant byte
   MSB = roundedBend / 128; //most significant byte
  
  midiBus.sendMessage(status_byte, channel_byte, LSB, MSB);
  // The two bytes of the pitch bend message form a 14 bit number, 0 to
  // 16383.
  // The value 8192 (sent, LSB first, as 0x00 0x40), is centered, or
  // "no pitch bend."
  // The value 0 (0x00 0x00) means, "bend as low as possible," and,
  // similarly, 16383 (0x7F 0x7F) is to "bend as high as possible."
  // The exact range of the pitch bend is specific to the synthesizer.
  
  midiBus.sendNoteOn(channel, (int)note, velocity);
  delay(200);
  midiBus.sendNoteOff(channel, (int)note, velocity);
  
  
}

void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("frequency_range")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    frequencyMin = 10 * int(theControlEvent.getController().getArrayValue(0));
    frequencyMax = 10 * int(theControlEvent.getController().getArrayValue(1));
  }
  if(theControlEvent.isFrom("velocity_range")) {
    velocityMin = int(theControlEvent.getController().getArrayValue(0));
    velocityMax = int(theControlEvent.getController().getArrayValue(1));
  }
  
}
