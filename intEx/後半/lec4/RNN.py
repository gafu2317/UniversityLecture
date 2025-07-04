#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
第4回演習問題（複数設定対応版）
"""
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import glob
import os
from scipy.io import loadmat

np.random.seed(0)

# --- 関数定義 (変更なし) ---
def read_data(dir_name, utterance_train, utterance_test, scaling_factor):
    data_files = glob.glob(os.path.join(dir_name, '*.mat'))
    x_train, y_train, x_test, y_test = [], [], [], []
    if len(data_files) > 0:
        print(f"{len(data_files)} files in {dir_name} を読み込んでいます...")
        for each_file in data_files:
            data = loadmat(each_file)
            utterance = int(each_file[-8])
            digit = int(each_file[-5])
            if utterance in utterance_train:
                x_train.append(data['spec'].T*scaling_factor)
                y_train.append(digit)
            elif utterance in utterance_test:
                x_test.append(data['spec'].T*scaling_factor)
                y_test.append(digit)
    else:
        print(f"ディレクトリ {dir_name} にファイルが見つかりません．")
        return None, None, None, None
    return x_train, y_train, x_test, y_test

def softmax(x):
    u = x.T
    e = np.exp(u-np.max(u, axis=0))
    return (e/np.sum(e, axis = 0)).T

def sigmoid(x):
    tmp = 1/(1+np.exp(-x))
    return tmp, tmp*(1-tmp)

def ReLU(x):
    return x*(x>0), 1*(x>0)
    
def CrossEntoropy(x, y):
    epsilon = 1e-10
    return -np.sum(y*np.log(x + epsilon))

def forward(x, z_prev, W_in, W, actfunc):
    tmp = np.dot(W_in, x)+np.dot(W, z_prev)
    z, u = actfunc(tmp)
    return z, u

def backward(W, W_out, delta, delta_out, derivative):
    return (np.dot(W.T, delta)+np.dot(W_out.T, delta_out))*derivative

def adam(W, m, v, dEdW, t, alpha=0.001, beta1=0.9, beta2=0.999, tol=1e-8):
    m_t = beta1*m+(1-beta1)*dEdW
    v_t = beta2*v+(1-beta2)*dEdW**2
    m_hat = m_t/(1-beta1**t)
    v_hat = v_t/(1-beta2**t)
    w_t = W - alpha*m_hat/(np.sqrt(v_hat)+tol)
    return w_t, m_t, v_t

# --- ここから変更箇所 ---

def run_experiment(
    q_units,
    optimizer_name,
    activation_func_tuple,
    num_epochs,
    learning_rate,
    utterance_train_list,
    utterance_test_list
):
    """
    指定された設定でRNNの学習とテストを1回実行する関数
    """
    
    # --- 1. ファイル名の設定 ---
    act_name = activation_func_tuple[0]
    file_prefix = f"result_opt_{optimizer_name}_q_{q_units}_act_{act_name}_epoch_{num_epochs}"
    print("\n" + "="*50)
    print(f"実験開始: {file_prefix}")
    print("="*50)
    
    # --- 2. データ読み込みと準備 ---
    dir_name = './Lyon_decimation_128'
    d = 77
    m = 10
    scaling_factor = 1e+3
    
    x_train, y_train, x_test, y_test = read_data(dir_name, utterance_train_list, utterance_test_list, scaling_factor)
    if x_train is None: return

    n_train = len(x_train)
    n_test = len(x_test)

    y_train_vec = [np.eye(m)[label] for label in y_train]
    y_test_vec = [np.eye(m)[label] for label in y_test]

    # --- 3. パラメータ初期化 ---
    # 関数の引数で設定を反映させる
    q = q_units
    activation_func = activation_func_tuple[1]

    W_in = np.random.normal(0, 0.1, size=(q, d+1))
    W = np.random.normal(0, 0.1, size=(q, q))
    W_out = np.random.normal(0, 0.1, size=(m, q+1))
    
    m_in, v_in = np.zeros_like(W_in), np.zeros_like(W_in)
    m_hidden, v_hidden = np.zeros_like(W), np.zeros_like(W)
    m_out, v_out = np.zeros_like(W_out), np.zeros_like(W_out)
    
    # --- 4. 学習ループ ---
    error = []
    error_test = []
    n_update = 0
    
    print("学習を行っています...")
    for epoch in range(num_epochs):
        print(f"epoch = {epoch}")
        index = np.random.permutation(n_train)
        e = np.full(n_train, np.nan)
        
        for i in index:
            xi, yi = x_train[i], y_train_vec[i]
            T = xi.shape[0]
            
            # 順伝播
            Z_prime = np.zeros((q,T+1))
            nabla_f = np.zeros((q,T))
            for t in range(T):
                Z_prime[:,t+1], nabla_f[:,t] = forward(np.append(1, xi[t,:]), Z_prime[:,t], W_in, W, activation_func)
            
            Z_T = np.append(1, Z_prime[:,T])
            z_out = softmax(np.dot(W_out, Z_T))
            e[i] = CrossEntoropy(z_out, yi)
            
            if epoch == 0: continue

            # 逆伝播 & 勾配計算
            delta_out = z_out - yi
            delta = np.zeros((q,T))
            for t in reversed(range(T)):
                if t == T-1:
                    delta[:,t] = backward(W, W_out[:,1:], np.zeros(q), delta_out, nabla_f[:,t])
                else:
                    delta[:,t] = backward(W, W_out[:,1:], delta[:,t+1], np.zeros(m), nabla_f[:,t])
            
            dEdW_out = np.outer(delta_out, Z_T)
            X = np.hstack((np.ones(T).reshape(-1,1), xi))
            dEdW_in = np.dot(delta, X)
            dEdW = np.dot(delta, Z_prime[:,:T].T)
            
            # パラメータ更新 (オプティマイザの選択)
            if optimizer_name == 'adam':
                n_update += 1
                W_out, m_out, v_out = adam(W_out, m_out, v_out, dEdW_out, n_update, alpha=learning_rate)
                W, m_hidden, v_hidden = adam(W, m_hidden, v_hidden, dEdW, n_update, alpha=learning_rate)
                W_in, m_in, v_in = adam(W_in, m_in, v_in, dEdW_in, n_update, alpha=learning_rate)
            else: # SGD
                W_out -= learning_rate * dEdW_out
                W -= learning_rate * dEdW
                W_in -= learning_rate * dEdW_in

        error.append(np.nanmean(e))
        
        # テスト
        e_test = np.full(n_test, np.nan)
        prob = np.zeros((n_test, m))
        for i in range(n_test):
            xi, yi = x_test[i], y_test_vec[i]
            T = xi.shape[0]
            Z_prime = np.zeros((q,T+1))
            for t in range(T):
                Z_prime[:,t+1] = forward(np.append(1, xi[t,:]), Z_prime[:,t], W_in, W, activation_func)[0]
            z_out = softmax(np.dot(W_out, np.append(1, Z_prime[:,T])))
            prob[i,:] = z_out
            e_test[i] = CrossEntoropy(z_out, yi)
        error_test.append(np.nanmean(e_test))

    # --- 5. 結果の保存 ---
    # 誤差関数のプロット
    plt.figure() # 新しい図を作成
    plt.plot(error, label="training", lw=3)
    plt.plot(error_test, label="test", lw=3)
    plt.xlabel("Epoch", fontsize=18)
    plt.ylabel("Cross-entropy", fontsize=18)
    plt.grid()
    plt.legend(fontsize=16)
    plt.title(file_prefix)
    plt.savefig(f"./{file_prefix}_error.pdf", bbox_inches='tight')
    plt.close()

    # 混同行列のプロット
    predict_label = np.argmax(prob, axis=1)
    true_label = np.argmax(y_test_vec, axis=1)
    ConfMat = np.zeros((m, m))
    for i in range(m):
        for j in range(m):
            ConfMat[i, j] = np.sum((true_label == i) & (predict_label == j))
    
    plt.figure() # 新しい図を作成
    fig, ax = plt.subplots(figsize=(5,5), tight_layout=True)
    sns.heatmap(ConfMat.astype(dtype=int), linewidths=1, annot=True, fmt="1", cbar=False, cmap="Blues", ax=ax)
    ax.set_xlabel("Predict", fontsize=18)
    ax.set_ylabel("True", fontsize=18)
    ax.set_title(file_prefix)
    plt.savefig(f"./{file_prefix}_confusion.pdf", bbox_inches="tight")
    plt.close(fig)
    print(f"結果を保存しました: {file_prefix}_*.pdf")


# --- ここからメインの実行部分 ---
if __name__ == '__main__':
    # --- 実験したい設定をリストで定義 ---
    
    # 1. ユニット数
    q_list = [64, 128]
    
    # 2. オプティマイザ ('sgd' または 'adam')
    optimizer_list = ['sgd', 'adam']
    
    # 3. 活性化関数 (名前と関数のタプル)
    activation_list = [('sigmoid', sigmoid)] # ('relu', ReLU) も追加可能
    
    # 4. エポック数
    epoch_list = [30]
    
    # 5. 学習率
    lr_list = [0.001]
    
    # 6. 訓練/テストデータ
    train_utterances = [1, 2, 3, 4, 5, 6, 7]
    test_utterances = [8, 9, 0]

    # --- ループですべての組み合わせを実行 ---
    for q_val in q_list:
        for opt_name in optimizer_list:
            for act_tuple in activation_list:
                for epochs in epoch_list:
                    for lr in lr_list:
                        # 関数を実行
                        run_experiment(
                            q_units=q_val,
                            optimizer_name=opt_name,
                            activation_func_tuple=act_tuple,
                            num_epochs=epochs,
                            learning_rate=lr,
                            utterance_train_list=train_utterances,
                            utterance_test_list=test_utterances
                        )

    print("\nすべての実験が完了しました。")