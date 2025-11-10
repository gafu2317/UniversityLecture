import asyncio

from toio import *


async def control_motor(cube_id):
    """モーターのスピードを指定して操作"""
    assert cube_id != "", "cube_idを入力してください"

    # 接続
    dev_list = await BLEScanner.scan_with_id(cube_id={cube_id})
    assert len(dev_list)
    cube = ToioCoreCube(dev_list[0].interface, name=dev_list[0].name)
    await cube.connect()

    #TODO: 2秒回転, モーターごとに速度指定
    await cube.api.motor.motor_control(left=30, right=0)
    await asyncio.sleep(5)
    await cube.api.motor.motor_control(0, 0) # stop

    # 接続解除
    await cube.disconnect()
    return 0


#TODO: 呼び出し元
if __name__ == "__main__":
    cube_id = "toio-34H"
    asyncio.run(control_motor(cube_id))