import javax.sound.midi.*;

class MidiLoader
{
  ArrayList<ArrayList<Note>> tracks;
  MidiLoader(String fileName){
  tracks = new ArrayList<ArrayList<Note>>();
    
  File myMidiFile = new File(dataPath(fileName));
  try{
    Sequence sequence = MidiSystem.getSequence(myMidiFile);
    long totalTick = sequence.getTickLength();
    long totalTime = sequence.getMicrosecondLength();

    Track[] midiTracks = sequence.getTracks();
    int counter = 0;
    for (int nTrack = 0; nTrack < midiTracks.length; nTrack++)
    { 
      Track t = midiTracks[nTrack];
      ArrayList<Note> notes = new ArrayList<Note>();
      tracks.add(nTrack, notes);
      
      for (int nEvent = 0; nEvent < t.size(); nEvent++){
         MidiEvent event = t.get(nEvent);
         long time = event.getTick();
         MidiMessage message = event.getMessage();
    
         if (message instanceof ShortMessage)
         {
            ShortMessage message2 = (ShortMessage) message;
            
            if(message2.getCommand() == ShortMessage.NOTE_ON)
            {
              int channel = message2.getChannel();
              int pitch = message2.getData1();
              int velocity = message2.getData2();
              long startTime = t.get(nEvent).getTick();
              long endTime = 0;
              
              Note note = new Note(channel, pitch, velocity, 0);
              
              if (velocity == 0) {
                t.remove(t.get(0));
              } 
              else{
                //look for note off
                for (int j = 0; j < t.size(); j++) {
                  if (t.get(j).getMessage() instanceof ShortMessage) {
                    ShortMessage s2 = (ShortMessage)(t.get(j).getMessage());                      
                    if ((s2.getCommand() == ShortMessage.NOTE_OFF) || (s2.getCommand() == ShortMessage.NOTE_ON && s2.getData2() == 0)) //
                    { 
                      if (s2.getChannel() == channel && s2.getData1() == pitch){
                        //calculate note duration
                        endTime = t.get(j).getTick();                          
                        note.ticks = int(endTime-startTime);
                        note.timestamp = (int)startTime;
                        notes.add(note);
                        t.remove(t.get(j));
                        break;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    catch(Exception e){
    }
  } 
}
