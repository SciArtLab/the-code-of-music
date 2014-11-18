class RectangularInterface extends SequencerInterface {
  int w, h, track_h;

  RectangularInterface() {    
    textAlign(TOP, LEFT);
    w = width/4;
    h = height/4;
    x = width/2 - w/2;
    y = height/2 - h/2;
    track_h = h /seq.tracks.size();
  }


  void drawGrid(){
    noFill();
    stroke(gridLinesColor);
    for(int j = 0; j < seq.tracks.size(); j++){
      rect(0, j*track_h, w, track_h);
      //highlight beats that are on on this measure.
      //so the track should know this
    }
    float beatLength = (w)/seq.beatsPerMeasure;    
    for (int i = 0; i < seq.beatsPerMeasure; i++) {
      float beatX = i * w/(float)seq.beatsPerMeasure;
      int beatWidth = w/seq.beatsPerMeasure;
      
      //draw steps that are on
      for(int j = 0; j < seq.tracks.size(); j++){
        Track track = seq.tracks.get(j);
        Note note = track.currentMeasureNotes.get(i);
        if(track.currentMeasureNotes.get(i) != null){
          
          int y = (int)map(note.pitch, 127, 0, 0, track_h);
          float duration = note.ticks / seq.getTicksPerMeasure(); //TO DO: move to track class
          int alpha = (int)map(note.velocity, 0, 127, 50, 255);
          stroke(playHeadColor, alpha);
          rect(beatX, j*track_h + y, beatWidth*duration, track_h/127);          
        }        
      }
      
      if (highlightCurrentBeat && i == seq.currentBeat) {
        fill(highlightedBeatColor, 50);
        noStroke();
        float currentBeat_x = seq.currentBeat * w/(float)seq.beatsPerMeasure;
        rect(currentBeat_x, 0, beatWidth, h);
      }
    
      stroke(gridLinesColor);
      line(i*beatLength, 0, i*beatLength, h); 
      fill(gridLinesColor);     
      text(seq.currentMeasure + "." + i, i*beatLength, 0);
      text(seq.beatLength*i + "ms", i*beatLength, height - 5);
    }
  }
  
  
  void drawPlayhead(){
    stroke(playHeadColor);
    float playheadPos = map((float)seq.howFarInMeasure, 0, 1, 0, w);
    line(playheadPos, 0, playheadPos, h);
    
  }
  
}

