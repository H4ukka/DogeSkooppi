class GraphNode {
  
  private float x = 0;
  private float y = 0;
  private float windowYoffset = 0;
  private float s = 0;
  
  private boolean locked;
  
  GraphNode(){}
  
  void setY (float v) { y = v; }
  float getY() { return y; }
  
  void setWindowYoffset (float v) { windowYoffset = v; }
  
  void update (float xpos, float scalars) {
    x = xpos;
    s = scalars;
    
    if(locked) {
      fill(#00f100);
      stroke(#00f100);
    }
    ellipse(x,windowYoffset - y * scalars,5,5);
    noFill();
    
    if(mousePressed && over()) {
      locked = true;
    }
    if(!mousePressed) {
      locked = false;
    }
    if(locked) {
      y = (windowYoffset - mouseY) / s;
    }
    
  }
  boolean over() {
    if(mouseX > x-5 && mouseX < x+5 && mouseY > windowYoffset-5 - y* s && mouseY < windowYoffset+5 - y* s) {
      return true;
    }else{
      return false;
    }
  }
}