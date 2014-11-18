import controlP5.*;

ControlP5 cp5;

RadioButton scale, root, span;
Slider syncopation;
Numberbox bpm, num, denom;

Sequencer seq;
SequencerInterface face; 
SequencerInterface rectangular, circular;


void setup(){   
   size(1200, 768); 
  //we need to initialize it:
  seq = new Sequencer();  
  circular = new CircularInterface();
  rectangular = new RectangularInterface();
  face = circular;
  setupControls();
  
}

void draw(){
  face.draw();    
}

void keyReleased(){
  if(key == 'c'){
    face = circular;
  }
  else if(key == 'r'){
    face = rectangular;
  }
}

void setupControls(){
  cp5 = new ControlP5(this);
  //MELODY CONTROLS
  //add tuning system
  //add 'create new system from picking frequencies'
  //add max and min interval
  root = cp5.addRadioButton("root")
            .setPosition(x(0), y(0))            
            .setSize(col_w/2, row_h)  
            .setSpacingColumn(col_w/2)
            .setValue(0)
            ;  
  scale = cp5.addRadioButton("scale")
            .setPosition(x(0), y(1))
            .setSize(col_w, row_h)  
            .setSpacingColumn(col_w);        
            ;
  span = cp5.addRadioButton("span")
            .setPosition(x(0), y(3))
            .setSize(col_w/2, row_h)  
            .setSpacingColumn(col_w/2)
            ;
  cp5.addTextlabel("octaves")
            .setText("OCTAVES")
            .setPosition(x(6) + 4, y(3)+3)
            ;
  
  //RHYTHM 
  //add accents, and polyrhythm    
  bpm = cp5.addNumberbox("bpm")
            .setPosition(x(0), y(6))
            .setSize(col_w, row_h) 
            .setValue(120); 
  
  //subdivision
  num = cp5.addNumberbox("num")
            .setPosition(x(2), y(6))
            .setSize(col_w, row_h) 
            .setValue(6)
            .setRange(1,32);
  denom = cp5.addNumberbox("denom")
            .setPosition(x(3) + pad*4, y(6))
            .setSize(col_w, row_h)
            .setValue(4);;
  cp5.addTextlabel("over")
    .setText("/")
    .setPosition(x(3), y(6)+3)
    ;  

  syncopation = cp5.addSlider("syncopation")
            .setPosition(x(0), y(8))
            .setSize(col_w*4, row_h);
            
  load(scale, seq.theory.scales.keySet().toArray());  //add 'getScales' to Theory class
  load(root, seq.theory.notes.keySet().toArray()); 
//  load(span, spans);
}

void load(RadioButton r, Object[] items) {
  for (int i=0; i<items.length;i++) {
    r.addItem((String)items[i], i)
    .setItemsPerRow(items.length);
    
  }
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(scale)){
    print("got an event from "+theEvent.getName()+"\t");
    for(int i=0;i<theEvent.getGroup().getArrayValue().length;i++) {
      print(int(theEvent.getGroup().getArrayValue()[i]));
    }
    println("\t "+theEvent.getValue());
//    myColorBackground = color(int(theEvent.group().value()*50),0,0);
  }

}

void radioButton(int a) {
  println("a radio Button event: "+a);
}

void bpm(int _bpm) {
  seq.setBpm(_bpm);
}

void num(int _num) {
  seq.setBeatsPerMeasure(_num);
}

void scale(int _scalePos){
  println(_scalePos);
//  seq.setScale(_scaleKey);
}

void root(int _rootPos){
  println(_rootPos);
//  seq.setRoot(_rootKey);
}




