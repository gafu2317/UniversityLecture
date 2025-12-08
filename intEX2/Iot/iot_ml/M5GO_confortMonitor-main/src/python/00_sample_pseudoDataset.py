import numpy as np
import pandas as pd
import os

# ①　擬似データセット生成パラメータ
np.random.seed(42)
# 不均衡データ：現実的なクラス分布（comfortable多め）
num_comf = 400
num_hot = 200  
num_cold = 200

print(f"データセット構成：comfortable={num_comf}, hot={num_hot}, cold={num_cold}")

def generate_correlated_environment_data(base_temp, temp_std, num_samples, season_factor=0):
    """
    環境相関を考慮したセンサーデータ生成
    - 温度と湿度の逆相関
    - 気圧と天候の関連
    - 季節変動
    """
    # 基本温度生成（季節要因込み）
    temp = np.random.normal(base_temp + season_factor, temp_std, num_samples)
    
    # 温度と湿度の逆相関（現実的な関係）
    # 温度が高い→湿度低下傾向、ノイズ付き
    humidity_base = 70 - (temp - 20) * 1.5  # 温度1度上昇で湿度1.5%低下
    humidity_noise = np.random.normal(0, 8, num_samples)  # 現実的なノイズ
    humid = humidity_base + humidity_noise
    humid = np.clip(humid, 20, 90)  # 物理的制約
    
    # 気圧：天候による変動（低気圧→不快感増加）
    # 一部のサンプルで低気圧条件（雨天・台風など）
    pres_base = np.random.normal(1013, 3, num_samples)
    low_pressure_mask = np.random.random(num_samples) < 0.15  # 15%が低気圧
    pres_base[low_pressure_mask] -= np.random.uniform(8, 20, np.sum(low_pressure_mask))
    
    return temp, humid, pres_base

# comfortable擬似データ生成（重複領域あり）
temp_comf, humid_comf, pres_comf = generate_correlated_environment_data(23.5, 2.5, num_comf, 0)
label_comf = ["comfortable"] * num_comf

# hot擬似データ生成（境界曖昧）
temp_hot, humid_hot, pres_hot = generate_correlated_environment_data(26.8, 2.2, num_hot, 1.0)
label_hot = ["hot"] * num_hot

# cold擬似データ生成（境界曖昧）
temp_cold, humid_cold, pres_cold = generate_correlated_environment_data(21.2, 2.8, num_cold, -0.5)
label_cold = ["cold"] * num_cold

# 全データ統合
all_temp = np.concatenate([temp_comf, temp_hot, temp_cold])
all_humid = np.concatenate([humid_comf, humid_hot, humid_cold])
all_pres = np.concatenate([pres_comf, pres_hot, pres_cold])
all_labels = label_comf + label_hot + label_cold

# 個人差・測定誤差の追加
measurement_noise_temp = np.random.normal(0, 0.3, len(all_temp))
measurement_noise_humid = np.random.normal(0, 1.5, len(all_humid))
measurement_noise_pres = np.random.normal(0, 1.0, len(all_pres))

all_temp += measurement_noise_temp
all_humid += measurement_noise_humid  
all_pres += measurement_noise_pres

# 外れ値の追加（センサー異常・極端環境：2%）
outlier_indices = np.random.choice(len(all_temp), int(len(all_temp) * 0.02), replace=False)
all_temp[outlier_indices] += np.random.uniform(-8, 12, len(outlier_indices))
all_humid[outlier_indices] += np.random.uniform(-20, 25, len(outlier_indices))

# 湿度の物理的制約
all_humid = np.clip(all_humid, 10, 95)

# ラベルノイズの追加（現実の主観的判断の曖昧さ：8%）
noise_indices = np.random.choice(len(all_labels), int(len(all_labels) * 0.08), replace=False)
labels_array = np.array(all_labels)
label_options = ["comfortable", "hot", "cold"]

for idx in noise_indices:
    current_label = labels_array[idx]
    new_label = np.random.choice([l for l in label_options if l != current_label])
    labels_array[idx] = new_label

print(f"ラベルノイズ: {len(noise_indices)}サンプル ({len(noise_indices)/len(all_labels)*100:.1f}%)")
print(f"外れ値: {len(outlier_indices)}サンプル ({len(outlier_indices)/len(all_labels)*100:.1f}%)")

# データフレーム作成
data = pd.DataFrame({
    "temperature": all_temp,
    "humidity": all_humid,
    "pressure": all_pres,
    "label": labels_array
})

# データ統計表示
print("\n=== 改良版データセット統計 ===")
for label in ["comfortable", "hot", "cold"]:
    subset = data[data["label"] == label]
    print(f"\n{label.capitalize()}:")
    print(f"  温度: {subset['temperature'].mean():.1f}±{subset['temperature'].std():.1f}°C")
    print(f"  湿度: {subset['humidity'].mean():.1f}±{subset['humidity'].std():.1f}%")
    print(f"  気圧: {subset['pressure'].mean():.1f}±{subset['pressure'].std():.1f}hPa")

# クラス境界重複度確認
comf_data = data[data["label"] == "comfortable"]
hot_data = data[data["label"] == "hot"]
cold_data = data[data["label"] == "cold"]

temp_overlap_ch = np.sum((comf_data["temperature"] > 25) & (comf_data["temperature"] < 27))
temp_overlap_hc = np.sum((hot_data["temperature"] < 24) & (hot_data["temperature"] > 22))
print(f"\n境界重複: comfortable-hot={temp_overlap_ch}, hot-cold={temp_overlap_hc}")

# JSON形式で保存（行ごとに辞書形式）
if not os.path.isdir("dataset"):
  os.mkdir("dataset")
data.to_json("dataset/comfort_pseudoData.json", orient = "records", lines = True)
print(f"\n✅ 改良版データセット保存完了: {len(data)}サンプル")
## 元コード
# import numpy as np
# import pandas as pd
# import os

# # ①　擬似データセット生成パラメータ
# np.random.seed(42)
# num_samples = 300

# # confortable擬似データ生成
# temp_comf = np.random.normal(24.5, 1.0, num_samples)
# humid_comf = np.random.normal(45, 5, num_samples)
# pres_comf = np.random.normal(1013, 1.0, num_samples)
# label_comf = ["comfortable"] * num_samples

# # hot擬似データ生成
# temp_hot = np.random.normal(29, 1.0, num_samples)
# humid_hot = np.random.normal(60, 5, num_samples)
# pres_hot = np.random.normal(1010, 1.0, num_samples)
# label_hot = ["hot"] * num_samples

# # cold擬似データ生成
# temp_cold = np.random.normal(20, 1.0, num_samples)
# humid_cold = np.random.normal(50, 5, num_samples)
# pres_cold = np.random.normal(1015, 1.0, num_samples)
# label_cold = ["cold"] * num_samples

# # データ統合
# data = pd.DataFrame({
#     "temperature": np.concatenate([temp_comf, temp_hot, temp_cold]),
#     "humidity":    np.concatenate([humid_comf, humid_hot, humid_cold]),
#     "pressure":    np.concatenate([pres_comf, pres_hot, pres_cold]),
#     "label":       label_comf + label_hot + label_cold
# })

# # JSON形式で保存（行ごとに辞書形式）
# if not os.path.isdir("dataset"):
#   os.mkdir("dataset")
# data.to_json("dataset/comfort_pseudoData.json", orient = "records", lines = True)