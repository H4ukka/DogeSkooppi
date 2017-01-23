/*
  Single-Line Textfield
  ---------------------
  ©2012
*/

class Entry {
  int x;
  int y;
  int xl;
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
    x = X;
    y = Y;
    xl = XL;
    l = L;
    cm = #101010;
    d = "";
    //textFont(f);
  }
  
  Entry (int X, int Y, int XL, String L, String HT) {
    x = X;
    y = Y;
    xl = XL;
    l = L;
    cm = #101010;
    ht = HT;
    //textFont(f);
   
  }
  
  Entry (int X, int Y, int XL, String L, String HT, String DD) {
    x = X;
    y = Y;
    xl = XL;
    l = L;
    cm = #101010;
    ht = HT;
    d = DD;
    //textFont(f);
   
  }
  
  Entry (int X, int Y, int XL, String L, int DV) {
    x = X;
    y = Y;
    xl = XL+5;
    l = L;
    cm = #101010;
    d = str(DV);
    //textFont(f);
    
  }
  
  void setTarget (GraphingPanel t) { target = t; }
  
  void update () {
    this.display();
    if((mouseX >= x && mouseX <= x+140+xl && mouseY >= y && mouseY <= y+20) || act == true) {
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
    if((mouseX <= x || mouseX >= x+140+xl || mouseY <= y || mouseY >= y+20) && mousePressed) {
      act = false;
    }

  }
  
  void display () {
    noStroke();
    tw = textWidth(l);
    fill(100);
    //rect(x,y,x+tw,20);
    rect(x+tw+15,y,xl,20);
    fill(10);
    text(l,x+5,y+15);
    fill(255);
    text(d,x+tw+20,y+15);
    if(act == true) {
      this.tline();
    }
    if(textWidth(d) > xl-15) {
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
         println("Value 'value' in " + l + " assigned as " + value);
         target.setStartAngleInRadians(radians(float(d)));
      }
    }
  }
  
  void tline() {
    lx = textWidth(d);
    if(t <= 10){  
      stroke(255);
      line(x+23+tw+lx,y+4,x+tw+lx+23,y+16);
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
  