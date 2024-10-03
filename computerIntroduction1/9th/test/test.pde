int width =1000;
int height = 1000;

int y = width/2;//ボールの初期位置x
int x = height/2;//ボールの初期位置y
int dy ;//ボールの加速度
int dx ;//ボールの加速度
int P1y = height/2;
int P2y = height/2;
int flashDuration = 180; // 3秒間のフレーム数
int flashFrame = -1; // フラッシュが始まるフレーム

void setup(){
size(1000, 1000);
background(0);
stroke(255);
frameRate(60);
//ボールをランダムな方向に発射する関数
while (true) {
  // -5から5までのランダムな整数を生成
  dy= int(random(-10, 10));
  // -1から1の間の値を除外
  if (dy < -2 || dy > 2) {
    break; // 条件を満たすランダムな整数が生成されたらループを終了
  }
}
while (true) {
  // -5から5までのランダムな整数を生成
  dx= int(random(-10, 10));
  // -1から1の間の値を除外
  if (dx < -2 || dx > 2) {
    break; // 条件を満たすランダムな整数が生成されたらループを終了
  }
}
}
void draw(){
background(0);
rect(50, P1y, 20, 100);
rect(930, P2y, 20, 100);//厚さを考慮して９３０にしている
ellipse(x,y,50,50);
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
}
if (x == 1000) {//右にボールが当たった時
  y = height/2;
  x = width/2;
  // フラッシュを開始
  flashFrame = frameCount;

  if (flashFrame != -1 && frameCount - flashFrame < flashDuration) {
    background(255, 0, 0); // フラッシュ中は背景を赤くする
  }else {
    background(0); // フラッシュが終了したら背景を黒に戻す
  }
  if (frameCount - flashFrame == flashDuration) {
  // フラッシュが終了したら
  flashFrame = -1; // フラッシュをリセット
  }
  noFill();
}
}