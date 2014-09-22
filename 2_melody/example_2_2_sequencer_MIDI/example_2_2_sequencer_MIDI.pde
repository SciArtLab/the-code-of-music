import themidibus.*;
MidiBus myBus;

int lastBeat;
float beatLength;

void setup(){
  lastBeat = millis();
  beatLength = 500;
  
  MidiBus.list();
  myBus = new MidiBus(this, -1, 2);

}

void draw(){
  if(millis() - lastBeat > beatLength){
    lastBeat = millis();
    onBeat();
  }

}

void onBeat(){  
  int midiNote = (int)random(0, 127);
  
  Note note = new Note(0, midiNote, 127);  
  myBus.sendNoteOn(note);
  delay(400);  //this is an initial, dirty way of doing this!
  myBus.sendNoteOff(note); 

}

void exit(){
  println("stop");
  for(int i = 0; i < 127; i++){
    myBus.sendNoteOff(new Note(0, i, 0));
  }
  super.exit();
}
