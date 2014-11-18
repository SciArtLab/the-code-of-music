class SynthTrack extends Track{  
  Noise noise; 
  Gain gain;
  AudioContext ac;
  
  
  SynthTrack(Sequencer _parent){
     super(_parent);
     ac = _parent.ac;
  }
  
  void onBeat(Clock c){
    int beat = seq.currentBeat;
    if(beat == 0)
    {
       noise = new Noise(seq.ac);
       gain = new Gain(seq.ac, 1, new Envelope(ac, 0.05));
       gain.addInput(noise);
       seq.ac.out.addInput(gain);
       ((Envelope)gain.getGainEnvelope()).addSegment(0, 100);
    }
    int pitch = Pitch.forceToScale((int)random(12), Pitch.dorian);
    float freq = Pitch.mtof(pitch + (int)random(5) * 12 + 32);
    
// maybe this should be in a 'playNote' function
// and there's also a 'playChord'
    WavePlayer wp = new WavePlayer(seq.ac, freq, Buffer.SINE);
    Gain g = new Gain(ac, 1, new Envelope(ac, 0));
    g.addInput(wp);
    ac.out.addInput(g);
    ((Envelope)g.getGainEnvelope()).addSegment(0.1, 100);
    ((Envelope)g.getGainEnvelope()).addSegment(0, parent.beatLength/parent.beatsPerMeasure, new KillTrigger(g));
    
    
  }

}
