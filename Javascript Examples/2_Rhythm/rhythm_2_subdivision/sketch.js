var kit;

//change tempo here
var bpm = 200;

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
    
    console.log(Tone.Transport.getTransportTime());
    var beat = Tone.Transport.getTransportTime().split(":")[1];
    if(beat == 0){
      kit.triggerAttack("kick", time);
      kit.triggerAttack("hh", time); 
    }  
    if(beat == 1){
      kit.triggerAttack("hh", time); 
    } 
    if(beat == 2){
      kit.triggerAttack("hh", time); 
      kit.triggerAttack("snare", time); 
    }  
    if(beat == 3){
      kit.triggerAttack("hh", time); 
    } 

  }, "4n");
 
 Tone.Transport.setBpm(bpm);
 Tone.Transport.setTimeSignature(4, 4);
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
