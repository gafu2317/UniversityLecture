.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)

all: $(CLASS)

test: $(CLASS)
	@echo Removing copies and Testing...
	rm -f sample*-copy.txt 
	$(JAVA) FileCopy sample_utf8.txt sample_utf8-copy.txt
	diff sample_utf8.txt sample_utf8-copy.txt
	$(JAVA) FileCopy sample_sjis.txt sample_sjis-copy.txt
	diff sample_sjis.txt sample_sjis-copy.txt
	$(JAVA) FileCopy sample.jpg sample-copy.jpg
	diff sample.jpg sample-copy.jpg
	@echo Testing existing file case...
	-$(JAVA) FileCopy sample_sjis.txt sample_utf8-copy.txt
	diff sample_utf8.txt sample_utf8-copy.txt

$(CLASS): $(SRC)
	$(JAVAC) $(SRC)

#$(CLASS): $(SRC)

#.java.class:
#	$(JAVAC) $<

clean:;	\rm -f *.class
