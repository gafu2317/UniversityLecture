# Makefile
CC = gcc
CFLAGS = -Wall -Wextra -pedantic
OBJ = main12.o task12-1.o
TARGET = task12-1

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) -o $(TARGET) $(OBJ)

main12.o: main12.c task12-1.h
	$(CC) $(CFLAGS) -c main12.c

task12-1.o: task12-1.c task12-1.h
	$(CC) $(CFLAGS) -c task12-1.c

clean:
	rm -f $(OBJ) $(TARGET)
