import logging

import numpy as np
from gymnasium.spaces.discrete import Discrete
from gymnasium.utils import seeding

logger = logging.getLogger(__name__)


class QTableAgent:
    def __init__(
        self,
        o_space: Discrete,
        a_space: Discrete,
        alpha=0.1,
        gamma=0.99,
        epsilon=0.1,
        seed=None,
    ):
        assert isinstance(o_space, Discrete), (
            "Please use the Discrete class for the observation space"
        )
        assert isinstance(a_space, Discrete), (
            "Please use the Discrete class for the action space"
        )

        self.obs_space_size = o_space.n
        self.action_space_size = a_space.n

        # Q学習パラメータ
        self.alpha = alpha
        self.gamma = gamma
        self.epsilon = epsilon
        
        # Qテーブルを初期化（状態×行動の2次元配列）
        self.Q = np.zeros(
            (self.obs_space_size, self.action_space_size), dtype=np.float32
        )
        # 乱数生成器
        self.rng, _ = seeding.np_random(seed)

    def select_action(self, state):
        if self.rng.random() < self.epsilon:
            return self.rng.integers(self.action_space_size)
        else:
            return self.greedy(state)

    def greedy(self, state):
        # 1. 配列の最⼤値を求める
        max_val = np.max(self.Q[state])
        # 2. 最⼤値と等しい要素のインデックスを取得
        candidates = np.flatnonzero(self.Q[state] == max_val)
        # 3. その中からランダムに１つ選ぶ
        return self.rng.choice(candidates)

    def update(self, state, action, reward, next_state, done):
        best_next = np.max(self.Q[next_state])
        td_target = reward + (0 if done else self.gamma * best_next)
        td_error = td_target - self.Q[state, action]
        self.Q[state, action] += self.alpha * td_error

    def save_q(self, path):
        np.save(path, self.Q)

    def load_q(self, path):
        self.Q = np.load(path)
