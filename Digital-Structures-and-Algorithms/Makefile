.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)
MAIN	= Main

all: $(CLASS)

test: $(CLASS)
# $(JAVA) $(MAIN) data_80MB/10000
# $(JAVA) $(MAIN) data_80MB/50000
# $(JAVA) $(MAIN) data_80MB/100000
# $(JAVA) $(MAIN) data_80MB/500000
	$(JAVA) $(MAIN) data_80MB/1000000

$(CLASS): $(SRC)
	$(JAVAC) $(SRC)

#$(CLASS): $(SRC)

#.java.class:
#	$(JAVAC) $<

clean:;	\rm -f *.class