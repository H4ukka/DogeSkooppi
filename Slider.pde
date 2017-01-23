class Slider {
  
  //graphics
  int xpos;      //slider x position
  int ypos;      //slider y position
  int xlength;   //length of the slider (X)
  int ylength;   //length of the slider (Y)
  color active;  //color when active
  color def;     //default color
  color slider;  //slider's color
  color empty;   //slider back color
  String Label;
  
  //mechanics
  float dmouse;  //difference between mouseX and value
  float value;   //slide value
  float maxval;  //max x value
  float minval;  //min x value
  
  float maxvalue;//max slider value
  float minvalue;
  float slideval;//mapped slider value
  
  //bools
  boolean texts;
  boolean animations;
  boolean over;
  boolean locked;
  
  private ArrayList<GraphingPanel> targets = new ArrayList<GraphingPanel>();
  
  Slider (int X, int Y, int XL, int YL, float maxv, float minv, float startv, boolean A, boolean T, String label) {
    
    xpos = X;
    ypos = Y;
    xlength = XL;
    ylength = YL;
    texts = T;
    animations = A;
    active = #5ABFFF;
    def = #3582D3;
    empty = #101010;
  
    slideval = startv;
    value = xpos + startv;
    minval = xpos;
    maxval = xpos + xlength;
    
    maxvalue = maxv;
    minvalue = minv;
    
    Label = label;
    
  }
  
  void AddTarget (GraphingPanel t) { targets.add(t); }
  
  void update() {
    
    //graphics
    noStroke();
    fill(empty);
    rect(xpos, ypos, xlength + 10, ylength);
    
    fill(slider);
    rect(value, ypos, 10, ylength);
    
    fill(#a4a5c4);
    text(Label,xpos,ypos - 8);
   
    //mechanics
    if(over()) {
     over = true;
     slider = active;
   }else{
     over = false;
     slider = def;
   }
   if(mousePressed && over) {
     locked = true;
   }
   if(!mousePressed) {
     locked = false;
   }
   if(locked) {

       value = constrain(mouseX,minval,maxval);
       slider = active;
       
       for(int i = 0; i < targets.size(); i++){
         targets.get(i).SetResolution((int)slideval);
       }
   }
     
   slideval = map(value, minval, maxval, minvalue, maxvalue);
   
  }
  
  boolean over() {
      if(mouseX > value && mouseX < value+10 && mouseY > ypos-10 && mouseY < ypos+10) {
        return true;
      }else{
        return false;
      }
  }
  
  float getval () {
    return slideval;
  }
}
  