/*
  Single-Line Textfield
  ---------------------
  ©2012
*/

class Entry extends View {

  int t;
  float lx;
  int sl;
  float tw;
  String d;
  String l;
  String value;
  String ht;
  color cm;
  boolean maxchar;
  boolean typ;
  boolean act;
  
  private GraphingPanel target;
  
  Entry (int X, int Y, int XL, String L) {
    XAnchor(X);
    YAnchor(Y);
    Width(XL);
    l = L;
    cm = #101010;
    d = "";
    //textFont(f);
  }
  
  Entry (int X, int Y, int XL, String L, String HT) {
    XAnchor(X);
    YAnchor(Y);
    Width(XL);
    l = L;
    cm = #101010;
    ht = HT;
    //textFont(f);
   
  }
  
  Entry (int X, int Y, int XL, String L, String HT, String DD) {
    XAnchor(X);
    YAnchor(Y);
    Width(XL);
    l = L;
    cm = #101010;
    ht = HT;
    d = DD;
    //textFont(f);
   
  }
  
  Entry (int X, int Y, int XL, String L, int DV) {
    XAnchor(X);
    YAnchor(Y);
    Width(XL + 5); //??
    l = L;
    cm = #101010;
    d = str(DV);
    //textFont(f);
    
  }
  
  void setTarget (GraphingPanel t) { target = t; }
  
  void update () {
    textSize(14);
    this.display();
    if((mouseX >= XAnchor() && mouseX <= XAnchor()+140+Width() && mouseY >= YAnchor() && mouseY <= YAnchor()+20) || act == true) {
      if(mousePressed) {
        typ = true;
        act = true;
      }
    }else{
      this.passive();
      act = false;
    }
    if(typ == true){
      this.typing();
    }
    if((mouseX <= XAnchor() || mouseX >= XAnchor()+140+Width() || mouseY <= YAnchor() || mouseY >= YAnchor()+20) && mousePressed) {
      act = false;
    }

  }
  
  void display () {
    noStroke();
    tw = textWidth(l);
    fill(#0f0e16);
    //rect(x,y,x+tw,20);
    rect(XAnchor()+tw+15,YAnchor(),Width(),20);
    fill(#a4a5c4);
    text(l,XAnchor()+5,YAnchor()+15);
    fill(255);
    text(d,XAnchor()+tw+20,YAnchor()+15);
    if(act == true) {
      this.tline();
    }
    if(textWidth(d) > Width()-15) {
      maxchar = true;
    }else{
      maxchar = false; 
    }
  }
  
  void active () {
    typ = true;
  }
  
  void passive () {
    typ = false;
  }
  
  void typing () {
    if(typed == true && typ == true && maxchar == false) {
      if(key != CODED && key != BACKSPACE && key != ENTER) { 
        d = d + key;
        typed = false;
      }
        
    }
    if(key == BACKSPACE && d.length() != 0 && typed == true) {
         d = d.substring(0, d.length() - 1);
         typed = false;
      } 
    if(typ == true && typed == true) {
      if(key == ENTER) {
         value = d;
         typed = false;
         this.passive();
         act = false;
         target.setStartAngleInRadians(radians(float(d)));
      }
    }
  }
  
  void tline() {
    lx = textWidth(d);
    if(t <= 10){  
      stroke(255);
      line(XAnchor()+23+tw+lx,YAnchor()+4,XAnchor()+tw+lx+23,YAnchor()+16);
      noStroke();
    }
    if(t == 20) {
      t = 0;
    }
    t++;
  }
  
  void setval (String tn) {
    d = tn;
  }
  
  String getval () {
    return d;
  } 
  
  void changecolor (color Cnew) {
    cm = Cnew;
  }
  
}

public boolean typed;

public void keyTyped () {
  typed = true;
}
  