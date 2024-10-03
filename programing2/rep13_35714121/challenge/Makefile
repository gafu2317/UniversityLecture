.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)

all: $(CLASS)

test: $(CLASS)
	java MultiDjkTester sample2.txt

$(CLASS): $(SRC)
	$(JAVAC) $(SRC)

#.java.class:
#	$(JAVAC) $<

clean:;	\rm -f *.class
