import beads.*;
import org.jaudiolibs.beads.*;
import themidibus.*;

class Sequencer{
  //it's good practice to make these variables 'private', but let's leave that discussion aside for now. 
  AudioContext ac;
  MidiBus midiBus;
  Theory theory;
  
  private int bpm; 
  private int beatsPerMeasure;
  Clock clock;
  
  ArrayList<Track> tracks;  
  

  float beatLength;
  int currentMeasure;
  int currentBeat; 
  float howFarInMeasure;
  
  //Constructor
  Sequencer(){    
    ac = new AudioContext();
    MidiBus.list();
    theory = new Theory();
    
    midiBus = new MidiBus(this, -1, 2); 
    beatsPerMeasure = 6;
    clock = new Clock(ac); 
    setBpm(120);
    clock.setClick(true); 
    clock.addMessageListener(
      new Bead(){
        public void messageReceived(Bead message){
          Clock c = (Clock)message;
          onClock(c);
        }
      }
    );
    ac.out.addDependent(clock);
    ac.start();
    
    
   tracks = new ArrayList<Track>();
//   Track synth1 = new SynthTrack(this);
//   tracks.add(synth1);
   Track synth2 = new MIDITrack(this);
   tracks.add(synth2);
   
   Track synth3 = new MIDITrack(this);
   tracks.add(synth3);
   
   
  }
  
  void setBpm(int _bpm){
    bpm = _bpm;
    beatLength = 60000.0/bpm;
    clock.setIntervalEnvelope(new Static(ac, beatLength));
  }
  
  void setBeatsPerMeasure(int _number){  
    beatsPerMeasure = _number;  
    for(int i = 0; i < tracks.size(); i++){
      while(tracks.get(i).currentMeasureNotes.size() < _number){
        tracks.get(i).currentMeasureNotes.add(null);
      }
    }  
  }
  
  int getBeatsPerMeasure(){
    return beatsPerMeasure;
  }



  void onClock(Clock c){       
    howFarInMeasure = (c.getCount()%getTicksPerMeasure())/getTicksPerMeasure();
    if(c.isBeat()) {
        currentMeasure = getMeasure(c.getBeatCount());
        currentBeat = getBeat(c.getBeatCount());
        for(int i = 0; i < tracks.size(); i++){
          tracks.get(i).onTick(c);
          tracks.get(i).onBeat(c);
        } 
    }
  }
  
  int getMeasure(int ticks){
    return ticks / getBeatsPerMeasure();
  }
  
  int getBeat(int ticks){
    return ticks % getBeatsPerMeasure();
  }
  
  float getTicksPerMeasure(){
    return getBeatsPerMeasure() * clock.getTicksPerBeat();    
  }
  
  
  
  int toTicks(int millis){
    //TO DO: implement
    return 50;
  }
  
}


