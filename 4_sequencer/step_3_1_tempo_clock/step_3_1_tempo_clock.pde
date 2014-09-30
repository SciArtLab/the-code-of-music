import beads.*;
import org.jaudiolibs.beads.*;

//Let's create our time grid. 
//We want to set a tempo, and we want a clock to tick at that rate.
int bpm; 
Clock clock;
//Because we are using Beads' clock (it runs on a different thread), we need a Beads' AudioContext object
AudioContext ac;

void setup(){
  //Creating the AudioContext object: 
  ac = new AudioContext();
  
  //Let's say we'd like to have 120 beats per minute (BPM is the usual measure of tempo in music software)
  bpm = 120;
  
  //if we have 120 beats in one minute, that means 120 beats in 60.0000ms
  //therefore, each one of them lasts 500ms (60000/120)
  float beatLength = 60000.0/bpm;
  
  //now we can create our clock, that will have a beat every 500ms.
  clock = new Clock(ac, beatLength); 
  //to hear it tick, setClick to true.
  clock.setClick(true); 
  
  //tell the clock to call our 'onClock' function each time it ticks. 
  //By default, it will tick 16 times per beat.
  clock.addMessageListener(
    new Bead(){
      public void messageReceived(Bead message){
        Clock c = (Clock)message;
        onClock(c);
      }
    }
  );
  //connect the clock to the audio out
  ac.out.addDependent(clock);
  //start beads
  ac.start();
}

void draw(){

}

void onClock(Clock c){
  
  if(c.isBeat()){
    println("tick");
  }
  else{
    println("tac");
  }
}




