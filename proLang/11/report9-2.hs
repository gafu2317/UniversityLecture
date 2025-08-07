-- レポート9-2: 階乗計算をforループ無しで行った例

fact 0 = 1
fact n = n * fact(n-1)

main = do
    print $ fact 5