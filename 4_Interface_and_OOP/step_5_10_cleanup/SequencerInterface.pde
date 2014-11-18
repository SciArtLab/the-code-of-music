class SequencerInterface{
  
  PFont f;
  color backgroundColor;
  color playHeadColor;
  color highlightedBeatColor;
  color gridLinesColor;
  
  int x, y;
  
  boolean highlightCurrentBeat;
  
  //constructor
  SequencerInterface(){    
    f = createFont("Helvetica", 10);
    textAlign(TOP, LEFT);
    textFont(f);
    highlightCurrentBeat = true;
    
    //default values for colors:
    backgroundColor = 0;
    playHeadColor = color(219, 38, 118);
    highlightedBeatColor = color(200);
    gridLinesColor = color(100);
    
  }
  
  void draw(){
    background(backgroundColor);
    pushMatrix();
    translate(x, y);
    drawGrid();
    drawPlayhead();    
    popMatrix();
  }
  
  void drawGrid(){
  
  }
  
  void drawPlayhead(){
  
  }
  
  void highlightCurrentBeat(){
  
  }
}
