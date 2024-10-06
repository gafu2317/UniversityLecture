.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)

all: $(CLASS)

test:;
	@echo 今回は make test は使用できません
	@echo kada1から3をターゲットとする規則を追加してください
	@echo make kadai1と入力すれば./kadai1.shを実行する

kadai1:
	chmod +x kadai1.sh
	./kadai1.sh

kadai2:
	chmod +x kadai2.sh
	./kadai2.sh

kadai3:
	chmod +x kadai3.sh
	./kadai3.sh

.java.class:
	$(JAVAC) $<

clean:;	\rm -f *.class

rm1:
	rm -f output1/*

rm2:
	rm -f output2/*

rm3:
	rm -f output3/*