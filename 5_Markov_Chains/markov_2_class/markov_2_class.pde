import themidibus.*; 
MidiBus myBus; 

int[] raw_sequence = {64,62,60,62,64,67};
Markov markov;

void setup(){
  MidiBus.list(); 
  myBus = new MidiBus(this, -1, 1); 
  
  markov = new Markov(raw_sequence);
    
  //step 3: create melody
  int melodyLength = 100; //or maybe measure length
  
  for(int i = 0; i < melodyLength; i++){
    int pitch = markov.getNext();
    int channel = 0;
    int velocity = 127;
    myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
    delay(200);
    myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff  
  }
    
}




void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

  

void draw(){
  

}
