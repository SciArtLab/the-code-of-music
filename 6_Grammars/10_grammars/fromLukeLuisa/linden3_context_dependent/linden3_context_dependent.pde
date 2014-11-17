// let's make a context-dependent L-system
import themidibus.*; 
MidiBus midiBus;

// how many generations
int generations = 40;

// the axiom is the string you prime the system with
String axiom = "__________________________________________1________________________________________";

// first rule of L-systems: don't talk about L-systems
String[][] rules = {
{"1", "1", "1", "_"}, 
{"1", "1", "_", "_"}, 
{"1", "_", "1", "_"}, 
{"1", "_", "_", "1"}, 
{"_", "1", "1", "_"}, 
{"_", "1", "_", "_"}, 
{"_", "_", "1", "1"}, 
{"_", "_", "_", "_"}
};

int ismatch = 0;

String instring, outstring;



void setup(){
  MidiBus.list(); 
  midiBus = new MidiBus(this, -1, 1);
  println(axiom);
  instring = axiom;

  for(int i=0;i<generations;i++) {
     outstring = ""; 
     
     int thelength = instring.length(); // how long is the string
     int numrules = rules.length; // how many rules do we have
    //println(numrules);
     
     // loop through the string
     for(int j=0;j<thelength;j++) {
           int now = j;
           int pre = (j+thelength-1)%thelength;
           int post = (j+thelength+1)%thelength;
           //println(pre + " " + now + " " + post);
  
         for(int k=0;k<numrules;k++)
         {
         ismatch = 0;
  
           if(instring.charAt(pre)==rules[k][0].charAt(0)) ismatch++;
  
           if(instring.charAt(now)==rules[k][1].charAt(0)) ismatch++;
  
           if(instring.charAt(post)==rules[k][2].charAt(0)) ismatch++;
  
            if(ismatch==3) {
               outstring=outstring+rules[k][3];
               k = numrules;
            }
         }
         if(ismatch==0)
         {
           println("not matching");
            outstring=outstring+instring.charAt(j); 
         }
       
     }
   
     instring = outstring;
     println(outstring);
  }
  
  float thepitch = 0.82;
  float thetime=0.0;
  float therate = 1;
  for(int i =0;i<instring.length();i++)
  {
    if(instring.charAt(i) == '[') {
       therate=therate*0.5;
    }
    if(instring.charAt(i) == ']') {
       therate=therate*2.0;
    }
    if(instring.charAt(i) == '+') {
       thepitch+=0.07;
    }
    if(instring.charAt(i) == '-') {
       thepitch-=0.07;
    }
    if(instring.charAt(i) == 'F') {
       println("i 1 " + thetime + " " + therate*3.0 + " " + thepitch);
      thetime+=therate;
    }
    int channel = 1;
    midiBus.sendNoteOn(channel, floor(thepitch*127), 100); // Send a Midi noteOn
    delay(floor(therate*50));
    midiBus.sendNoteOff(channel, floor(thepitch), 0); // Send a Midi nodeOff
  }

}

