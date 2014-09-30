import beads.*;
import org.jaudiolibs.beads.*;

//the reason to know which measure, beat, and tick we are in is to be able to draw a representation of passing time.
//notice that currentMeasure and currentBeat are class variables (and not local ones). This is so that we can access them from the draw loop.

//let's draw a cycling timeline grid.
float beatLength;

//we'll draw a measure as a rectangle, with subdivisions for beats.
int x, y, w, h;
//add a font for labeling:
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
  x = 10;
  y = 10;
  w = width - 2*x;
  h = height - 2*y;
  
  f = createFont("Helvetica", 10);
  textAlign(TOP, LEFT);
  textFont(f);
}

void draw(){
  background(0);
  //first, let's draw our grid
  noFill();
  stroke(200);
  rect(x, y, w, h);
  //for each measure, we draw a vertical line
  for(int i = 0; i < beatsPerMeasure; i++){
      int beatWidth = w/beatsPerMeasure;
      line(x + i*beatWidth, y + 0, x + i*beatWidth,  y + h);
      //now let's label them:
      text(currentMeasure + "." + i, x + i*beatWidth, y - 2);
      text(beatLength*i + "ms", x + i*beatWidth, h + y + 10);
      
    }
}

void onClock(Clock c){
  currentBeat = c.getBeatCount() % beatsPerMeasure;
  currentMeasure = c.getBeatCount() / beatsPerMeasure;
  
  
  
  
}




