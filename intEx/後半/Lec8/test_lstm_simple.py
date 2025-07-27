#!/usr/bin/env python3
"""
Simple LSTM test without numpy - using only standard Python
"""

import math
import random

def sigmoid(x):
    """シグモイド関数"""
    try:
        return 1 / (1 + math.exp(-x))
    except OverflowError:
        return 0.0 if x < 0 else 1.0

def tanh(x):
    """tanh関数"""
    try:
        return math.tanh(x)
    except OverflowError:
        return -1.0 if x < 0 else 1.0

def matrix_multiply(A, B):
    """行列の乗算（簡易版）"""
    if not A or not B:
        return []
    
    rows_A, cols_A = len(A), len(A[0])
    rows_B, cols_B = len(B), len(B[0])
    
    if cols_A != rows_B:
        raise ValueError("行列のサイズが合いません")
    
    result = [[0 for _ in range(cols_B)] for _ in range(rows_A)]
    
    for i in range(rows_A):
        for j in range(cols_B):
            for k in range(cols_A):
                result[i][j] += A[i][k] * B[k][j]
    
    return result

def vector_add(a, b):
    """ベクトルの加算"""
    return [x + y for x, y in zip(a, b)]

class SimpleLSTM:
    def __init__(self, input_size, hidden_size, output_size):
        """Simple LSTM using standard Python"""
        self.input_size = input_size
        self.hidden_size = hidden_size
        self.output_size = output_size
        
        # 重みとバイアスの初期化（簡略化）
        std = 0.1
        
        # 忘却ゲート
        self.Wf = [[random.gauss(0, std) for _ in range(input_size + hidden_size)] 
                   for _ in range(hidden_size)]
        self.bf = [0.0 for _ in range(hidden_size)]
        
        # 入力ゲート
        self.Wi = [[random.gauss(0, std) for _ in range(input_size + hidden_size)] 
                   for _ in range(hidden_size)]
        self.bi = [0.0 for _ in range(hidden_size)]
        
        # 候補値
        self.Wc = [[random.gauss(0, std) for _ in range(input_size + hidden_size)] 
                   for _ in range(hidden_size)]
        self.bc = [0.0 for _ in range(hidden_size)]
        
        # 出力ゲート
        self.Wo = [[random.gauss(0, std) for _ in range(input_size + hidden_size)] 
                   for _ in range(hidden_size)]
        self.bo = [0.0 for _ in range(hidden_size)]
        
        # 最終出力層
        self.Wy = [[random.gauss(0, std) for _ in range(hidden_size)] 
                   for _ in range(output_size)]
        self.by = [0.0 for _ in range(output_size)]
        
        print(f"LSTM初期化完了: 入力{input_size}, 隠れ{hidden_size}, 出力{output_size}")
    
    def forward(self, inputs):
        """順伝播"""
        h = [0.0] * self.hidden_size  # 隠れ状態
        c = [0.0] * self.hidden_size  # セル状態
        outputs = []
        
        print(f"入力系列長: {len(inputs)}")
        
        for t, x in enumerate(inputs):
            # 入力と隠れ状態を結合
            combined = x + h
            
            # 忘却ゲート
            f_input = []
            for i in range(self.hidden_size):
                val = sum(self.Wf[i][j] * combined[j] for j in range(len(combined))) + self.bf[i]
                f_input.append(val)
            f = [sigmoid(val) for val in f_input]
            
            # 入力ゲート
            i_input = []
            for i in range(self.hidden_size):
                val = sum(self.Wi[i][j] * combined[j] for j in range(len(combined))) + self.bi[i]
                i_input.append(val)
            i_gate = [sigmoid(val) for val in i_input]
            
            # 候補値
            c_tilde_input = []
            for i in range(self.hidden_size):
                val = sum(self.Wc[i][j] * combined[j] for j in range(len(combined))) + self.bc[i]
                c_tilde_input.append(val)
            c_tilde = [tanh(val) for val in c_tilde_input]
            
            # セル状態更新
            c = [f[i] * c[i] + i_gate[i] * c_tilde[i] for i in range(self.hidden_size)]
            
            # 出力ゲート
            o_input = []
            for i in range(self.hidden_size):
                val = sum(self.Wo[i][j] * combined[j] for j in range(len(combined))) + self.bo[i]
                o_input.append(val)
            o = [sigmoid(val) for val in o_input]
            
            # 隠れ状態更新
            h = [o[i] * tanh(c[i]) for i in range(self.hidden_size)]
            
            print(f"時刻{t}: 隠れ状態平均 = {sum(h)/len(h):.4f}")
        
        # 最終出力
        y_input = []
        for i in range(self.output_size):
            val = sum(self.Wy[i][j] * h[j] for j in range(len(h))) + self.by[i]
            y_input.append(val)
        output = [sigmoid(val) for val in y_input]
        
        return output

def test_lstm():
    """LSTMのテスト"""
    print("=== Simple LSTM テスト開始 ===")
    
    # LSTMモデル作成
    input_size = 1
    hidden_size = 3
    output_size = 1
    
    lstm = SimpleLSTM(input_size, hidden_size, output_size)
    
    # テストデータ
    test_sequences = [
        [[1.0], [0.0], [1.0]],  # パターン 1
        [[0.0], [1.0], [0.0]],  # パターン 2  
        [[1.0], [1.0], [0.0]],  # パターン 3
    ]
    
    print("\n=== 予測実行 ===")
    for i, sequence in enumerate(test_sequences):
        print(f"\nテストケース {i+1}: {[x[0] for x in sequence]}")
        
        try:
            output = lstm.forward(sequence)
            print(f"予測結果: {output[0]:.4f}")
            
            # 0.5を閾値として分類
            prediction = 1 if output[0] > 0.5 else 0
            print(f"分類結果: {prediction}")
            
        except Exception as e:
            print(f"エラー: {e}")
            return False
    
    print("\n=== テスト完了 ===")
    print("LSTMの基本的な動作が確認できました。")
    print("注意: 学習は実装されていないため、予測は初期重みに基づくランダムな結果です。")
    return True

if __name__ == "__main__":
    success = test_lstm()
    if success:
        print("\n✓ LSTM実装は正常に動作しています")
    else:
        print("\n✗ LSTM実装にエラーがあります")