
# パッケージと使用例

## Numpy

```python
import numpy as np

# 要素が全て0の5✕10行列を作成
>>> np.zeros((5,10))
array([[0., 0., 0., 0., 0., 0., 0., 0., 0., 0.],
       [0., 0., 0., 0., 0., 0., 0., 0., 0., 0.],
       [0., 0., 0., 0., 0., 0., 0., 0., 0., 0.],
       [0., 0., 0., 0., 0., 0., 0., 0., 0., 0.],
       [0., 0., 0., 0., 0., 0., 0., 0., 0., 0.]])

# 2行目の要素を取得
>>> np.arange(5*10).reshape((5,10))
array([[ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9],
       [10, 11, 12, 13, 14, 15, 16, 17, 18, 19],
       [20, 21, 22, 23, 24, 25, 26, 27, 28, 29],
       [30, 31, 32, 33, 34, 35, 36, 37, 38, 39],
       [40, 41, 42, 43, 44, 45, 46, 47, 48, 49]])
>>> x = np.arange(5*10).reshape((5,10))
>>> x[1]
array([10, 11, 12, 13, 14, 15, 16, 17, 18, 19])

# 2行2列目の要素を取得
>>> x[1,1]
np.int64(11)

# 最大値を取得
>>> np.max(x)
np.int64(49)

# 条件にあうindexを取得
>>> np.where(x[0]==5)
(array([5]),)

# 乱数シード（seed）を設定した乱数の生成器を取得（numpy>1.17）
# 注意: バージョンによって異なる．[参考](https://note.nkmk.me/python-numpy-random/)
>>> rng = np.random.default_rng(seed=10)

# 連続値[0.0, 1.0)を一様分布からサンプリング
>>> rng.random()
0.20768181007914688

# 整数[0,...,n-1]を一様分布からサンプリング
>>> rng.integers(10)
np.int64(7)

# リストから1つをランダムに選択
>>> rng.choice([0, 1, 2, 5])
np.int64(5)
```

## Gymnasium

```python
>>> from gymnasium.utils import seeding
>>> from gymnasium.spaces import Discrete

# 乱数シード（seed）を設定した乱数の生成器を取得
>>> rng, _ = seeding.np_random(seed)

# 離散空間を初期化
>>> x = Discrete(10)

# 空間の要素数
>>> x.n
np.int64(10)
```

## Enum

```python
>>> from enum import IntEnum

# 定義
>>> class Action(IntEnum):
...     UP = 0
...     DOWN = 1
...     LEFT = 2
...     RIGHT = 3
... 

# 初期化
>>> Action(0)     
<Action.UP: 0>
>>> Action(1)
<Action.DOWN: 1>

# 判定
>>> up = Action.UP
>>> Action.UP==up
True
>>> Action.DOWN==up
False
```

## Matplotlib

```python
>>> import matplotlib.pyplot as plt

# ラインプロット
>>> x = [0,1,2]
>>> y = [10, 10, 5]
>>> plt.plot(x, y)
[<matplotlib.lines.Line2D object at 0x0000020C62680C50>]
>>> plt.xlabel("X axis")
Text(0.5, 0, 'X axis')
>>> plt.ylabel("Y axis")
Text(0, 0.5, 'Y axis')
>>> plt.show()
```

## Pandas

```python
>>> import pandas as pd

# 初期化
>>> df = pd.DataFrame({"x": [0,1,2], "y": [10, 10, 5]})
>>> df 
   x   y
0  0  10
1  1  10
2  2   5

# csvに書き出す
>>> file_path = "test.csv"
>>> df.to_csv(file_path)
```
