class GraphingPanel extends View {
  
  private int divs;
  
  private int resolution;
  
  private boolean calculateFromParents;
  
  private float a;
  private float a_start;
  private float m;
  private float x;
  
  private float amp;
  
  private float step_length;
  private float vertical_scalar;
  
  private float min;
  private float max;
  
  private float divX;
  private float div_width;
  
  private float integral;
  
  private String label = "";
  
  private color graphColor;
  
  float values[];
  GraphNode[] nodes;
  
  private float a_multip;
  
  private ArrayList<GraphingPanel> parentPanelList = new ArrayList<GraphingPanel>();
  
  GraphingPanel(int x, int y, int w, int h, float a, float start_a, String l, color c, int r, float amplitude, float scalar) {
    XAnchor(x);
    YAnchor(y);
    Width(w);
    Height(h);
    
    amp = amplitude;
    
    label = l;
    graphColor = c;
    
    divs = 4;
    divX = 1;
    
    div_width = Height() / divs;
    
    m = 100;
    resolution = r;
    a_multip = a;
    a_start = start_a;
    
    UpdateResolution();
    
    preCalcValues();

    vertical_scalar = scalar;
  }
  
  void UpdateResolution () {
    
    step_length = (float)Width() / (float)resolution;
    
    values = new float[resolution + 1];
    nodes = new GraphNode[resolution + 1];
    
    for(int i = 0; i < nodes.length; i++) {
      nodes[i] = new GraphNode();
      nodes[i].setWindowYoffset(YAnchor() + Height()/2);
    }
  }
  
  void calcMinMax () {
    min = 0;
    max = 0;
    for(int i = 0; i < resolution; i++) {
      if(abs(values[i]) > max) max = abs(values[i]);
      if(abs(values[i]) < min) min = abs(values[i]);
    }
    vertical_scalar = (Height() / 2) / max - 1;
  }
  
  void setStartAngleInRadians(float a) {
    a_start = a;
    preCalcValues();
  }
  
  void preCalcValues() {
    a = a_start;
    for(int i = 0; i <= resolution; i++) {
      values[i] = sin(a) * amp;
      nodes[i].setY(values[i]);
      a += (TWO_PI / resolution) * a_multip;
    }
  }
  
  void calcIntegral () {
    float total = 0;
    for(int i = 0; i <= resolution; i++) {
      total += nodes[i].getY() * ((float)step_length * (float)1 / (float)Width());
    }
    integral = total;
  }
  
  void CalculateFromParents (boolean b) { calculateFromParents = b; }
  void VerticalScalar (float f) { vertical_scalar = f; }
  void SetResolution (int r) { 
    resolution = r; 
    UpdateResolution();
    preCalcValues();
  }
  
  void AddParentPanel (GraphingPanel panel) {
    parentPanelList.add(panel);
  }
  
  void calculateValuesFromParents() {
    for(int i = 0; i <= resolution; i++) {
      
      float y = parentPanelList.get(0).nodes[i].getY();
      
      for(int j = 1; j < parentPanelList.size(); j++) {
        y *= parentPanelList.get(j).nodes[i].getY();
      }
      values[i] = y;
      nodes[i].setY(y);
    }
    calcMinMax();
  }
  
  void update () {
    
    if (calculateFromParents) {
      calculateValuesFromParents();
      calcIntegral();
      calcMinMax();
      
      text(integral, XAnchor(), YAnchor() + Height() + 20);
    }
 
    x = XAnchor();
    
    noFill();
    
    stroke(#29283d);
    strokeWeight(1);
    drawGrid();
    
    strokeWeight(1);
    beginShape();

    for(int i = 0; i <= resolution; i++) {
      stroke(graphColor);
      fill(graphColor);
      vertex(x, (YAnchor() + Height()/2) - (nodes[i].getY() * vertical_scalar));
      nodes[i].update(x, vertical_scalar);
      if (calculateFromParents) { 
        rectMode(CORNERS);
        fill(graphColor, 50);
        noStroke();
        rect(x - (step_length / 2), (YAnchor() + Height()/2) - (nodes[i].getY() * vertical_scalar), x + (step_length / 2), YAnchor() + Height()/2);
        stroke(graphColor);
        noFill();
        rectMode(CORNER);
      }
      x += step_length;
    }
    
    endShape();
    
    strokeWeight(1);
    stroke(#3a3856);
    rect(XAnchor(), YAnchor(), Width(), Height(), 3);
    strokeWeight(1);
    
    drawTexts();
  }
  
  void drawTexts() {
    textSize(14);
    fill(#a4a5c4);
    text(label, XAnchor(), YAnchor() - 4);
  }
  
  void drawGrid() {
    // Vertical lines
    for(float i = div_width; i < Width() - div_width; i+=div_width) {
      line(XAnchor() + i, YAnchor(), XAnchor() + i, YAnchor() + Height());
    }
    // Horizontal lines
    for(float i = div_width; i < Height() - div_width; i+=div_width) {
      line(XAnchor(), YAnchor() + i, XAnchor() + Width(), YAnchor() + i);
    }
  }
}