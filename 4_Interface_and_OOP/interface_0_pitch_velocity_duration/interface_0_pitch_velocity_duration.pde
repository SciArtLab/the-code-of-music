Clock clock;
NotePlayer notePlayer;

int BPM;
int beatsPerMeasure;

int [] scale = {62, 64, 66, 67, 69, 71, 73};//D major
int currentNote;
int velocity; 
int duration;



void setup(){
  
  colorMode(HSB, 360, 100, 100);
  notePlayer = new NotePlayer();
  clock = new Clock(240);//which, in sheet music, would be 'allegro'.
  clock.beatsPerMeasure = 4;//but we'll ignore this.
  
}

void draw(){
  background(0);
    int x = 0;
    int y = (int)map(currentNote, 0, 127, height, 0);
    int S = (int)map(velocity, 0, 127, 20, 100);
    int B = (int)map(velocity, 0, 127, 60, 100);
    int w = (int)map(duration, 100, 200, width/8, width/4);
    noStroke();
    fill(340, 100, B);
    rect((width - w)/2, y, w, height - y);
    
  
}

void onTick(long nowInMillis){ 
  
  if(clock.isNewBeat){
     int posInScale = floor(random(0, scale.length)); 
     int octave = floor(random(0,3));  
     currentNote = scale[posInScale] + 12*octave;
     int channel = 0;
     velocity = floor(random(0, 127));
     duration = floor(random(100, 400));
     notePlayer.play(channel, currentNote, velocity, duration, nowInMillis);
     
     
    }
    notePlayer.onTick(nowInMillis);//just for note offs. this should probably be hidden somewhere else.
}
  
  

void exit(){
  clock.stop();
  notePlayer.stop();
  super.exit();
}

