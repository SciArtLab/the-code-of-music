import beads.*;
import org.jaudiolibs.beads.*;



/*
Let's look into the code. There are two groups of functionality: sequencing, and drawing 
a representation of our sequencer. Let's extract the sequencing functionality to a different class.
In the code below, I've separated sequencing and drawing by using comments.

*/

////////////////SEQUENCING////////////////
AudioContext ac;
int bpm; 
Clock clock;
int beatsPerMeasure;
//variables that can be calculated using the above, but that are used to draw the sequencer.
float beatLength;
int currentMeasure;
int currentBeat; 
float howFarInMeasure;

////////////////INTERFACE////////////////
int seqRadius;
PFont f;


void setup(){
  ////////////////SEQUENCING////////////////
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
  
  ////////////////INTERFACE////////////////
  size(400, 400);
  seqRadius = 100;
  f = createFont("Helvetica", 10);
  textAlign(TOP, LEFT);
  textFont(f);
}

void draw(){
  ////////////////INTERFACE////////////////
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
    
    float curBeatAngle = beatAngle * i;
    
    float beat_x = cos(curBeatAngle) * seqRadius;
    float beat_y = sin(curBeatAngle) * seqRadius;
    
    line(0, 0, beat_x, beat_y);
    
    //add labels to the beat divisions.
    text(currentMeasure + "." + i, beat_x *1.2, beat_y * 1.2);
    
    //hightlight current beat
    if(i == currentBeat){
      fill(200);
      noStroke();
      arc(0, 0, seqRadius*2, seqRadius*2, curBeatAngle, curBeatAngle + beatAngle); 
    }
    
    
  }
  //draw playhead
  stroke(219, 38, 118);
  float playheadPos = map((float)howFarInMeasure, 0, 1, 0, TWO_PI);
  line(0, 0, cos(playheadPos)*seqRadius, sin(playheadPos)*seqRadius);
  
  
  popMatrix();
    
    
}

void onClock(Clock c){
  ////////////////SEQUENCING////////////////
  currentBeat = c.getBeatCount() % beatsPerMeasure;
  currentMeasure = c.getBeatCount() / beatsPerMeasure;
  
  //calculate how many ticks are in a measure
  float ticksPerMeasure = beatsPerMeasure * c.getTicksPerBeat();
  //get a number between 0 and 1 to tell us how far we are
  howFarInMeasure = (c.getCount()%ticksPerMeasure)/ticksPerMeasure;
  
  
  
}




