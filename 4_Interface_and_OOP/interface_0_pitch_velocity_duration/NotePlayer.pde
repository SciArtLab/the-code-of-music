import themidibus.*;
MidiBus midiBus; 
//Note is a midiBus class that holds a note, a timestamp, a duration.
ArrayList<Note> noteOffsSchedule;

//This class takes dealing with MIDI noteOffs out of the way.
class NotePlayer{
  NotePlayer(){    
    MidiBus.list(); 
    midiBus = new MidiBus(this, 0, 1);
    noteOffsSchedule = new ArrayList<Note>();
  }
  
  void onTick(long now){
    turnNotesOff();
  }
  
  void turnNotesOff(){
  //TO DO: replace ArrayList with HashMap to get O(1) processing time
    for(int i = 0; i < noteOffsSchedule.size(); i++)
    {    
      Note note = noteOffsSchedule.get(i);
      if(millis() > note.timestamp + note.ticks){
        midiBus.sendNoteOff(note);
        noteOffsSchedule.remove(i);
      }
    }
  }
  
  void play(int channel, int midiNote, int velocity, int duration, long timestamp){
    //channel, note, velocity, DURATION, timestamp
    Note note = new Note(channel, midiNote, velocity, duration, timestamp, ""); 
    midiBus.sendNoteOn(note);
    noteOffsSchedule.add(note); 
  }
  
  void stop(){
    for(int i = 0; i < 127; i++){
      midiBus.sendNoteOff(new Note(0, i, 0));
    }
  }
  

}
