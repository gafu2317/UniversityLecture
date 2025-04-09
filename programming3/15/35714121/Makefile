CC = gcc
CFLAGS = -Wall -lm
OBJ = main15-1.o task15-1.o
EXEC = task15-1

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CC) $(CFLAGS) -o $(EXEC) $(OBJ)

main15-1.o: main15-1.c task15-1.h
	$(CC) $(CFLAGS) -c main15-1.c

task15-1.o: task15-1.c task15-1.h
	$(CC) $(CFLAGS) -c task15-1.c

