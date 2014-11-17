import beads.*;
import org.jaudiolibs.beads.*;

/*
Now let's create a Sequencer class and move the clock and beat code there.

- Any variables that were in the top of your sketch should probably be *class variables*, 
or 'fields'.
- The code in 'setup' should probably go to the new class' *constructor*. 
The constructor is the method that is called whenever you create an instance of your class:
Sequencer mySequencer = new Sequencer(); //----> *Sequencer()* is the constructor

Now we know that everything in this tab is interface-related, and everything in the Sequencer class
is sequencing-related, so let's delete those label comments.

Now this tab does need to access some of the data the Sequencer has (beatsPerMeasure, currentBeat)

So we need to create an instance of the Sequencer class to access them. Let's call that object 'seq'.
*/

Sequencer seq;

int seqRadius;
PFont f;

void setup(){  
  //we need to initialize it:
  seq = new Sequencer();
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
  
  float beatAngle = TWO_PI/(float)seq.beatsPerMeasure;
  
  //draw grid lines
  for(int i = 0; i < seq.beatsPerMeasure; i++){
    stroke(100);  
    
    float curBeatAngle = beatAngle * i;
    
    float beat_x = cos(curBeatAngle) * seqRadius;
    float beat_y = sin(curBeatAngle) * seqRadius;
    
    line(0, 0, beat_x, beat_y);
    
    //add labels to the beat divisions.
    text(seq.currentMeasure + "." + i, beat_x *1.2, beat_y * 1.2);
    
    //hightlight current beat
    if(i == seq.currentBeat){
      fill(200);
      noStroke();
      arc(0, 0, seqRadius*2, seqRadius*2, curBeatAngle, curBeatAngle + beatAngle); 
    }
    
    
  }
  //draw playhead
  stroke(219, 38, 118);
  float playheadPos = map((float)seq.howFarInMeasure, 0, 1, 0, TWO_PI);
  line(0, 0, cos(playheadPos)*seqRadius, sin(playheadPos)*seqRadius);
  
  
  popMatrix();
    
    
}






