from typing import Optional
from pathlib import Path
import time

import matplotlib.pyplot as plt
import pandas as pd

from q_learning import QTableAgent
from offline_env import OfflineEnv


def train(
    env,
    num_steps,
    agent,
    eval_env,
    eval_interval=10**3,
    eval_steps=100,
    log_q: Optional[Path] = None,
):
    #TODO: 評価結果の記録向けに初期化

    state, _ = env.reset()

    for step in range(1, num_steps + 1):
        action = agent.select_action(state)
        next_state, reward, _, _, _ = env.step(action)

        agent.update(state, action, reward, next_state, False)
        state = next_state

        #TODO: 評価とそ記録

    #TODO: Qテーブルを保存し記録を返す


if __name__ == "__main__":
    env = OfflineEnv(life_range=(1, 6))
    eval_env = OfflineEnv(life_range=(35, 36))

    agent = QTableAgent(
        env.observation_space,
        env.action_space,
        alpha=0.1,
        gamma=0.9,
        epsilon=0.1,
    )

    #TODO: 学習の実行，評価結果のcsvファイルの作成，その可視化
