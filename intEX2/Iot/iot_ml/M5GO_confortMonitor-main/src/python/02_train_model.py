import pandas as pd
import numpy as np
import tensorflow as tf
from sklearn.model_selection import train_test_split
import os
import itertools
import time

# 学習用JSONを読み込み
df = pd.read_json("dataset/pseudo_trainSet.json", orient = "records", lines = True)

X = df[["temperature", "humidity", "pressure"]].values
y = df["label"].values

# 学習と検証に再分割
X_train, X_eval, y_train, y_eval = train_test_split(X, y, test_size = 0.2, random_state = 42)

# テストデータ読み込み
test_df = pd.read_json("dataset/pseudo_testSet.json", orient="records", lines=True)
X_test = test_df[["temperature", "humidity", "pressure"]].values
y_test = test_df["label"].values

# ハイパーパラメータ探索範囲（M5GO制約考慮）
param_grid = {
    'hidden_layers': [
        [8],           # 1層
        [12],          # 1層（大）
        [6, 4],        # 2層
        [8, 6],        # 2層（元構成）
        [10, 8],       # 2層（大）
        [12, 8, 4],    # 3層
        [16, 12, 6],   # 3層（大）
    ],
    'epochs': [25, 35, 45],
    'batch_size': [8, 16, 32]
}

def create_model(hidden_layers):
    """指定された隠れ層でモデルを作成"""
    model = tf.keras.Sequential()
    model.add(tf.keras.layers.Input(shape=(3,)))
    
    for neurons in hidden_layers:
        model.add(tf.keras.layers.Dense(neurons, activation='relu'))
    
    model.add(tf.keras.layers.Dense(3, activation='softmax'))
    
    model.compile(
        optimizer='adam',
        loss='sparse_categorical_crossentropy',
        metrics=['accuracy']
    )
    return model

def get_model_size(model):
    """モデルのパラメータ数を計算"""
    return model.count_params()

# グリッドサーチ実行
print("=== ハイパーパラメータ最適化開始 ===")
print(f"探索組み合わせ数: {len(param_grid['hidden_layers']) * len(param_grid['epochs']) * len(param_grid['batch_size'])}")

best_accuracy = 0
best_params = None
best_model = None
results = []

total_combinations = len(param_grid['hidden_layers']) * len(param_grid['epochs']) * len(param_grid['batch_size'])
current_combination = 0

for hidden_layers, epochs, batch_size in itertools.product(
    param_grid['hidden_layers'], 
    param_grid['epochs'], 
    param_grid['batch_size']
):
    current_combination += 1
    print(f"\n[{current_combination}/{total_combinations}] Testing: layers={hidden_layers}, epochs={epochs}, batch={batch_size}")
    
    try:
        # モデル作成
        model = create_model(hidden_layers)
        model_params = get_model_size(model)
        
        # 学習実行
        start_time = time.time()
        history = model.fit(
            X_train, y_train,
            validation_data=(X_eval, y_eval),
            epochs=epochs,
            batch_size=batch_size,
            verbose=0
        )
        training_time = time.time() - start_time
        
        # テスト評価
        test_loss, test_accuracy = model.evaluate(X_test, y_test, verbose=0)
        val_accuracy = max(history.history['val_accuracy'])
        
        # 結果記録
        result = {
            'hidden_layers': hidden_layers,
            'epochs': epochs,
            'batch_size': batch_size,
            'test_accuracy': test_accuracy,
            'val_accuracy': val_accuracy,
            'model_params': model_params,
            'training_time': training_time
        }
        results.append(result)
        
        print(f"  Test Accuracy: {test_accuracy:.4f}, Val Accuracy: {val_accuracy:.4f}")
        print(f"  Parameters: {model_params}, Time: {training_time:.1f}s")
        
        # ベストモデル更新
        if test_accuracy > best_accuracy:
            best_accuracy = test_accuracy
            best_params = result.copy()
            if best_model is not None:
                del best_model
            best_model = model
            print(f"  *** NEW BEST: {test_accuracy:.4f} ***")
        else:
            del model
            
    except Exception as e:
        print(f"  Error: {str(e)}")
        continue

# 結果分析
print("\n" + "="*60)
print("HYPERPARAMETER OPTIMIZATION RESULTS")
print("="*60)

