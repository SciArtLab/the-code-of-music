// axiom = A
// rule1 = A -> B
// rule2 = B -> BA

import themidibus.*; 
MidiBus myBus; 

// set the number of generations
int generations = 10;

// what we're gonna start with
String axiom = "A";

// we need an array of rules
String[][] rules = {{"A", "B"}, {"B", "BA"}};

String instring, outstring;

int i, j, k;
int ismatching = 0;


void setup() {
  MidiBus.list(); 
  myBus = new MidiBus(this, -1, 1);
    
  instring = axiom;
  //println(axiom);
  
  for(i=0;i<generations;i++) // 1 - loop through the generations
  {
    outstring = "";
    int howlong = instring.length(); // how long is the string we're analyzing?
    int howmanyrules = rules.length; // how many rules do we have?
    for(j=0;j<howlong;j++) // 2 - loop through the input string
    {
      ismatching = 0;
      for(k=0;k<howmanyrules;k++) // 3 - loop through the rules
      {
        if(instring.charAt(j)==rules[k][0].charAt(0)) ismatching++;
         if(ismatching>0) {
          outstring=outstring+rules[k][1];
          k = howmanyrules; 
         }
      }
      if(ismatching==0)
      {
       outstring=outstring+instring.charAt(j); 
      }
    }
  instring = outstring; 
  //println(outstring);
  
  }
  
  // the original example created a CMIX score; here we're sending MIDI messages.
  for(i=0;i<outstring.length();i++)
  {
    int channel = 1;
    int pitch = 0;
    int velocity = 20;
    int duration = 100;
    if(outstring.charAt(i)=='A') {
      pitch = 69;
      velocity = 50;
      duration = 300;
    }
    if(outstring.charAt(i)=='B'){
       pitch = 71;
       velocity = 120;
       duration = 800;
    }
    myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
    delay(duration);
    myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
  
  }


}



void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
