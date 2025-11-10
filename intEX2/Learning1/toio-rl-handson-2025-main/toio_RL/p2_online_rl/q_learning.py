import logging

import numpy as np
from gymnasium.spaces.discrete import Discrete
from gymnasium.utils import seeding

logger = logging.getLogger(__name__)


class QTableAgent:
    def __init__(
        self,
        o_spcae: Discrete,
        a_space: Discrete,
        alpha=0.1,
        gamma=0.99,
        epsilon=0.1,
        seed=None,
    ):
        assert isinstance(o_spcae, Discrete), (
            "Please use the Discrete class for the observation space"
        )
        assert isinstance(a_space, Discrete), (
            "Please use the Discrete class for the action space"
        )

        self.obs_space_size = o_spcae.n
        self.action_space_size = a_space.n

        #TODO: 初期化処理（パラメータ，Qテーブル）
        # 乱数生成器
        self.rng, _ = seeding.np_random(seed)

    def select_action(self, state):
        pass #TODO: ε-greedyによる行動選択

    def greedy(self, state):
        pass #TODO: greedyによる行動選択

    def update(self, state, action, reward, next_state, done):
        pass #TODO: Q関数の更新

    def save_q(self, path):
        np.save(path, self.Q)

    def load_q(self, path):
        self.Q = np.load(path)
