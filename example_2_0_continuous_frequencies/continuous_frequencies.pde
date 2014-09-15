import beads.*;
import java.util.Arrays; 

AudioContext ac;
Glide freqEnv;

void setup() {
  size(300,300);
  ac = new AudioContext();
  freqEnv = new Glide(ac, 400);
  //this time we use the Glide object because it smooths the mouse input. 
  //freqEnv.addSegment(400, 100);
  WavePlayer wp = new WavePlayer(ac, freqEnv, Buffer.SINE);
  Gain g = new Gain(ac, 1, 0.1);
  g.addInput(wp);
  ac.out.addInput(g);
  ac.start();
}

/*
 * The drawing code also has some mouse listening code now.
 */
color fore = color(255, 102, 204);
color back = color(0,0,0);

/*
 * Just do the work straight into Processing's draw() method.
 */
void draw() {
  loadPixels();
  //set the background
  Arrays.fill(pixels, back);
  //scan across the pixels
  for(int i = 0; i < width; i++) {
    //for each pixel work out where in the current audio buffer we are
    int buffIndex = i * ac.getBufferSize() / width;
    //then work out the pixel height of the audio data at that point
    int vOffset = (int)((1 + ac.out.getValue(0, buffIndex)) * height / 2);
    //draw into Processing's convenient 1-D array of pixels
    vOffset = min(vOffset, height);
    pixels[vOffset * height + i] = fore;
  }
  updatePixels();
  //mouse listening code here
  freqEnv.setValue(map(mouseY, height, 0, 300, 400));
  println(freqEnv.getValue());
  
}
