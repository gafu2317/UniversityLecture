import asyncio

from toio import *


async def move2pos(cube_id):
    """PositionIDへ移動"""
    assert cube_id != "", "cube_idを入力してください"

    # 接続
    dev_list = await BLEScanner.scan_with_id(cube_id={cube_id})
    assert len(dev_list)
    cube = ToioCoreCube(dev_list[0].interface, name=dev_list[0].name)
    await cube.connect()

    # 位置を表示
    def id_notification_handler(payload: bytearray):
        id_info = IdInformation.is_my_data(payload)
        if isinstance(id_info, PositionId):
            print(f"{id_info.center=}")

    # 登録
    await cube.api.id_information.register_notification_handler(id_notification_handler)

    await asyncio.sleep(4)

    #TODO: PositionID(200,200)へ移動
    await cube.api.motor.motor_control_target(
        timeout=5,
        # 移動タイプ: 回転してから移動
        movement_type=MovementType.Linear,
        speed=Speed(
            max=100,
            # モーター速度変更タイプ: ⽬標地点までの途中で徐々に加速し、そこから⽬標地点まで減速する
            speed_change_type=SpeedChangeType.AccelerationAndDeceleration
        ),
        target=TargetPosition(
            cube_location=CubeLocation(point=Point(x=300, y=200), angle=0),
            # 回転オプション: 絶対⾓度
            rotation_option=RotationOption.AbsoluteOptimal,
        ),
    )

    await asyncio.sleep(4)

    # 接続解除
    await cube.disconnect()
    return 0


#TODO: 呼び出し元

if __name__ == "__main__":
    cube_id = "toio-34H"
    asyncio.run(move2pos(cube_id))