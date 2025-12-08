import numpy as np
import pandas as pd
import os

# 元の擬似データセット生成（比較用）
np.random.seed(42)
num_samples = 300

# confortable擬似データ生成
temp_comf = np.random.normal(24.5, 1.0, num_samples)
humid_comf = np.random.normal(45, 5, num_samples)
pres_comf = np.random.normal(1013, 1.0, num_samples)
label_comf = ["comfortable"] * num_samples

# hot擬似データ生成
temp_hot = np.random.normal(29, 1.0, num_samples)
humid_hot = np.random.normal(60, 5, num_samples)
pres_hot = np.random.normal(1010, 1.0, num_samples)
label_hot = ["hot"] * num_samples

# cold擬似データ生成
temp_cold = np.random.normal(20, 1.0, num_samples)
humid_cold = np.random.normal(50, 5, num_samples)
pres_cold = np.random.normal(1015, 1.0, num_samples)
label_cold = ["cold"] * num_samples

# データ統合
data = pd.DataFrame({
    "temperature": np.concatenate([temp_comf, temp_hot, temp_cold]),
    "humidity":    np.concatenate([humid_comf, humid_hot, humid_cold]),
    "pressure":    np.concatenate([pres_comf, pres_hot, pres_cold]),
    "label":       label_comf + label_hot + label_cold
})

# 統計表示
print("=== 元のデータセット統計 ===")
for label in ["comfortable", "hot", "cold"]:
    subset = data[data["label"] == label]
    print(f"\n{label.capitalize()}:")
    print(f"  温度: {subset['temperature'].mean():.1f}±{subset['temperature'].std():.1f}°C")
    print(f"  湿度: {subset['humidity'].mean():.1f}±{subset['humidity'].std():.1f}%")
    print(f"  気圧: {subset['pressure'].mean():.1f}±{subset['pressure'].std():.1f}hPa")

# JSON形式で保存（行ごとに辞書形式）
if not os.path.isdir("dataset"):
  os.mkdir("dataset")
data.to_json("dataset/comfort_original_Data.json", orient = "records", lines = True)
print(f"\n✅ 元データセット保存完了: {len(data)}サンプル")