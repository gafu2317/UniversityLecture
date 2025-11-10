
# toio-rl-handson

強化学習による移動ロボット制御（知能プログラミング演習Ⅱ）向けのPythonコードです．

## 使い方

コードは穴開き状態になっているため，そのままでは動きません．
（#TODO）の部分をご自身で書いてください．

## 準備

- 必要なアプリケーションの確認とインストールは，[環境構築](supplementary/build_env_note.md)を参照してください．

- 仮想環境で必要なパッケージをダウンロードしてください．

### venvの場合
```bash
python -m venv venv

# 仮想環境に入る
# windowsの場合
venv\Scripts\activate
# mac/ubuntuの場合
source venv/bin/activate

pip install -r requirements.txt

# 仮想環境から出る
deactivate
```

### condaの場合
```bash
conda env create -f environment.yml

# doneと表示されたのち、下記コマンドで「toio_rl」があればOK
<User>@<Host>:~ > conda env list
# conda environments:
#
toio_rl               *  /home/staff/<User>/.conda/envs/toio_rl
base                     /usr/local/anaconda3
python311                /usr/local/anaconda3/envs/python311

# 仮想環境に入る
<User>@<Host>:~ > conda activate toio_rl
(toio_rl) <User>@<Host>:~ > 

# 仮想環境から出る
(toio_rl) <User>@<Host>:~ > conda deactivate
<User>@<Host>:~ > 
```

## 実行方法

* 実行前に仮想環境環境を有効化してください
* 演習番号に対応したフォルダに移動してコードを実行します（例えば演習1ならp1）

```bash
# windowsの場合
cd toio_RL\p1_toio
# mac/ubuntuの場合
cd toio_RL/p1_toio

python connection.py
```

## 補足資料

- [パッケージの使用例](supplementary/cheetsheet.md)
- [デバッグ向けTips](supplementary/debugtips.md)

