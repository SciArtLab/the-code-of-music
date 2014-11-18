Clock clock;
NotePlayer notePlayer;

int BPM;
int beatsPerMeasure;

int [] scale = {62, 64, 66, 67, 69, 71, 73};//D major
int[] currentNotes;

int x, y, w, h;
PFont f;

void setup(){
  
  colorMode(HSB, 360, 100, 100);
  notePlayer = new NotePlayer();
  BPM = 100;
  clock = new Clock(BPM);
  clock.beatsPerMeasure = 4;
  
  currentNotes = new int[clock.beatsPerMeasure];
  
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
  
  //highlight current beat
  fill(200);
  float currentBeat_x = clock.beat * beatWidth;
  rect(currentBeat_x, 0, beatWidth, h);
  
  
  //for each measure, we draw a vertical line
  for(int i = 0; i < clock.beatsPerMeasure; i++){
    float beatPos = i*beatWidth;
    line(beatPos, 0, beatPos,  h);
    //now let's label them:
    text(clock.measure + "." + i, beatPos, - 2);
    int seconds = round(clock.measure*clock.beatLength + i*clock.beatLength);
    text( seconds + "s", beatPos, h + 10);
  }
  
  //draw playhead
  stroke(219, 38, 118);
  float playheadPos = map(clock.posInMeasure, 0, 1, 0, w);
  line(playheadPos, 0, playheadPos, h);
//  println(clock.posInMeasure);
  
  popMatrix();
}

void onTick(long nowInMillis){ 
  
}

int playRandomNote(long nowInMillis){
  int posInScale = floor(random(0, scale.length)); 
   int octave = floor(random(0,3));  
   int note = scale[posInScale] + 12*octave;
   int channel = 0;
   int velocity = floor(random(0, 127));
   int duration = floor(random(100, 400));
   notePlayer.play(channel, note, velocity, duration, nowInMillis);
   return note;

} 

void exit(){
  clock.stop();
  notePlayer.stop();
  super.exit();
}

