from typing import Optional, Tuple, Dict, Any
import asyncio
from enum import IntEnum
import logging

import numpy as np
from gymnasium.spaces import Discrete
from gymnasium.utils import seeding
from toio.simple import AsyncSimpleCube
from toio import (
    MovementType,
    ToioRelativeCoordinateSystem,
    IdInformation,
    PositionId,
    PositionIdMissed,
    StandardIdMissed,
)

from toio_RL.common.keyboard_input import read_action_async, Key

logger = logging.getLogger(__name__)


class Action(IntEnum):
    UP = 0
    DOWN = 1
    LEFT = 2
    RIGHT = 3


class OnlineEnv:
    """
    Online environment for collecting a target on a grid with a Toio cube.
    """

    # A3開発マットは中央のセルが(0,0)
    # 環境の座標(x,y)は左上(0,0)
    OFFSET_X: int = 3
    OFFSET_Y: int = 2

    def __init__(
        self,
        grid_width: int = 7,
        grid_height: int = 5,
        life_range: Tuple[int, int] = (1, 6),
        agent_name: str = "",
        target_name: Optional[str] = None,
        render_mode: Optional[str] = "ansi",
    ) -> None:
        if not agent_name:
            raise ValueError("agent_nameを設定してください")

        # toioの初期化, target_nameにidが指定されていなければ，仮想的なりんごを設定
        self._use_physical_target = target_name is not None
        names = [agent_name] + ([target_name] if self._use_physical_target else [])
        self.cubes = [
            AsyncSimpleCube(
                coordinate_system_class=ToioRelativeCoordinateSystem,
                name=name,
            )
            for name in names
        ]

        self.observation_space = Discrete((grid_width * grid_height) ** 2)
        self.action_space = Discrete(len(Action))

        #TODO: 初期化処理

        # 乱数生成器
        self._rng: Optional[np.random.Generator] = None
        # デバッグ処理向け
        self._fail_flag: Dict[str, bool] = {}
        self.render_mode = render_mode

    async def reset(
        self, seed: Optional[int] = None, options: Optional[Dict[str, Any]] = None
    ) -> Tuple[int, Dict]:
        """
        Returns: observation, info dict
        """
        self._rng, _ = seeding.np_random(seed)
        pass #TODO: 環境の初期化（toio接続，りんご初期化，初期状態を返す）

    async def step(self, action: int) -> Tuple[int, float, bool, bool, Dict]:
        """
        Returns: observation, reward, terminated, truncated, info dict
        """
        pass #TODO: 環境を1step進める

    def get_observation(self) -> int:
        pass #TODO: 状態の取得

    def get_reward(self) -> float:
        pass #TODO: 報酬の取得

    # ----- utility methods -----

    def pos_to_index(self, xy: Tuple[int, int]) -> int:
        pass #TODO: 座標(x,y)から状態indexへの変換

    def index_to_pos(self, idx: int) -> Tuple[int, int]:
        pass #TODO: 状態indexから座標(x,y)への変換

    def pos_to_matcell(self, xy: Tuple[int, int]) -> Tuple[int, int]:
        """Convert grid coordinate to Toio mat cell coordinate."""
        return (xy[0] - self.OFFSET_X, xy[1] - self.OFFSET_Y)

    def matcell_to_pos(self, cell: Tuple[int, int]) -> Tuple[int, int]:
        """Convert Toio mat cell coordinate back to grid coordinate."""
        return (cell[0] + self.OFFSET_X, cell[1] + self.OFFSET_Y)

    def render(self) -> Optional[str]:
        """
        Render grid to console as string.
        """
        if self.render_mode != "ansi":
            return NotImplemented
        grid = [["." for _ in range(self.grid_width)] for _ in range(self.grid_height)]
        ax, ay = self._agent_pos
        tx, ty = self._target_pos
        grid[ay][ax] = "T"
        grid[ty][tx] = "A" if grid[ty][tx] != "T" else "TA"
        output = "\n".join(" ".join(row) for row in grid)
        print(
            f"{output}\nAgent: ({ax},{ay})  Target: ({tx},{ty})  Life: {self._target_life}"
        )
        return output

    async def close(self) -> None:
        for cube in self.cubes:
            await cube.disconnect()

    # ----- private methods -----

    async def _initialize_cubes(self) -> None:
        """Connect cubes and register position notification handlers."""
        self._fail_flag = {}
        for idx, cube in enumerate(self.cubes):
            cube.DEFAULT_MOVEMENT_TYPE = MovementType.Linear
            cube.DEFAULT_TIMEOUT = 1
            try:
                await cube.connect()
            except Exception:
                if cube._cube is not None:
                    await cube.disconnect()
                raise RuntimeError(f"Cannot connect to cube {cube._name}")
            is_target = idx == 1 and self._use_physical_target
            handler = self._make_id_handler(cube._cube.name, is_target, cube)
            await cube._cube.api.id_information.register_notification_handler(handler)
        await asyncio.sleep(1)

    def _make_id_handler(self, name: str, is_target: bool, cube: AsyncSimpleCube):
        def handler(payload: bytearray) -> None:
            info = IdInformation.is_my_data(payload)
            if cube._location is None or isinstance(
                info, (PositionIdMissed, StandardIdMissed)
            ):
                logger.info("座標を読み取れません．toioを移動してください")
                self._fail_flag[name] = True
                return
            if not isinstance(info, PositionId):
                return
            pos = cube._location.from_absolute_location(info.center)
            cell = cube._point_to_cell(pos.point)
            xy = self.matcell_to_pos(cell)
            if is_target:
                self._target_pos = xy
            else:
                self._agent_pos = xy

            if self._fail_flag.get(name, False):
                logger.info(f"{'apple' if is_target else 'agent'}の座標を更新しました")
                self._fail_flag[name] = False

        return handler

    def _respawn_target(self) -> None:
        """Randomly place the virtual target on a free cell and reset its lifetime."""
        free = [
            self.pos_to_index((x, y))
            for x in range(self.grid_width)
            for y in range(self.grid_height)
            if (x, y) not in (self._agent_pos, self._target_pos)
        ]
        assert self._rng is not None
        choice = self._rng.choice(free)
        self._target_pos = self.index_to_pos(choice)
        self._target_life = int(
            self._rng.integers(self.life_range[0], self.life_range[1])
        )


async def test_with_keyboard():
    print(
        "矢印キーでエージェントの行動を指定（↑, ↓, ←, →）。終了は 'q' または Ctrl+C。"
    )
    mapping = {
        Key.UP.value: Action.UP,
        Key.RIGHT.value: Action.RIGHT,
        Key.DOWN.value: Action.DOWN,
        Key.LEFT.value: Action.LEFT,
    }
    #TODO: メインループ（環境を初期化，矢印キーの方向へ環境を動かして，状態を表示）


if __name__ == "__main__":
    asyncio.run(test_with_keyboard())
