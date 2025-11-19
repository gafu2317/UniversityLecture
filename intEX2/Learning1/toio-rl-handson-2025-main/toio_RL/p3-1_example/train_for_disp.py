from typing import Optional
from pathlib import Path
import time
from datetime import datetime
import json
import os

import matplotlib.pyplot as plt
import pandas as pd

from q_learning import QTableAgent
from offline_env import OfflineEnv
from q_plotter import QPlotter


def train(
    env,
    num_steps,
    agent,
    eval_env,
    eval_interval=10**3,
    eval_steps=100,
    log_q: Optional[Path] = None,
    plot_q: bool = True,
    plot_interval=10**2,
    plot_steps=20,
):
    # 評価結果の記録向けに初期化
    start_timestamp = time.time()
    eval_rewards = []
    elapse_time = []
    steps = []

    state, _ = env.reset()
    if plot_q:
        q_plotter = QPlotter(eval_env)
        q_plotter.plot_q(Q=agent.Q)

    for step in range(1, num_steps + 1):
        action = agent.select_action(state)
        next_state, reward, _, _, _ = env.step(action)

        agent.update(state, action, reward, next_state, False)
        state = next_state

        # 評価とそ記録
        if (step % eval_interval == 0) or (plot_q and step % plot_interval == 0):
            eval_reward_sum = 0
            _eval_step = 0
            eval_state, _ = eval_env.reset()
            while _eval_step < eval_steps:
                action = agent.greedy(eval_state)
                next_state, reward, _, _, _ = eval_env.step(action)
                eval_state = next_state
                eval_reward_sum += reward
                _eval_step += 1
                if plot_q and step % plot_interval == 0 and _eval_step < plot_steps:
                    q_plotter.plot_q(Q=agent.Q)
                    print(f"{step=}, {_eval_step=}")

            print(f"Evaluation: {step=}, {eval_reward_sum=}")
            eval_rewards.append(eval_reward_sum)
            elapse_time.append(time.time() - start_timestamp)
            steps.append(step)

    # Qテーブルを保存し記録を返す
    if log_q is not None:
        agent.save_q(log_q)
    if plot_q:
        q_plotter.close()
    return eval_rewards, elapse_time, steps


if __name__ == "__main__":
    ############################# パラメータ ###################################
    # 探索率．0から1の実数
    EPSILON = 0.1
    # 学習ステップ数．0以上の整数
    NUM_STEPS = 1000**2
    # 学習率．0以上の実数
    ALPHA = 0.02
    # 割引率．0から1未満の実数
    GAMMA = 0.9
    # 目標地点を変更するステップ数．(a,b)に対して，[a, a+1, ...., b-1]の中から一様にランダム決定．学習時
    target_life_range_for_learn = (35, 36)
    # 目標地点を変更するステップ数．(a,b)に対して，[a, a+1, ...., b-1]の中から一様にランダム決定．評価時
    target_life_range_for_eval = (35, 36)

    # Qの可視化有無
    DISPLAY_Q = True
    # 書き出すQ値のファイル名（string，必要なときのみ）
    Q_FILE_NAME = f"q_table"

    # csv/プロットする獲得報酬の計測間隔（step）．間隔が短いほど，計算負荷が増加
    EVAL_INTERVAL = NUM_STEPS / 100
    # csv/プロットする獲得報酬の評価ステップ数．各intervalごとに，このステップ数だけ行動を選択し，その間に獲得できた報酬の総和を獲得報酬とする
    EVAL_STEPS = 100
    # Q値を可視化する間隔（step）．間隔が短いほど，計算負荷が増加
    PLOT_INTERVAL = NUM_STEPS / 40
    # Q値を可視化するステップ数．各intervalごとに，表示しているステップの数
    PLOT_STEPS = 20
    ###########################################################################

    # env = OfflineEnv(life_range=target_life_range_for_learn)
    # eval_env = OfflineEnv(life_range=target_life_range_for_eval)

    # 課題①用の障害物リスト
    # obstacle_list = [(3, 2), (3, 3), (3, 4)]
    # 課題②用の障害物リスト
    obstacle_list = []


    env = OfflineEnv(
        life_range=target_life_range_for_learn, obstacles=obstacle_list
    )
    eval_env = OfflineEnv(
        life_range=target_life_range_for_eval, obstacles=obstacle_list
    )

    agent = QTableAgent(
        env.observation_space,
        env.action_space,
        alpha=ALPHA,
        gamma=GAMMA,
        epsilon=EPSILON,
    )

    eval_rewards, elapse_time, steps = train(
        env,
        eval_env=eval_env,
        agent=agent,
        num_steps=NUM_STEPS,
        eval_interval=EVAL_INTERVAL,
        eval_steps=EVAL_STEPS, 
        log_q=Path(".") / Q_FILE_NAME,  # Qテーブルの書き出し先
        plot_interval=PLOT_INTERVAL,
        plot_steps=PLOT_STEPS,
        plot_q=DISPLAY_Q,
    )

    # 動作確認向けログ
    time_str = datetime.now().strftime("%Y_%m%d_%H%M%S")

    # csvファイルに書き出す
    df = pd.DataFrame({"step": steps, "eval_rewards": eval_rewards})
    df.to_csv(f"eval_{time_str}.csv")

    # 可視化する
    plt.plot(steps, eval_rewards)
    plt.xlabel("#step")
    plt.ylabel("Evaluated summed reward")
    plt.show()
