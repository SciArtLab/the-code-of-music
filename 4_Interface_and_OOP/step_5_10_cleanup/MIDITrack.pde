class MIDITrack extends Track{
  int channel;
  ArrayList<Note> notes;
  
//  MIDITrack(Sequencer _parent, int _channel){
//    MIDITrack(_parent);
//    channel = _channel;
//  }
  
  MIDITrack(Sequencer _parent){
     super(_parent);
     notes = new ArrayList<Note>();
     currentMeasureNotes = new ArrayList<Note>();
     for(int i = 0; i < _parent.beatsPerMeasure; i++){
       currentMeasureNotes.add(i, null);
     }
     
     channel = (int)random(0, 10);
     
//     timeline = new HashMap<Long, Note>();//timestamp in ticks, note
  }
  
  void onBeat(Clock c){  
    if(seq.currentBeat == 0){
      clearSteps();
    }
    int beat = floor(random(0, 3));  
    if(seq.currentBeat == beat){
      int midiNote = (int)random(0, 127);
      //int channel, int pitch, int velocity, int ticks, long timestamp, java.lang.String bus_name
      int duration = (int)random(seq.getTicksPerMeasure()/16, seq.getTicksPerMeasure()*seq.getBeatsPerMeasure());
      int velocity = (int)random(0, 255);
      Note note = new Note(channel, midiNote, velocity, duration, c.getCount(), "");  
      seq.midiBus.sendNoteOn(note);
//      timeline.put(c.getCount(), note);
      currentMeasureNotes.add(seq.currentBeat, note);
      notes.add(note);
    }
    
    
  }
  
  void clearSteps(){
    for(int i = 0; i < currentMeasureNotes.size(); i++)    {
      currentMeasureNotes.set(i, null);
    }
  }
  
  
  void onTick(Clock c){   
   //turn notes off 
    Long now = new Long(c.getCount());
    for(int i = 0; i < notes.size(); i++)
    {
      Note note = notes.get(i);
      if(c.getCount() > note.timestamp + note.ticks){
        seq.midiBus.sendNoteOff(note);
        notes.remove(i);
      }
    }
  }
}

