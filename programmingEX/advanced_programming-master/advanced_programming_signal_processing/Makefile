# デフォルト（O3）
matching: main.c imageUtil.c
	gcc -w -O3 -o matching main.c imageUtil.c -lm

# 基本最適化
O0: main.c imageUtil.c
	gcc -w -O0 -o matching main.c imageUtil.c -lm

O1: main.c imageUtil.c
	gcc -w -O1 -o matching main.c imageUtil.c -lm

O2: main.c imageUtil.c
	gcc -w -O2 -o matching main.c imageUtil.c -lm

O3: main.c imageUtil.c
	gcc -w -O3 -o matching main.c imageUtil.c -lm

# 高度な最適化
Ofast: main.c imageUtil.c
	gcc -w -Ofast -o matching main.c imageUtil.c -lm

native: main.c imageUtil.c
	gcc -w -O3 -o matching main.c imageUtil.c -lm -mtune=native

fast_native: main.c imageUtil.c
	gcc -w -Ofast -o matching main.c imageUtil.c -lm -mtune=native

# レベル別実行（コンパイル→実行→評価）
level1: matching
	time sh run.sh level1
	sh answer_final.sh result level1

level2: matching
	time sh run.sh level2
	sh answer_final.sh result level2

level3: matching
	time sh run.sh level3
	sh answer_final.sh result level3

level4: matching
	time sh run.sh level4
	sh answer_final.sh result level4

level5: matching
	time sh run.sh level5
	sh answer_final.sh result level5

level6: matching
	time sh run.sh level6
	sh answer_final.sh result level6

level7: matching
	time sh run.sh level7
	sh answer_final.sh result level7

clean:
	$(RM) matching
