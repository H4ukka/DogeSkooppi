class Window {
  private int window_width;
  private int window_height;
  
  Window(){}
  
  void update() {
    window_width = width;
    window_height = height;
  }
  
  int Width () { return window_width; }
  int Height () { return window_height; }
}