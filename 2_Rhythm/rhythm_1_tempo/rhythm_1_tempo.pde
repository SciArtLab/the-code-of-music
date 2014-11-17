import themidibus.*;
MidiBus midiBus;
//Tempo is usually expressed in 'beats per minute', or BPM.
//In the previous examples, we were setting a certain length for the clock's beat (200ms)
//Now let's set a BPM, and have the Clock's constructor determine the beat length based on it:
// 1 beat = 1 / BPM *60*1000

//Try changing the tempo by moving the mouse over the sketch window.

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
  p = new Player(BPM);
}

void draw() {
  
}

void onTick(long millis) {
  if (p.transport.isNewBeat) {
    int midiNote = floor(random(0, 127));
    int duration = 200;  
    int velocity = 120;  
    int channel = 0;
    
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






