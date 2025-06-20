#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
第2回演習問題2
"""
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from tensorflow.keras.utils import to_categorical
from tensorflow.keras.datasets import mnist

use_small_data = True # False
plot_misslabeled = False

##### データの取得
#クラス数を定義
m = 3

(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train = x_train.astype('float32') / 255.
x_train = x_train.reshape([60000, 28*28])
x_train = x_train[y_train < m,:]

x_test = x_test.astype('float32') / 255.
x_test = x_test.reshape([10000, 28*28])
x_test = x_test[y_test < m,:]

y_train = y_train[y_train < m]
y_train = to_categorical(y_train, m)

y_test = y_test[y_test < m]
y_test = to_categorical(y_test, m)

if use_small_data:
    ## プログラム作成中は訓練データを小さくして，
    ## 実行時間が短くようにしておく
    y_train = y_train[range(1000)]
    x_train = x_train[range(1000),:]

n, d = x_train.shape
n_test, _ = x_test.shape

np.random.seed(123)



##### 課題1(a) 活性化関数の作成

def ReLU(x):
    # returnの後にシグモイド関数を返すプログラムを書く
    return x*(x>0), 1*(x>0)

def sigmoid(x):
    # シグモイド関数とその微分を返す関数を作成
    sig = 1 / (1 + np.exp(-x))
    return sig, sig * (1 - sig)

def Tanh(x):
    # ハイパボリックタンジェントとその微分を返す関数を作成
    tanh = np.tanh(x)
    return tanh, 1 - tanh**2

##### 課題1(b) 順伝播の関数を作成
# z_in : z_k
# W_k : k層目からk+1層目へのパラメータ
# 返り値 : z_{k+1} と u_{k+1}
def forward(z_in, W_k, actfunc):
    # W_kとz_inの内積を計算
    u = np.dot(W_k, z_in)
    
    # actfuncから出力される活性化関数の値と微分値を保存
    f, nabla_f = actfunc(u)
    
    # 1と活性化関数の値fをappendしたものをz_outに設定
    z_out = np.append(1, f)
    
    # z_out, nabla_fを返す
    return z_out, nabla_f

#### ソフトマックス関数 
#### (前回の課題NN.pyで作成したものをそのまま使えば良い)
def softmax(x):
    # 数値安定性のため、最大値を引く
    exp_x = np.exp(x - np.max(x))
    return exp_x / np.sum(exp_x)

#### 誤差関数
#### (前回の課題NN.pyで作成したものをそのまま使えば良い)
def CrossEntoropy(g, y):
    # クロスエントロピー: -sum(y_i * log(g_i))
    # 数値安定性のため、小さな値εを加える
    epsilon = 1e-10
    return -np.sum(y * np.log(g + epsilon))

#### 逆伝播
def backward(W_tilde, delta, derivative):
    # 逆伝播のプログラムを書く
    # (前回とほぼ同じ)
    return np.dot(W_tilde.T, delta) * derivative

##### 中間層のユニット数とパラメータの初期値

q1 = 200
q2 = 100
q3 = 20

W0 = np.random.normal(0, 0.2, size=(q1, d+1))
W1 = np.random.normal(0, 0.2, size=(q2, q1+1))
W2 = np.random.normal(0, 0.2, size=(q3, q2+1))
W3 = np.random.normal(0, 0.2, size=(m, q3+1))

########## 確率的勾配降下法によるパラメータ推定
num_epoch = 50

eta = 10**(-2)

error = []
error_test = []

for epoch in range(0, num_epoch):
    print("epoch =", epoch)
    index = np.random.permutation(n)
    
    e = np.full(n,np.nan)
    for i in index:
        z0 = np.append(1, x_train[i, :]) # 前回まで変数xiとしてたものと同じ
        yi = y_train[i, :]

        ##### 課題1(c) 順伝播 (訓練データ版, テストデータ版もあるので注意)

        ## 入力層(第0層)から第1層へ
        z1, u1 = forward(z0, W0, Tanh) 

        ## 第1層から第2層へ
        z2, u2 = forward(z1, W1, Tanh)

        ## 第2層から第3層へ
        z3, u3 = forward(z2, W2, Tanh)

        ## 第3層から出力層(第3層)へ
        g = softmax(np.dot(W3, z3))
        
        ##### 誤差評価
        e[i] = CrossEntoropy(g, yi)

        ##### 課題1(c) 訓練版ここまで

        if epoch == 0:
            continue

        eta_t = eta/epoch 
        
        ##### 課題1(d) 逆伝播

        delta3 = g - yi
        delta2 = backward(W3[:, 1:], delta3, u3)
        delta1 = backward(W2[:, 1:], delta2, u2)
        delta0 = backward(W1[:, 1:], delta1, u1)

        ##### 課題1(e) パラメータの更新
        # 各層の重みを更新
        W3 = W3 - eta_t * np.outer(delta3, z3)
        W2 = W2 - eta_t * np.outer(delta2, z2)
        W1 = W1 - eta_t * np.outer(delta1, z1)
        W0 = W0 - eta_t * np.outer(delta0, z0)

    ##### training error
    error.append(sum(e)/n) 

    ##### test error
    e_test = np.full(n_test, np.nan) 
    prob = np.full((n_test,m),np.nan)
    for j in range(0, n_test):
        z0 = np.append(1, x_test[j, :])
        yi = y_test[j, :]

        ##### 課題1(c) 順伝播 (テストデータ版. やることは訓練データと同じ)
        z1, u1 = forward(z0, W0, Tanh) 
        z2, u2 = forward(z1, W1, Tanh)
        z3, u3 = forward(z2, W2, Tanh)

        # 後で使うため，ここでは出力を(n_test x m)配列probに保存
        # （特に気にする必要なし）
        prob[j,:] = softmax(np.dot(W3, z3))
        
        ##### テスト誤差: 誤差をe_testに保存
        e_test[j] = CrossEntoropy(prob[j,:], yi)

        ##### 課題1(c) テスト版 ここまで        

    error_test.append(sum(e_test)/n_test)
    e_test = []

########## 誤差関数のプロット
plt.clf()
plt.plot(error, label="training", lw=3)     #青線
plt.plot(error_test, label="test", lw=3)     #オレンジ線
plt.yscale("log")
plt.xlabel("Epoch")
plt.ylabel("Cross-entropy (log-scale)")
plt.grid()
plt.legend(fontsize =16)
plt.savefig("./error.pdf", bbox_inches='tight', transparent=True)
    
predict = np.argmax(prob, 1)


predict_label = np.argmax(prob, axis=1)
true_label = np.argmax(y_test, axis=1)


ConfMat = np.zeros((m, m))

# 混同行列の計算
for i in range(len(true_label)):
    ConfMat[true_label[i], predict_label[i]] += 1

plt.clf()
fig, ax = plt.subplots(figsize=(5,5))
sns.heatmap(ConfMat.astype(dtype = int), linewidths=1, annot = True, fmt="1", cbar =False, cmap="Blues")
ax.set_xlabel(xlabel="Predict", fontsize=18)
ax.set_ylabel(ylabel="True", fontsize=18)
plt.savefig("./confusion.pdf", bbox_inches="tight", transparent=True)

if plot_misslabeled:
    n_maxplot = 20
    n_plot = 0

    ##### 誤分類結果のプロット
    for i in range(m):
        idx_true = (y_test[:, i]==1)
        for j in range(m):
            idx_predict = (predict==j)
            if j != i:
                for l in np.where(idx_true*idx_predict == True)[0]:
                    plt.clf()
                    D = np.reshape(x_test[l, :], (28, 28))
                    sns.heatmap(D, cbar =False, cmap="Blues", square=True)
                    plt.axis("off")
                    plt.title('{} to {}'.format(i, j))
                    plt.savefig("./misslabeled{}.pdf".format(l), bbox_inches='tight', transparent=True)

plt.close()
