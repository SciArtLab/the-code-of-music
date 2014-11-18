
Sequencer seq;
SequencerInterface face;
CircularInterface circular;
RectangularInterface rectangular;


void setup(){
  seq = new Sequencer();
  rectangular = new RectangularInterface();
  circular = new CircularInterface();
  
  face = circular;
  
}

void draw(){
  
 face.draw();    
    
}

void keyPressed(){
  if(key =='r'){
    face = rectangular;
  }
  else if (key == 'c'){
    face = circular;
  }
}


