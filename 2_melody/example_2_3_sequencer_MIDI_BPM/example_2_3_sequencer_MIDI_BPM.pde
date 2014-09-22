import themidibus.*;
MidiBus myBus;

int lastBeat;
float beatLength;
int BPM;

void setup(){
  lastBeat = millis();
  BPM = 120;
  beatLength = 1.0/BPM*60*1000;
  
  MidiBus.list();
  myBus = new MidiBus(this, -1, 1);

}

void draw(){
  if(millis() - lastBeat > beatLength){
    lastBeat = millis();
    onBeat();
  }
}

void onBeat(){  
  Note note = new Note(0, 60, 127);
  print("'");
  myBus.sendNoteOn(note);
  delay(400);
  myBus.sendNoteOff(note); 

}

void exit(){
  println("stop");
  for(int i = 0; i < 127; i++){
    myBus.sendNoteOff(new Note(0, i, 0));
  }
  super.exit();
}
