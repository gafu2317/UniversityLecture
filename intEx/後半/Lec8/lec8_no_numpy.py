"""
複雑なニューラルネットワークの実装
課題4: LSTMを用いた再帰型ニューラルネットワークの実装
（numpyなしバージョン）
"""

import math
import random

class LSTM:
    """
    LSTM (Long Short-Term Memory) の実装（標準Pythonのみ）
    時系列データの分類・予測を行う
    """
    
    def __init__(self, input_size, hidden_size, output_size):
        """
        パラメータの初期化
        
        Args:
            input_size: 入力データの次元数
            hidden_size: 隠れ層のユニット数
            output_size: 出力の次元数
        """
        self.input_size = input_size
        self.hidden_size = hidden_size
        self.output_size = output_size
        
        # 重みの初期化（標準偏差0.1の正規分布）
        std = 0.1
        
        # 忘却ゲートの重み
        self.Wf = [[random.gauss(0, std) for _ in range(input_size + hidden_size)] 
                   for _ in range(hidden_size)]
        self.bf = [0.0 for _ in range(hidden_size)]
        
        # 入力ゲートの重み
        self.Wi = [[random.gauss(0, std) for _ in range(input_size + hidden_size)] 
                   for _ in range(hidden_size)]
        self.bi = [0.0 for _ in range(hidden_size)]
        
        # 候補値の重み
        self.Wc = [[random.gauss(0, std) for _ in range(input_size + hidden_size)] 
                   for _ in range(hidden_size)]
        self.bc = [0.0 for _ in range(hidden_size)]
        
        # 出力ゲートの重み
        self.Wo = [[random.gauss(0, std) for _ in range(input_size + hidden_size)] 
                   for _ in range(hidden_size)]
        self.bo = [0.0 for _ in range(hidden_size)]
        
        # 出力層の重み
        self.Wy = [[random.gauss(0, std) for _ in range(hidden_size)] 
                   for _ in range(output_size)]
        self.by = [0.0 for _ in range(output_size)]
    
    def sigmoid(self, x):
        """シグモイド活性化関数"""
        try:
            return 1 / (1 + math.exp(-x))
        except OverflowError:
            return 0.0 if x < 0 else 1.0
    
    def tanh(self, x):
        """tanh活性化関数"""
        try:
            return math.tanh(x)
        except OverflowError:
            return -1.0 if x < 0 else 1.0
    
    def forward(self, inputs):
        """
        順伝播計算
        
        Args:
            inputs: 入力系列 [[x1], [x2], [x3], ...]
            
        Returns:
            最終出力
        """
        # 隠れ状態とセル状態の初期化
        h = [0.0] * self.hidden_size
        c = [0.0] * self.hidden_size
        
        # 各時刻での計算
        for x in inputs:
            # 入力と前の隠れ状態を結合
            combined = x + h
            
            # 忘却ゲート: f_t = σ(W_f * [h_{t-1}, x_t] + b_f)
            f = []
            for i in range(self.hidden_size):
                val = sum(self.Wf[i][j] * combined[j] for j in range(len(combined))) + self.bf[i]
                f.append(self.sigmoid(val))
            
            # 入力ゲート: i_t = σ(W_i * [h_{t-1}, x_t] + b_i)
            i = []
            for idx in range(self.hidden_size):
                val = sum(self.Wi[idx][j] * combined[j] for j in range(len(combined))) + self.bi[idx]
                i.append(self.sigmoid(val))
            
            # 候補値: C̃_t = tanh(W_C * [h_{t-1}, x_t] + b_C)
            c_tilde = []
            for idx in range(self.hidden_size):
                val = sum(self.Wc[idx][j] * combined[j] for j in range(len(combined))) + self.bc[idx]
                c_tilde.append(self.tanh(val))
            
            # セル状態の更新: C_t = f_t * C_{t-1} + i_t * C̃_t
            c = [f[idx] * c[idx] + i[idx] * c_tilde[idx] for idx in range(self.hidden_size)]
            
            # 出力ゲート: o_t = σ(W_o * [h_{t-1}, x_t] + b_o)
            o = []
            for idx in range(self.hidden_size):
                val = sum(self.Wo[idx][j] * combined[j] for j in range(len(combined))) + self.bo[idx]
                o.append(self.sigmoid(val))
            
            # 隠れ状態の更新: h_t = o_t * tanh(C_t)
            h = [o[idx] * self.tanh(c[idx]) for idx in range(self.hidden_size)]
        
        # 最終出力の計算
        output = []
        for i in range(self.output_size):
            val = sum(self.Wy[i][j] * h[j] for j in range(len(h))) + self.by[i]
            output.append(self.sigmoid(val))
        
        return output

def create_sample_data():
    """
    サンプルデータの作成
    [1,0,1]パターンを含む系列の分類タスク
    """
    # パターン [1,0,1] を含む系列は1、そうでなければ0
    patterns = [
        ([[1.0], [0.0], [1.0]], 1),  # パターンあり
        ([[0.0], [1.0], [0.0]], 0),  # パターンなし
        ([[1.0], [1.0], [0.0]], 0),  # パターンなし
        ([[0.0], [0.0], [1.0]], 0),  # パターンなし
        ([[1.0], [0.0], [1.0]], 1),  # パターンあり
    ]
    return patterns

def test_lstm():
    """LSTMモデルのテスト"""
    print("LSTM (Long Short-Term Memory) ニューラルネットワークのテスト")
    print("=" * 60)
    
    # モデルの設定
    input_size = 1      # 各時刻の入力次元
    hidden_size = 10    # 隠れ層のユニット数
    output_size = 2     # 出力クラス数（パターンあり/なし）
    
    # LSTMモデルの作成
    lstm = LSTM(input_size, hidden_size, output_size)
    print(f"LSTMモデルを作成しました")
    print(f"- 入力次元: {input_size}")
    print(f"- 隠れユニット数: {hidden_size}")
    print(f"- 出力次元: {output_size}")
    print()
    
    # サンプルデータの取得
    test_data = create_sample_data()
    
    print("テストデータでの予測実行:")
    print("-" * 40)
    
    for i, (sequence, expected) in enumerate(test_data):
        # 予測実行
        output = lstm.forward(sequence)
        
        # 結果表示
        input_sequence = [x[0] for x in sequence]
        predicted_class = 0 if output[0] > output[1] else 1
        confidence = max(output)
        
        print(f"テスト {i+1}: {input_sequence}")
        print(f"  期待値: {expected}, 予測: {predicted_class}")
        print(f"  出力: [{output[0]:.4f}, {output[1]:.4f}]")
        print(f"  信頼度: {confidence:.4f}")
        
        if predicted_class == expected:
            print("  結果: ✓ 正解")
        else:
            print("  結果: ✗ 不正解")
        print()
    
    print("注意: このモデルは学習していないため、予測は初期重みに基づくランダムな結果です。")
    print("実際の使用では、訓練データを用いた学習が必要です。")

if __name__ == "__main__":
    # メイン実行
    test_lstm()