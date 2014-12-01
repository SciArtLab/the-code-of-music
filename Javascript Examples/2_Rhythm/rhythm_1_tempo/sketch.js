var kit;

//change tempo here
var bpm = 100;

var currentNote;
var playing = false;

function preload(){
  kit = new Tone.MultiSampler({
      "kick" : "../../audio/505/kick.mp3",
      "snare" : "../../audio/505/snare.mp3",
      "hh" : "../../audio/505/hh.mp3"
    });
  kit.setVolume(-10);
  kit.toMaster();
}
function setup() {
  noCanvas();
  var button = getElement('button');
  button.mousePressed(play);
  Tone.Transport.setInterval(function(time){
    kit.triggerAttack("kick", time);
    }, "4n");
 
 Tone.Transport.setBpm(bpm);
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

