//Combining the two previous examples:

Clock clock;
NotePlayer notePlayer;

int BPM;
int beatsPerMeasure;

int [] scale = {62, 64, 66, 67, 69, 71, 73};//D major
Note[] currentNotes;

int x, y, w, h;
PFont f;

void setup(){
  
  colorMode(HSB, 360, 100, 100);
  notePlayer = new NotePlayer();
  BPM = 120;
  clock = new Clock(BPM);
  clock.beatsPerMeasure = 4;
  
  currentNotes = new Note[clock.beatsPerMeasure];
  
  //interface
  size(400, 200);
  x = 20;
  y = 40;
  w = width - 2*x;
  h = height - y - y/2;
  
  f = createFont("Helvetica", 10);
  textAlign(TOP, LEFT);
  textFont(f);
  
}

void draw(){
  //have currentNote, velocity, duration
  background(0);
  noFill();
  stroke(200);
  rect(x, y, w, h);
  int beatWidth = w/clock.beatsPerMeasure;
  
  pushMatrix();
  
  //display BPM
  text("BPM: " + BPM, x, y/2);
  
  //translate to the position of the grid
  translate(x, y);
  
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
      if(i == clock.beat){
        alpha = 255;
      }
      int w = (int)map(n.ticks, 100, 200, width/8, width/4);
      noStroke();
      fill(340, 100, B, alpha);
      rect(i*beatWidth, h - pitchH, beatWidth, 5);
    }
    
  }
  
  
  
  fill(200);
  //for each measure, we draw a vertical line
  stroke(255);
  for(int i = 0; i < clock.beatsPerMeasure; i++){
    float beatPos = i*beatWidth;
    line(beatPos, 0, beatPos,  h);
    //now let's label them:
    text(clock.measure + "." + i, beatPos, - 2);
    int seconds = round(clock.measure*clock.beatLength + i*clock.beatLength);
    text( seconds + "s", beatPos, h + 10);
  }
  
  //draw playhead
  stroke(255);
  float playheadPos = map(clock.posInMeasure, 0, 1, 0, w);
  line(playheadPos, 0, playheadPos, h);
//  println(clock.posInMeasure);
  
  popMatrix();
}

void onTick(long nowInMillis){ 
  if(clock.isNewBeat){
    for(int i = 0; i < clock.beatsPerMeasure; i++){
      if(clock.beat == i){
        currentNotes[i] = playRandomNote(nowInMillis);
      }
    }
  }
    notePlayer.onTick(nowInMillis);
}

Note playRandomNote(long nowInMillis){
  int posInScale = floor(random(0, scale.length)); 
   int octave = floor(random(0,3));  
   int pitch = scale[posInScale] + 12*octave;
   int channel = 0;
   int velocity = floor(random(0, 127));
   int duration = floor(random(100, 400));
   Note note = new Note(channel, pitch, velocity, duration, "");
   note.timestamp = nowInMillis;
   notePlayer.play(note);
   return note;

} 

void exit(){
  clock.stop();
  notePlayer.stop();
  super.exit();
}

