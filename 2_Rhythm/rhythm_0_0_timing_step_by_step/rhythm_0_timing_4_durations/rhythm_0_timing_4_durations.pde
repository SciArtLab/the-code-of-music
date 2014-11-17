import themidibus.*;
MidiBus midiBus; 

//Now that we aren't doing 'delay()' anymore, we need another way to deal with durations.
//A first approach might be just to keep track of the notes that need to be turned off:

Clock clock;
//Note is a midiBus class that holds a note, a timestamp, a duration.
ArrayList<Note> noteOffsSchedule;

void setup(){
  MidiBus.list(); 
  midiBus = new MidiBus(this, 0, 1);
  noteOffsSchedule = new ArrayList<Note>();
  clock = new Clock();
  clock.beatLength = 200;
}

void draw(){

}

void onTick(double nowInMillis){  
  turnNotesOff();
}

void onBeat(double nowInMillis){
  int midiNote = floor(random(0, 127));   
  //channel, note, velocity, duration, timestamp
  Note note = new Note(0, midiNote, 127, 8000, (long)nowInMillis, ""); 
  midiBus.sendNoteOn(note);
  noteOffsSchedule.add(note); 
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

void exit(){
  clock.stop();
  for(int i = 0; i < 127; i++){
    midiBus.sendNoteOff(new Note(0, i, 0));
  }
  super.exit();
}
