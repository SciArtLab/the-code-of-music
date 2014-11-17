import themidibus.*; 
MidiBus myBus; 


int[] pitches_sequence;
int beatDuration = 60;
int[] durations_sequence;
int[] velocities_sequence;

Markov markov_pitches, markov_durations, markov_velocities;

void setup(){
//  MidiBus.list(); 
  myBus = new MidiBus(this, -1, 1); 
  
//  MidiLoader loader = new MidiLoader("jesu.mid");
  MidiLoader loader = new MidiLoader("taylor_swift-shake_it_off.mid");
  
  
  //get the data in the second track of the midi file
  int track = 3;
  ArrayList<Note> notes = loader.getNotes(track);
  println("notes in track: " + track + " : " + notes.size());
  
  pitches_sequence = new int[notes.size()];
//  durations_sequence = new int[notes.size()];
  velocities_sequence = new int[notes.size()];
  
  for(int i = 0; i < notes.size(); i++){
    pitches_sequence[i] = notes.get(i).pitch;
//    durations_sequence[i] = (int)notes.get(i).duration;
    velocities_sequence[i] = notes.get(i).velocity;
  }
  println(loader.getNotes(2));
  println("PITCHES");
  println(pitches_sequence);
//  println("DURATIONS");
//  println(durations_sequence);
  println("VELOCITIES");
  println(velocities_sequence);
  
  markov_pitches = new Markov(pitches_sequence);
//  markov_durations = new Markov(durations_sequence);
  markov_velocities = new Markov(velocities_sequence);
    
  //step 3: create melody
  int melodyLength = 100; //or maybe measure length
  
  
  
  for(int i = 0; i < melodyLength; i++){
    int pitch = markov_pitches.getNext();
    int channel = 10;
    int velocity = markov_velocities.getNext() * 127;
    int duration = 100;
//    int duration = beatDuration * markov_durations.getNext();
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
