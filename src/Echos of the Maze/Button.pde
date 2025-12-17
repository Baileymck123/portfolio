//Kirubashinilakshana
// Creates clickable menu buttons
class Button {

  String label;   // text displayed on the button
  float x, y;     // top-left corner position
  float w, h;     // width and height of the button

  // Constructor
  Button(String label, float x, float y, float w, float h) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  // Draw the button
  void display() {
    rectMode(CORNER);

    fill(#FF991C);
    stroke(0);
    rect(x, y, w, h, 10); // rounded button background

    fill(0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text(label, x + w / 2, y + h / 2);
  }

  // Checks if mouse clicked inside button
  boolean clicked() {
    return mouseX > x && mouseX < x + w &&
           mouseY > y && mouseY < y + h;
  }
}
