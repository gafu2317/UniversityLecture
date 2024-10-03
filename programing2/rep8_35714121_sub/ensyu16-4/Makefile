.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)
MAIN	= M164CmdArgCircle

all: $(CLASS)

test: $(CLASS)
	$(JAVA) $(MAIN) 5
	$(JAVA) $(MAIN) 10
	$(JAVA) $(MAIN) 20

$(CLASS): $(SRC)
	$(JAVAC) $(SRC)

#$(CLASS): $(SRC)

#.java.class:
#	$(JAVAC) $<

clean:;	\rm -f *.class

