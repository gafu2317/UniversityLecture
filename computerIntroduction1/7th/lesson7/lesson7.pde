int y = 0;
int x = 200;
int dy = 5;
int dx = 10;
void setup(){
  size(400, 400);
  background(0);
  stroke(255);
}
void draw(){
  background(0);
  ellipse(x,y,50,50);
  y = y + dy;
  x = x + dx;
  if (y == 0) {
    dy = 5;
  }
  if (y == 400) {
    dy = -5;
  }
  if (x == 0) {
    dx = 5;
  }
  if (x == 400) {
    dx = -5;
  }
}