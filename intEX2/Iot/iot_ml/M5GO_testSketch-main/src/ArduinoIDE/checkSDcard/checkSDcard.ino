#include <M5Unified.h>
#include <SD.h>

int csCandidates[] = {5, 4, 13, 15, 12};

void setup() {
  M5.begin();
  M5.Lcd.setTextSize(2);

  for (int i = 0; i < sizeof(csCandidates) / sizeof(int); ++i) {
    int cs = csCandidates[i];
    M5.Lcd.printf("Trying CS=%d\n", cs);
    if (SD.begin(cs)) {
      M5.Lcd.printf("SD OK (CS=%d)\n", cs);
      File f = SD.open("/probe.txt", FILE_WRITE);
      if (f) {
        f.println("CS test success");
        f.close();
        M5.Lcd.println("Write OK");
      } else {
        M5.Lcd.println("Write FAIL");
      }
      return;
    }
    delay(500);
  }

  M5.Lcd.println("All SD init failed");
}

void loop() {}