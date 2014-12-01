
//Tone.js
var keys = new Tone.PolySynth(3, Tone.MonoSynth, Tone.MonoSynth.prototype.preset.Pianoetta);
    keys.setVolume(-30);
    keys.toMaster();

var root = teoria.note('a2');  
var theScale = root.scale('minor'); 

var currentNote;
var playing = false;

function setup() {
  noCanvas();
  var button = getElement('button');
  button.mousePressed(play);

  Tone.Transport.setInterval(function(time){
      var pos = floor(random(1, theScale.scale.length));
      currentNote = theScale.get(pos);
      var parallelNote = currentNote.interval("P-5");
      var velocity = 0.4 + Math.random() * 0.5;
      //first voice
      keys.triggerAttackRelease(currentNote.scientific(), "8n", time, velocity);   
      keys.triggerAttackRelease(parallelNote.scientific(), "8n", time, velocity);

    }, "8n");
 
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

