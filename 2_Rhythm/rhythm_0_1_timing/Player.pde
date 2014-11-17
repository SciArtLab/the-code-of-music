//Towards a Score: this class can be generalized to handle any other kind of event, and notify different listeners
ArrayList<Note> schedule;

class Player implements TransportListener{
  Transport transport;
  
  Player(){
    schedule = new ArrayList<Note>();
    transport = new Transport(240, this);
  }
  
  void tick(long millis){
    //if we were writing this in Java (outside the Processing IDE), 
    //the Player would have a listener: our app would implement a playerListener interface, with an onTick method.
    //Within the Processing IDE, we have access to our sketch's onTick method (and can't modify the interfaces that our sketch implements).
    onTick(millis);
    runEvents(millis);
  }
  
  void runEvents(long now){
      for(int i = 0; i < schedule.size() ; i++){
        Note note = schedule.get(i);
        if(note.timestamp - now >= 0 && note.timestamp - now <= 1){ 
          midiBus.sendNoteOn(note.channel, note.pitch, note.velocity);
          schedule.remove(i);
        }
      }
  }
  
  void play(int channel, int pitch, int velocity, int duration, long now){
    Note noteOn = new Note(0, pitch, velocity, duration);
    noteOn.timestamp = now;
    schedule.add(noteOn);
    
    Note noteOff = new Note(0, pitch, 0);
    //durations are in ticks; 24 by default
    noteOff.timestamp = now + floor(duration * transport.beatLength/24);
    schedule.add(noteOff);
  }
  
  void stopAll(){
    for(int i = 0; i < 127; i++){
      midiBus.sendNoteOff(new Note(0, i, 0));
    }
  }

}
