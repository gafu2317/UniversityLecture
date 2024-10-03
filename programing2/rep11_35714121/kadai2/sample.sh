#!/bin/sh

for i in `seq -w 1 30`; do
	echo n=$i
	#cat < input/${i}.txt
	#cat < input/${i}.txt > output/${i}sampleout.txt
done

