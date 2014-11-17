//Towards a Transport class
class Transport implements Runnable {
  final Thread timingThread  = new Thread(this);
  TransportListener listener; 
  
  //user settings
  float beatLength;
  int beatsPerMeasure;  
  int syncopation;
  
  //public state (if this was Java these would be private)
  boolean isNewBeat; 
  float posInMeasure;
  
  //internal state 
  long startMillis;
  long elapsedMillis;
  int ticks;
  int totalBeats;
  long lastBeat;
  long lastMeasure;
  
  Transport(int bpm, TransportListener _listener){
    listener = _listener;
    setTempo(bpm);
    beatsPerMeasure = 4;
    syncopation = 0;
    isNewBeat = true;
    start();
  }
  
  void setTempo(int bpm){
     beatLength = 1.0 / bpm *60*1000.0;
  }
  
  void start(){
    timingThread.start();
    lastBeat = System.currentTimeMillis();
  }
  
  void stop(){
    timingThread.interrupt();
  }
  
  int beat(){
    return totalBeats % beatsPerMeasure;
  }
  
  int measure(){
    return totalBeats / beatsPerMeasure;
  }
  
  @Override
  void run() {
    startMillis = System.currentTimeMillis();
    int waitInNanos = 500000;//0.5ms
      while (true) {
        try {          
          ticks++;
          long now = System.currentTimeMillis();
          elapsedMillis = now - startMillis;

          if(now - lastBeat > beatLength + syncopation){
            lastBeat = now;
            isNewBeat = true;
            if(beat() == 0){
              lastMeasure = now;
            }
            totalBeats++;
          }
          else{
            isNewBeat = false;
          }
          listener.tick(elapsedMillis);
          float measureDuration = (beatLength)*beatsPerMeasure;
          posInMeasure = (now - lastMeasure)/measureDuration;
          
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
  
