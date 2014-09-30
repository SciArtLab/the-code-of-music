import beads.*;
import org.jaudiolibs.beads.*;

float beatLength;

//instead of rectangle x,y,w and h, we need a radius for the sequencer
int seqRadius;
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
  
  //interface
  size(400, 400);
  seqRadius = 100;
  f = createFont("Helvetica", 10);
  textAlign(TOP, LEFT);
  textFont(f);
}

void draw(){
  background(50);
  
  pushMatrix();
  translate(width/2, height/2);
  stroke(100);
  noFill();
  ellipse(0, 0, seqRadius*2, seqRadius*2);
  
  float beatAngle = TWO_PI/(float)beatsPerMeasure;
  
  //draw grid lines
  for(int i = 0; i < beatsPerMeasure; i++){
    stroke(100);  
    //find out the position of the current beat in polar coordinates: (angle, radius)
    //the radius is the same for all beats: seqRadius. let's calculate the angle:    
    float curBeatAngle = beatAngle * i;
    
    //now let's find the cartesian coordinates for those polar positions, 
    //to be able to draw them in Processing's coordinate system.
    float beat_x = cos(curBeatAngle) * seqRadius;
    float beat_y = sin(curBeatAngle) * seqRadius;
    
    line(0, 0, beat_x, beat_y);
    
    //add labels to the beat divisions.
    //we're multiplying (beat_x, beat_y) by 1.2 to scale that vector (making it 20% longer)
    //in order to offset the text.
    text(currentMeasure + "." + i, beat_x *1.2, beat_y * 1.2);
//    text(beatLength*i/1000 + "s", beat_x, beat_y ); 
    
    //hightlight current beat
    if(i == currentBeat){
      fill(200);
      noStroke();

      arc(0, 0, seqRadius*2, seqRadius*2, curBeatAngle, curBeatAngle + beatAngle);
//    uncomment this line for a circle indicator (instead of an arc)
//    ellipse(beat_x * 0.9, beat_y * 0.9, 10, 10);      
    }
    
    
  }
  //draw playhead
  stroke(219, 38, 118);
  float playheadPos = map((float)howFarInMeasure, 0, 1, 0, TWO_PI);
  line(0, 0, cos(playheadPos)*seqRadius, sin(playheadPos)*seqRadius);
  
  
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




