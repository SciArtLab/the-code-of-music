import themidibus.*;
MidiBus midiBus; 

Clock clock;

void setup(){
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  clock = new Clock();
  clock.beatLength = 200;
  
}

void draw(){
//Try uncommenting them and notice that while the drawing slows down for
//large numbers of ellipses, musical time isn't affected
  int howMany = floor(random(0, 1000));
  println("drawing " + howMany*howMany + " ellipses");
  for(int i = 0; i < howMany; i++){
    for(int j = 0; j < howMany; j++){
        ellipse(i % width, j % height, 10, 10); 
    }
  } 
  println("frameRate: " + frameRate);
}

void onTick(double nowInMillis){

}

void onBeat(){
  midiBus.sendNoteOn(0, 60, 80);
}

void exit(){
  clock.stop();
  super.exit();
}
