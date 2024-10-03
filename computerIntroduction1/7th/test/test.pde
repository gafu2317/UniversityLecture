void setup() {
  size(400, 400, P3D); // P3Dを指定して3Dモードを有効にする
}

void draw() {
  background(220);
  translate(width / 2, height / 2); // 球の中心を画面の中央に移動
  rotateX(frameCount * 0.01); // X軸を中心に球を回転
  rotateY(frameCount * 0.01); // Y軸を中心に球を回転
  
  // 3Dの球を描画
  sphere(100); // 半径が100の3Dの球を描画
}
