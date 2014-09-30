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
  background(0);

  noFill();
  stroke(100);
  rect(x, y, w, h);
  
  float beatWidth = w/(float)beatsPerMeasure;
  
  //highlight current beat
  pushMatrix();
  //translate to the position of the grid
  translate(x, y);
  fill(200);
  float currentBeat_x = currentBeat * beatWidth;
  rect(currentBeat_x, 0, beatWidth, h);
  
  //for each measure, we draw a vertical line
  for(int i = 0; i < beatsPerMeasure; i++){
      float beatPos = i*beatWidth;
      line(beatPos, 0, beatPos,  h);
      //now let's label them:
      text(currentMeasure + "." + i, beatPos, -2);
      text(beatLength*i + "ms", beatPos, h + 10);      
    }
    popMatrix();
    
}

void onClock(Clock c){
  currentBeat = c.getBeatCount() % beatsPerMeasure;
  currentMeasure = c.getBeatCount() / beatsPerMeasure;
  
  
  
}




