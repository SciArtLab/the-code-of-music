
//Tone.js
var keys = new Tone.MonoSynth();
    keys.setPreset("Pianoetta");
    keys.setVolume(-10);
    keys.toMaster();

var root = teoria.note('a4');  
var theScale = root.scale('minor'); 

var currentNote;
var playing = false;

function setup() {
  noCanvas();
  var button = getElement('button');
  button.mousePressed(play);
  //start at a random note
  var pos = floor(random(1, theScale.scale.length));
  currentNote = theScale.get(pos);

  var output = getElement('name');

  Tone.Transport.setInterval(function(time){
      var direction = "";
      if(random(0,1)>0.5) direction ="-"
        // 'm' = minor, 'M' = major, 'A' = augmented and 'd' = diminished
      currentNote.transpose("M" + direction + "3");
      // console.log(currentNote);
      var velocity = 0.4 + Math.random() * 0.5;
      keys.triggerAttackRelease(currentNote.fq(), "8n", time, velocity);      
    }, "8n");
 
 Tone.Transport.setBpm(100);
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

