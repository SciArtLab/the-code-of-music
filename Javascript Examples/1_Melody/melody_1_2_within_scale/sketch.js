//create an instrument
var keys = new Tone.MonoSynth();
    keys.setPreset("Pianoetta");
    keys.setVolume(-10);
    keys.toMaster();

var tone = new Tone();

var playing = false;
var root = 60;

function setup() {
  noCanvas();
  var output = getElement('name'); 
 
 var scale = [0, 2, 4, 5, 7, 9, 11];
// CHROMATIC_SCALE = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11},
// MAJOR_SCALE = {0, 2, 4, 5, 7, 9, 11},
// MINOR_SCALE = {0, 2, 3, 5, 7, 8, 10},
// HARMONIC_MINOR_SCALE = {0, 2, 3, 5, 7, 8, 11},
// MELODIC_MINOR_SCALE = {0, 2, 3, 5, 7, 8, 9, 10, 11}, // mix of ascend and descend
// NATURAL_MINOR_SCALE = {0, 2, 3, 5, 7, 8, 10},
// DIATONIC_MINOR_SCALE = {0, 2, 3, 5, 7, 8, 10},
// AEOLIAN_SCALE = {0, 2, 3, 5, 7, 8, 10},
// DORIAN_SCALE = {0, 2, 3, 5, 7, 9, 10},  
// LYDIAN_SCALE = {0, 2, 4, 6, 7, 9, 11},
// MIXOLYDIAN_SCALE = {0, 2, 4, 5, 7, 9, 10},
// PENTATONIC_SCALE = {0, 2, 4, 7, 9},
// BLUES_SCALE = {0, 2, 3, 4, 5, 7, 9, 10, 11}

  Tone.Transport.setInterval(function(time){
      var note_pos = floor(random(0, scale.length));
      var velocity = 0.4 + Math.random() * 0.5;
      var exp = floor(random(0, 6));
      duration = pow(2,exp) + "n";    //for example, 8n, 16n.
      var note = tone.midiToNote(root + scale[note_pos]);
      keys.triggerAttackRelease(note, duration, time, velocity); 
    }, "8n");
 
 Tone.Transport.setBpm(100);
  var button = getElement('button');
  button.mousePressed(play);
}

function play() {  
  if(playing){
    Tone.Transport.stop();
    getElement('button').html('play');
    playing = false;
  }
  else{
    Tone.Transport.start();
    getElement('button').html('stop');
    playing = true;
  }
  
}
