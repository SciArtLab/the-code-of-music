import beads.*;
import org.jaudiolibs.beads.*;

class Sequencer{
  float beatLength;
  int bpm; 
  Clock clock;
  int beatsPerMeasure;
  int currentMeasure;
  int currentBeat; 
  float howFarInMeasure;
  AudioContext ac;
  
  Sequencer(){
    ac = new AudioContext();
    bpm = 120;
    
    beatsPerMeasure = 6;
    
    beatLength = 60000.0/bpm;
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
    
    void onClock(Clock c){
    currentBeat = c.getBeatCount() % beatsPerMeasure;
    currentMeasure = c.getBeatCount() / beatsPerMeasure;
    
    //calculate how many ticks are in a measure
    float ticksPerMeasure = beatsPerMeasure * c.getTicksPerBeat();
    //get a number between 0 and 1 to tell us how far we are
    howFarInMeasure = (c.getCount()%ticksPerMeasure)/ticksPerMeasure;
    
  
  
  }
}

