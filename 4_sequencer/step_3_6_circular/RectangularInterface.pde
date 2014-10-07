class RectangularInterface extends SequencerInterface{
  int w, h;
  
  RectangularInterface(){
    x = 20;
    y = 20;
    w = width - 40;
    h = height - 40;
  
  }
  
  void drawGrid(){
    noFill();
    stroke(gridLines);
    rect(0, 0, w, h);
    
    float beatLength = (w)/seq.beatsPerMeasure;    
    
    for (int i = 0; i < seq.beatsPerMeasure; i++) {
      if (i == seq.currentBeat) {
        fill(highlight);
        noStroke();
        float currentBeat_x = seq.currentBeat * w/(float)seq.beatsPerMeasure;
        rect(currentBeat_x, 0, w/seq.beatsPerMeasure, h);
      }

      stroke(gridLines);
      line(i*beatLength, 0, i*beatLength, h);      
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
