//This example combines Dan Shiffman's Markov Chains example (https://github.com/shiffman/Programming-from-A-to-Z-F14)
// with Tone.js to generate a melody

// An array of lines from a text file
var lines;
// The Markov Generator object
var generator;

//Tone
var keys = new Tone.PolySynth(3, Tone.MonoSynth, Tone.MonoSynth.prototype.preset.Pianoetta);
keys.setVolume(-30);
keys.toMaster();

var score;

// Preload the seed data
function preload() {
  lines = loadStrings('data/melody.txt');
}


function setup() {
  //Markov
  noCanvas();
  // The Markov Generator
  // First argument is N-gram length, second argument is max length of generated text
  generator = new MarkovGenerator(1, 2, true);
  // Feed all the lines from the text file into the generator
  // for (var i = 0; i < lines.length; i++) {
  //   generator.feed(lines[i]);
  // }
  generator.feed(lines[0]);
  // Set up a button
  var button = getElement('button');
  button.mousePressed(generate);

}

function generate() {
  // Display the generated text
  var output = getElement('name');
  var melody = generator.generate().split(' ');
  console.log(melody);

   //if the array is composed of other arrays time is the first value
    //the rest of the values are given to the callback in order
  // var score = {
  //   "keys" : [["0:0:2", ["E4", "G4", "A4"]], ["0:0:3", ["E4", "G4", "A4"]], ["0:1:3", ["E4", "G4", "A4"]]],
  // };

  var score = {
    "keys":[]
  };
   
  for(var i = 0; i < melody.length; i++){
    var time = "0:0:" + i.toString();
    var note = melody[i]
    score["keys"].push(
    [
      time, [melody[i], melody[i], melody[i]]
    ]
    );
  }
  println(score);

 //create events for all of the notes
 Tone.Note.parseScore(score);

 Tone.Note.route("keys", function(time, value){
      var velocity = Math.random() * 0.5 + 0.4;
      for (var i = 0; i < value.length; i++) {
        keys.triggerAttackRelease(value[i], "16n", time, velocity);
        println('callback');
      }
    });

 Tone.Transport.setLoopStart(0);
 Tone.Transport.setLoopEnd("1:0");
 Tone.Transport.loop = true;
 Tone.Transport.setBpm(100);

 Tone.Transport.start();
 console.log('asdf');

  
}
