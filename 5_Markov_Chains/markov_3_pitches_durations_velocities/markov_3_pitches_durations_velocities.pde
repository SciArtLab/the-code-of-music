import themidibus.*; 
MidiBus myBus; 


int[] pitches_sequence = {61, 79, 77, 74, 60, 61, 77, 77, 60, 61};
int beatDuration = 100;
int[] durations_sequence = {1, 2, 1, 1, 1, 2, 4, 3, 1};
int[] velocities_sequence = {40, 100, 50, 10, 10, 10, 20, 30, 10};

Markov markov_pitches, markov_durations, markov_velocities;

void setup(){
  MidiBus.list(); 
  myBus = new MidiBus(this, -1, 1); 
  
  markov_pitches = new Markov(pitches_sequence);
  markov_durations = new Markov(durations_sequence);
  markov_velocities = new Markov(velocities_sequence);
    
  //step 3: create melody
  int melodyLength = 100; //or maybe measure length
  
  for(int i = 0; i < melodyLength; i++){
    int pitch = markov_pitches.getNext();
    int channel = 10;
    int velocity = markov_velocities.getNext() * 127;
    int duration = beatDuration * markov_durations.getNext();
    myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
    delay(duration);
    myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff  
  }
    
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

  

void draw(){
  

}
