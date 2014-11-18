//A simple clock on a separate thread
//use with  polyrhythm_example session, which has a drum kit that routes different midi notes to a kick, snare, hi-hat.

class Clock implements Runnable {
  private final Thread timingThread  = new Thread(this);
  long startMillis;
  long elapsedMillis;
  
  long lastBeat;
  long lastMeasure;
  float beatLength;
  int syncopation;
  
  int totalBeats;
  
  int beatsPerMeasure;
  int measure;
  int beat;
  boolean isNewMeasure, isNewBeat; 
  float posInMeasure;
  
  
  public Clock(int bpm){
    setTempo(bpm);
    beatsPerMeasure = 4;
    isNewBeat = true;
    start();
  }
  
  public void setTempo(int bpm){
     beatLength = 1.0 / bpm *60*1000.0;
     println(beatLength);
  }
  
  
  public void start(){
    timingThread.start();
    lastBeat = System.currentTimeMillis();
    
  }
  
  public void stop(){
    timingThread.interrupt();
  }
  
  
  @Override
  public void run() {
    startMillis = System.currentTimeMillis();
    int waitInNanos = 500000; //0.5 ms  
      while (true) {
        try {
          long now = System.currentTimeMillis();
          elapsedMillis = now - startMillis;
          
//          beatLength = beatLength + syncopation

          if(now - lastBeat > beatLength + syncopation){
            lastBeat = now;
            isNewBeat = true;
            beat = totalBeats % beatsPerMeasure;
            measure = totalBeats / beatsPerMeasure;
            if(beat == 0){
              isNewMeasure = true;
              lastMeasure = now;
            }
            totalBeats++;
          }
          else{
            isNewBeat = false;
            isNewMeasure = false;
          }
          float measureDuration = (beatLength)*beatsPerMeasure;
          posInMeasure = (now - lastMeasure)/measureDuration;
          onTick(elapsedMillis);
          Thread.sleep(0, waitInNanos);
        } 
        catch (InterruptedException e) {
          break;
        } 
        catch (Exception e) {
          e.printStackTrace();
        }
      }
    }
  }

