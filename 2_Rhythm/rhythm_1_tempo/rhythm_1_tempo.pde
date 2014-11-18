import themidibus.*;
MidiBus midiBus;
//Tempo is usually expressed in 'beats per minute', or BPM.
//In the previous examples, we were setting a certain length for the clock's beat (200ms)
//Now let's set a BPM, and have the Clock's constructor determine the beat length based on it:
// 1 beat = 1 / BPM *60*1000

//Try changing the tempo by moving the mouse over the sketch window.

Score s;
Transport t;

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
  int BPM = 240;
  s = new Score();
  t = new Transport(BPM);
  t.setListener(s);
}

void draw() {
  
}

void onTick(long now) {
  if(t.newBeat()) {
    int midiNote = floor(random(0, 127));
    int duration = t.toTicks(0.5);  //a half note
    int velocity = 120;  
    int channel = 0;
    
    s.add(channel, midiNote, velocity, duration, now);
    
  }
}

void mouseMoved(){
  int tempo = floor(map(mouseX, 0, height, 20, 500));
  t.setTempo(tempo);
  println("tempo: " + tempo + " BPM");
}

//to avoid lingering notes, quit your sketch by hiting the X button in the window.
//(otherwise Processing doesn't seem to call the 'exit' function)
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}






