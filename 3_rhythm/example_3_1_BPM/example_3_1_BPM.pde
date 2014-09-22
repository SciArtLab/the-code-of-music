import beads.*;
import java.util.Arrays; 

AudioContext ac;
int pitch;
boolean isBeat;
int beatsPerMeasure;
float beatLength;

int BPM;

WavePlayer wp;
Gain g 

void setup(){  
  ac = new AudioContext();
  BPM = 120;
  beatsPerMeasure = 3;
  beatLength = 1.0/BPM*60*1000;
  Clock clock = new Clock(ac, beatLength);
  
  clock.addMessageListener(
  new Bead() {    
     public void messageReceived(Bead message) { //This is equivalent to 'onBeat' in our previous example
        Clock c = (Clock)message;
          onClock(c);
       }
     }
   
 ); 
 ac.out.addDependent(clock);
 ac.start();

}

void draw(){
  if(isBeat){
    background(0);
    int side = (int)random(10, 40);
    int x = (int)random(0, width);
    int y = (int)map(pitch, 60, 70, height, 0);
    rect(x, y, side, side);
    isBeat = false;
  }
  
  
}

void onClock(Clock c){ 
  if(c.isBeat()) {      
    pitch = Pitch.forceToScale((int)random(60, 70), Pitch.dorian, 12);
    float freq = Pitch.mtof(pitch);
    WavePlayer wp = new WavePlayer(ac, freq, Buffer.SINE);
    Gain g = new Gain(ac, 1, new Envelope(ac, 0));
    g.addInput(wp);
    ac.out.addInput(g);
    ((Envelope)g.getGainEnvelope()).addSegment(0.1, 100);
    ((Envelope)g.getGainEnvelope()).addSegment(0.1, beatLength - 200);
    ((Envelope)g.getGainEnvelope()).addSegment(0, 100, new KillTrigger(g));
    isBeat = true;
  }
  
  
  
  
}

