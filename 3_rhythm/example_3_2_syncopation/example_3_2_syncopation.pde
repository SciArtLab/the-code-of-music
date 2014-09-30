import beads.*;
import java.util.Arrays; 

AudioContext ac;
int pitch;

int BPM; //beats per minute
int beatsPerMeasure;
int beatBaseLength;
float beatLength;
int currentMeasure;
int currentBeat; 
Clock clock;
long lastBeat;

boolean isBeat;
float playheadPos;

//interface
PFont f;
int x, y, w, h;

void setup(){  
  //audio
  ac = new AudioContext();
  BPM = 120;
  beatsPerMeasure = 4;//numerator of time signature
  beatBaseLength = 8;//denominator of time signature
  beatLength = 1.0/BPM*60*1000;
  
  clock = new Clock(ac, beatLength);
  clock.setClick(true);
  clock.addMessageListener(
  new Bead() {   
     public void messageReceived(Bead message) { 
        Clock c = (Clock)message;
          onClock(c);
       }
     }
 ); 
 ac.out.addDependent(clock);
 ac.start();
 
 //interface
  size(400, 200);
  x = 20;
  y = 20;
  w = width - 40;
  h = height - 40;
 
  f = createFont("Helvetica", 10);
  textFont(f);
  textAlign(LEFT, BOTTOM);
  
  

}

void draw(){
  background(100);
  noFill();
  
  stroke(0);
  rect(x, y, w, h);
  for(int i = 0; i < beatsPerMeasure; i++){
    int beatLength = (w)/beatsPerMeasure;
    line(x + i*beatLength, y + 0, x + i*beatLength,  y + h);
    text(currentMeasure + "." + i, x + i*beatLength, y);
    text(beatLength*i + "ms", x + i*beatLength, height - 5);
  }
  
  //highlight current beat
  fill(200);
  float currentBeat_x = x + currentBeat * w/(float)beatsPerMeasure;
  rect(currentBeat_x, y + 0, w/beatsPerMeasure, h);
  
  //playhead
  double howFarInMeasure = clock.getSubTickNow() % (beatsPerMeasure*clock.getTicksPerBeat());
  playheadPos = map((float)howFarInMeasure, 0, beatsPerMeasure*clock.getTicksPerBeat(), 0, w);
  line(x + playheadPos, y + 0, x + playheadPos, y + h);
  
}

void onClock(Clock c){ 
    if(c.isBeat()) {
      lastBeat = c.getCount();
      currentMeasure = c.getBeatCount() / beatsPerMeasure;
      currentBeat = c.getBeatCount() % beatsPerMeasure;
      println(currentMeasure + "." + currentBeat);
    }
//lag behind
    if(c.getCount() == lastBeat + 5)
//anticipate
//    if(c.getCount() == lastBeat + c.getTicksPerBeat() - 5)
//random
//    if(c.getCount() == lastBeat + (int)random(-c.getTicksPerBeat()/8, c.getTicksPerBeat()/8))
    {
      Noise n = new Noise(ac);
       Gain g2 = new Gain(ac, 1, new Envelope(ac, 0.05));
       g2.addInput(n);
       ac.out.addInput(g2);
       ((Envelope)g2.getGainEnvelope()).addSegment(0, 100, new KillTrigger(g2));
    }

  
}

