//ドラえもんのスモールライトでロボットの大きさが変わるコードを作る

int windowWidth = 1500;
int windowHeight = 1000;
int robotFaceRadius = 200;//顔の半径（すべての基準となる値）
int decreaseRate = 1; // 減少の速度
int startTime; // 開始時間
boolean isRunning = true; // 変数の更新を制御するフラグ


void settings() {
  size(windowWidth, windowHeight);
  startTime = millis(); // 開始時間を記録
}

void draw() {
  background(#ffffff);

  //後からロボットの大きさを変えるので、robotFaceRadiusを基準にサイズ指定する
  // ロボットの頭
  int robotFaceCenterX = windowWidth/2; 
  int robotFaceCenterY = windowHeight/5; 
  ellipse(robotFaceCenterX, robotFaceCenterY, robotFaceRadius, robotFaceRadius);

  // ロボットの目
  int robotEyeLeftX = robotFaceCenterX-robotFaceRadius/5;
  int robotEyeLeftY = robotFaceCenterY-robotFaceRadius/5;
  int robotEyeRightX = robotFaceCenterX+robotFaceRadius/5;
  int robotEyeRightY = robotFaceCenterY-robotFaceRadius/5;
  int robotEyeRadius = robotFaceRadius/4;
  fill(255); // 目の色（白）
  ellipse(robotEyeLeftX, robotEyeLeftY, robotEyeRadius, robotEyeRadius);
  ellipse(robotEyeRightX, robotEyeRightY, robotEyeRadius, robotEyeRadius);

  // ロボットの口
  int robotMouthLeftX = robotFaceCenterX-robotFaceRadius/5;
  int robotMouthLeftY = robotFaceCenterY+robotFaceRadius/5;
  int robotMouthWidth = robotFaceRadius*2/5;
  int robotMouthHeight = robotFaceRadius/10;

  rect(robotMouthLeftX, robotMouthLeftY, robotMouthWidth, robotMouthHeight);


  // ロボットの体
  int robotBodyLeftX = robotFaceCenterX-robotFaceRadius/2;
  int robotBodyLeftY = robotFaceCenterY+robotFaceRadius/2;
  int robotBodyWidth = robotFaceRadius;
  int robotBodyHeight = robotFaceRadius*2;

  rect(robotBodyLeftX, robotBodyLeftY, robotBodyWidth, robotBodyHeight);
  
  PFont font = createFont("MS Gothic",  robotFaceRadius/5);  // 使用するフォントを指定
  textFont(font);
  String text = "ロボットデス";
  
  for (int i = 0; i < text.length(); i++) {
    char c = text.charAt(i);
    String character = String.valueOf(c);
    fill(0);  // 文字の色（黒）
    textAlign(CENTER);
    text(character, robotBodyLeftX+robotBodyWidth/2, robotBodyLeftY+robotBodyHeight/10 + i * robotFaceRadius/5);  // 文字を描画
    noFill();
  }
  // ロボットの腕
  int robotArmWidth = robotBodyWidth/4;
  int robotArmHeight = robotBodyHeight/2;
  int robotArmLeftX = robotBodyLeftX-robotArmWidth/2;
  int robotArmLeftY = robotBodyLeftY;
  //左腕
  pushMatrix();
  translate(robotArmLeftX, robotArmLeftY);
  rotate(PI/6);
  rect(0, 0, robotArmWidth, robotArmHeight);
  popMatrix();
  //右腕
  pushMatrix();
  translate(robotArmLeftX+robotBodyWidth+robotArmWidth, robotArmLeftY);
  rotate(-PI/6);
  rect( -robotArmWidth, 0, robotArmWidth, robotArmHeight);
  popMatrix();


  // ロボットの足
  int robotLegWidth = robotBodyWidth/4;
  int robotLegHeight = robotBodyHeight/2;
  int robotLegLeftX = robotBodyLeftX;
  int robotLegLeftY = robotBodyLeftY+robotBodyHeight;
  //左足
  rect(robotLegLeftX, robotLegLeftY, robotLegWidth, robotLegHeight);
  //右足
  rect(robotLegLeftX+robotBodyWidth-robotLegWidth, robotLegLeftY, robotLegWidth, robotLegHeight);

  //ドラえもん(まず左上に描画し、そのあとtranslateで移動させる )
  // fill (#1e90ff);//水色
  arc (150,150,200,200, radians (135), radians (405));
  noFill();
  fill (#ffffff);
  ellipse (130,90,40,50);
  ellipse (170,90,40,50);
  fill(#000000);
  ellipse (140,95,10,10);//left eye
  ellipse (160,95,10,10);//right eye
  noFill();
  // fill (#ff0000);
  ellipse (150,117,20,20); //nose
  noFill();
  strokeWeight (2);
  line (150,127,150,200);

  arc (150,117,170, 170, radians (40), radians (140));//mouth
  arc (132,165,150, 150, radians (130), radians (253));
  arc (170,165,150, 150, radians (286), radians (410));


  // line (85,223,217,223);
  //left hige
  line (78,120,105,130);
  line (73,149,100,150);
  line (75,180,105,170);
   //right hige
  line (190,130,219,120);
  line (195,150,221,149);
  line (190,170,219,180);
  //body
  bezier (79,221, 150, 225, 150, 225, 221, 221);//首輪
  bezier (79,226, 150, 230, 150, 230, 221, 226);
  line (79,221,79,226);
  line (221,221,221,226);

  bezier (79, 226, 60, 236, 40, 286, 40, 286);//腕
  bezier (221, 226, 240, 236, 260, 286, 260, 286);
  ellipse (40, 316, 60, 60);//手
  ellipse (260, 316, 60, 60);
  
  bezier (79,246, 45, 365, 79, 380, 79, 380);//身体の輪郭
  bezier (221,246, 255, 365, 221, 380, 221, 380);

  bezier (79, 380, 40, 405, 95, 430, 150, 405);//足
  bezier (221, 380, 260, 405, 205, 430, 150, 405);
  line (150,360,150,405);
  bezier (79, 380, 115, 390, 150, 380, 150, 380);
  bezier (221, 380, 185, 390, 150, 380, 150, 380);

  ellipse (150, 290, 130, 130);//おなか
  arc (150, 290, 100, 100, 0, PI);//ポケット
  line (100,290,200,290);

  ellipse (150, 245, 46, 46);//鈴
  bezier (127, 240, 150, 235, 173, 240, 173, 240);
  bezier (127, 237, 150, 232, 173, 237, 173, 237);
  line (150, 258, 150, 268);
  ellipse (150, 253, 10, 10);

  rect (300, 50, 300, 100, 20);//吹き出し
  line (270, 150, 300, 80);
  line (270, 150, 300, 120);

  pushMatrix();
  translate(280, 316);
  rotate(PI/6);
  rect (0, 0, 50, 30);//スモールライト
  rect (50, -10, 30, 50);
  popMatrix();
  
  fill(0);
  textSize(18);
  textAlign(LEFT, CENTER); 
  text("こんにちは、ぼく〇〇〇〇〇です ロボットをスモールライトで小さくしていきます。五秒後に始まるよ。", 320, 50, 280, 90);
  noFill();
  // スモールライトを光らせる
  if (isRunning) {
    int elapsedTime = millis() - startTime; // 経過時間を計算
    int newRobotFaceRadius = robotFaceRadius - decreaseRate * (elapsedTime / 5000); // 1秒あたりの減少
    if (elapsedTime >= 5000) { // 5秒経過したらスモールライトを光らせる
      // 透明な黄色の色を設定（RGB: 255, 255, 0, アルファ: 128）
      int yellowColor = color(255, 255, 0, 128);
      fill(yellowColor);
      triangle(1300, 200, 330, 340, 1000, 800);
      noFill();
      if (elapsedTime >= 8000) { // 8秒経過したら止める
        isRunning = false; // 変数の更新を停止
      } else {
        if (newRobotFaceRadius >= 50) {//五秒から八秒までロボットの大きさを変える
          robotFaceRadius = newRobotFaceRadius; 
        }
      }
    }
  }
}


