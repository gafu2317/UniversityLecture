.SUFFIXES: .java .class

JAVAC	= javac
JAVA	= java

TIMEOUT = echo Do check manually:
HASTIMEOUT = $(if $(shell which timeout 2>/dev/null),yes)
ifeq ($(HASTIMEOUT),yes)
TIMEOUT = timeout --preserve-status 10
endif
HASGTIMEOUT = $(if $(shell which gtimeout 2>/dev/null),yes)
ifeq ($(HASGTIMEOUT),yes)
TIMEOUT = gtimeout --preserve-status 10
endif

SRC	= $(wildcard *.java)
CLASS	= $(SRC:.java=.class)
PROGRAM	= $(shell pwd)
MAIN	= ThreadTest1

all: $(CLASS)

test: $(CLASS)
	-$(TIMEOUT) $(JAVA) $(MAIN)

$(CLASS): $(SRC)
	$(JAVAC) $(SRC)

#$(CLASS): $(SRC)

#.java.class:
#	$(JAVAC) $<

clean:;	\rm -f *.class

