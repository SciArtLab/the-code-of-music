//We'll start from this example from Luke Duboi's Algorithmic composition class.

// axiom = A
// rule1 = A -> B
// rule2 = B -> BA

// set the number of generations
int generations = 2;

// what we're gonna start with
String axiom = "A";

// we need an array of rules
String[][] rules = {{"A", "B"}, {"B", "BA"}};

String instring, outstring;

int i, j, k;
int ismatching = 0;


void setup() {

instring = axiom;
println(axiom);

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
instring = outstring; // we know we're doing this at the end
println(outstring);

}


}
