.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)
MAIN	= RevPolishNotationCalc

all: $(CLASS)

test:
	@for i in test1 test2 test3 test4; do \
		make -s $$i; \
	done

test1: $(CLASS)
	@echo "1) 3 9 5 + - = ? (answer=-11)"
	$(JAVA) $(MAIN) 3 9 5 + -

test2: $(CLASS)
	@echo "2) 3 2 / 5 6 + * = ? (16.5)"
	$(JAVA) $(MAIN) 3 2 / 5 6 + x

test3: $(CLASS)
	@echo "3) 3 1 5 + = ? (Error)"
	$(JAVA) $(MAIN) 3 1 5 +

test4: $(CLASS)
	@echo "4) 1 a 9 + - = ? (Error)"
	$(JAVA) $(MAIN) 1 a 9 + -

$(CLASS): $(SRC)
	$(JAVAC) $(SRC)

#$(CLASS): $(SRC)

#.java.class:
#	$(JAVAC) $<

clean:;	\rm -f *.class
