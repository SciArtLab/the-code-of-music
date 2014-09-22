import beads.*;
import java.util.Arrays; 

AudioContext ac;
int pitch;

int BPM; //beats per minute
int beatsPerMeasure;
int currentMeasure;
int currentBeat; 

boolean isBeat;

void setup(){  
  size(400, 200);
  ac = new AudioContext();
  BPM = 120;
  beatsPerMeasure = 4;
  float beatLength = 1.0/BPM*60*1000;
  
  Clock clock = new Clock(ac, beatLength);
  clock.setClick(true);
  clock.addMessageListener(
  //this is the on-the-fly bead
  new Bead() {   
     public void messageReceived(Bead message) { 
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
  if(c.isBeat()) {      
    int posInMeasure = c.getBeatCount() % beatsPerMeasure;
    if( posInMeasure == 0){ 
       Noise n = new Noise(ac);
       Gain g2 = new Gain(ac, 1, new Envelope(ac, 0.05));
       g2.addInput(n);
       ac.out.addInput(g2);
       ((Envelope)g2.getGainEnvelope()).addSegment(0, 100, new KillTrigger(g2));
    }
    currentMeasure = c.getBeatCount() / beatsPerMeasure;
    currentBeat = c.getBeatCount() % beatsPerMeasure;
    println(currentMeasure + "." + currentBeat);
  }
  
  
  
  
}

