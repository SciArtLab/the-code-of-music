int lastBeat;
float beatLength;

void setup(){
  lastBeat = millis();
  beatLength = 500;
}

void draw(){
  if(millis() - lastBeat > beatLength){
    lastBeat = millis();
    onBeat();
  }
}

void onBeat(){    
  print("'");
}

