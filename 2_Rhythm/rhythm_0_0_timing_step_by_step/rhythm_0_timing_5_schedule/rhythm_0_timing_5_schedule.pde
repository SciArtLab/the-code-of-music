import themidibus.*;
MidiBus midiBus;

//Here is a more general approach: we have a Score class (which could evolve to a more general scheduler for any kind of event), 
//that schedules a noteOff message whenever a noteOn is sent.
//Since our Clock has more functionality now, handling BPM and beats, measures, and ticks, let's call it 'Transport'.


Score s;
Transport t;

void setup() {
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  //The Transport keeps track of time.
  t = new Transport(240);
  
  //The Score sends 'note on's and schedules the respective 'note off's. 
  //It's a simple scheduler, which could be generalized into a more complete Score class:
  //it's composed of a list of timed events
  s = new Score();
  
  t.setListener(s); //in a generalized version, we'd have an 'addListener' function instead (to be able to have many of them)
  //, but we are trying to keep the code as simple as possible.
  
  //This is how it works:
  //The clock 'ticks'. It notifies its 'listener' (the Score), calling its 'tick' function. 
  //In that function, the listener:
  
    //1) Calls the main sketch's 'onTick' function (defined below)
        //This is to give the sketch a chance to schedule events (noteOns) just in time, right before they are supposed to happen.
        //(we need this to be able to respond to user input immediately)
    
    //2) Runs the events. In this specific version, events are noteOn's and noteOffs (which are noteOn's with velocity = 0), 
        //but that could be easily expanded/generalized.
  
}

void draw() {
  
}

void onTick(long millis){
  if (t.newBeat()) {
    int channel = 0;
    int pitch = floor(random(10, 120));
    int velocity = 120;
    int duration = t.toTicks(0.25); //this gives us a quarter note. 1 is a whole note, and so on.   
    //'toTicks' receives a note duration between 0 and 1:
    // 1 is a whole measure
    // 1/2 or 0.5 is a half note, 
    // 1/4 or 0.25 is a quarter note, etc.
    
    s.add(channel, pitch, velocity, duration, millis);
  }
}

void exit(){
  //Apparently Processing only calls this if the app is closed by clicking the X button on the window...
  //So do that to avoid lingering notes.
  println("exiting");
  t.stop();
  s.allNotesOff();
  super.exit();
}






