CC = gcc
CFLAGS = -Wall -g
OBJ = main14.o task14.o
TARGET = task14

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJ)

main14.o: main14.c task14.h
	$(CC) $(CFLAGS) -c main14.c

task14.o: task14.c task14.h
	$(CC) $(CFLAGS) -c task14.c

clean:
	rm -f $(OBJ) $(TARGET)
