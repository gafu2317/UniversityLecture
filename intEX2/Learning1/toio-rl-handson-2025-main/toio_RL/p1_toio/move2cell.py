import asyncio

from toio import *
from toio.simple import AsyncSimpleCube


async def move2cell(cube_id):
    """指定セルへ移動"""
    assert cube_id != "", "cube_idを入力してください"

    #TODO: AsyncSimpleCubeを使用して移動させる
    cube = AsyncSimpleCube(
        name=cube_id,
        coordinate_system_class=ToioRelativeCoordinateSystem
    )
    cube.DEFAULT_MOVEMENT_TYPE = MovementType.Linear
    cube.DEFAULT_TIMEOUT = 1
    # 接続
    try:
        await cube.connect()
    except:
        await cube.disconnect()
        raise RuntimeError(f"toio({cube._name})に接続できませんでした")
    # 登録
    def cell_notification_handler(payload: bytearray):
        id_info = IdInformation.is_my_data(payload)
        if not isinstance(id_info, PositionId): return
        mat_pos = cube._location.from_absolute_location(id_info.center)
        mat_cell = cube._point_to_cell(mat_pos.point)
        print(f"cell={mat_cell}")
    await cube._cube.api.id_information.register_notification_handler(
        cell_notification_handler
    )
    await asyncio.sleep(4)
    # セル(0,0)へ移動
    await cube.move_to_the_grid_cell(cell_x=2, cell_y=2, speed=100)
    await asyncio.sleep(4)
    # 接続解除
    await cube.disconnect()
    return 0


#TODO: 呼び出し元
if __name__ == "__main__":
    cube_id = "toio-34H"
    asyncio.run(move2cell(cube_id))