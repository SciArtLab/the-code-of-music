//Towards a Transport class
class Transport implements Runnable {
  private final Thread timingThread  = new Thread(this);
  private TransportListener listener; 
  
  //settings
  private int beatsPerMeasure;  
  private int ticksPerBeat;
  private int syncopation;
  
  //pre-calculated vars
  private long beatLength;//in millis, based on BPM
  private long tickLength;//in millis, based on BPM and ticksPerBeat
  
  //state
  private long start;//in millis
  private long now;//in millis
  private int beats;
  private int ticks;  
  
  //for users
  private boolean isNewBeat; 
  private long lastBeat;  
  private long lastMeasure;//to calculate posInMeasure, to draw playhead
  
  
  public Transport(int bpm){
    beatsPerMeasure = 4;
    ticksPerBeat = 480;//this is MAX/MSP's default value
    syncopation = 0;
    
    setTempo(bpm);
    isNewBeat = true;
    start();
  }
  
  public void setTempo(int bpm){
     beatLength = (long)(1.0 / bpm *60*1000.0) + syncopation;
     tickLength = (long)(beatLength / (float)ticksPerBeat);
  }
  
  public void setListener(TransportListener _listener){
    listener = _listener;
  }
  
  public void start(){
    timingThread.start();
    lastBeat = System.currentTimeMillis();
  }
  
  public void stop(){
    timingThread.interrupt();
  }
  
  public int measure(){
    return beats / beatsPerMeasure;
  }
  
  public int beat(){
    return beats % beatsPerMeasure;
  }
  
  
  public int unit(){
    //16 units per beat (like Ableton Live, for example). It's an arbitrary number.
    float ticksPerUnit = ticksPerBeat / 16;
    return (int)(ticks % ticksPerBeat/ticksPerUnit);
  }
  
  public float posInMeasure(){
    float measureDuration = (beatLength)*beatsPerMeasure;
    return (now - lastMeasure)/measureDuration;
  }
  
  public boolean newBeat(){
    return isNewBeat;
  }
  
  @Override
  void run() {
    start = System.currentTimeMillis(); 
    int waitMillis = (int)(tickLength / 1000000);
    int waitNanos = (int) tickLength % 1000000;
    while (true) {
      try {    
        ticks++;
        now = System.currentTimeMillis();
        if(now - lastBeat > beatLength){
          beats++;
          lastBeat = now;
          isNewBeat = true;
          if(beat() == 0){
            lastMeasure = now;
          }
        }
        else{
          isNewBeat = false;
        }
        if(listener != null){
          listener.tick(now);
        }
        Thread.sleep(waitMillis, waitNanos);
      } 
      catch (InterruptedException e) {
        break;
      } 
      catch (Exception e) {
        e.printStackTrace();
      }
    }
  }
  
  long ticksToMillis(int ticks){
    //1 tick = 1 beat/24 (this comes from the MIDI specification)
    return (long)(ticks * t.beatLength/ticksPerBeat);
  }
  
  //note duration between 0 and 1:
  // 1 is a whole measure
  // 1/2 or 0.5 is a half note, 
  // 1/4 or 0.25 is a quarter note, etc.
  int toTicks(float durationFraction){
    return floor(durationFraction * ticksPerBeat*beatsPerMeasure);
  }
  
  
    
    
    
}
  
