# コンパイラ
CC = gcc

# コンパイルオプション
CFLAGS = -Wall -g

# 実行ファイル名
TARGET = task13

# ソースファイル
SRC = main13.c task13.c

# オブジェクトファイル
OBJ = $(SRC:.c=.o)

# デフォルトのターゲット
all: $(TARGET)

# 実行ファイルのビルド
$(TARGET): $(OBJ)
	$(CC) -o $@ $^

# オブジェクトファイルのビルド
%.o: %.c task13.h
	$(CC) $(CFLAGS) -c $< -o $@

# クリーンターゲット
clean:
	rm -f $(OBJ) $(TARGET)

# .PHONYは、ターゲットがファイル名と衝突しないようにするためのもの
.PHONY: all clean
