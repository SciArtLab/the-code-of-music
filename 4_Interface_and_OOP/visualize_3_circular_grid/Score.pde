//Towards a Score: this class can be generalized to handle any other kind of event, and notify different listeners

class Score implements TransportListener{
  private ArrayList<Note> schedule;
  
  public Score(){
    schedule = new ArrayList<Note>();
  }
  
  public void tick(long millis){
    onTick(millis);
    runEvents(millis);
    //a note about the call to onTick: if we were writing this in Java (outside the Processing IDE), 
    //the Score would have a listener: our app would implement a ScoreListener interface, with an onTick method.
    //Within the Processing IDE, we have access to our sketch's onTick method (and can't modify the interfaces that our sketch implements).
  }
  
  private void runEvents(long now){
      for(int i = 0; i < schedule.size() ; i++){
        Note note = schedule.get(i);
        if(note.timestamp - now >= 0 && note.timestamp - now <= 1){ 
          //these are both noteOn's and noteOff's: noteOff's are simply noteOn's with velocity = 0
          midiBus.sendNoteOn(note.channel, note.pitch, note.velocity);
          schedule.remove(i);
        }
      }
  }
  
  Note add(int channel, int pitch, int velocity, int duration, long now){
    Note noteOn = new Note(channel, pitch, velocity, duration);
    noteOn.timestamp = now;
    schedule.add(noteOn);
    
    Note noteOff = new Note(channel, pitch, 0);
    noteOff.timestamp = now + t.ticksToMillis(duration);
    schedule.add(noteOff);
    
    return noteOn;
  }
  
  
  
  public void allNotesOff(){
    for(int i = 0; i < 127; i++){
      midiBus.sendNoteOff(new Note(0, i, 0));
    }
  }

}
