ArrayList<GraphingPanel> panels = new ArrayList<GraphingPanel>();
Window window = new Window();

Entry currentPhaseEntry;

void settings () {
  size(800, 900);
}

void setup () {
  
  //surface.setResizable(true);
  
  window.update();
  
  GraphingPanel p1 = new GraphingPanel(10, 10, 500, 250, 1, 0);
  GraphingPanel p2 = new GraphingPanel(10, 10 + height / 3, 500, 250, 1, 0);
  GraphingPanel p3 = new GraphingPanel(10, 10 + (height / 3) * 2, 500, 250, 3, 0);
  
  
  panels.add(p1);
  panels.add(p2);
  panels.add(p3);
  
  p3.AddParentPanel(p1);
  p3.AddParentPanel(p2);
  
  p3.CalculateFromParents(true);
  
  textSize(14);
  currentPhaseEntry = new Entry(550, 10 + height / 3, 100, "Vaihekulma:", 0);
  currentPhaseEntry.setTarget(p2);
}

void draw () {
  window.update();

  background(#fafafa);
  
  for(int i = 0; i < panels.size(); i++) {
    panels.get(i).update();
  }
  
  currentPhaseEntry.update();
  
}