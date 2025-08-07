-- レポート10-3: Haskellにおける高階関数

-- (1) map関数を自分で実装したmy_map
my_map :: (a -> b) -> [a] -> [b]
my_map f [] = []
my_map f (x:xs) = f x : my_map f xs

-- (2) filter関数を自分で実装したmy_filter
my_filter :: (a -> Bool) -> [a] -> [a]
my_filter p [] = []
my_filter p (x:xs)
    | p x       = x : my_filter p xs
    | otherwise = my_filter p xs

-- テスト用の関数
double :: Int -> Int
double x = x * 2

square :: Int -> Int
square x = x * x

isEven :: Int -> Bool
isEven x = x `mod` 2 == 0

isPositive :: Int -> Bool
isPositive x = x > 0

-- テスト用のmain関数
main :: IO ()
main = do
    putStrLn "=== レポート10-3: Haskellにおける高階関数 ==="
    
    putStrLn "\nmy_map関数のテスト:"
    let testList1 = [1, 2, 3, 4, 5]
    putStrLn $ "元のリスト: " ++ show testList1
    putStrLn $ "my_map double [1,2,3,4,5]: " ++ show (my_map double testList1)
    putStrLn $ "my_map square [1,2,3,4,5]: " ++ show (my_map square testList1)
    putStrLn $ "my_map (+10) [1,2,3,4,5]: " ++ show (my_map (+10) testList1)
    
    putStrLn "\nmy_filter関数のテスト:"
    let testList2 = [-3, -2, -1, 0, 1, 2, 3, 4, 5, 6]
    putStrLn $ "元のリスト: " ++ show testList2
    putStrLn $ "my_filter isEven: " ++ show (my_filter isEven testList2)
    putStrLn $ "my_filter isPositive: " ++ show (my_filter isPositive testList2)
    putStrLn $ "my_filter (>3): " ++ show (my_filter (>3) testList2)
    
    putStrLn "\n標準のmapとfilterとの比較:"
    putStrLn $ "標準map double: " ++ show (map double testList1)
    putStrLn $ "my_map double: " ++ show (my_map double testList1)
    putStrLn $ "標準filter isEven: " ++ show (filter isEven testList2)
    putStrLn $ "my_filter isEven: " ++ show (my_filter isEven testList2)
    
    putStrLn "\n組み合わせ使用の例:"
    putStrLn $ "my_filter isEven (my_map square [1..10]): " ++ 
               show (my_filter isEven (my_map square [1..10]))