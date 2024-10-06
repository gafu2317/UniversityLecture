#!/bin/sh

for i in `seq -f '%03g' 1 30`; do
	echo n=$i
	#cat graph/graph${i}.txt
	#cat graph/graph${i}.txt > output1/sampleout${i}.txt
	#diff graph/graph${i}.txt output1/sampleout${i}.txt
	#diff -s graph/graph${i}.txt output1/sampleout${i}.txt
done

