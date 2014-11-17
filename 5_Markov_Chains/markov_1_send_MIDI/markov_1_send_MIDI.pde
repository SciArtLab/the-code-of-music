import themidibus.*; 
MidiBus myBus; 

int[] raw_sequence = {64,62,60,62,64,67};
int[] index = new int[128]; 
int[] indexed_sequence = new int[raw_sequence.length];

int markov[][];

int index_size;

void setup(){
  MidiBus.list(); 
  myBus = new MidiBus(this, -1, 1); 
  
  index_size = 0;
  //process sequence
  boolean new_item = true;
  
  //step 1: analyze sequence
  for(int i = 0; i < raw_sequence.length; i++){
    new_item = true;
    for(int j = 0; j < index_size; j++){
      if(raw_sequence[i] == index[j]){
        new_item = false;  
        indexed_sequence[i] = j;      
      }
    }
    if(new_item){
      index[index_size] = raw_sequence[i];
      indexed_sequence[i] = index_size; 
      index_size++;
    }
  }
  
  println("RAW SEQUENCE");
  println(raw_sequence);
  println("INDEX");
  println(index);
  println("INDEXED SEQUENCE");
  println(indexed_sequence);
  
    //step 2: create a table of transitions
    markov = new int[index_size][0]; 
    for(int i = 0; i < indexed_sequence.length; i++){
      int current = indexed_sequence[i];
      int next = indexed_sequence[(i+1) % indexed_sequence.length];
      
      markov[current] = append(markov[current], next);
    }
    
    println("MARKOV");
    for(int i=0;i<markov.length;i++)
    {
       println(i);
       println(markov[i]); 
      
    }
    
    //step 3: create melody
    int melodyLength = 100; //or maybe measure length
    int currentIndex = (int)random(0, markov.length);
    
    for(int i = 0; i < melodyLength; i++){
      int transitionPos = (int)random(0, markov[currentIndex].length);
      int nextIndex = markov[currentIndex][transitionPos];
      currentIndex = nextIndex;   
      
      int channel = 1;
      int pitch = index[currentIndex];
      int velocity = 127;
      myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
      delay(200);
      myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff  
    }
    
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

  

void draw(){
  

}
