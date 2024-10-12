#!/bin/sh

for i in `seq -w 1 30`; do # seqは先頭を0で埋めた01-30の文字列のリストを出力
	java KP < input/${i}.txt > output/kpout${i}.txt # ファイルに出力
done