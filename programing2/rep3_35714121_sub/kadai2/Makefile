.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)
MAIN	= PlotGraphTester

all: $(CLASS)

test: $(CLASS)
	$(JAVA) $(MAIN)

$(CLASS): $(SRC)
	$(JAVAC) $(SRC)

#$(CLASS): $(SRC)

#.java.class:
#	$(JAVAC) $<

clean:;	\rm -f *.class

