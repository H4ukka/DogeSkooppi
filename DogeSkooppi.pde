ArrayList<GraphingPanel> panels = new ArrayList<GraphingPanel>();
Window window = new Window();

Entry currentPhaseEntry;
Slider resolutionSlider;

void settings () {
  size(800, 900);
}

void setup () {
  
  //surface.setResizable(true);
  
  window.update();
  
  GraphingPanel p1 = new GraphingPanel(10, 40, 500, 250, 1, 0, "Jännite", color(29, 214, 234), 50);
  GraphingPanel p2 = new GraphingPanel(10, 40 + height / 3, 500, 250, 1, 0, "Virta", color(109, 67, 153), 50);
  GraphingPanel p3 = new GraphingPanel(10, 40 + (height / 3) * 2, 500, 250, 3, 0, "Teho", color(61, 236, 152), 50);
  
  
  panels.add(p1);
  panels.add(p2);
  panels.add(p3);
  
  p3.AddParentPanel(p1);
  p3.AddParentPanel(p2);
  
  p3.CalculateFromParents(true);
  
  currentPhaseEntry = new Entry(550, 40 + height / 3, 100, "Vaihekulma:", 0);
  currentPhaseEntry.setTarget(p2);
  
  resolutionSlider = new Slider(550, 5 + height / 3, 200, 10, 100, 5, 50, false, false, "Resoluutio:");
  resolutionSlider.AddTarget(p1);
  resolutionSlider.AddTarget(p2);
  resolutionSlider.AddTarget(p3);
}

void draw () {
  window.update();

  background(#1b1a28);
  
  for(int i = 0; i < panels.size(); i++) {
    panels.get(i).update();
  }
  
  currentPhaseEntry.update();
  resolutionSlider.update();
  
}