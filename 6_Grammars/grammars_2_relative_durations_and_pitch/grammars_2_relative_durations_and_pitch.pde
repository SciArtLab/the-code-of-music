import themidibus.*; 
MidiBus midiBus;

// how many generations
int generations = 3;

// the axiom is the string you prime the system with
String axiom = "F";

String[][] rules = {{"F", "FF+[+F-F-F]-[-F+F+F]"}};

int ismatch = 0;

String instring, outstring;

void setup(){
  MidiBus.list(); 
  midiBus = new MidiBus(this, -1, 1);
  
  instring = axiom;

    for(int i=0;i<generations;i++) {
       outstring = ""; 
       
       int thelength = instring.length(); // how long is the string
       int numrules = rules.length; // how many rules do we have
       
       // loop through the string
       for(int j=0;j<thelength;j++) {
           ismatch = 0;
           for(int k=0;k<numrules;k++)
           {
             if(instring.charAt(j)==rules[k][0].charAt(0)) ismatch++;
              if(ismatch>0) {
                 outstring=outstring+rules[k][1];
                 k = numrules;
              }
           }
           if(ismatch==0)
           {
              outstring=outstring+instring.charAt(j); 
           }
         
       }
     
       instring = outstring;
       println(outstring);
       //println();
    }
    
    float thepitch = 0.52;//82
    float thetime= 0.0;
    float therate = 1;//duration??
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
//        println("i 1 " + thetime + " " + therate*3.0 + " " + thepitch);
        thetime+=therate;
        
        int channel = 1;
        midiBus.sendNoteOn(channel, floor(thepitch*127), 100); // Send a Midi noteOn
        delay(floor(therate*400));
        midiBus.sendNoteOff(channel, floor(thepitch), 0); // Send a Midi nodeOff
      }
    }

}

void draw(){

}


void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}



