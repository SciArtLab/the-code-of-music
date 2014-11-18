class Track{
  Sequencer parent;
  HashMap timeline;
  ArrayList<Note> currentMeasureNotes;
  
  Track(Sequencer _parent){
     parent = _parent;
     
  }
  void onBeat(Clock c){
    
  }
  
  void onTick(Clock c){
    
  }
}