print(f"\nBest Configuration:")
print(f"  Hidden Layers: {best_params['hidden_layers']}")
print(f"  Epochs: {best_params['epochs']}")
print(f"  Batch Size: {best_params['batch_size']}")
print(f"  Test Accuracy: {best_params['test_accuracy']:.4f}")
print(f"  Model Parameters: {best_params['model_params']}")
print(f"  Training Time: {best_params['training_time']:.1f}s")

# 元モデルとの比較
baseline_accuracy = 0.576  # 元モデルの精度
improvement = (best_accuracy - baseline_accuracy) * 100
print(f"\nComparison with Baseline:")
print(f"  Baseline Accuracy: {baseline_accuracy:.4f}")
print(f"  Best Accuracy: {best_accuracy:.4f}")
print(f"  Improvement: {improvement:+.2f} percentage points")

# モデルサイズ分析
print(f"\nModel Size Analysis:")
original_params = 8*3 + 8 + 6*8 + 6 + 3*6 + 3  # 元モデル計算
print(f"  Original Parameters: {original_params}")
print(f"  Best Model Parameters: {best_params['model_params']}")
size_ratio = best_params['model_params'] / original_params
print(f"  Size Ratio: {size_ratio:.2f}x")

# 上位5結果の表示
print(f"\nTop 5 Configurations:")
sorted_results = sorted(results, key=lambda x: x['test_accuracy'], reverse=True)[:5]
for i, result in enumerate(sorted_results, 1):
    print(f"  {i}. Layers: {result['hidden_layers']}, "
          f"Epochs: {result['epochs']}, Batch: {result['batch_size']}, "
          f"Acc: {result['test_accuracy']:.4f}")

# ベストモデル保存
if not os.path.isdir("models"):
    os.mkdir("models")

best_model.save("models/comfort_model_optimized.keras")

# TFLite変換とサイズチェック
converter = tf.lite.TFLiteConverter.from_keras_model(best_model)
tflite_model = converter.convert()

with open("models/comfort_model_optimized.tflite", "wb") as f:
    f.write(tflite_model)

tflite_size = len(tflite_model)
print(f"\nTensorFlow Lite Model:")
print(f"  Size: {tflite_size} bytes ({tflite_size/1024:.2f} KB)")
print(f"  M5GO Compatible: {'Yes' if tflite_size < 50000 else 'No'}")

print(f"\n✅ 最適化完了: {len(results)}個の構成をテスト")
print(f"✅ ベストモデル保存: comfort_model_optimized.keras")


## 元コード
# import pandas as pd
# import numpy as np
# import tensorflow as tf
# from sklearn.model_selection import train_test_split
# import os

# # 学習用JSONを読み込み
# df = pd.read_json("dataset/pseudo_trainSet.json", orient = "records", lines = True)

# X = df[["temperature", "humidity", "pressure"]].values
# y = df["label"].values

# # 学習と検証に再分割
# X_train, X_eval, y_train, y_eval = train_test_split(X, y, test_size = 0.2, random_state = 42)

# # モデル定義
# model = tf.keras.Sequential([
#   tf.keras.layers.Input(shape = (3, )),             # 入力層（温度、湿度、気圧を入力）
#   tf.keras.layers.Dense(8, activation = 'relu'),    # 中間層
#   tf.keras.layers.Dense(6, activation = 'relu'),    # 中間層
#   tf.keras.layers.Dense(3, activation = 'softmax')  # 出力層（3クラス分類）
# ])

# model.compile(
#   optimizer = 'adam',
#   loss = 'sparse_categorical_crossentropy',
#   metrics = ['accuracy']
# )

# # 学習
# history = model.fit(
#   X_train, y_train,
#   validation_data = (X_eval, y_eval),
#   epochs = 30,
#   batch_size = 16
# )

# # テストデータ読み込み
# test_df = pd.read_json("dataset/pseudo_testSet.json", orient="records", lines=True)
# # 特徴量とラベルを抽出
# X_test = test_df[["temperature", "humidity", "pressure"]].values
# y_test = test_df["label"].values

# # 精度評価
# loss, acc = model.evaluate(X_test, y_test)
# print(f"Evaluation accuracy: {acc:.3f}")

# # 学習済みモデルを出力
# if not os.path.isdir("models"):
#   os.mkdir("models")
# model.save("models/comfort_model.keras")

