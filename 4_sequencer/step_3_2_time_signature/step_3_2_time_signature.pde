import beads.*;
import org.jaudiolibs.beads.*;

//now let's add a time signature. this will allow us to play with rhythm.

int bpm; 
Clock clock;
//let's define how we want to group our beats –in 2's? 3's? 4's?
//whatever the number, we'll call our group of beats 'measure', or 'bar'.
int beatsPerMeasure;

int currentMeasure;
int currentBeat; 


AudioContext ac;

void setup(){
  
  ac = new AudioContext();
  bpm = 120;
  
  //let's say we'd like 4 beats per measure
  beatsPerMeasure = 4;
  
  float beatLength = 60000.0/bpm;
  clock = new Clock(ac, beatLength); 
  clock.setClick(true); 
  clock.addMessageListener(
    new Bead(){
      public void messageReceived(Bead message){
        Clock c = (Clock)message;
        onClock(c);
      }
    }
  );
  ac.out.addDependent(clock);
  ac.start();
}

void draw(){

}

void onClock(Clock c){
  //now, when the clock ticks, if I'm on a beat, I'd like to know which one: the first, second, third in my measure?
  //maybe I'd like to have a bass play a note on every first beat.
  //the Clock class has a getBeatCount() function. 
  //If I'm on beat 5, and I have 4 beats per measure, I'm on the 1st beat of the 2nd measure.
  //5 / 2 = 2 (2nd measure); 5 % 2 = 1 (1st beat)
  currentBeat = c.getBeatCount() % beatsPerMeasure;
  currentMeasure = c.getBeatCount() / beatsPerMeasure;
  
  //there's further subdivision: getCount() returns the current Tick.
  println(currentMeasure + "." + currentBeat + "." + c.getCount()%c.getTicksPerBeat());
  
  
}




