//A simple clock on a separate thread
//use with  polyrhythm_example session, which has a drum kit that routes different midi notes to a kick, snare, hi-hat.

class Clock implements Runnable {
  private final Thread timingThread  = new Thread(this);
  long startMillis;
  long elapsedMillis;
  
  long lastBeat;
  float beatLength;
  int syncopation;
  
  int totalBeats;
  
  int beatsPerMeasure;
  int measure;
  int beat;
  boolean isNewMeasure, isNewBeat; 
  
  
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
          elapsedMillis = System.currentTimeMillis() - startMillis;
          
          if(System.currentTimeMillis() - lastBeat > beatLength + syncopation){
            lastBeat = System.currentTimeMillis();
            isNewBeat = true;
            beat = totalBeats % beatsPerMeasure;
            measure = totalBeats / beatsPerMeasure;
            if(beat == 0){
              isNewMeasure = true;
            }
            totalBeats++;
          }
          else{
            isNewBeat = false;
            isNewMeasure = false;
          }
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

