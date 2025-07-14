# Math Detective AI

Gemini APIを使用した数学学習支援AI

## セットアップ

1. 必要なライブラリをインストール:
```bash
pip install google-generativeai python-dotenv
```

2. `.env`ファイルにGemini API Keyを設定:
```
GEMINI_API_KEY=your_api_key_here
```

## 使用方法

```bash
python3 math_detective_ai.py
```

### コマンド
- 数学問題を入力: 新しい問題を開始
- `ヒント` または `hint`: 次のレベルのヒントを取得
- `答え: [あなたの答え]`: 答えを提出
- `quit` または `終了`: プログラム終了

## 特徴

- 🔍 段階的ヒント提供（答えは絶対に教えない）
- 🕵️ 探偵キャラクターによる対話
- 📊 理解度に応じた適応的サポート
- 🎯 高校数学全般に対応
