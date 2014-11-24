//A musical rendering of Dan Shiffman's Game of Life Sketch

// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A basic implementation of John Conway's Game of Life CA

// Each cell is now an object!

import themidibus.*;
MidiBus midiBus;

Score s;
Transport t;
int BPM = 50;

GOL gol;

void setup() {
  size(640, 360);
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  BPM = 120;
  s = new Score();
  t = new Transport(BPM);
  gol = new GOL();
//  t.beatsPerMeasure = gol.columns;
  t.setListener(s);
  
  
}

void draw() {
  background(255);

  gol.generate();
  gol.display();
  
  
  int x_pos = floor(map(t.posInMeasure(), 0, 1, 0, width));
//  line(x_pos, 0, x_pos, height);
  
  noStroke();
  fill(255, 0, 0, 50);
  rect(x_pos, 0, 10, height);
  
  

  
}

void onTick(long now) {
    float pos =  t.posInMeasure()*gol.columns;
    int pos_in_grid = floor(pos);
    if(pos == pos_in_grid){ //if we're on a line
      for ( int j = 0; j < gol.rows;j++) {
        if(gol.board[pos_in_grid][j].state > 0){
          int pitch = floor(map(j, gol.rows, 0, 20, 127));
          s.add(0, pitch, 120, t.toTicks(1/4), t.now);
        }
      }
    }
}

// reset board when mouse is pressed
void mousePressed() {
  gol.init();
}

