class CircularInterface extends SequencerInterface{
  
  int seqRadius;
  
  CircularInterface(){
    size(400, 400);
    seqRadius = 100;
    textAlign(CENTER, CENTER);
  }
  
  void draw(){
    background(50);
  
    pushMatrix();
    translate(width/2, height/2);
    
    //COLOR: sequencer border and background
    stroke(100);
    noFill();
    ellipse(0, 0, seqRadius*2, seqRadius*2);  
    
    float beatAngle = TWO_PI/(float)seq.beatsPerMeasure;
    
    //draw grid lines
    for(int i = 0; i < seq.beatsPerMeasure; i++){
      //COLOR: grid line stroke and text color (same as gridLines)
      stroke(100);  
      
      float curBeatAngle = beatAngle * i;
      
      float beat_x = cos(curBeatAngle) * seqRadius;
      float beat_y = sin(curBeatAngle) * seqRadius;
      
      line(0, 0, beat_x, beat_y);
      
      //add labels to the beat divisions.
      text(seq.currentMeasure + "." + i, beat_x *1.2, beat_y * 1.2);
      
      //hightlight current beat
      if(i == seq.currentBeat){
        //COLOR: highlighted beat
        fill(200);
        noStroke();
        arc(0, 0, seqRadius*2, seqRadius*2, curBeatAngle, curBeatAngle + beatAngle); 
      }
    }
    
    //draw playhead
    //COLOR: playhead
    stroke(219, 38, 118);
    float playheadPos = map((float)seq.howFarInMeasure, 0, 1, 0, TWO_PI);
    line(0, 0, cos(playheadPos)*seqRadius, sin(playheadPos)*seqRadius);
    
    
    popMatrix();
    
  }
}
