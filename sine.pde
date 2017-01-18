ArrayList<GraphingPanel> panels = new ArrayList<GraphingPanel>();
Window window = new Window();

void settings () {
  size(800, 900);
}

void setup () {
  
  //surface.setResizable(true);
  
  window.update();
  
  GraphingPanel p1 = new GraphingPanel(10, 10, 500, 250, 1);
  GraphingPanel p2 = new GraphingPanel(10, 10 + height / 3, 500, 250, 2);
  GraphingPanel p3 = new GraphingPanel(10, 10 + (height / 3) * 2, 500, 250, 3);
  
  panels.add(p1);
  panels.add(p2);
  panels.add(p3);
  
  p3.AddParentPanel(p1);
  p3.AddParentPanel(p2);
  
  p3.CalculateFromParents(true);
  p3.calculateValuesFromParents();
  
  p2.VerticalScalar(50);
}

void draw () {
  window.update();
  background(0);
  
  for(int i = 0; i < panels.size(); i++) {
    panels.get(i).update();
  }
  
}