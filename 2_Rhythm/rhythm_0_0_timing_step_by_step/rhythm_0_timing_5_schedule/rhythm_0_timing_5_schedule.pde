import themidibus.*;
MidiBus midiBus;

//A more general approach is to have a Player class (which could evolve to a more general Score for any kind of event), 
//that schedules a noteOff message whenever a noteOn is sent.
//Since our Clock has more functionality now, handling BPM and beats and measures, let's call it 'Transport'.


Player p;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  p = new Player();
}

void draw() {
}

void onTick(long millis) {
  if (p.transport.isNewBeat) {
    int channel = 0;
    int pitch = floor(random(10, 120));
    
    int velocity = 120;
    int q = 24; //a quarter note has 24 ticks 
    int duration = floor(random(q/8f, q*8));
    
    p.play(channel, pitch, velocity, duration, millis);
  }
}






