-- レポート10-1: 再帰とパターンマッチング

-- フィボナッチ数列
fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = fibonacci (n-1) + fibonacci (n-2)

-- my_length: リストの長さを計算
my_length :: [a] -> Int
my_length [] = 0
my_length (x:xs) = 1 + my_length xs

-- my_sum: リストの要素の合計を計算
my_sum :: [Int] -> Int
my_sum [] = 0
my_sum (x:xs) = x + my_sum xs

-- my_reverse: リストを逆順にする
my_reverse :: [a] -> [a]
my_reverse [] = []
my_reverse (x:xs) = my_reverse xs ++ [x]

-- テスト用のmain関数
main :: IO ()
main = do
    putStrLn "=== レポート10-1: 再帰とパターンマッチング ==="
    
    putStrLn "\nフィボナッチ数列:"
    putStrLn $ "fibonacci 0 = " ++ show (fibonacci 0)
    putStrLn $ "fibonacci 1 = " ++ show (fibonacci 1)
    putStrLn $ "fibonacci 5 = " ++ show (fibonacci 5)
    putStrLn $ "fibonacci 8 = " ++ show (fibonacci 8)
    
    putStrLn "\nmy_length関数:"
    putStrLn $ "my_length [] = " ++ show (my_length ([] :: [Int]))
    putStrLn $ "my_length [1,2,3] = " ++ show (my_length [1,2,3])
    putStrLn $ "my_length [1,2,3,4,5] = " ++ show (my_length [1,2,3,4,5])
    
    putStrLn "\nmy_sum関数:"
    putStrLn $ "my_sum [] = " ++ show (my_sum [])
    putStrLn $ "my_sum [1,2,3] = " ++ show (my_sum [1,2,3])
    putStrLn $ "my_sum [10,20,30] = " ++ show (my_sum [10,20,30])
    
    putStrLn "\nmy_reverse関数:"
    putStrLn $ "my_reverse [] = " ++ show (my_reverse ([] :: [Int]))
    putStrLn $ "my_reverse [1,2,3] = " ++ show (my_reverse [1,2,3])
    putStrLn $ "my_reverse \"hello\" = " ++ show (my_reverse "hello")