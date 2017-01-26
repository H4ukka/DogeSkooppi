class GraphingPanel {
  private int view_x;
  private int view_y;
  private int view_width;
  private int view_height;
  
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
  
  private String label = "";
  
  private color graphColor;
  
  float values[];
  GraphNode[] nodes;
  
  private float a_multip;
  
  private ArrayList<GraphingPanel> parentPanelList = new ArrayList<GraphingPanel>();
  
  GraphingPanel(int x, int y, int w, int h, float a, float start_a, String l, color c, int r, float amplitude, float scalar) {
    view_x = x;
    view_y = y;
    view_width = w;
    view_height = h;
    
    amp = amplitude;
    
    label = l;
    graphColor = c;
    
    divs = 4;
    divX = 1;
    
    div_width = view_height / divs;
    
    m = 100;
    resolution = r;
    a_multip = a;
    a_start = start_a;
    
    UpdateResolution();
    
    preCalcValues();

    vertical_scalar = scalar;
  }
  
  void UpdateResolution () {
    
    step_length = (float)view_width / (float)resolution;
    
    values = new float[resolution + 1];
    nodes = new GraphNode[resolution + 1];
    
    for(int i = 0; i < nodes.length; i++) {
      nodes[i] = new GraphNode();
      nodes[i].setWindowYoffset(view_y + view_height/2);
    }
  }
  
  void calcMinMax () {
    min = 0;
    max = 0;
    for(int i = 0; i < resolution; i++) {
      if(abs(values[i]) > max) max = abs(values[i]);
      if(abs(values[i]) < min) min = abs(values[i]);
    }
    vertical_scalar = (view_height / 2) / max - 1;
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
      total += nodes[i].getY() * ((float)step_length * (float)1 / (float)view_width);
    }
    println(total);
  }
  
  void Width (int w) { view_width = w; }
  void Height (int h) { view_height = h; }
  void AnchorX (int x) { view_x = x; }
  void AnchorY (int y) { view_y = y; }
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
    }
 
    x = view_x;
    
    noFill();
    
    stroke(#29283d);
    strokeWeight(1);
    drawGrid();
    
    strokeWeight(1);
    beginShape();

    for(int i = 0; i <= resolution; i++) {
      stroke(graphColor);
      fill(graphColor);
      vertex(x, (view_y + view_height/2) - (nodes[i].getY() * vertical_scalar));
      nodes[i].update(x, vertical_scalar);
      if (calculateFromParents) { 
        rectMode(CORNERS);
        fill(graphColor, 50);
        noStroke();
        rect(x - (step_length / 2), (view_y + view_height/2) - (nodes[i].getY() * vertical_scalar), x + (step_length / 2), view_y + view_height/2);
        stroke(graphColor);
        noFill();
        rectMode(CORNER);
      }
      x += step_length;
    }
    
    endShape();
    
    strokeWeight(1);
    stroke(#3a3856);
    rect(view_x, view_y, view_width, view_height, 3);
    strokeWeight(1);
    
    drawTexts();
  }
  
  void drawTexts() {
    textSize(14);
    fill(#a4a5c4);
    text(label, view_x, view_y - 4);
  }
  
  void drawGrid() {
    // Vertical lines
    for(float i = div_width; i < view_width - div_width; i+=div_width) {
      line(view_x + i, view_y, view_x + i, view_y + view_height);
    }
    // Horizontal lines
    for(float i = div_width; i < view_height - div_width; i+=div_width) {
      line(view_x, view_y + i, view_x + view_width, view_y + i);
    }
  }
}