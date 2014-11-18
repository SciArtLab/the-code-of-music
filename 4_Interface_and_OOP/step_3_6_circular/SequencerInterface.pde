class SequencerInterface{
  int x, y;
  PFont f; 
  boolean drawPlayHead;
  color backgroundColor, gridLines, playHeadColor, highlight;  

  SequencerInterface(){
    size(400, 400);    
    f = createFont("Helvetica", 10);
    textAlign(TOP, LEFT);
    textFont(f);
    drawPlayHead = true;
    
    backgroundColor = color(255);
    gridLines = color(0, 0, 255);
    playHeadColor = color(255, 0, 0);
    highlight = color(0, 255, 0);
  }
  
  void draw(){
    pushMatrix();
    println("x: " + x + ", y: " + y);
    translate(x, y);
    background(backgroundColor);
    drawGrid();
    drawPlayhead();
    popMatrix();
  }
  
  void drawGrid(){
  
  }
  
  void drawPlayhead(){
  
  }

}
