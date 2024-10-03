String scene = "start";  // シーンを指定する文字列
PFont font;
int width = 1600;  // ゲーム画面の幅
int height = 800;  // ゲーム画面の高さ
float px = 800;  // プレイヤーのx座標
float py =  720-50;  // プレイヤーのy座標
float playerYSpeed = 0;  // プレイヤーの横移動速度
float playerXSpeed = 0;  // プレイヤーの縦移動速度
int gameTime = 50;  // ゲーム時間
int time;  // 残り時間
ArrayList<Obstacle> obstacles;


void setup(){
  size(1600, 800);
  font = createFont("メイリオ", 32);
  textFont(font);
  player(800,400,50,50);
  time = gameTime;
  frameRate(60);
    obstacles = new ArrayList<Obstacle>();
}

void draw(){
  if(scene == "start"){
    start_scene();
  }else if(scene == "game"){
    game_scene();
  }else if(scene == "clear"){
    clear_scene();
  }else if(scene == "gameover"){
    gameover_scene();
  }
}

void start_scene(){
  // スタートシーンの処理
  background(#BAA4C4);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(100);
  text("よけろ！", width/2, height/8);

  px = 800; // プレイヤーのx座標を初期化
  py = 720 - 50; // プレイヤーのy座標を初期化
  playerYSpeed = 0; // プレイヤーの横移動速度を初期化
  playerXSpeed = 0; // プレイヤーの縦移動速度を初期化
  time = gameTime; // 残り時間を初期化
    // 障害物リストを初期化
  obstacles = new ArrayList<Obstacle>();

  player(400,500,500,500);

  String startText = "スタート";
  textSize(100);
  float startButtonX = width/4*3;
  float startButtonY = height/2;
  text(startText, startButtonX, startButtonY);

  // ボタンの領域を正確に設定
  float buttonWidth = textWidth(startText);
  float buttonHeight = textAscent() + textDescent();

  if (mouseX > startButtonX - buttonWidth/2 && mouseX < startButtonX + buttonWidth/2 &&
      mouseY > startButtonY - buttonHeight/2 && mouseY < startButtonY + buttonHeight/2) {
    if (mousePressed ) {  // loadingがfalseの時だけ実行
      scene = "game";
    }
  }
}

void game_scene(){
  // ゲームシーンの処理
  //背景設定（ステージ設定）
  background(#B7A8CC);
  noStroke();
  fill(255);
  rect(0,height-80 ,width, 80);
  fill(0);
  stroke(0);
  strokeWeight(5);
  line(0,720,1600,720);
  noStroke();
  // 1秒ごとにcurrentValueが1ずつ減少
  if (frameCount % 60 == 0 && time > 0) {
    time--;
  }
  fill(#000000);
  textSize(30);
  text("残り時間" + time + "秒", 150, 100);

  py = py + playerYSpeed;
  px = px + playerXSpeed;
//重力の設定
  if (py < 720-50) {
    playerYSpeed += 0.5;
  } else {
    playerYSpeed = 0;
    py = 720-50;
  }

  //プレイヤーの描画
  player(px,py,100,100);
  //マップの端
  if (px > 1600 - 50 -50) {
    playerXSpeed = 0;
  }
  if (px < 0 + 50 + 50) {
    playerXSpeed = 0;
  }

  // 一定の確率で新しいObstacleを生成してArrayListに追加
  if (random(1) < 0.01) {
    Obstacle newObstacle = new Obstacle();
    obstacles.add(newObstacle);
  }

  // すべてのObstacleを更新して描画
  for (int i = obstacles.size() - 1; i >= 0; i--) {
    Obstacle obs = obstacles.get(i);
    obs.update();
    obs.display();

    // 画面外に出たObstacleをリストから削除
    if (obs.isOffscreen()) {
      obstacles.remove(i);
    }

    // 当たり判定の処理
    if (obs.isHit()) {
      // 当たり判定が成り立った場合の処理
      scene = "gameover";
    }
  }

  if(time == 0) scene = "clear";
}

void clear_scene(){
  // クリアシーンの処理
  background(#bf65e8);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(100);
  text("クリア！", width/2, height/4);
  String startText = "スタートに戻る";
  textSize(100);
  float startButtonX = width/2;
  float startButtonY = height/4*3;
  text(startText, startButtonX, startButtonY);

  // ボタンの領域を正確に設定
  float buttonWidth = textWidth(startText);
  float buttonHeight = textAscent() + textDescent();

  if (mouseX > startButtonX - buttonWidth/2 && mouseX < startButtonX + buttonWidth/2 &&
      mouseY > startButtonY - buttonHeight/2 && mouseY < startButtonY + buttonHeight/2) {
    if (mousePressed ) {  // loadingがfalseの時だけ実行
      scene = "start";
    }
  }
}
void gameover_scene(){
  // ゲームオーバーシーンの処理
  background(#bf65e8);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(100);
  text("ゲームオーバー！", width/2, height/4);
  String startText = "スタートに戻る";
  textSize(100);
  float startButtonX = width/2;
  float startButtonY = height/4*3;
  text(startText, startButtonX, startButtonY);

  // ボタンの領域を正確に設定
  float buttonWidth = textWidth(startText);
  float buttonHeight = textAscent() + textDescent();

  if (mouseX > startButtonX - buttonWidth/2 && mouseX < startButtonX + buttonWidth/2 &&
      mouseY > startButtonY - buttonHeight/2 && mouseY < startButtonY + buttonHeight/2) {
    if (mousePressed ) {  // loadingがfalseの時だけ実行
      scene = "start";
    }
  }
}

// キーが押されたときの処理
void keyPressed() {
  if (key == 'w' || key == 'W') {//ジャンプ
    if (py == 720-50 ) {
      playerYSpeed = -20;
    }
  } else if (key == 's' || key == 'S') {//落下
    if (py > 0 + 50 + 50) {
    playerYSpeed = 10;
    }
  } else if (key == 'a' || key == 'A') {//左移動
    playerXSpeed = -5;
  } else if (key == 'd' || key == 'D') {//右移動
    playerXSpeed = 5;
  }
}


//プレイヤーの描画
void player (float x, float y, float Pwidth, float Pheight) {
  stroke(0);
  strokeWeight(3);
  fill(#bf65e8);
  rectMode(CORNER);
  rect(x-Pwidth/2, y-Pheight/2, Pwidth, Pheight, Pwidth/10);//身体
  line(x-Pwidth/3, y-Pheight/4, x-Pwidth/4, y-Pheight/9*4);//耳
  line(x-Pwidth/4, y-Pheight/9*4, x-Pwidth/6, y-Pheight/4);
  line(x+Pwidth/3, y-Pheight/4, x+Pwidth/4, y-Pheight/9*4);
  line(x+Pwidth/4, y-Pheight/9*4, x+Pwidth/6, y-Pheight/4);
  fill(#ffff00);
  ellipse(x-Pwidth/4, y-Pheight/10, Pwidth/5, Pheight/5);//目
  ellipse(x+Pwidth/4, y-Pheight/10, Pwidth/5, Pheight/5);
  fill(#000000);
  ellipse(x-Pwidth/4, y-Pheight/10, Pwidth/12, Pheight/12);//瞳孔
  ellipse(x+Pwidth/4, y-Pheight/10, Pwidth/12, Pheight/12);
  fill(#ffffff);
  line(x-Pwidth/6, y+Pheight/20*3, x-Pwidth/9*4, y+Pheight/20*3-Pheight/20);//ひげ
  line(x-Pwidth/6, y+Pheight/20*4, x-Pwidth/9*4, y+Pheight/20*4);
  line(x-Pwidth/6, y+Pheight/20*5, x-Pwidth/9*4, y+Pheight/20*5+Pheight/20);
  line(x+Pwidth/6, y+Pheight/20*3, x+Pwidth/9*4, y+Pheight/20*3-Pheight/20);
  line(x+Pwidth/6, y+Pheight/20*4, x+Pwidth/9*4, y+Pheight/20*4);
  line(x+Pwidth/6, y+Pheight/20*5, x+Pwidth/9*4, y+Pheight/20*5+Pheight/20);
  fill(#696969);
  ellipse(x, y+Pheight/20*4, Pwidth/12, Pheight/12);//鼻
  fill(#000000);
  line(x, y+Pheight/20*4+Pheight/24, x, y+Pheight/20*4+Pheight/24+Pheight/10);//口
  noFill();
  bezier(x-Pwidth/4, y+Pheight/20*4+Pheight/24+Pheight/10, x-Pwidth/8, y+Pheight/20*4+Pheight/24+Pheight/10+Pheight/10, x, y+Pheight/20*4+Pheight/24+Pheight/10, x, y+Pheight/20*4+Pheight/24+Pheight/10);
  bezier(x+Pwidth/4, y+Pheight/20*4+Pheight/24+Pheight/10, x+Pwidth/8, y+Pheight/20*4+Pheight/24+Pheight/10+Pheight/10, x, y+Pheight/20*4+Pheight/24+Pheight/10, x, y+Pheight/20*4+Pheight/24+Pheight/10);
}
// 障害物を表すクラス
class Obstacle {
  float x;
  float y;
  int a;
  float dx;

  Obstacle() {
    respawn();
  }

  void respawn() {
    x = width;
    y = random(height);
    a = int(random(1, 8));
    dx = random(-10, -1);
  }

  void update() {
    x += dx;
    y = height / 3*2 + sin(frameCount * 0.05 + a) * 100;
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(cos(frameCount * 0.05 + a));
    ellipse(0, 0, 50, 50);
    popMatrix();
  }

  boolean isOffscreen() {
    return x < 0;
  }

  boolean isHit() {
// 当たり判定(playerの周囲を9つに割って考えている)
  if (x <= px - 50) {
    if (y <= py - 50 || py + 50 <= y) {
      if (dist(x, y, px, py) <= 25) {
        // 当たり判定が成り立った場合の処理
        return true;
      }
    } else if (py - 50 < y && y < py + 50) {
      if (abs(px - x) <= 25) {
        // 当たり判定が成り立った場合の処理
        return true;
      }
    } 
    } else if (px - 50 < x && x < px + 50) {
      if (y <= py - 50 || py + 50 <= y) {
        if (abs(py - y) <= 25) {
          // 当たり判定が成り立った場合の処理
          return true;
        }
      } else return true;
    } else if (px + 50 < x) {
      if (y <= py - 50 || py + 50 <= y) {
        if (dist(x, y, px, py) <= 25) {
          // 当たり判定が成り立った場合の処理
          return true;
        }
      } else if (py - 50 < y && y < py + 50) {
        if (abs(px - x) <= 25) {
          // 当たり判定が成り立った場合の処理
          return true;
        }
      } 
    }
    return false;
  }
}

