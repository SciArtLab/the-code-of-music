//create an instrument
var tone = new Tone();
var keys = new Tone.MonoSynth();
    keys.setPreset("Pianoetta");
    keys.setVolume(-10);
    keys.toMaster();

var playing = false;

function setup() {
  noCanvas();
  var output = getElement('name'); 

  Tone.Transport.setInterval(function(time){
      var midiNote = floor(random(20, 127));
      var note = tone.midiToNote(midiNote);
      var velocity = 0.4 + Math.random() * 0.5;
      keys.triggerAttackRelease(note, "8n", time, velocity); 
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
