class SandBody {
  SandBody() {
  }
  
  void run() {
    update();
    render();
  }

  void update() {
  }

  void render() {
    noStroke();
    fill(black, 255);
    ellipse(0, 0, 3, 3);
  }
}
