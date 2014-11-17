//A simple clock on a separate thread

class Clock implements Runnable {
  private final Thread timingThread  = new Thread(this);
  long startMillis;
  long elapsedMillis;
  
  long lastBeat;
  float beatLength;
  
  public Clock(){
    beatLength = 200;
    start();
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
          onTick(elapsedMillis);
          if(System.currentTimeMillis() - lastBeat > beatLength){
            lastBeat = System.currentTimeMillis();
            onBeat(elapsedMillis);
          }
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

