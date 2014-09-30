import beads.*;
import org.jaudiolibs.beads.*;

float beatLength;

int x, y, w, h;
PFont f;

int bpm; 
Clock clock;
int beatsPerMeasure;

int currentMeasure;
int currentBeat; 
float howFarInMeasure;


AudioContext ac;

void setup(){
  
  ac = new AudioContext();
  bpm = 120;
  
  beatsPerMeasure = 4;
  
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
  
  //interface
  size(400, 200);
  x = 20;
  y = 20;
  w = width - 40;
  h = height - 40;
  f = createFont("Helvetica", 10);
  textAlign(TOP, LEFT);
  textFont(f);
}

void draw(){
  background(50);
  
  pushMatrix();
  translate(x, y);
  
  noFill();
  stroke(100);
  rect(0, 0, w, h);
  
  float beatWidth = w/(float)beatsPerMeasure;
  
  //draw grid lines
  for(int i = 0; i < beatsPerMeasure; i++){
      stroke(100);
      float beatPos = beatWidth * i;
      line(beatPos, 0, beatPos,  h);
      
      //now let's label them:
      text(currentMeasure + "." + i, beatPos, -2);
      text(beatLength*i/1000 + "s", beatPos, h + 10); 
 
      //highlight current beat       
      if(i == currentBeat){
        fill(200);
        noStroke();
        float currentBeat_x = currentBeat * beatWidth;
        rect(currentBeat_x, 0, beatWidth, h);  
      }
       
  }   
  
  //draw playhead
  //see how 'howFarInMeasure' (a number between 0 and 1) is calculated in the onClock function below.
  stroke(219, 38, 118);
  float playheadPos = map((float)howFarInMeasure, 0, 1, 0, w);
  line(playheadPos, 0, playheadPos, h);
  
  popMatrix();
    
    
}

void onClock(Clock c){
  currentBeat = c.getBeatCount() % beatsPerMeasure;
  currentMeasure = c.getBeatCount() / beatsPerMeasure;
  
  //calculate how many ticks are in a measure
  float ticksPerMeasure = beatsPerMeasure * c.getTicksPerBeat();
  //get a number between 0 and 1 to tell us how far we are
  howFarInMeasure = (c.getCount()%ticksPerMeasure)/ticksPerMeasure;
  
  
  
}




