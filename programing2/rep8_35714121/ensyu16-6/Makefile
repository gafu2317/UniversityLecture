.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)
MAIN	= M166Calendar

all: $(CLASS)

test: $(CLASS)
	$(JAVA) $(MAIN) 2021 6
	$(JAVA) $(MAIN) 2020 
	$(JAVA) $(MAIN) 

$(CLASS): $(SRC)
	$(JAVAC) $(SRC)

#$(CLASS): $(SRC)

#.java.class:
#	$(JAVAC) $<

clean:;	\rm -f *.class

