import themidibus.*;
MidiBus midiBus;
//TIME SIGNATURE
//Our Transport will now keep track the current measure, the current beat, and the current subdivision.
//We'll control our time signature by setting the number of beats in a measure.

Player p;

int BPM;
//in case you're curious:
final int 
  GRAVE = 40,
  LARGO = 45,
  LARGHETTO = 50,
  LENTO = 55,
  ADAGIO = 60,
  ADAGIETTO = 65,
  ANDANTE = 70,
  ANDANTINO = 80,
  MODERATO = 95,
  ALLEGRETTO = 110,
  ALLEGRO = 120,
  VIVACE = 145,
  PRESTO = 180,
  PRETISSIMO = 220;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  int BPM = 120;
  p = new Player(PRESTO);
}

void draw() {
  
}

void onTick(long millis) {
  println(p.transport.measure() + " : " +  p.transport.beat());
  if (p.transport.isNewBeat) {
    int channel = 0;
    int[] notes = {60, 62, 65, 67};
    int beat = p.transport.beat();
    int midiNote = notes[beat];//one note per beat
    int velocity = 100;
    //make the second and third notes longer
    int duration = 12;
    
    if(beat == 1){
      duration = 48;
    }
    if(beat == 3){
      duration = 96;
    }
    p.play(channel, midiNote, velocity, duration, millis);
    
  }
}

void mouseMoved(){
  int tempo = floor(map(mouseX, 0, height, 20, 500));
  p.transport.setTempo(tempo);
  println("tempo: " + tempo + " BPM");
}

void exit(){
  p.stopAll();
  super.exit();
}






