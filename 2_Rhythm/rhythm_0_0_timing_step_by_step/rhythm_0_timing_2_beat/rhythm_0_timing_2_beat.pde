import themidibus.*;
MidiBus midiBus; 

int lastBeat;
float beatLength;

void setup(){
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  
  lastBeat = millis();
  beatLength = 200;
  
}

void draw(){
  background(0);
  if(millis() - lastBeat > beatLength){
    lastBeat = millis();
    
    int channel = 0; 
    //let's keep these variables constant now, so it's easier to tell how the timing is working
    int note = 60;  
    int velocity = 127;
    int duration = 200; 
    midiBus.sendNoteOn(channel, note, velocity);
    delay(duration);
    midiBus.sendNoteOff(channel, note, velocity);
  }
  
  
//Try uncommenting them and see how timing becomes unreliable
//  int howMany = floor(random(0, 1000));
//  println("drawing " + howMany*howMany + " ellipses");
//  for(int i = 0; i < howMany; i++){
//    for(int j = 0; j < howMany; j++){
//        ellipse(i % width, j % height, 10, 10); 
//    }
//  } 
//  println("frameRate: " + frameRate);
 
}
