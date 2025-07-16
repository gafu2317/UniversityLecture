# ユニットテスト・カバレッジレポート実習

## ファイル構成

- `math_functions.c/h` - テスト対象の数学関数ライブラリ
- `test_math_functions.c` - ユニットテストコード
- `Makefile` - ビルドとカバレッジ生成用

## 実行方法

### 1. 通常のテスト実行
```bash
make test
```

### 2. カバレッジ付きテスト実行
```bash
make coverage-report
```

### 3. HTMLカバレッジレポート生成（lcov必要）
```bash
make coverage-html
```

### 4. クリーンアップ
```bash
make clean
```

## 実装されている関数

- `add(a, b)` - 加算
- `subtract(a, b)` - 減算  
- `multiply(a, b)` - 乗算
- `divide(a, b)` - 除算（ゼロ除算チェック付き）
- `factorial(n)` - 階乗計算
- `is_prime(n)` - 素数判定
- `fibonacci(n)` - フィボナッチ数列

## テストケース

各関数に対して複数のテストケースを実装：
- 正常系のテスト
- 境界値のテスト
- 異常系のテスト

## カバレッジ確認

カバレッジレポートで以下を確認できます：
- 行カバレッジ
- 分岐カバレッジ
- 関数カバレッジ