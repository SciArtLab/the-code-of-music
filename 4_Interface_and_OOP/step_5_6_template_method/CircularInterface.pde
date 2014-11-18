class CircularInterface extends SequencerInterface{
  
  int seqRadius;
  
  
  CircularInterface(){
    //coordinates of circle center
    x = width/2;
    y = height/2;
    seqRadius = 100;
    textAlign(CENTER, CENTER);
  }

  void drawGrid(){
    noFill();
    stroke(gridLinesColor);    
    ellipse(0, 0, seqRadius*2, seqRadius*2);  
    
    float beatAngle = TWO_PI/(float)seq.beatsPerMeasure;
    
    //draw grid lines
    for(int i = 0; i < seq.beatsPerMeasure; i++){
      stroke(gridLinesColor);  
      
      float curBeatAngle = beatAngle * i;
      
      float beat_x = cos(curBeatAngle) * seqRadius;
      float beat_y = sin(curBeatAngle) * seqRadius;
      
      line(0, 0, beat_x, beat_y);
      
      //add labels to the beat divisions.
      text(seq.currentMeasure + "." + i, beat_x *1.2, beat_y * 1.2);
      
      //hightlight current beat
      if(i == seq.currentBeat){
        fill(highlightedBeatColor);
        noStroke();
        arc(0, 0, seqRadius*2, seqRadius*2, curBeatAngle, curBeatAngle + beatAngle); 
      }
    }
  }
  
  void drawPlayhead(){
    noFill();
    stroke(playHeadColor);
    float playheadPos = map((float)seq.howFarInMeasure, 0, 1, 0, TWO_PI);
    line(0, 0, cos(playheadPos)*seqRadius, sin(playheadPos)*seqRadius);
  }
  
}
