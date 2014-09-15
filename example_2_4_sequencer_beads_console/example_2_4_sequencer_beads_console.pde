import beads.*;
import java.util.Arrays; 

AudioContext ac;



void setup(){  
  ac = new AudioContext();
  Clock clock = new Clock(ac, 500);
  
  
  clock.addMessageListener(
  //this is the on-the-fly bead
  new Bead() {
    //this is the method that we override to make the Bead do something
    
     public void messageReceived(Bead message) { //This is equivalent to 'onBeat' in our previous example
        Clock c = (Clock)message;
        if(c.isBeat()) {
          onBeat();
        }
        
        
     }
   }
 );
 
 ac.out.addDependent(clock);
 ac.start();

}

void draw(){
  
}

void onBeat(){    
  print("'");
}

