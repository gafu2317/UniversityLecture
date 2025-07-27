"""
複雑なニューラルネットワークの実装
課題4: LSTMを用いた再帰型ニューラルネットワークの実装
"""

import numpy as np
import matplotlib.pyplot as plt

class LSTM:
    """
    LSTM (Long Short-Term Memory) の実装
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
        
        # 重みの初期化（Xavier初期化を使用）
        std = 0.1
        
        # 忘却ゲートの重み
        self.Wf = np.random.normal(0, std, (hidden_size, input_size + hidden_size))
        self.bf = np.zeros(hidden_size)
        
        # 入力ゲートの重み
        self.Wi = np.random.normal(0, std, (hidden_size, input_size + hidden_size))
        self.bi = np.zeros(hidden_size)
        
        # 候補値の重み
        self.Wc = np.random.normal(0, std, (hidden_size, input_size + hidden_size))
        self.bc = np.zeros(hidden_size)
        
        # 出力ゲートの重み
        self.Wo = np.random.normal(0, std, (hidden_size, input_size + hidden_size))
        self.bo = np.zeros(hidden_size)
        
        # 出力層の重み
        self.Wy = np.random.normal(0, std, (output_size, hidden_size))
        self.by = np.zeros(output_size)
    
    def sigmoid(self, x):
        """シグモイド関数"""
        return 1 / (1 + np.exp(-np.clip(x, -500, 500)))
    
    def tanh(self, x):
        """ハイパボリックタンジェント関数"""
        return np.tanh(x)
    
    def softmax(self, x):
        """ソフトマックス関数"""
        exp_x = np.exp(x - np.max(x))
        return exp_x / np.sum(exp_x)
    
    def forward(self, inputs):
        """
        順伝播計算
        
        Args:
            inputs: 入力系列 (sequence_length, input_size)
            
        Returns:
            outputs: 各時刻の出力
            states: 内部状態の履歴
        """
        sequence_length = len(inputs)
        
        # 状態の初期化
        h = np.zeros(self.hidden_size)  # 隠れ状態
        c = np.zeros(self.hidden_size)  # セル状態
        
        outputs = []
        states = {'h': [h.copy()], 'c': [c.copy()]}
        
        for t in range(sequence_length):
            x = inputs[t]
            
            # 入力と隠れ状態を結合
            combined = np.concatenate([x, h])
            
            # 忘却ゲート
            f = self.sigmoid(np.dot(self.Wf, combined) + self.bf)
            
            # 入力ゲート
            i = self.sigmoid(np.dot(self.Wi, combined) + self.bi)
            
            # 候補値
            c_tilde = self.tanh(np.dot(self.Wc, combined) + self.bc)
            
            # セル状態の更新
            c = f * c + i * c_tilde
            
            # 出力ゲート
            o = self.sigmoid(np.dot(self.Wo, combined) + self.bo)
            
            # 隠れ状態の更新
            h = o * self.tanh(c)
            
            # 出力層
            y = np.dot(self.Wy, h) + self.by
            
            outputs.append(y)
            states['h'].append(h.copy())
            states['c'].append(c.copy())
        
        return outputs, states
    
    def predict(self, inputs):
        """予測を行う"""
        outputs, _ = self.forward(inputs)
        predictions = [self.softmax(output) for output in outputs]
        return predictions

def generate_sample_data(n_samples=100, sequence_length=10):
    """
    サンプルデータ生成（簡単な時系列分類問題）
    パターン：[1,0,1]が含まれるか判定
    """
    X = []
    y = []
    
    for _ in range(n_samples):
        # ランダムな2値系列を生成
        sequence = np.random.choice([0, 1], size=sequence_length)
        
        # [1,0,1]パターンが含まれるかチェック
        contains_pattern = False
        for i in range(len(sequence) - 2):
            if (sequence[i] == 1 and sequence[i+1] == 0 and sequence[i+2] == 1):
                contains_pattern = True
                break
        
        # ワンホットエンコーディング
        sequence_onehot = []
        for val in sequence:
            if val == 0:
                sequence_onehot.append([1, 0])
            else:
                sequence_onehot.append([0, 1])
        
        X.append(sequence_onehot)
        y.append([1, 0] if contains_pattern else [0, 1])
    
    return np.array(X), np.array(y)

def main():
    """メイン実行関数"""
    print("LSTM時系列分類の実験")
    print("=" * 50)
    
    # ハイパーパラメータ
    input_size = 2      # [0,1]のワンホット
    hidden_size = 10    # 隠れ層のユニット数
    output_size = 2     # パターンあり/なしの2クラス
    n_samples = 200     # サンプル数
    sequence_length = 15  # 系列長
    
    print(f"設定:")
    print(f"  入力サイズ: {input_size}")
    print(f"  隠れ層ユニット数: {hidden_size}")
    print(f"  出力サイズ: {output_size}")
    print(f"  系列長: {sequence_length}")
    print(f"  サンプル数: {n_samples}")
    print()
    
    # データ生成
    print("データ生成中...")
    X, y = generate_sample_data(n_samples, sequence_length)
    
    # LSTMモデルの作成
    lstm = LSTM(input_size, hidden_size, output_size)
    
    # いくつかのサンプルで予測を実行
    print("予測実行中...")
    print()
    
    for i in range(3):
        sample_input = X[i]
        true_label = y[i]
        
        predictions = lstm.predict(sample_input)
        final_prediction = predictions[-1]  # 最後の時刻の予測
        
        # 入力系列を表示
        input_sequence = [np.argmax(x) for x in sample_input]
        print(f"サンプル {i+1}:")
        print(f"  入力系列: {input_sequence}")
        print(f"  真のラベル: {'パターンあり' if np.argmax(true_label) == 0 else 'パターンなし'}")
        print(f"  予測確率: パターンあり={final_prediction[0]:.3f}, パターンなし={final_prediction[1]:.3f}")
        print(f"  予測結果: {'パターンあり' if final_prediction[0] > final_prediction[1] else 'パターンなし'}")
        print()
    
    print("実験完了!")
    print("注意: これは訓練前の初期状態での予測結果です。")
    print("実際の学習には勾配計算と最適化アルゴリズムの実装が必要です。")

if __name__ == "__main__":
    main()