//Combining the two previous examples:
import themidibus.*;
MidiBus midiBus;

Score s;
Transport t;

int BPM;
int beatsPerMeasure;

int [] scale = {62, 64, 66, 67, 69, 71, 73};//D major
Note[] currentNotes;

int x, y;
int w, h;
PFont f;
color backgroundColor, gridLines, playHeadColor, highlight; 

void setup(){
  //interface
  size(400, 200);
  colorMode(HSB, 360, 100, 100);
  x = 20;
  y = 40;
  w = width - 2*x;
  h = height - y - y/2;
  
  f = createFont("Helvetica", 10);
  textAlign(TOP, LEFT);
  textFont(f);
  
  backgroundColor = color(0);
  gridLines = color(200);
  playHeadColor = color(340, 100, 100);
  highlight = color(0, 255, 0);
  
  //music
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  BPM = 120;
  s = new Score();
  t = new Transport(BPM);
  t.setListener(s);
  t.beatsPerMeasure = 4;
  currentNotes = new Note[t.beatsPerMeasure];
  
}

//music
void onTick(long nowInMillis){ 
  if(t.newBeat()){
    for(int i = 0; i < t.beatsPerMeasure; i++){
      if(t.beat() == i){
        currentNotes[i] = playRandomNote(nowInMillis);
      }
    }
  }
    
}

Note playRandomNote(long nowInMillis){
  int posInScale = floor(random(0, scale.length)); 
   int octave = floor(random(0,3));  
   int pitch = scale[posInScale] + 12*octave;
   int channel = 0;
   int velocity = floor(random(0, 127));
   int duration = floor(random(100, 400));
   return s.add(channel, pitch, velocity, duration, nowInMillis);
} 

//interface
void draw(){
  background(backgroundColor);
  //border
  noFill();
  stroke(gridLines);
  rect(x, y, w, h);
  
  //display BPM
  text("BPM: " + BPM, x, y/2);
  pushMatrix();
  translate(x, y);
  drawGrid();
  drawPlayhead();
  popMatrix();
}

void drawGrid(){
  int beatWidth = w/t.beatsPerMeasure;
  
  //draw generated notes
  for(int i = 0; i < currentNotes.length; i++){
    if(currentNotes[i] != null){
      Note n = currentNotes[i];
      int x = 0;
      int pitchH = (int)map(n.pitch, 0, 127, 0, h);
      int S = (int)map(n.velocity, 0, 127, 20, 100);
      int B = (int)map(n.velocity, 0, 127, 60, 100);
      //highlight current beat
      int alpha = 150;
      if(i == t.beat()){
        alpha = 255;
      }
      int w = (int)map(n.ticks, 100, 200, width/8, width/4);
      noStroke();
      fill(340, 100, B, alpha);
      rect(i*beatWidth, h - pitchH, beatWidth, 5);
    }
    
  }
  
  //for each measure, we draw a vertical line
  stroke(gridLines);
  for(int i = 0; i < t.beatsPerMeasure; i++){
    float beatPos = i*beatWidth;
    line(beatPos, 0, beatPos,  h);
    //now let's label them:
    fill(gridLines);
    text(t.measure() + "." + i, beatPos, - 2);
    int seconds = round(t.measure()*t.beatLength + i*t.beatLength);
    text( seconds + "s", beatPos, h + 10);
  }
}

void drawPlayhead(){
  stroke(playHeadColor);
  float playheadPos = map(t.posInMeasure(), 0, 1, 0, w);
  line(playheadPos, 0, playheadPos, h);
}

//remember to quit using X button on app window
void exit(){
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}

