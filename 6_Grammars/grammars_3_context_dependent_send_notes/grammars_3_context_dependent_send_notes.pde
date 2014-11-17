import themidibus.*; 
MidiBus midiBus;

// how many generations of the L-system
int generations = 100;


// what we start with:
String axiom="__________________________________________________1_____________________________________________________";

// these are the production rules

//String[][] rules = {{"1", "1", "1", "_"}, {"1", "1", "_", "_"}, {"1", "_", "1", "_"}, {"1", "_", "_", "1"}, {"_", "1", "1", "_"}, {"_", "1", "_", "_"}, {"_", "_", "1", "1"}, {"_", "_", "_", "_"}};

String[][] rules = {{"1", "1", "1", "_"}, {"1", "1", "_", "1"}, {"1", "_", "1", "_"}, {"1", "_", "_", "1"}, {"_", "1", "1", "_"}, {"_", "1", "_", "1"}, {"_", "_", "1", "1"}, {"_", "_", "_", "_"}};


String wc = "*"; // wildcard character
int pre = 0;
int lookedfor = 1;
int post = 2;
int replacement = 3;

String instring, outstring;
int rulematch = 0;

void setup()
{
  MidiBus.list(); 
  midiBus = new MidiBus(this, -1, 1);
  
  // step 1: generate the string

  // first run
  instring = axiom;

  println(instring);

  for(int i = 0;i<generations;i++) // run once per generation
  {

    println(outstring);
   for(int l =0;l<instring.length();l++) {
      if(instring.charAt(l)=='1') {
        float thepitch = (l*0.06);
//        println("i 1 " + i*0.25 + " 1 " + thepitch);
        int channel = 1;
        int pitch = floor(map(thepitch, 0, instring.length()*0.06, 0, 120));
        midiBus.sendNoteOn(channel, pitch, 100); // Send a Midi noteOn
        delay(50);
        midiBus.sendNoteOff(channel, pitch, 0); // Send a Midi nodeOff
      }
      else{
        int note = 48;
        if(random(0,1) > 0.3){
          note = 24;
          
        }
        if(random(0,1) > 0.7){
          note = 36;
        }
         midiBus.sendNoteOn(2, note, 50); // Send a Midi noteOn
         delay(50);
         midiBus.sendNoteOff(2, 60, 0); // Send a Midi nodeOff
      }
    }
    
    outstring = ""; // clear the output string

    int thelength = instring.length();
    for(int j = 0;j<thelength;j++) { // iterate through the input string
      boolean substitute = false;
      for(int k = 0;k<rules.length;k++) { // iterate through the rules
    
        int ismatch = 0;
        if(instring.charAt(j)==rules[k][lookedfor].charAt(0)) ismatch++;
        if(instring.charAt((j+thelength-1)%thelength)==rules[k][pre].charAt(0)) ismatch++;
        if(instring.charAt((j+thelength+1)%thelength)==rules[k][post].charAt(0)) ismatch++;

        if(rules[k][pre]==wc) ismatch++;
        if(rules[k][post]==wc) ismatch++;
            
        if(ismatch==3) 
        {
          substitute = true;
          rulematch = k;
          k=rules.length; // get us out of this loop
        }     
      }
      if(substitute)
      { // it's a match... replace it
        outstring = outstring+rules[rulematch][replacement];
      }
      else
      { // not a match... copy over the character from the input string
        outstring = outstring+instring.charAt(j);
      }

    }
   // println(outstring);
    instring = outstring;

   
    }

 
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

