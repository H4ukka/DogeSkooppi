class GraphingPanel {
  private int view_x;
  private int view_y;
  private int view_width;
  private int view_height;
  
  private int divs;
  
  private int resolution;
  
  private boolean calculateFromParents;
  
  private float a;
  private float m;
  private float x;
  
  private float step_length;
  private float vertical_scalar;
  
  private float min;
  private float max;
  
  private float divX;
  private int div_width;
  
  float values[];
  
  private float a_multip;
  
  private ArrayList<GraphingPanel> parentPanelList = new ArrayList<GraphingPanel>();
  
  GraphingPanel(int x, int y, int w, int h, float a) {
    view_x = x;
    view_y = y;
    view_width = w;
    view_height = h;
    
    divs = 10;
    divX = 1;
    
    div_width = view_height / divs;
    
    m = 100;
    resolution = 200;
    a_multip = a;
    
    values = new float[resolution + 1];
    
    preCalcValues();
    
    step_length = (float)view_width / (float)resolution;
    
    vertical_scalar = div_width;
    
    calcMinMax();
  }
  
  void calcMinMax () {
    min = 0;
    max = 0;
    for(int i = 0; i < resolution; i++) {
      if(values[i] > max) max = values[i];
      if(values[i] < min) min = values[i];
    }
    
    //vertical_scalar = (view_height / 2) / max - 1;
  }
  
  void preCalcValues() {
    a = 0;
    for(int i = 0; i < resolution; i++) {
      values[i] = sin(a);
      a += (TWO_PI / resolution) * a_multip;
    }
  }
  
  void Width (int w) { view_width = w; }
  void Height (int h) { view_height = h; }
  void AnchorX (int x) { view_x = x; }
  void AnchorY (int y) { view_y = y; }
  void CalculateFromParents (boolean b) { calculateFromParents = b; }
  void VerticalScalar (float f) { vertical_scalar = f; }
  
  void AddParentPanel (GraphingPanel panel) {
    parentPanelList.add(panel);
  }
  
  void calculateValuesFromParents() {
    for(int i = 0; i < resolution; i++) {
      float y = 0;
      for(int j = 0; j < parentPanelList.size(); j++) {
        y += parentPanelList.get(j).values[i];
      }
      values[i] = y;
    }
    calcMinMax();
  }
  
  void update () {
    x = view_x;
    
    noFill();
    
    stroke(30);
    strokeWeight(1);
    drawGrid();
    
    stroke(255);
    strokeWeight(2);
    beginShape();

    for(int i = 0; i <= resolution; i++) {
      vertex(x, view_y + values[i] * vertical_scalar + view_height/2);
      x += step_length;
    }
    
    endShape();
    
    strokeWeight(2);
    rect(view_x, view_y, view_width, view_height);
  }
  
  void drawGrid() {
    for(int i = div_width; i < view_width; i+=div_width) {
      line(view_x + i, view_y, view_x + i, view_y + view_height);
    }
    for(int i = div_width; i < view_height; i+=div_width) {
      line(view_x, view_y + i, view_x + view_width, view_y + i);
    }
  }
}