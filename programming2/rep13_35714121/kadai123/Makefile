.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)

all: $(CLASS)

test:;
	@echo "'make test' is unavailable for this time."
	@echo "Add rules for targets 'kadai1', 'kadai2' and 'kadai3'."

kadai1: 
	$(JAVAC) Graph.java GraphTester.java
	$(JAVA) GraphTester sample.txt > output1.txt
	diff sample.txt output1.txt

kadai2: 
	$(JAVAC) Dijkstra.java DijkstraTester.java
	$(JAVA) DijkstraTester sample.txt > output2.txt

kadai3: 
	$(JAVAC) PQDijkstra.java PQDijkstraTester.java
	$(JAVA) PQDijkstraTester sample.txt > output3.txt

kadai123: kadai1 kadai2 kadai3

rm1:;
	\rm -f output1.txt
rm2:;
	\rm -f output2.txt
rm3:;
	\rm -f output3.txt

rm123: rm1 rm2 rm3


$(CLASS): $(SRC)
	$(JAVAC) $(SRC)

#.java.class:
#	$(JAVAC) $<

clean:;	\rm -f *.class
