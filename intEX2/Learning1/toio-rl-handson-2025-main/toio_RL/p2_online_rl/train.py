import asyncio

from q_learning import QTableAgent
from online_env import OnlineEnv
from toio_RL.common.q_plotter import QPlotter


async def train(
    env,
    agent,
    num_steps,
    q_plot_interval,
):
    q_plotter = QPlotter(env)

    try:
        pass #TODO: 学習コード（環境を初期化，Q学習による行動選択とQ値更新）
    except KeyboardInterrupt:
        print("\nCtrl+C を受け取りました。終了します。")
    finally:
        await env.close()


if __name__ == "__main__":
    #TODO: 環境・Q学習エージェントの初期化と学習の呼び出し
