int x, y;
boolean isSKeyPressed = false;
boolean isWKeyPressed = false;

void setup(){
size(400, 400);
background(0);
x = 0;
y = 100;
}
void draw(){
fill(255);
if (isWKeyPressed) {
y = y + 1;
}
if (isSKeyPressed) {
y = y - 1;
}
x = x + 1;
ellipse(x, y, 5,5);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    isSKeyPressed = true;
  }
  if (key == 'w' || key == 'W') {
    isWKeyPressed = true;
  }
}

void keyReleased() {
  if (key == 's' || key == 'S') {
    isSKeyPressed = false;
  }
  if (key == 'w' || key == 'W') {
    isWKeyPressed = false;
  }
}
