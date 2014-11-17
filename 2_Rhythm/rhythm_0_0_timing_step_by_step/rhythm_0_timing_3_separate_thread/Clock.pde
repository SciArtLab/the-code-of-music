//A simple clock on a separate thread

class Clock implements Runnable {
  final Thread timingThread  = new Thread(this);
  long startMillis;
  long elapsedMillis;
  
  long lastBeat;
  float beatLength;
  
  Clock(){
    beatLength = 200;
    start();
  }
  
  void start(){
    timingThread.start();
    lastBeat = System.currentTimeMillis();
    
  }
  
  void stop(){
    timingThread.interrupt();
  }
  
  
  @Override
  void run() {
    startMillis = System.currentTimeMillis();
    int waitInNanos = 500000; //0.5 ms  
      while (true) {
        try {
          elapsedMillis = System.currentTimeMillis() - startMillis;
          onTick(elapsedMillis);
          if(System.currentTimeMillis() - lastBeat > beatLength){
            lastBeat = System.currentTimeMillis();
            onBeat();
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

