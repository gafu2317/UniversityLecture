#!/bin/bash

# Javaコンパイル
javac BFSTree.java BFSTester.java

# 各グラフファイルに対して処理を行う
for graph in graph010.txt graph020.txt graph030.txt
do
    file="graph/$graph"
    output_file="output2/${graph%.txt}_output.txt"
    java BFSTester $file 100 300 > $output_file
done