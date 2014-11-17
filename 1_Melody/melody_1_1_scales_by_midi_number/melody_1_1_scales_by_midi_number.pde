import themidibus.*;

MidiBus midiBus; 
//int [] scale = {60, 62, 64, 65, 67, 69, 71};//C major
int [] scale = {62, 64, 66, 67, 69, 71, 73};//D major

int pos;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  
}

void draw() {
  int posInScale = pos % scale.length; //is it the tonic, second, third... seventh?
  int octave = pos / scale.length;  
  int note = scale[posInScale] + 12*octave;
  pos = (pos + 1);
  
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


