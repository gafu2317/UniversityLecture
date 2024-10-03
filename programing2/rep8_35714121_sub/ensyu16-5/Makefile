.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)
MAIN	= M165SumOfArgsEx

all: $(CLASS)

test: $(CLASS)
	$(JAVA) $(MAIN) 3.2 5.5

$(CLASS): $(SRC)
	$(JAVAC) $(SRC)

#$(CLASS): $(SRC)

#.java.class:
#	$(JAVAC) $<

clean:;	\rm -f *.class

