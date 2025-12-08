#include <M5Unified.h>
#include <Wire.h>
#include <SHT3X.h>
#include <QMP6988.h>
#include <SD.h>

SHT3X sht3x;
QMP6988 qmp;

void setup() {
  auto cfg = M5.config();
  M5.begin(cfg);
  Wire.begin();

  sht3x.begin();
  qmp.begin(&Wire, 0x70);  // ←動作するアドレスで初期化

  M5.Lcd.setTextSize(2);
  M5.Lcd.println("Ready for Data Logging");

  if (!SD.begin(4)) {
    M5.Lcd.println("SD init failed!");
  } else {
    M5.Lcd.println("SD card ready");
  }
  drawButtonLabels();  // ラベル描画
}

void loop() {
  sht3x.update();
  qmp.update();

  float temp = sht3x.cTemp;
  float hum = sht3x.humidity;
  float pres = qmp.pressure / 100.0;

  M5.update();

  // A: 快適, B: 暑い, C: 寒い
  if (M5.BtnA.wasPressed()) {
    saveData(temp, hum, pres, "comfortable");
  } else if (M5.BtnB.wasPressed()) {
    saveData(temp, hum, pres, "hot");
  } else if (M5.BtnC.wasPressed()) {
    saveData(temp, hum, pres, "cold");
  }

  delay(100);
}

void saveData(float t, float h, float p, String label) {
  File file = SD.open("/comfort_log.csv", FILE_APPEND);
  if (file) {
    file.printf("%.2f,%.2f,%.2f,%s\n", t, h, p, label.c_str());
    file.close();

    M5.Lcd.fillRect(0, 100, 320, 30, BLACK);  // メッセージ領域クリア
    M5.Lcd.setCursor(0, 100);
    M5.Lcd.printf("Saved: %.2f, %.2f, %.2f, %s", t, h, p, label.c_str());
  } else {
    M5.Lcd.println("SD write failed!");
  }
}

void drawButtonLabels() {
  M5.Lcd.setTextSize(2);
  M5.Lcd.setTextColor(WHITE, BLACK);  // 白文字・黒背景

  // 質問文
  M5.Lcd.setCursor(0, 200);
  M5.Lcd.println("What do you feel now?");

  // 左（BtnAの上）
  M5.Lcd.setCursor(20, 220);
  M5.Lcd.println("Comfort");

  // 中央（BtnBの上）
  M5.Lcd.setCursor(140, 220);
  M5.Lcd.println("Hot");

  // 右（BtnCの上）
  M5.Lcd.setCursor(230, 220);
  M5.Lcd.println("Cold");
}