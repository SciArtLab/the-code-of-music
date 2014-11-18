class SequencerInterface{
  
  PFont f;
  color backgroundColor;
  color playHeadColor;
  color highlightedBeatColor;
  color gridLinesColor;
  
  //constructor
  SequencerInterface(){    
    f = createFont("Helvetica", 10);
    textAlign(TOP, LEFT);
    textFont(f);
    
    //default values for colors:
    backgroundColor = 50;
    playHeadColor = color(219, 38, 118);
    highlightedBeatColor = color(200);
    gridLinesColor = color(100);
    
  }
  
  void draw(){
  
  }
}
