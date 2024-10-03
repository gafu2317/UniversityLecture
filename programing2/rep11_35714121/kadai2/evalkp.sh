#!/bin/sh

for i in `seq -w 1 30`; do # seqは先頭を0で埋めた01-30の文字列のリストを出力
	echo n=$i
	cat < input/${i}.txt # 入力ファイルを読み込んでコンソールに出力
	java KP  < input/${i}.txt > output/${i}out.txt # ファイルに出力
done