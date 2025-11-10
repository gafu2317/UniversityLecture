import asyncio

from toio import *


async def connect_toio(cube_id):
    """cube_idのtoioに接続"""

    assert cube_id != "", "cube_idを入力してください"

    # cube_idを検索
    dev_list = await BLEScanner.scan_with_id(cube_id={cube_id})

    # 接続
    cube = ToioCoreCube(dev_list[0].interface, name=dev_list[0].name)
    await cube.connect()

    print(f"Success! {cube.name}")

    await asyncio.sleep(3)

    # 接続解除
    await cube.disconnect()

    #TODO: cube_idの検索/接続/解除
    return 0


#TODO: 呼び出し元

if __name__ == "__main__":
    cube_id = "toio-34H" #使⽤するidをここに入れる
    asyncio.run(connect_toio(cube_id))




