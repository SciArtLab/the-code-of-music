import beads.*;
import java.util.Arrays; 

AudioContext ac;
boolean isBeat;
float freq;
float scale[];

WavePlayer wp;
Gain g;

void setup(){  
  ac = new AudioContext();
  Clock clock = new Clock(ac, 500);
  scale = new float[5];
  for(int i = 0; i < 5; i++){    
    scale[i] = random(130, 3000);
    
    
  }
  wp = new WavePlayer(ac, freq, Buffer.SINE);
  
  clock.addMessageListener(
  //this is the on-the-fly bead
  new Bead() {
    //this is the method that we override to make the Bead do something
    
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
  if(isBeat){
    background(0);
    int side = (int)random(10, 40);
    int x = (int)random(0, width);
    int y = (int)map(freq, 60, 70, height, 0);
    rect(x, y, side, side);
    isBeat = false;
  }
  
}

void onBeat(){    
  int pos = (int)random(0, 5);
  float freq = scale[pos];
  //  WavePlayer wp = new WavePlayer(ac, freq, Buffer.SINE);
  wp.setFrequency(freq);
  g = new Gain(ac, 1, new Envelope(ac, 0));
  g.addInput(wp);
  ac.out.addInput(g);
  ((Envelope)g.getGainEnvelope()).addSegment(0.1, 200);
  ((Envelope)g.getGainEnvelope()).addSegment(0, 600);
  
  isBeat = true;
  
  
}

