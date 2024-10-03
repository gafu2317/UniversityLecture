int width =1000;
int height = 1000;

int y = width/2;//ボールの初期位置x
int x = height/2;//ボールの初期位置y
int dy ;//ボールの加速度
int dx ;//ボールの加速度

int P1y = height/2;//プレイヤー１の板(初期位置)
int P2y = height/2;//プレイヤー２の板(初期位置)

int P1score = 0;//プレイヤー１のスコア
int P2score = 0;//プレイヤー２のスコア

void setup(){
  size(1000, 1000);
  background(0);//背景を黒にする
  stroke(255);
  randomdx();
  randomdy();
}
void draw(){
  P2y = mouseY;//プレイヤー２の板の中心
  background(0);
  stroke(255);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(24);
  text("P1score: " + P1score, 250, 50);
  text("P2score: " + P2score, 750, 50);
  
  line(50, P1y - 50, 50, P1y + 50);//プレイヤー１の板
  line(950, P2y - 50, 950, P2y +50);//プレイヤー２の板

  fill(255,200);
  ellipse(x,y,50,50);//ボール
  fill(255,0,0);
  ellipse(x,y,10,10);//ボールの中心

  y = y + dy;
  x = x + dx;
  if (y < 0) {//上にボールが当たった時
    dy = -dy;
  }
  if (y > height) {//下にボールが当たった時
    dy = -dy;
  }
  if (x < 0 ) {//左にボールが当たった時
    y = height/2;
    x = width/2;
    randomdx();
    randomdy();
    background(0,0,255);//一瞬背景を青にする
    P2score = P2score + 1;
  }
  if (x > 1000) {//右にボールが当たった時
    y = height/2;
    x = width/2;
    randomdx();
    randomdy();
    background(255,0,0);//一瞬背景を赤くする
    P1score = P1score + 1;
  }
  if ((40<x && x<50) && (y > P1y - 50 && y < P1y + 50)) {//プレイヤー１の板にボールが当たった時
  randomdy();
  dx = -dx;
  }
  if ((950<x && x<960) && (y > P2y - 50 && y < P2y + 50)) {//プレイヤー２の板にボールが当たった時
  randomdy();
  dx = -dx;
  }
}

void keyPressed() {
  if (key == 'w' && P1y > 50) {
    P1y = P1y - 100;
  } else if (key == 's' && P1y < height-50) {
    P1y = P1y + 100;
  }
}

void randomdx(){
      //ボールをランダムな方向に発射する関数
  while (true) {
    // -10から10までのランダムな整数を生成
    dx = int(random(-10, 10));
    // -2から2の間の値を除外
    if (dx < -2 || dx > 2) {
      break; // 条件を満たすランダムな整数が生成されたらループを終了
    }
  }
}
void randomdy(){
      //ボールをランダムな方向に発射する関数
  while (true) {
    // -10から10までのランダムな整数を生成
    dy = int(random(-10, 10));
    // -2から2の間の値を除外
    if (dy < -2 || dy > 2) {
      break; // 条件を満たすランダムな整数が生成されたらループを終了
    }
  }
}