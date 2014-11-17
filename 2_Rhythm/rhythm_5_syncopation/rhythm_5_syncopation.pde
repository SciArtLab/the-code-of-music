import themidibus.*;
MidiBus midiBus;
//Syncopation example or 'swing'
//Move the mouse to change the amount: to the left it approaches zero, 
//to the right it approaches two beats

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
    p.transport.syncopation = floor(random(-syncopationAmount, syncopationAmount));
    
    int channel = 0;
    int[] notes = {60, 62, 65, 67};
    int beat = p.transport.beat();
    int midiNote = notes[beat];//one note per beat
    
    int duration = 24;
    
    //accent the first and third beat of every measure.
    int velocity = 40;
    if(beat == 1){
      velocity = 110;
    }
    if(beat == 3){
      velocity = 60;
    }
    p.play(channel, midiNote, velocity, duration, millis);
    
  }
}

void mouseMoved(){
  syncopationAmount = floor(map(mouseX, 0, width, 0, p.transport.beatLength/2));
  println("syncopation amount: " + syncopationAmount);
 
}

void exit(){
  p.stopAll();
  super.exit();
}






