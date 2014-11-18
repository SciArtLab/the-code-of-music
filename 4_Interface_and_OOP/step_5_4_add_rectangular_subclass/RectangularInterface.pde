class RectangularInterface extends SequencerInterface{
  int x, y, w, h;
  
  RectangularInterface(){
    size(400, 200);
    textAlign(TOP, LEFT);
    
    x = 20;
    y = 20;
    w = width - 40;
    h = height - 40;
    
  }
  
  void draw(){
    background(50);
    fill(200);
    float currentBeat_x = x + seq.currentBeat * w/(float)seq.beatsPerMeasure;
    rect(currentBeat_x, y + 0, w/seq.beatsPerMeasure, h);
    
    noFill();
    stroke(100);
    rect(x, y, w, h);
    for(int i = 0; i < seq.beatsPerMeasure; i++){
      int beatLength = (w)/seq.beatsPerMeasure;
      line(x + i*beatLength, y + 0, x + i*beatLength,  y + h);
      text(seq.currentMeasure + "." + i, x + i*beatLength, y);
      text(beatLength*i + "ms", x + i*beatLength, height - 5);
    }
    
    stroke(0, 255, 0);
    float playheadPos = map((float)seq.howFarInMeasure, 0, 1, 0, w);
    line(x + playheadPos, y + 0, x + playheadPos, y + h);
  
  }
  
}
