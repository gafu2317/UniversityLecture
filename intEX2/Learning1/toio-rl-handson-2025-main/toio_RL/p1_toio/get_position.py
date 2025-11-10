import asyncio

from toio import *


#TODO: 座標のprint
def notification_handler(payload: bytearray):
    id_info = IdInformation.is_my_data(payload) 
    if isinstance(id_info, PositionId):
        print(f"{id_info.center=}, {id_info.sensor=}")

async def get_position(cube_id):
    """toioの座標を取得して表示"""
    assert cube_id != "", "cube_idを入力してください"

    # 接続
    dev_list = await BLEScanner.scan_with_id(cube_id={cube_id})
    assert len(dev_list)
    cube = ToioCoreCube(dev_list[0].interface, name=dev_list[0].name)
    await cube.connect()

    #TODO: 位置を知らせる関数を登録/解除

    await cube.api.id_information.register_notification_handler(notification_handler)  
    await asyncio.sleep(10)

    # 接続解除
    await cube.disconnect()
    return 0


if __name__ == "__main__":
    cube_id = "toio-34H"
    asyncio.run(get_position(cube_id))
