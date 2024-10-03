.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)

all: $(CLASS)

test:;
	@echo "'make test' is unavailable for this time."
	@echo "Use the rules of 'kadai1', 'kadai2', 'kadai3' and 'kadai4' for initial tests."
	@echo "Modify the rules to check for all ten problem instances" 
	@echo "using addtional command lines or shell scripts."

kadai1: WUGraph.class LoadPrintTester.class
	java LoadPrintTester wugraph/wug0.txt

kadai2: WUGraph.class EdgeSortTester.class
	java EdgeSortTester wugraph/wug0.txt

kadai3: UnionFind.class UnionFindTester.class
	java UnionFindTester

kadai4: UnionFind.class WUGraph.class MSTTester.class
	java MSTTester wugraph/wug0.txt >wugraph/mst0.txt

.java.class:
	$(JAVAC) $<

clean:;	\rm -f *.class
