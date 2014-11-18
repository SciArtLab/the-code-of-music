class CircularInterface extends SequencerInterface{
  
  int seqRadius, trackWidth;
  
  
  CircularInterface(){
    //coordinates of circle center
    x = width/2;
    y = height/2;
    seqRadius = 100;
    trackWidth = seqRadius*2 / seq.tracks.size();
    textAlign(CENTER, CENTER);
  }

  void drawGrid(){
    
    float beatAngle = TWO_PI/(float)seq.getBeatsPerMeasure();
    
    for(int i = 0; i < seq.getBeatsPerMeasure(); i++){
      float curBeatAngle = beatAngle * i;
      
      float beat_x = cos(curBeatAngle) * seqRadius;
      float beat_y = sin(curBeatAngle) * seqRadius;
      
      //draw steps that are on
      for(int j = 0; j < seq.tracks.size(); j++){
        Track track = seq.tracks.get(j);        
        Note note = track.currentMeasureNotes.get(i);
        if(note != null){
          int y = (int)map(note.pitch, 0, 127, 0, (j + 1)*trackWidth);
          int prevY = y - trackWidth/10;
          //map duration: instead of all beat, map 
          
          float duration = note.ticks / seq.getTicksPerMeasure(); //TO DO: move to track class
          float durationAngle = map(note.ticks, 0, seq.getTicksPerMeasure(), 0, beatAngle);
          int alpha = (int)map(note.velocity, 0, 127, 50, 255);
          //fill(255, 0, 0);
          noFill();
          stroke(playHeadColor, alpha);
          arc(0, 0, y, y, curBeatAngle, curBeatAngle + durationAngle);
          //cover arc to create ring effect
//          fill(50); 
//          arc(0, 0, prevY, prevY, curBeatAngle, curBeatAngle + beatAngle);

           //cover arc creating fill effect
//          ellipse(0, 0, j*trackWidth, j*trackWidth);           
        }        
      }
      
      //draw grid lines
      stroke(gridLinesColor);  
      line(0, 0, beat_x, beat_y);
      
      //add labels to the beat divisions.
      text(seq.currentMeasure + "." + i, beat_x *1.2, beat_y * 1.2);
      
      //hightlight current beat
      if(i == seq.currentBeat){
        fill(highlightedBeatColor, 50);
        noStroke();
        arc(0, 0, seqRadius*2, seqRadius*2, curBeatAngle, curBeatAngle + beatAngle); 
      }
    }
    //draw track separations
    noFill();
    stroke(gridLinesColor);    
    for(int j = 0; j < seq.tracks.size(); j++){
      ellipse(0, 0, (j+1)*trackWidth, (j+1)*trackWidth); 
    }
  }
  
  void drawPlayhead(){
    noFill();
    stroke(playHeadColor);
    float playheadPos = map((float)seq.howFarInMeasure, 0, 1, 0, TWO_PI);
    line(0, 0, cos(playheadPos)*seqRadius, sin(playheadPos)*seqRadius);
  }
  
  
  
}
