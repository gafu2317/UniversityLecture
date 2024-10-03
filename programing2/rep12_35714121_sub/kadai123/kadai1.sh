#!/bin/bash
# Javaコンパイル
javac Graph.java GraphTester.java

for i in $(seq -w 1 30);
do
    file="graph/graph0${i}.txt"
    output_file="output1/graph0${i}_output.txt"
    java GraphTester $file > $output_file
    diff $file $output_file
done
