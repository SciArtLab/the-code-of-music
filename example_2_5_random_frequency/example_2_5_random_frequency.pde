import beads.*;
import java.util.Arrays; 

AudioContext ac;



void setup(){  
  ac = new AudioContext();
  Clock clock = new Clock(ac, 500);
  
  
  clock.addMessageListener(
  //this is the on-the-fly bead
  new Bead() {
    //this is the method that we override to make the Bead do something
    int pitch;
     public void messageReceived(Bead message) { //This is equivalent to 'onBeat' in our previous example
        Clock c = (Clock)message;
        if(c.isBeat()) {           
          onBeat();
       }
     }
   }
 );
 
 ac.out.addDependent(clock);
 ac.start();

}

void draw(){
  
}

void onBeat(){    
  float freq = random(27,3000);
  
  WavePlayer wp = new WavePlayer(ac, freq, Buffer.SINE);
  Gain g = new Gain(ac, 1, new Envelope(ac, 0));
  g.addInput(wp);
  ac.out.addInput(g);
  ((Envelope)g.getGainEnvelope()).addSegment(0.1, 100);
  ((Envelope)g.getGainEnvelope()).addSegment(0, 100);
  
}

