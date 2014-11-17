import themidibus.*;
MidiBus midiBus;


Player p;
int syncopationAmount;
int BPM;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  BPM = 120;
  p = new Player(180);
}

void draw() {
  
}

void onTick(long millis) {  
  if (p.transport.isNewBeat) {
    //instead of using p.transport.isNewBeat and clock.beat (which depend on the time signature),
     //we'll use p.transport.totalBeats.
     //an instrument that is playing at 4/4 (4 beats per measure) will play when p.transport.totalBeats % 4 == 0.
     //an instrument that is playing at 3/4 will play when p.transport.totalBeats % 3 == 0.
     int channel = 0;
     int midiNote;
     int velocity = 100;
     int duration = 800;  
     
     if(p.transport.totalBeats % 4 == 0){
       midiNote = 36;
       velocity = 50;
       p.play(channel, midiNote, velocity, duration, millis);
     }
     if(p.transport.totalBeats % 3 == 0){
       midiNote = 37;
       p.play(channel, midiNote, velocity, duration, millis);
     }
     if(p.transport.totalBeats % 5 == 0){
       midiNote = 42;
       p.play(channel, midiNote, velocity, duration, millis);
     }
    }
}


void exit(){
  p.stopAll();
  super.exit();
}






