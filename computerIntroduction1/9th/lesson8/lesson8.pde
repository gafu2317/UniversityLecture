int width =1000;
int height = 1000;

int y = width/2;//ボールの初期位置x
int x = height/2;//ボールの初期位置y
int dy =5;//ボールの加速度
int dx =5;//ボールの加速度

int P1y = height/2;//プレイヤー１の板(初期位置)
int P2y ;

void setup(){
  size(1000, 1000);
  background(0);
  stroke(255);
}
void draw(){
  P2y = mouseY;//プレイヤー２の板の中心
  background(0);
  stroke(255);

  line(50, P1y - 50, 50, P1y + 50);//プレイヤー１の板
  line(950, P2y - 50, 950, P2y +50);//プレイヤー２の板

  ellipse(x,y,50,50);//ボール
  y = y + dy;
  x = x + dx;
  if (y == 0) {//上にボールが当たった時
    dy = 5;
  }
  if (y == height) {//下にボールが当たった時
    dy = -5;
  }
  if (x == 0 ) {//左にボールが当たった時
    y = height/2;
    x = width/2;
    background(0,0,255);//一瞬背景を青にする
  }
  if (x == 1000) {//右にボールが当たった時
    y = height/2;
    x = width/2;
    background(255,0,0);//一瞬背景を赤くする
  }
  if (x == 50 && (y > P1y - 50 && y < P1y + 50)) {//プレイヤー１の板にボールが当たった時
    dx = 5;
    dy = -dy;
  }
  if (x == 950 && (y > P2y - 50 && y < P2y + 50)) {//プレイヤー２の板にボールが当たった時
    dx = -5;
    dy = -dy;
  }
}

void keyPressed() {
  if (key == 'w' && P1y > 50) {
    P1y = P1y - 50;
  } else if (key == 's' && P1y < height-50) {
    P1y = P1y + 50;
  }
}