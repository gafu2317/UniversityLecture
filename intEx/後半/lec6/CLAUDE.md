出力は日本語でお願いします

この演習課題を始める前に、以下の準備が必要です。

*   **自前の環境**:
    *  フォルダに以下のファイルが全て含まれていることを確認します:
        *   CNN2.py
        *   CNN3.py
        *   CNN4.py
        *   report.tex
        *   report.pdf
        *   task.pdf
    *   `torch`と`torchvision`をインストールします。`pip`を使用する場合のコマンドは `$ pip install torch` および `$ pip install torchvision` です。

### 2. 課題 (Tasks)

PyTorchを用いて多値分類を畳み込みニューラルネットワーク（CNN）で実装します。レポートの提出も必要で、`report.tex`テンプレートを使用する

*   **課題1: CNN2.pyにおける`x`のサイズ確認**
    *   `CNN2.py`（講義スライドで説明されたプログラム）の`forward`関数を以下のように編集し、`x`のサイズを出力して終了するようにします:
        ```python
        def forward(self, x):
            print(x.size())
            sys.exit()
            x = self.conv(x)
            x = self.relu(x)
            x = self.maxpooling(x)
            x = self.flatten(x)
            logits = self.linear(x)
            return logits
        ```
    *   **`forward`関数の各行**（`self.conv`の前、`self.relu`の前、`self.maxpooling`の前、`self.flatten`の前、`self.linear`の前、`return logits`の前、最後の`logit`のサイズ）での**`x`のサイズを調べて記載**し、それぞれのサイズがなぜそのようになるのかをreport.texに記載します。
    *   この課題に関しては、**コードの提出は不要**です。

*   **課題2: CNN3.pyのCNNクラス編集**
    *   `CNN3.py`の`CNN`クラスを編集し、以下の定義に基づいてCNNを作成します。指定のない設定はデフォルトで構いません。
    *   **`(a)-(g)`を`self.fe`に、`(h)-(j)`を`self.fc`に`Sequential`を使ってまとめます**。
        *   (a) **畳み込み層**: 出力チャネル数 6, フィルタサイズ 3, ストライド 1, パディング 1
        *   (b) ReLU活性化関数
        *   (c) **マックスプーリング**: フィルタサイズ 2, ストライド 2
        *   (d) **畳み込み層**: 出力チャネル数 6, フィルタサイズ 3, ストライド 1, パディング 1
        *   (e) ReLU活性化関数
        *   (f) **マックスプーリング**: フィルタサイズ 2, ストライド 2
        *   (g) Flatten
        *   (h) **線形層**: 出力 100次元
        *   (i) ReLU活性化関数
        *   (j) **線形層**: 出力 10次元
    *   ヒントとして、最初の線形層の入力サイズを指定する際には、課題1で行ったサイズ確認方法で確かめることができます。
    *   プログラムを完成させて実行すると、`error.pdf`が作成されます。この図には何がプロットされていて、どのようなことが読み取れるのかをなるべく詳しくreport.texに記載します。

*   **課題3: CNN4.pyを用いたCNN設計**
    *   `CNN4.py`は、**Fashion MNIST**（28 × 28のグレースケール、10クラスのデータ）を読み込んでCNNを実行するためのテンプレートです。
    *   `CNN`クラスの`init`と`forward`は空欄になっているため、**自由にネットワークを設計し、最終的な正解率（最後に表示されるFinal Accuracy）がなるべく高くなるようなCNNを作成**します。
    *   **少なくとも1つの畳み込み層を使用**すること。その他の設定（紹介されていない機能なども含む）は自由に設計できます。
    *   利用可能な層のリファレンスとして[https://pytorch.org/docs/stable/nn.html](https://pytorch.org/docs/stable/nn.html)、利用可能な最適化アルゴリズムのリファレンスとして[https://pytorch.org/docs/stable/optim.html](https://pytorch.org/docs/stable/optim.html)が挙げられています。
    *   最終的に採用した設定および結果についてreport.texに記載すること。
