import beads.*;
import org.jaudiolibs.beads.*;

/*
  Imagine you'd like to be able to easily switch between your two interface designs: 
  circle or rectangle.
  We'll use this as an example to demonstrate the creation of a class and subclasses, 
  use inheritance and polymorphism.
  Let's create a SequencerInterface class so we can switch easily between these two. 
  
  I'll open our old rectangular Sequencer code and take a look 
  at what is the same and what is different compared to our circular
  sequencer. 
  Different: 
  - size
  - rectangle has w, h; circle has radius.
  - before drawing: rectangle translates to (x, y). circle translates to (width/2, height/2).
  
  Same: 
  - font
  - colors
  - both have some code to draw the grid and highlight the current, and to draw the playhead after.
  
  So let's create a class with the common vars and methods, SequencerInterface, 
  and then two *subclasses*: CircularSequencer and RectangularSequencer.
  SequencerInterface will have any code that is shared between our sequencers;
  CircularSequencer and RectangularSequencer will *inherit* this code, 
  and have additional code for the differences.
  
  In our main code (this tab), we'll have a SequencerInterface variable. 
  This will be able to hold both CircularSequencer and RectangularSequencer objects:
  it's a variable that can have different behavior depending on its particular type, which
  is defined at runtime. 
  This is called *polymorphism* (poly: many. morph: shape).
  
  Note: our *superclass* could be an *abstract class*, or even an *interface* (we won't get into this today, 
  but if you're interested, look it up!)

*/

Sequencer seq;
SequencerInterface face; 

void setup(){  
  //we need to initialize it:
  seq = new Sequencer();
  face = new CircularInterface();
  
}

void draw(){
  face.draw();
    
}






