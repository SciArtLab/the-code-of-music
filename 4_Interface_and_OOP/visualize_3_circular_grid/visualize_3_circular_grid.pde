import themidibus.*;
MidiBus midiBus;

Score s;
Transport t;

int BPM;
int beatsPerMeasure;

int [] scale = {62, 64, 66, 67, 69, 71, 73};//D major
Note[] currentNotes;

int x, y;
int seqRadius;
PFont f; 
color backgroundColor, gridLines, playHeadColor, highlight;  

void setup(){
  //interface
  size(400, 400);  
  colorMode(HSB, 360, 100, 100);
  x = width/2;
  y = height/2;
  seqRadius = 100;
  
  f = createFont("Helvetica", 10);
  textAlign(TOP, LEFT);
  textFont(f);
  
  backgroundColor = color(0, 0, 0);
  gridLines = color(200);
  playHeadColor = color(340, 100, 100);
  highlight = color(0, 255, 0);
  
  //music
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  s = new Score();
  BPM = 120;
  t = new Transport(BPM);
  t.setListener(s);
  t.beatsPerMeasure = 16;
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
   int octave = floor(random(0,5));  
   int pitch = scale[posInScale] + 12*octave;
   int channel = 0;
   int velocity = floor(random(0, 127));
   int duration = t.toTicks(random(1/16.0, 1/2.0));
   
   return s.add(channel, pitch, velocity, duration, nowInMillis);
} 

//interface
void draw(){
  background(backgroundColor);
  //display BPM
  text("BPM: " + BPM, 20, 20);
  pushMatrix();
  translate(x, y);
  drawGrid();
  drawPlayhead(); 
  popMatrix(); 
}

void drawGrid(){
  //border
  stroke(gridLines);
  noFill();
  ellipse(0, 0, seqRadius*2, seqRadius*2);
  
  float beatAngle = TWO_PI/(float)t.beatsPerMeasure;
  
  //draw generated notes
  for(int i = 0; i < currentNotes.length; i++){
    if(currentNotes[i] != null){
      Note n = currentNotes[i];
      
      //find out the position of the current note in polar coordinates: (angle, radius)
      //the radius is the same for all beats: seqRadius. let's calculate the angle:    
      float curBeatAngle = beatAngle * i;
      
      int pitchPos = (int)map(n.pitch, 0, 127, 0, seqRadius*2);
      float durationAngle = map(n.ticks, 0, t.ticksPerBeat*t.beatsPerMeasure, 0, 180);//TO DO: add a getTicksPerMeasure method to Transport
      
      int S = (int)map(n.velocity, 0, 127, 20, 100);
      int B = (int)map(n.velocity, 0, 127, 60, 100);
      //highlight current beat
      int alpha = 150;
      if(i == t.beat()){
        alpha = 255;
        S -= 10;
        B = 100;
      }
      
      noStroke();
      fill(340, 100, B, alpha);
      int totalAngle = (int)(curBeatAngle + durationAngle) % 360;
      arc(0, 0, pitchPos, pitchPos, curBeatAngle, curBeatAngle + radians(totalAngle));
      println(curBeatAngle);
      fill(backgroundColor);
      arc(0, 0, pitchPos - 10, pitchPos - 10, curBeatAngle, curBeatAngle + radians(totalAngle));

      //or, ignore durations
//      arc(0, 0, pitchPos, pitchPos, curBeatAngle, curBeatAngle + beatAngle);
//      println(curBeatAngle);
//      fill(backgroundColor);
//      arc(0, 0, pitchPos - 10, pitchPos - 10, curBeatAngle, curBeatAngle + beatAngle);
      
    }
  }
  
  //draw grid lines
  for(int i = 0; i < t.beatsPerMeasure; i++){
    stroke(gridLines);  
    //find out the position of the current beat in polar coordinates: (angle, radius)
    //the radius is the same for all beats: seqRadius. let's calculate the angle:    
    float curBeatAngle = beatAngle * i;
    
    //now let's find the cartesian coordinates for those polar positions, 
    //to be able to draw them in Processing's coordinate system.
    float beat_x = cos(curBeatAngle) * seqRadius;
    float beat_y = sin(curBeatAngle) * seqRadius;
    
    line(0, 0, beat_x, beat_y);
    
    fill(gridLines);
    //add labels to the beat divisions.
    //we're multiplying (beat_x, beat_y) by 1.2 to scale that vector (making it 20% longer)
    //in order to offset the text.
    
    text(t.measure() + "." + i, beat_x *1.2, beat_y * 1.2);
  //    text(beatLength*i/1000 + "s", beat_x, beat_y ); 
  //    uncomment this line for a circle indicator (instead of an arc)
  //      ellipse(beat_x * 0.9, beat_y * 0.9, 10, 10); 
     
    }
  }


void drawPlayhead(){
  //draw playhead
  stroke(playHeadColor);
  float playheadPos = map((float)t.posInMeasure(), 0, 1, 0, TWO_PI);
  line(0, 0, cos(playheadPos)*seqRadius, sin(playheadPos)*seqRadius);
  
}



