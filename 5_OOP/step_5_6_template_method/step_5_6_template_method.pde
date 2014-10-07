import beads.*;
import org.jaudiolibs.beads.*;

Sequencer seq;
SequencerInterface face; 
SequencerInterface rectangular, circular;

void setup(){  
  //we need to initialize it:
  seq = new Sequencer();  
  circular = new CircularInterface();
  rectangular = new RectangularInterface();
  face = circular;
  
}

void draw(){
  face.draw();    
}

void keyReleased(){
  if(key == 'c'){
    face = circular;
  }
  else if(key == 'r'){
    face = rectangular;
  }
}






