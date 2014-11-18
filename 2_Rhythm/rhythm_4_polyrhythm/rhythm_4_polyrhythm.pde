import themidibus.*;
MidiBus midiBus;

//This sends midiNotes to drum kits: 35 is bass drum, 38 a snare, 42 a closed hi-hat

Score s;
Transport t;
int syncopationAmount;
int BPM;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  BPM = 400;
  s = new Score();
  t = new Transport(BPM);
  t.setListener(s);
}

void draw() {
  
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
     
     if(t.beats % 7 == 0){
       channel = 0;
       midiNote = 35;
       velocity = 50;
       s.add(channel, midiNote, velocity, duration, millis);
     }
     if(t.beats % 5 == 0){
       channel = 1;
       midiNote = 38;
       s.add(channel, midiNote, velocity, duration, millis);
     }
     if(t.beats % 8 == 0){
       channel = 2;
       midiNote = 42;
       s.add(channel, midiNote, velocity, duration, millis);
     }
    }
}


//remember to quit using X button on app window
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}







