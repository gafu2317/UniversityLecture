-- レポート10-2: リストの内包的表記

-- 1から100の間の3の倍数のみを含むリストを作成
multiplesOfThree :: [Int]
multiplesOfThree = [x | x <- [1..100], x `mod` 3 == 0]

-- 1^2 + 2^2 + 3^2 + ... + 1000^2 を求める
sumOfSquares :: Int
sumOfSquares = sum [x^2 | x <- [1..1000]]

-- テスト用のmain関数
main :: IO ()
main = do
    putStrLn "=== レポート10-2: リストの内包的表記 ==="
    
    putStrLn "\n1から100の間の3の倍数:"
    putStrLn $ "最初の10個: " ++ show (take 10 multiplesOfThree)
    putStrLn $ "最後の5個: " ++ show (drop (length multiplesOfThree - 5) multiplesOfThree)
    putStrLn $ "総数: " ++ show (length multiplesOfThree)
    
    putStrLn "\n1^2 + 2^2 + 3^2 + ... + 1000^2 の計算結果:"
    putStrLn $ "結果: " ++ show sumOfSquares
    
    -- 検証用: 1から10までの平方和
    let smallSumOfSquares = sum [x^2 | x <- [1..10]]
    putStrLn $ "\n検証用 (1^2 + 2^2 + ... + 10^2): " ++ show smallSumOfSquares
    putStrLn $ "手計算: 1+4+9+16+25+36+49+64+81+100 = 385"