class Markov{
  int currentIndex;
  int[] index;
  int[] indexed_sequence;
  int[][] markov;
  
  Markov(int[] sequence){
    index = new int[128];
    indexed_sequence = new int[sequence.length];
    generate(sequence);
  }
  
  void generate(int[] sequence){
    int index_size = 0;  
    boolean new_item = true;
    
    //1. analyze sequence
    for(int i = 0; i < sequence.length; i++){
      new_item = true;
      for(int j = 0; j < index_size; j++){
        if(sequence[i] == index[j]){
          new_item = false;  
          indexed_sequence[i] = j;      
        }
      }
      if(new_item){
        index[index_size] = sequence[i];
        indexed_sequence[i] = index_size; 
        index_size++;
      }
    }
    //2. create a table of transitions
      markov = new int[index_size][0]; 
      for(int i = 0; i < indexed_sequence.length; i++){
        int current = indexed_sequence[i];
        int next = indexed_sequence[(i+1) % indexed_sequence.length];
        
        markov[current] = append(markov[current], next);
      }
      
      println("RAW SEQUENCE");
      println(sequence);
      println("INDEX");
      println(index);
      println("INDEXED SEQUENCE");
      println(indexed_sequence);
      println("MARKOV");    
      for(int i=0;i<markov.length;i++)
      {
         println(i);
         println(markov[i]); 
        
      }
      currentIndex = (int)random(0, markov.length);    
      
  }
  
  int getNext(){
    int transitionPos = (int)random(0, markov[currentIndex].length);
    int nextIndex = markov[currentIndex][transitionPos];
    currentIndex = nextIndex;   
    return index[currentIndex];
  }
  
}
