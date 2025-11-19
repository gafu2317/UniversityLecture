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
    # 評価結果の記録向けに初期化
    start_timestamp = time.time()
    eval_rewards = []
    elapse_time = []
    steps = []

    state, _ = env.reset()

    for step in range(1, num_steps + 1):
        action = agent.select_action(state)
        next_state, reward, _, _, _ = env.step(action)

        agent.update(state, action, reward, next_state, False)
        state = next_state

        # 評価とそ記録
        if step % eval_interval == 0:
            eval_reward_sum = 0
            _eval_step = 0
            eval_state, _ = eval_env.reset()
            while _eval_step < eval_steps:
                action = agent.greedy(eval_state)
                next_state, reward, _, _, _ = eval_env.step(action)
                eval_state = next_state
                eval_reward_sum += reward
                _eval_step += 1

            print(f"Evaluation: {step=}, {eval_reward_sum=}")
            eval_rewards.append(eval_reward_sum)
            elapse_time.append(time.time() - start_timestamp)
            steps.append(step)

    # Qテーブルを保存し記録を返す
    if log_q is not None:
        agent.save_q(log_q)
    return eval_rewards, elapse_time, steps


if __name__ == "__main__":
    # 学習用の環境
    env = OfflineEnv(
        # 仮想の🍎の寿命．[1,6)の間の整数値の寿命をランダムに設定．寿命が切れたら，別の場所にランダムに配置．
        life_range=(35, 36)
    )
    # 評価用の環境
    eval_env = OfflineEnv(life_range=(35, 36))

    agent = QTableAgent(
        env.observation_space,
        env.action_space,
        alpha=0.1,  # 学習率
        gamma=0.1,  # 割引率
        epsilon=0.1,  # 探索率
    )

    # 学習の実行，評価結果のcsvファイルの作成，その可視化
    eval_rewards, elapse_time, steps = train(
        env,
        eval_env=eval_env,
        agent=agent,
        num_steps=10**2,  # 学習ステップ数
        eval_interval=10**1,  # 評価間隔
        eval_steps=20,  # 1回の評価あたりに計測するステップ数
        log_q=Path(".") / "test_q_trained",  # Qテーブルの書き出し先
    )

    # csvファイルに書き出す
    df = pd.DataFrame({"step": steps, "eval_rewards": eval_rewards})
    df.to_csv("test_eval.csv")

    # 可視化する
    plt.plot(steps, eval_rewards)
    plt.xlabel("#step")
    plt.ylabel("Evaluated summed reward")
    plt.show()
