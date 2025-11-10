
# デバッグ向けのTips

## f文字

```python
>>> x = 10
>>> print(x)
10
>>> print(f"{x=}")
x=10
```

## logger

- 基本は`print`だが開発ではコードを汚さない方法が好まれる

```python

import logging
logger = logging.getLogger(__name__)

# コード中に追跡したい箇所へ
x = 10
logger.debug(f"{x=}")
logger.info("Success to connect")
logger.warning("Met exception!")
logger.error("Fail to connect!")
logger.critical("Abort!")

# コードを呼び出すファイルのどこかで実行（INFO以上のログを表示する）
logging.basicConfig(level=logging.INFO)
```

## type hint

- Pythonは，変数に代入できるデータ型の指定が不要
- 変数のデータ型をコード上で記しておくための記法

```python
from typing import Optional, Tuple

# 使用例
class OnlineEnv:
    def __init__(
        self,
        grid_width: int = 7, # int型
        grid_height: int = 5, # int型
        life_range: Tuple[int, int] = (1, 6), #(int型, int型)
        agent_name: str = "", # string型
        target_name: Optional[str] = None, # String型もしくはNone
    ) -> None:
        self._target_life: int = 0 # int型
```
