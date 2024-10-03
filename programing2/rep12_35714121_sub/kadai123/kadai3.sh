#!/bin/bash

# Javaコンパイル
javac DFSTree.java DFSTester.java

for graph in graph005.txt graph015.txt graph025.txt
do
    file="graph/$graph"
    output_file="output3/${graph%.txt}_output.txt"
    java DFSTester $file 150 250 > $output_file
done