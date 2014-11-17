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
      for (int nTrack = 0; nTrack < midiTracks.length; nTrack++)
      { 
        Track track = midiTracks[nTrack];
        ArrayList<Note> notes = new ArrayList<Note>();
        tracks.add(nTrack, notes);
        
        for (int nEvent = 0; nEvent < track.size(); nEvent++)
        {
           MidiEvent event = track.get(nEvent);
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
                
                Note note = new Note(channel, pitch, velocity, 0);
                notes.add(note);
              
//              int i = staff.getNotesCount()-1;
//              while((i>=0)&&(staff.getNote(i).getPitch() != pitch)) { i--; }
//
//              if(i>=0)
//              {
//                Note n = staff.getNote(i);
//                if(n.getDuration() == -1)
//                {
//                  n.setDuration((int)(time-n.getTime()));
//                }
//              }
            }
         }
      }
    }
    
//    for (int nTrack = 0; nTrack < midiTracks.length; nTrack++)
//    {
//      Staff staff = score.createStaff();
//      Track   track = midiTracks[nTrack];
//
//      for (int nEvent = 0; nEvent < track.size(); nEvent++)
//      {
//   MidiEvent event = track.get(nEvent);
//        long time = event.getTick();
//        MidiMessage message = event.getMessage();
//
//        if (message instanceof ShortMessage)
//   {
//     ShortMessage message2 = (ShortMessage) message;
//
//          if(message2.getCommand() == ShortMessage.PROGRAM_CHANGE)
//          {
//            staff.setInstrument(message2.getData1());
//          }
//          else if(message2.getCommand() == ShortMessage.NOTE_ON)
//          {
//            int midi = message2.getData1();
//            int velocity = message2.getData2();
//
//            if(message2.getChannel() == Staff.CHANNEL_DRUMS) { staff.setInstrument(Staff.DRUMS);}
//
//            int i = staff.getNotesCount()-1;
//            while((i>=0)&&(staff.getNote(i).getPitch() != midi)) { i--; }
//
//            if(i>=0)
//            {
//              Note n = staff.getNote(i);
//              if(n.getDuration() == -1)
//              {
//                n.setDuration((int)(time-n.getTime()));
//              }
//            }
//
//            Note note = staff.createNote();
//            note.setPitch(midi);
//            //note.setVelocity(velocity);
//            note.setTime((int)time);
//            note.setDuration(-1);
//
//            staff.validate();
//          }
//          else if(message2.getCommand() == ShortMessage.NOTE_OFF)
//          {
//            int midi = message2.getData1();
//            int velocity = message2.getData2();
//
//            int i = staff.getNotesCount()-1;
//            while((i>=0)&&(staff.getNote(i).getPitch() != midi)) { i--; }
//
//            if(i>=0)
//            {
//              Note n = staff.getNote(i);
//              if(n.getDuration() == -1)
//              {
//                n.setDuration((int)(time-n.getTime()));
//              }
//            }
//            
//            staff.validate();
//          }
//          else if(message2.getCommand() == ShortMessage.PITCH_BEND)
//          {
//            // Pitch bend : skip
//          }
//          else if(message2.getCommand() == ShortMessage.CONTROL_CHANGE)
//          {
//            int control = message2.getData1();
//
//            if(control == 0x06)
//            {
//              // Data Entry (coarse) : skip ?
//            }
//            else if(control == 0x07)
//            {
//              // Volume (coarse) : skip
//            }
//            else if(control == 0x0A)
//            {
//              // Pan (coarse) : skip
//            }
//            else if(control == 0x64)
//            {
//              // Registered Param LSB : skip ?
//            }
//            else if(control == 0x65)
//            {
//              // Registered Param MSB : skip ?
//            }
//            else
//            {
//              System.out.println("Control : "+String.format("%02x",control));
//            }
//          }
//          else
//          {
//            System.out.println("ShortMessage : "+String.format("%02x",message2.getCommand()));
//          }
//        }
//        else if(message instanceof MetaMessage)
//        {
//          MetaMessage message2 = (MetaMessage)message;
//
//          if(message2.getType() == 0x2F)
//          {
//            for(int i=0;i<staff.getNotesCount();i++)
//            {
//              Note n = staff.getNote(i);
//              if(n.getDuration() == -1)
//              {
//                n.setDuration((int)(time-n.getTime()));
//              }
//            }
//          }
//          else if(message2.getType() == 0x51)
//          {
//            byte[]   abData = message2.getData();
//
//            int   nTempo = ((abData[0] & 0xFF) << 16) | ((abData[1] & 0xFF) << 8) | (abData[2] & 0xFF);
//       score.setBPM( (int)convertTempo(nTempo));
//          }
//          else if(message2.getType() == 0x03)
//          {
//            String str = new String(message2.getData());
//
//            System.out.println("Name : "+str);
//          }
//          else if(message2.getType() == 0x7F)
//          {
//            // Proprietary Event : skip
//          }
//          else if(message2.getType() == 0x59)
//          {
//            // Key Signature : skip
//          }
//          else if(message2.getType() == 0x20)
//          {
//            // MIDI Channel : ?
//          }
//          else if(message2.getType() == 0x21)
//          {
//            // MIDI Port : skip
//          }
//          else if(message2.getType() == 0x01)
//          {
//            // Text : skip
//          }
//          else if(message2.getType() == 0x58)
//          {
//            // Time Signature : skip
//          }
//          else
//          {
//            System.out.println("MetaMessage : "+String.format("%02x", message2.getType()));
//          }
//        }
//      }
//
//      long baseTime = (60l*1000000l)/score.getBPM()/Note.QUARTER;
//
//      for(int i=0;i<staff.getNotesCount();i++)
//      {
//        Note n = staff.getNote(i);
//
//        // Dirty hack -_-
//
//        long time = n.getTime();
//        long duration = n.getDuration();
//
//        long t = (time*totalTime)/totalTick;
//        time = (int)(t / baseTime);
//        
//        t = (duration*totalTime)/totalTick;
//        duration = (int)(t / baseTime);
//
//        n.setTime((int)time);
//        n.setDuration((int)duration);
//      }
//    }
//
//    // Converte DRUMs channels
//
//    ArrayList<Staff> drums = new ArrayList<Staff>();
//
//    for(int i=0;i<score.getStaffsCount();i++)
//    {
//      Staff st = score.getStaff(i);
//
//      if(st.getInstrument() == Staff.DRUMS)
//      {
//        score.removeStaff(st);
//        drums.add(st);
//      }
//    }
//
//    for(int i=0;i<drums.size();i++)
//    {
//      Staff st = drums.get(i);
//
//      for(int j = 0;j<st.getNotesCount();j++)
//      {
//        Note n = st.getNote(j);
//
//        Staff sd = score.getStaffWithInstrumen(Staff.DRUMS+n.getPitch());
//
//        if(sd == null)
//        {
//          sd = score.createStaff();
//          sd.setInstrument(Staff.DRUMS+n.getPitch());
//        }
//
//        Note nd = sd.createNote();
//        nd.setPitch(  DRUM_NOTE[n.getPitch()] );
//        nd.setDuration( n.getDuration() );
//        nd.setTime( n.getTime() );
//      }
//    }
//
//    score.validate();
//    
    }
    catch(Exception e){
    }
  }
  
  ArrayList<Note> getNotes(int trackNumber){
    return tracks.get(trackNumber);
  }
  
    
}
