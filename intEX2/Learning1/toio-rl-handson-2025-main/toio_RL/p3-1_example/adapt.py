import asyncio
import time  

from online_env import OnlineEnv
from q_learning import QTableAgent
from q_plotter import QPlotter


async def test_agent(
    env,
    agent,
    q_plot_interval,
    stuck_threshold_sec,  #  スタックと判定する秒数
    random_steps_on_stuck, #  スタック時にランダム行動する回数
):
    q_plotter = QPlotter(env)

    last_agent_pos_state = -1     # 最後に確認したエージェントの座標インデックス
    STUCK_THRESHOLD = stuck_threshold_sec
    
    # ランダム行動モードの残りステップ数
    random_mode_steps_left = 0
    try:

        state, _ = await env.reset()
        last_move_time = time.time()
        env.render()
        q_plotter.plot_q(Q=agent.Q)

        # stateからエージェントの座標インデックスを計算
        last_agent_pos_state = state // env.n_cells

        for step in range(1000):
            print(f"\n--- ステップ {step + 1} ---")

            # スタック判定と行動選択 
            current_time = time.time()
            elapsed_since_last_move = current_time - last_move_time

            action = -1  # 実行する行動を初期化

            if random_mode_steps_left > 0:
                # (1) ランダム行動モード実行中
                print(f"ランダム行動モード実行中 (残り {random_mode_steps_left} ステップ)")
                # 完全にランダムな行動を選択
                action = agent.rng.integers(agent.action_space_size)
                random_mode_steps_left -= 1

            elif elapsed_since_last_move > STUCK_THRESHOLD:
                # (2) 通常モードで、5秒以上のスタックを検出
                print(f"{STUCK_THRESHOLD}秒以上スタック検出。{random_steps_on_stuck}回のランダム行動を開始。")
                # ランダム行動モード（残り9回）に設定
                random_mode_steps_left = random_steps_on_stuck - 1 
                # 今回のステップもランダム行動（計10回）
                action = agent.rng.integers(agent.action_space_size)

            else:
                # (3) 通常モードで、スタックしていない
                # Qテーブルの最善手（greedy）を実行
                action = agent.greedy(state)

            # 行動選択終了

            # 決定した行動で環境を動かす
            next_state, reward, _, _, _ = await env.step(action)

            # 新しい状態からエージェントの座標インデックスを取得
            current_agent_pos_state = next_state // env.n_cells

            if current_agent_pos_state != last_agent_pos_state:
                # 座標が変わった場合
                print("座標が更新されました。")
                last_move_time = time.time()  # 最終移動時刻を更新
                last_agent_pos_state = current_agent_pos_state  # 最終座標を更新
            else:
                # 座標が変わらなかった場合
                print("座標は変わりませんでした。")
                # （座標が変わらない限り、タイマーはリセットされない）

            state = next_state  # 状態を更新

            env.render()
            if step % q_plot_interval == 0:
                q_plotter.plot_q(Q=agent.Q)
            print(f"状態:{state}, 報酬:{reward}")
            await asyncio.sleep(0.1) #
    except KeyboardInterrupt:
        print("\nCtrl+C を受け取りました。終了します。")
    finally:
        await env.close()


if __name__ == "__main__":
    # 学習済みQを読み込んでオンライン環境に適用
    env = OnlineEnv(agent_name="toio-e0M", target_name="toio-E1B") #
    agent = QTableAgent(
        env.observation_space,
        env.action_space,
    ) 
    # agent.load_q("q_table.npy") #ノーマル
    # agent.load_q("q_table1.npy") #課題１
    agent.load_q("q_table2.npy") #課題２

    asyncio.run(test_agent(
        env,
        agent,
        q_plot_interval=1, 
        stuck_threshold_sec=1.0,  # 2秒でスタックと判定
        random_steps_on_stuck=3  # スタック時に3回ランダム行動
    ))


# import asyncio

# from online_env import OnlineEnv
# from q_learning import QTableAgent
# from q_plotter import QPlotter


# async def test_agent(
#     env,
#     agent,
#     q_plot_interval,
# ):
#     q_plotter = QPlotter(env)

#     try:
#         state, _ = await env.reset()
#         env.render()
#         q_plotter.plot_q(Q=agent.Q)

#         for step in range(1000):
#             print(f"\n--- ステップ {step + 1} ---")
#             action = agent.greedy(state)
#             state, reward, _, _, _ = await env.step(action)
#             env.render()
#             if step % q_plot_interval == 0:
#                 q_plotter.plot_q(Q=agent.Q)
#             print(f"状態:{state}, 報酬:{reward}")
#             await asyncio.sleep(0.1)
#     except KeyboardInterrupt:
#         print("\nCtrl+C を受け取りました。終了します。")
#     finally:
#         await env.close()


# if __name__ == "__main__":
#     # 学習済みQを読み込んでオンライン環境に適用
#     env = OnlineEnv(agent_name="toio-e0M", target_name="toio-E1B")
#     agent = QTableAgent(
#         env.observation_space,
#         env.action_space,
#     )
#     agent.load_q("q_table1.npy")

#     asyncio.run(test_agent(env, agent, q_plot_interval=1))
