class CircularInterface extends SequencerInterface{
  //instead of rectangle x,y,w and h, we need a radius for the sequencer
  int seqRadius;
  
  CircularInterface(){
    seqRadius = 100;
    x = width/2;
    y = height/2;
  }
  
  void drawGrid(){
    stroke(gridLines);
    noFill();
    ellipse(0, 0, seqRadius*2, seqRadius*2);
    
    float beatAngle = TWO_PI/(float)seq.beatsPerMeasure;
    
    //draw grid lines
    for(int i = 0; i < seq.beatsPerMeasure; i++){
      stroke(gridLines);  
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
      text(seq.currentMeasure + "." + i, beat_x *1.2, beat_y * 1.2);
  //    text(beatLength*i/1000 + "s", beat_x, beat_y ); 
      
      //hightlight current beat
      if(i == seq.currentBeat){
        fill(highlight);
        noStroke();
  
        arc(0, 0, seqRadius*2, seqRadius*2, curBeatAngle, curBeatAngle + beatAngle);
  //    uncomment this line for a circle indicator (instead of an arc)
  //    ellipse(beat_x * 0.9, beat_y * 0.9, 10, 10);      
      }
      
      
    }
  }
  
  void drawPlayhead(){
    //draw playhead
    stroke(playHeadColor);
    float playheadPos = map((float)seq.howFarInMeasure, 0, 1, 0, TWO_PI);
    line(0, 0, cos(playheadPos)*seqRadius, sin(playheadPos)*seqRadius);
    
  }
  
}
