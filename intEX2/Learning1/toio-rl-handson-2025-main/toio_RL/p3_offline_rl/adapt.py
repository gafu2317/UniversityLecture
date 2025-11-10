import asyncio

from online_env import OnlineEnv
from q_learning import QTableAgent
from toio_RL.common.q_plotter import QPlotter


async def test_agent(
    env,
    agent,
    q_plot_interval,
):
    q_plotter = QPlotter(env)

    try:
        state, _ = await env.reset()
        env.render()
        q_plotter.plot_q(Q=agent.Q)

        for step in range(1000):
            print(f"\n--- ステップ {step + 1} ---")
            action = agent.greedy(state)
            state, reward, _, _, _ = await env.step(action)
            env.render()
            if step % q_plot_interval == 0:
                q_plotter.plot_q(Q=agent.Q)
            print(f"状態:{state}, 報酬:{reward}")
            await asyncio.sleep(0.1)
    except KeyboardInterrupt:
        print("\nCtrl+C を受け取りました。終了します。")
    finally:
        await env.close()


if __name__ == "__main__":
    #TODO: 学習済みQを読み込んでオンライン環境に適用
