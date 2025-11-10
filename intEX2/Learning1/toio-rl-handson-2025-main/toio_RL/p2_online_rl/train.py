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
        state, _ = await env.reset()
        env.render()
        q_plotter.plot_q(Q=agent.Q)
        for step in range(1, num_steps + 1):
            print(f"\n--- ステップ {step + 1} ---")
            action = agent.select_action(state)
            next_state, reward, terminated, truncated, _ = await env.step(action)
            # 非エピソーディックなのでdoneは常にFalse
            agent.update(state, action, reward, next_state, False)
            state = next_state
            env.render()
            print(f"状態:{state}, 報酬:{reward}")
            if step % q_plot_interval == 0:
                q_plotter.plot_q(Q=agent.Q)
            await asyncio.sleep(0.1)
    except KeyboardInterrupt:
        print("\nCtrl+C を受け取りました。終了します。")
    finally:
        await env.close()


if __name__ == "__main__":
    env = OnlineEnv(agent_name="toio-34H", life_range=(35, 36))
    agent = QTableAgent(
        env.observation_space,
        env.action_space,
        alpha=0.01,
        gamma=0.9,
        epsilon=0.1,
    )
    asyncio.run(
        train(
            env,
            agent,
            num_steps=5 * 10**5,
            q_plot_interval=1,
        )
    )