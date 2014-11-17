import beads.*;
import org.jaudiolibs.beads.*;



Sequencer seq;
SequencerInterface face; 

void setup(){  
  //we need to initialize it:
  seq = new Sequencer();
//  face = new CircularInterface();
  face = new RectangularInterface();
  
}

void draw(){
  face.draw();
    
}






