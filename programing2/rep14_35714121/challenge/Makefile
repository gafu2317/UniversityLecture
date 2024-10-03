.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)

all: $(CLASS)

test:;
	java PrimTester wugraph/wug0.txt
	@echo Modify to check for all data.

.java.class:
	$(JAVAC) $<

clean:;	\rm -f *.class
