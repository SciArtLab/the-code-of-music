//a partial port of Teoria.js

class Theory{
  
  HashMap<String, PVector> notes, intervals;
  HashMap<String, String[]> scales;
  String[] intervalFromFifth = {"second", "sixth", "third", "seventh", "fourth", "unison", "fifth"};
  String[] intervalsIndex = {"unison", "second", "third", "fourth", "fifth",
                        "sixth", "seventh", "octave", "ninth", "tenth",
                        "eleventh", "twelfth", "thirteenth", "fourteenth",
                        "fifteenth"};
  // linaer index to fifth = (2 * index + 1) % 7
  String[] fifths = {"f", "c", "g", "d", "a", "e", "b"};
  String[] accidentals = {"bb", "b", "", "#", "x"};
  PVector sharp;
//  Note A4;
  
  
  
  Theory(){
    
    notes = new HashMap<String, PVector>();    
    notes.put("c", new PVector(0, 0));
    notes.put("d", new PVector(-1, 2));
    notes.put("e", new PVector(-2, 4));
    notes.put("f", new PVector(1, -1));
    notes.put("g", new PVector(0, 1));    
    notes.put("a", new PVector(-1, 3));    
    notes.put("b", new PVector(-2, 5));
    
    
    intervals = new HashMap<String, PVector>();
    intervals.put("unison", new PVector(0, 0));
    intervals.put("second", new PVector(3, -5));
    intervals.put("third", new PVector(2, -3));
    intervals.put("fourth", new PVector(1, -1));
    intervals.put("fifth", new PVector(0, 1));
    intervals.put("sixth", new PVector(3, -4));
    intervals.put("seventh", new PVector(2, -2));
    intervals.put("octave", new PVector(1, 0));
    
    
    
    scales = new HashMap<String, String[]>();
    String [] major = {"major second", "major third", "fourth", "fifth", "major sixth", "major seventh"};
    String [] naturalMinor = {"major second", "minor third", "fourth", "fifth", "minor sixth", "minor seventh"};
    String [] harmonicMinor = {"major second", "minor third", "fourth", "fifth", "minor sixth", "major seventh"};
    String [] majorPentatonic = {"major second", "major third", "fifth", "major sixth"};
    String [] minorPentatonic = {"minor third", "fourth", "minor sixth", "minor seventh"};
    
    scales.put("major", major);
    scales.put("natural minor", naturalMinor);
    scales.put("harmonic minor", harmonicMinor);
    scales.put("major pentatonic", majorPentatonic);
    scales.put("minor pentatonic", minorPentatonic);

    
    sharp =  new PVector(-4, 7);
//    A4 = add(notes.get("a"), new PVector(4, 0));
    
    
  }  
}

