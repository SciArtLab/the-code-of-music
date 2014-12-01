//create an instrument
var keys = new Tone.MonoSynth();
    keys.setPreset("Pianoetta");
    keys.setVolume(-10);
    keys.toMaster();

var playing = false;

var fmin, fmax;
var vmin, vmax;
var dmin, dmax;

function setup() {
  noCanvas();
  fmin = 20;
  fmax = 2000;x

  vmin = 10;
  vmax = 100;

  dmin = 20; //in millis
  dmax = 2000;

  var duration;
  setupInterfaceControls();
 
  Tone.Transport.setInterval(function(time){
      var freq = floor(random(fmin, fmax));
      var velocity = random(vmin, vmax)/100;  
      // var exp = floor(random(0, 6));
      // duration = pow(2,exp) + "n";    //for example, 8n, 16n.
      duration = random(dmin, dmax)/1000;
      keys.triggerAttackRelease(freq, duration, time, velocity);
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

function setupInterfaceControls(){
  $( "#frequency-slider" ).slider({
    range: true,
    min: fmin,
    max: fmax,
    values: [ 75, 300 ],
    slide: function( event, ui ) {
      $( "#freq-amount" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
      fmin = $( "#frequency-slider" ).slider( "values", 0 ); 
      fmax = $( "#frequency-slider" ).slider( "values", 1 );
    }
  });
  $( "#freq-amount" ).val(  $( "#frequency-slider" ).slider( "values", 0 ) +
    " - " + $( "#frequency-slider" ).slider( "values", 1 ) );

  $( "#velocity-slider" ).slider({
      range: true,
      min: vmin,
      max: vmax,
      values: [ 10, 80 ],
      slide: function( event, ui ) {
        $( "#velocity-amount" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        vmin = $( "#velocity-slider" ).slider( "values", 0 ); 
        vmax = $( "#velocity-slider" ).slider( "values", 1 );
      }
    });
  $( "#velocity-amount" ).val(  $( "#velocity-slider" ).slider( "values", 0 ) +
    " - " + $( "#velocity-slider" ).slider( "values", 1 ) );

  $( "#duration-slider" ).slider({
      range: true,
      min: dmin,
      max: dmax,
      values: [ dmin, dmax ],
      slide: function( event, ui ) {
        $( "#duration-amount" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
        dmin = $( "#duration-slider" ).slider( "values", 0 ); 
        dmax = $( "#duration-slider" ).slider( "values", 1 );
      }
    });
  $( "#duration-amount" ).val( $("#vduration-slider" ).slider( "values", 0 ) +
    " - " + $( "#duration-slider" ).slider( "values", 1 ) );
}
