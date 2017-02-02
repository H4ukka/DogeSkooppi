ArrayList<GraphingPanel> panels = new ArrayList<GraphingPanel>();

Entry currentPhaseEntry;
Slider resolutionSlider;

void settings () {
  size(800, 1000);  
}

void setup () {
  frameRate(60);

  GraphingPanel p1 = new GraphingPanel(10, 40, 780, 250, 1, 0, "Jännite", color(29, 214, 234), 50, 1, 100);
  GraphingPanel p2 = new GraphingPanel(10, 40 + height / 3, 780, 250, 1, 0, "Virta", color(109, 67, 153), 50, 1, 100);
  GraphingPanel p3 = new GraphingPanel(10, 40 + (height / 3) * 2, 780, 250, 3, 0, "Teho", color(61, 236, 152), 50, 1, 100); 

  panels.add(p1);
  panels.add(p2);
  panels.add(p3);
  
  p3.AddParentPanel(p1);
  p3.AddParentPanel(p2);
  
  p3.CalculateFromParents(true);
  
  currentPhaseEntry = new Entry(250, height / 3, 100, "Vaihekulma:", 0);
  currentPhaseEntry.setTarget(p2);
  
  resolutionSlider = new Slider(10, 5 + height / 3, 200, 10, 100, 5, 50, false, false, "Resoluutio:");
  resolutionSlider.AddTarget(p1);
  resolutionSlider.AddTarget(p2);
  resolutionSlider.AddTarget(p3);
}

void draw () {
  background(#212121);
  
  for(int i = 0; i < panels.size(); i++) {
    panels.get(i).update();
  }
  
  currentPhaseEntry.update();
  resolutionSlider.update(); 
}